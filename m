Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311A34D8049
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiCNLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiCNLA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:00:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8BD36B47
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 03:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=86nbLiR0MkBXCOLBGSi53xPDKrTVsOY11BL+JmwuMJY=; b=Ge4R7dvmihFJcEPRq5KCmBbCs2
        w2432IoagskBOyKKKKJFNUn5t0sb68FlZLfaUXYuiaXa5IBuoCbFJLGyMUKkXzKBTm0bCuyGhRv9A
        VrcL5TOJqkGRsvliRB1mjhwLZQ/PelJ/wH/Q9RMDBm1pBJLJOyyEplQszhLp/elvjcy23PTw3CTAb
        1CvKBrf3debS0xkw06Bm8jdCQJvjx7ymDhKQs9JVG2CdT5N9DYIw7OaZazgHllnwJSZQr/r4TzAXH
        YQVNxtR9XKClf7hgIOiFUqbGXPXndje8UagfWeUqEpyTSSKS9p6SDv58TWpE7D5aJJ8R7QtuB57CQ
        jrDGS8AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTiPm-003xgm-Hh; Mon, 14 Mar 2022 10:59:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 032983001FD;
        Mon, 14 Mar 2022 11:59:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD23933FA5132; Mon, 14 Mar 2022 11:59:00 +0100 (CET)
Date:   Mon, 14 Mar 2022 11:59:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/nmi: Remove the 'strange power saving mode' hint
 from unknown NMI handler
Message-ID: <Yi8f9PYNEHksy3io@hirez.programming.kicks-ass.net>
References: <nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2203140924120.24795@cbobk.fhfr.pm>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 09:25:18AM +0100, Jiri Kosina wrote:
> From: Jiri Kosina <jkosina@suse.cz>
> 
> The 'Do you have a strange power saving mode enabled?' hint when unknown 
> NMI happens dates back to i386 stone age, and isn't currently really 
> helpful.
> 
> Unknown NMIs are coming for many different reasons (broken firmware, 
> faulty hardware, ...) and rarely have anything to do with 'strange power 
> saving mode' (whatever that even is).
> 
> Just remove it as it's largerly misleading.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Fair enough,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/kernel/nmi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 4bce802d25fb..e73f7df362f5 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -292,7 +292,6 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
>  	pr_emerg("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
>  		 reason, smp_processor_id());
>  
> -	pr_emerg("Do you have a strange power saving mode enabled?\n");
>  	if (unknown_nmi_panic || panic_on_unrecovered_nmi)
>  		nmi_panic(regs, "NMI: Not continuing");
>  
> -- 
> Jiri Kosina
> SUSE Labs
> 
