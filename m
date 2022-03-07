Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DEA4CFCE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241979AbiCGLbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241772AbiCGLar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:30:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B5E24598
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oSz3DPnkeU8LZIj+TvEQPWLYdk62KVKTnGo8SPdsSYk=; b=TKV6guTPKJ59VSHum1McQ4Uq+c
        K+/8tzPA5SjcOnPwKTsMqYYmr/QxTjokutLhENg7idcX/SpRjDGI1PXJnh2PiF85pVdzU8jhJpsXX
        xpbK/gNStQbaw/GwxkJyYm6jc/R+RYLjB78SuUzvdYRUb34sLk0WlRXG7w1veABCWr066iI8hr6WT
        Go0ZYJi97yh3JslqynYa1M47WcfmBFURY9SlX7vGa56WcrvCFdfEwdpBAwkgb9I/+XRGVMcumulXa
        Qeg8rEzr6xm30L3Ux7gMUNrHkgw72gc2cs9dr4V1amLqdz0dRfEmU3YycVNVyoVAe1ezBlQHaOeW8
        OuSUDi/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRBMg-00FAEv-19; Mon, 07 Mar 2022 11:17:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57BBF3002BE;
        Mon,  7 Mar 2022 12:17:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BB352D371F79; Mon,  7 Mar 2022 12:17:19 +0100 (CET)
Date:   Mon, 7 Mar 2022 12:17:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 04/39] x86/ibt: Base IBT bits
Message-ID: <YiXpv0q88paPHPqF@hirez.programming.kicks-ass.net>
References: <20220303112321.422525803@infradead.org>
 <20220303112825.190662703@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303112825.190662703@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:25PM +0100, Peter Zijlstra wrote:

> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -62,8 +62,11 @@ export BITS
>  #
>  KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
>  
> -# Intel CET isn't enabled in the kernel
> +ifeq ($(CONFIG_X86_KERNEL_IBT),y)
> +KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
> +else
>  KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
> +endif
>  
>  ifeq ($(CONFIG_X86_32),y)
>          BITS := 32

Joao reported that RETPOLINE=n builds explode; turns out the compilers
default to using NOTRACK prefixes for jump-tables and we explicitly do
not enable that security compromise for the kernel.

Since the compilers don't have explicit control over NOTRACK generation,
blanket disable jump-tables when using IBT without RETPOLINE.

Joao will be submitting GCC and Clang bugreports on this shortly.

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index d38c18f4bd53..f80a425e7d29 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -63,7 +63,9 @@ export BITS
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
 ifeq ($(CONFIG_X86_KERNEL_IBT),y)
-KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
+# Explicitly disable jump-tables, also implied by RETPOLINE=y, for kernel IBT
+# to avoid NOTRACK prefixes.
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch -fno-jump-tables)
 else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
 endif
