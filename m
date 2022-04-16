Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D40C503702
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 16:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiDPOJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiDPOJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 10:09:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725FE1BE9B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 07:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B4A5B81D08
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 14:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF118C385A1;
        Sat, 16 Apr 2022 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650117991;
        bh=NBki7mRtf9UFQc10+FewhE0a/KpNtdwZJZ4uucd1VX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BHFYxQHuL6O6roK1z8yYzua5jpwcSYr+GAYeFawfMEJNIjActkGzPXRtBUjgH6eeY
         r1dW8ld5O0hJHUk2XVkKPGllK4aI6/bG7QsnygbA2GphxcwRMfE2Cnc7kkGgT/Ja/Z
         HWYYF/ykN3s2hiZER7Ahik941fns6wytUUbNX4b6GGfXyEI4AQnVen81wB87Enj+bu
         C/7hQohjk3Rz51mUu5bOxRx/MgRujaQsviFLD3u4GsA7aZ4CNZ5hU1l+9cCq1tZ85q
         LIifJlPHMsEExB7KSiCR17r5SHbi5XvNRs3AyRKdca7f1pR656aEizmd367IEmE/aG
         /3uAMboN4ksLQ==
Date:   Sat, 16 Apr 2022 23:06:28 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Adam Zabrocki <pi3@pi3.com.pl>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix KRETPROBES when
 CONFIG_KRETPROBE_ON_RETHOOK is set
Message-Id: <20220416230628.40d09e2742cda9777e2e180e@kernel.org>
In-Reply-To: <20220415181006.GA14021@pi3.com.pl>
References: <20220415180723.GA13921@pi3.com.pl>
        <20220415181006.GA14021@pi3.com.pl>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2022 20:10:06 +0200
Adam Zabrocki <pi3@pi3.com.pl> wrote:

> [PATCH] x86/kprobes: Fix KRETPROBES when CONFIG_KRETPROBE_ON_RETHOOK is set
> 
> The recent kernel change "kprobes: Use rethook for kretprobe if possible",
> introduced a potential NULL pointer dereference bug in the KRETPROBE
> mechanism. The official Kprobes documentation defines that "Any or all
> handlers can be NULL". Unfortunately, there is a missing return handler
> verification to fulfill these requirements and can result in a NULL pointer
> dereference bug.
> 
> This patch adds such verification in kretprobe_rethook_handler() function.
> 

Good catch! I forgot that user can register kretprobe without handler...

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> Fixes: 73f9b911faa7 ("kprobes: Use rethook for kretprobe if possible")
> Signed-off-by: Adam Zabrocki <pi3@pi3.com.pl>
> ---
>  kernel/kprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index dbe57df2e199..dd58c0be9ce2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2126,7 +2126,7 @@ static void kretprobe_rethook_handler(struct rethook_node *rh, void *data,
>  	struct kprobe_ctlblk *kcb;
>  
>  	/* The data must NOT be null. This means rethook data structure is broken. */
> -	if (WARN_ON_ONCE(!data))
> +	if (WARN_ON_ONCE(!data) || !rp->handler)
>  		return;
>  
>  	__this_cpu_write(current_kprobe, &rp->kp);
> 
> -- 
> pi3 (pi3ki31ny) - pi3 (at) itsec pl
> http://pi3.com.pl
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
