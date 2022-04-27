Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6C651156E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiD0LBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiD0LAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:00:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4588440E33F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:48:15 -0700 (PDT)
Received: from zn.tnic (p5de8eeb4.dip0.t-ipconnect.de [93.232.238.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 694731EC0535;
        Wed, 27 Apr 2022 12:48:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651056489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0Mx2ljMgyeb1KSAU+/20OsjJdc7S6/3Eyp+HNpvcZrE=;
        b=qBbR2/Dmz6OVlPD0bpbknyeGPlgK+UyCPyBRlIOjy4P3f22zHsx1pbyPpVTIp6nDzENDtR
        17XD4Vi9Kr6NwYiDZ1ZipFlaFS1dWwbv5qJM81nSbaSi8rp+OyvjaAZbmsmEYCI1ivzvll
        KHsgX+VzC3BWJbMjWC982GC5JX/F4Uc=
Date:   Wed, 27 Apr 2022 12:48:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Subject: Re: [PATCH v7 2/8] x86/crash: Introduce new options to support cpu
 and memory hotplug
Message-ID: <YmkfaSAiGIYgTlvY@zn.tnic>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
 <20220413164237.20845-3-eric.devolder@oracle.com>
 <Ylgot+LUDQl+G/5N@zn.tnic>
 <f3ea7ee0-1cb8-6928-d0af-4c2fc63a42a4@oracle.com>
 <Yl6PueNCZZeobMWr@zn.tnic>
 <cc7a6b5c-954c-54fe-be5f-324dc984ac51@oracle.com>
 <Ymb1tBJsch/TB2ph@zn.tnic>
 <0aee5cd1-eb8c-f778-c6e5-7f5ca3624d15@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0aee5cd1-eb8c-f778-c6e5-7f5ca3624d15@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 03:08:26PM -0500, Eric DeVolder wrote:
> Why is it safe to examine kexec_crash_image outside the mutex? As I
> understand it, there is still the (very rare) opportunity for a kdump
> load/unload initiated via userland and this check to collide. (Similarly, I
> believe the mutex entry is almost always assured/likely.)

Yeah, I guess. As the comment in do_kexec_load() says

	"KISS: always take the mutex."

so ignore this part of the diff and let's always grab the mutex.

Sorry for the confusion.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
