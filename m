Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC24C42E5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbiBYK4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239773AbiBYK4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:56:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4271DAC45
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5anAWthvzNGxhw1sVxyVzzJrZJ+m8Z4X7pE0EgqoUS4=; b=gLbXQWWaFfSgUYBj/ktCST7+H3
        NOmvmMA16ApR1UHgzXYBt6U40GuDmLIlUYcVpVbCwiR8l72PlCxyifgSo0ZAdrjkXMMpt2x9L0u+M
        8xR3E85JvlRIv8HJavrZJ71J57HcwTIiByjulnSCeUyKQ38kWcqeYbDuywkXFtd5vruTV7mtua+y/
        cGHkWkbT+7FPTFtlMFER0JWKoZ+xHY4WnNUaA3YHb22Gf6m9EWu+88Z+LkImzsodLImD0f+P7cMI6
        oWKRimCjTyR9t2+2vHsfVWBHWCkmJfkABsTyNfru/0gXCR1jybA9j/C+jyBtXVY5RVSZGFkJ4ArtR
        vP2HDplQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNYFh-00Cw7b-Db; Fri, 25 Feb 2022 10:55:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB86330076F;
        Fri, 25 Feb 2022 11:55:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A03B02C695412; Fri, 25 Feb 2022 11:55:08 +0100 (CET)
Date:   Fri, 25 Feb 2022 11:55:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 20/39] x86/bugs: Disable Retpoline when IBT
Message-ID: <Yhi1jKbcjayFARNR@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.189353523@infradead.org>
 <202202241710.B35CBB06@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202241710.B35CBB06@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 05:11:23PM -0800, Kees Cook wrote:
> On Thu, Feb 24, 2022 at 03:51:58PM +0100, Peter Zijlstra wrote:
> > Retpoline and IBT are mutually exclusive. IBT relies on indirect
> > branches (JMP/CALL *%reg) while retpoline avoids them by design.
> > 
> > Demote to LFENCE on IBT enabled hardware.
> 
> What's the expected perf impact of this?

Well, the expected case is that this is all dead code because any part
that has IBT also has eIBRS and if we have eIBRS we never use retpolines
as per the current code.

The only case is virt, where someone could expose IBT and not eIBRS, in
which case this will, as per Josh's answer, make things faster since
LFENCE sucks less than full Retpoline.
