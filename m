Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFE4D2AB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiCIIgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 03:36:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiCIIgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 03:36:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775070046
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 00:35:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 631D5210ED;
        Wed,  9 Mar 2022 08:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646814942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTHzCmhPfqxvRLxF+O1Z3NpIP0vvYhiZC42fCnuo32c=;
        b=JCQ8ryY7sAPoShoA+BY7+DOHhpT78675rY8skEqERAv2Gh0NtniW9F2BE7jbiafxblaEdB
        1cACtvRHKulCbmg2zrvC5gpF57GW3hCXailJ08Qjnt1Qe9yeivAVpz4YZNQay/s8oQaXYH
        gI8F/7CL+lG9osKzgOIpDadvcrfH39o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646814942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTHzCmhPfqxvRLxF+O1Z3NpIP0vvYhiZC42fCnuo32c=;
        b=uNg66GUoH4NFONTM4nS7OLENgyCLMagXot1GqDUSSz2I1xp3cCkHic1EazKRZAuDKv4vV1
        JNuBl7/34unJWtAg==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CBDD9A3B85;
        Wed,  9 Mar 2022 08:35:41 +0000 (UTC)
Date:   Wed, 9 Mar 2022 09:35:41 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 04/45] objtool,efi: Update __efi64_thunk annotation
In-Reply-To: <20220308154317.402118218@infradead.org>
Message-ID: <alpine.LSU.2.21.2203090934310.672@pobox.suse.cz>
References: <20220308153011.021123062@infradead.org> <20220308154317.402118218@infradead.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/x86/platform/efi/efi_thunk_64.S
> +++ b/arch/x86/platform/efi/efi_thunk_64.S
> @@ -20,12 +20,14 @@
>   */
>  
>  #include <linux/linkage.h>
> +#include <linux/objtool.h>
>  #include <asm/page_types.h>
>  #include <asm/segment.h>
>  
>  	.text
>  	.code64
> -SYM_CODE_START(__efi64_thunk)
> +SYM_FUNC_START(__efi64_thunk)
> +STACK_FRAME_NON_STANDARD __efi64_thunk

I would prefer if STACK_FRAME_NON_STANDARD annotation...

>  	push	%rbp
>  	push	%rbx
>  
> @@ -79,7 +81,7 @@ SYM_CODE_START(__efi64_thunk)
>  2:	pushl	$__KERNEL_CS
>  	pushl	%ebp
>  	lret
> -SYM_CODE_END(__efi64_thunk)
> +SYM_FUNC_END(__efi64_thunk)

went here after SYM_FUNC_END(), but that is just a cosmetic nit.

Miroslav
