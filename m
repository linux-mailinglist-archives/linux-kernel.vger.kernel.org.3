Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D149B4C5248
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 00:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiBYXwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 18:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiBYXwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 18:52:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06D3E203BF7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645833089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y2IBGil2YdvPDM255vltKaypTxD3n81LpuJed8Qxq7M=;
        b=LDkO7al2kz+V+RqYbSt3bMOqfCMksr9P0gOa/dscAJET4c2YAARkQKWKq8XFhEOn3+VlBu
        e1EAAuxg0HLpgCQe3VCKbSCY0uGRtuYTCGIdoq6OyUT/UgszZYirZI0Euzbg0KHyZ+UMdZ
        UO7z3GO+GTo3FMJQvP/RzyW1yBqnGjw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-355-brbvTv6cNGqtlK6gP3zgTg-1; Fri, 25 Feb 2022 18:51:27 -0500
X-MC-Unique: brbvTv6cNGqtlK6gP3zgTg-1
Received: by mail-oo1-f71.google.com with SMTP id z4-20020a4ad1a4000000b0031beb2043f7so3707751oor.20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 15:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y2IBGil2YdvPDM255vltKaypTxD3n81LpuJed8Qxq7M=;
        b=TVJbnREaXVP7rJQnbluSGA4YyxrguXJIqzLe283Zg7lQHLVKeCbc3EHTWWHpakCMOi
         p+HNGTXlzaborgGJXP51U7yOibv3aPwytkwrmOUrTSxRk6wpDIVgaZp2DGfvotWe5UdL
         Ww4xbrN00uPwAmOvzDiLU780nd3l2PPn4wQqR4WCgFnAF7MrUUAeNKTdwOWzNRZMJz8C
         aVAjPIwJz9PbQq2sgH/Q1Bv7w+cSX/srHnURMPlgp/Bn1gBwqMCkdIylCc9hFzzM7vkv
         LGLS+TSHmiMSCay79wrhzlNZ19glC6fIIhqmzsqVPs1SGttqelZ6jXjbQGYS1UuFj2/m
         eT5A==
X-Gm-Message-State: AOAM5310GrfoK6zjbXJLbLGhjXQjba/zpp9rhwXFPHyer8pxYWJu9TX3
        7I5W+4e/mqR6Ue9k1M9YWVuTsXs715MoJ1rBC5U7EPN0gl/x/vk2akLdHthVBu3cK7ka+uh/IWE
        97NB+OV5Y7DSw8t2f7aVSeo+7
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id 66-20020a9d06c8000000b005ad5a1ef79dmr3981648otx.154.1645833086889;
        Fri, 25 Feb 2022 15:51:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwtX1UpdaaTh689RLxHzcJpgb8zEzYb7jqpzo8JJBVfDMO4NcDtQpoGeessluDemnGXPmh2WQ==
X-Received: by 2002:a9d:6c8:0:b0:5ad:5a1e:f79d with SMTP id 66-20020a9d06c8000000b005ad5a1ef79dmr3981634otx.154.1645833086509;
        Fri, 25 Feb 2022 15:51:26 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id y19-20020a056830209300b005afb1e59e0fsm1743857otq.55.2022.02.25.15.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 15:51:26 -0800 (PST)
Date:   Fri, 25 Feb 2022 15:51:22 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 18/39] x86/ibt: Add IBT feature, MSR and #CP handling
Message-ID: <20220225235122.lhhsfzamd5pfm7ue@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151323.069205370@infradead.org>
 <20220224235516.qdikcfdl7jo35iu6@treble>
 <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yhi0lY8w3E5VKquU@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 11:51:01AM +0100, Peter Zijlstra wrote:
> > > +bool ibt_selftest(void)
> > > +{
> > > +	unsigned long ret;
> > > +
> > > +	asm ("1: lea 2f(%%rip), %%rax\n\t"
> > > +	     ANNOTATE_RETPOLINE_SAFE
> > > +	     "   jmp *%%rax\n\t"
> > > +	     ASM_REACHABLE
> > > +	     ANNOTATE_NOENDBR
> > > +	     "2: nop\n\t"
> > > +
> > > +	     /* unsigned ibt_selftest_ip = 2b */
> > > +	     ".pushsection .rodata,\"a\"\n\t"
> > > +	     ".align 8\n\t"
> > > +	     ".type ibt_selftest_ip, @object\n\t"
> > > +	     ".size ibt_selftest_ip, 8\n\t"
> > > +	     "ibt_selftest_ip:\n\t"
> > > +	     ".quad 2b\n\t"
> > > +	     ".popsection\n\t"
> > 
> > It's still seems silly to make this variable in asm.
> > 
> > Also .rodata isn't going to work for CPU hotplug.
> 
> It's just the IP, that stays invariant. I'm not sure how else to match
> regs->ip to 2 in #CP.

Ah, I see what you mean now.  Still, it can just reference the code
label itself without having to allocate storage:

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4806fa0adec7..cfaa05ddd1ec 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -225,7 +225,7 @@ static void handle_endbr(struct pt_regs *regs)
 	BUG();
 }
 
-extern const unsigned long ibt_selftest_ip; /* defined in asm beow */
+void ibt_selftest_ip(void); /* code label defined in asm below */
 
 DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 {
@@ -237,7 +237,7 @@ DEFINE_IDTENTRY_ERRORCODE(exc_control_protection)
 	if (WARN_ON_ONCE(user_mode(regs) || error_code != 3))
 		return;
 
-	if (unlikely(regs->ip == ibt_selftest_ip)) {
+	if (unlikely(regs->ip == (unsigned long)ibt_selftest_ip)) {
 		regs->ax = 0;
 		return;
 	}
@@ -249,22 +249,12 @@ bool ibt_selftest(void)
 {
 	unsigned long ret;
 
-	asm ("1: lea 2f(%%rip), %%rax\n\t"
+	asm ("1: lea ibt_selftest_ip(%%rip), %%rax\n\t"
 	     ANNOTATE_RETPOLINE_SAFE
 	     "   jmp *%%rax\n\t"
 	     ASM_REACHABLE
 	     ANNOTATE_NOENDBR
-	     "2: nop\n\t"
-
-	     /* unsigned ibt_selftest_ip = 2b */
-	     ".pushsection .rodata,\"a\"\n\t"
-	     ".align 8\n\t"
-	     ".type ibt_selftest_ip, @object\n\t"
-	     ".size ibt_selftest_ip, 8\n\t"
-	     "ibt_selftest_ip:\n\t"
-	     ".quad 2b\n\t"
-	     ".popsection\n\t"
-
+	     "ibt_selftest_ip: nop\n\t"
 	     : "=a" (ret) : : "memory");
 
 	return !ret;

