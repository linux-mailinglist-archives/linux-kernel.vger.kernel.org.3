Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988BC52B86F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbiERLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbiERLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:14:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4162A16A258
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:14:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFB73B81E7C
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 11:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4A0C385A5;
        Wed, 18 May 2022 11:14:48 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="XI9oqW2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652872486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Za+DQLmt+oUGTeJhfIppqwlsrJRYB67GyeAjlchsa3A=;
        b=XI9oqW2HtGkL2CyZGV/jzmh5qaRm17/NDKqKx+B02j2hnREx2OejsVPPFnMcRoeY72sLk8
        QQF52j0Bg9lanZlVZAXw7+vRsuMpWHQJiRrE6TvVQC813l+XULCt2r9GfAbSUF/EdF88Tv
        9JmCOFVzq2Z3rRHyFXXKojNQYCGppMM=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 604e2236 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 18 May 2022 11:14:46 +0000 (UTC)
Date:   Wed, 18 May 2022 13:14:40 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vadim Galitsin <vadim.galitsyn@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Vadim Galitsin <vadim.galitsyn@oracle.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <YoTVIGiXUO2l8Czm@zx2c4.com>
References: <20220501192740.203963477@linutronix.de>
 <YnKeag3Ulg0NR58Q@zx2c4.com>
 <YoRFjTIzMYZu8Hq8@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoRFjTIzMYZu8Hq8@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vadim,

On Wed, May 18, 2022 at 03:02:05AM +0200, Jason A. Donenfeld wrote:
> Observation: the problem is definitely related to using the FPU in a
> hard IRQ.

I wrote a tiny reproducer that should be pretty reliable for testing
this, attached below. I think this proves my working theory. Run this in
a VirtualBox VM, and then move your mouse around or hit the keyboard, or
do something that triggers the add_{input,disk}_randomness() path from a
hardirq handler. On my laptop, for example, the trackpoint goes via
hardirq, but the touchpad does not. As soon as I move the trackpoint
around, the below program prints "XSAVE is borked!".

Also, note that this isn't just "corruption" of the guest VM, but also
leaking secret contents of the host VM into the guest. So you might
really want to make sure VirtualBox issues a fix for this before 5.18,
as it's arguably security sensitive.

Regards,
Jason


#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/prctl.h>

int main(int argc, char *argv[])
{
	int status = 0;

	for (int i = 0, nproc = sysconf(_SC_NPROCESSORS_ONLN); i < nproc; ++i) {
		if (!fork()) {
			prctl(PR_SET_PDEATHSIG, SIGKILL);
			asm("movq $42, %%rax\n"
			    "movq %%rax, %%xmm0\n"
			    "0:\n"
			    "movq %%xmm0, %%rbx\n"
			    "cmpq %%rax, %%rbx\n"
			    "je 0b\n"
			    : : : "rax", "rbx", "xmm0", "cc");
			_exit(77);
		}
	}
	wait(&status);
	if (WEXITSTATUS(status) == 77)
		printf("XSAVE is borked!\n");
	return 1;
}
