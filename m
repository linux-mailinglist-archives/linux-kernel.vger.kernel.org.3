Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0045186B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237090AbiECOeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbiECOeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:34:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 963C832078;
        Tue,  3 May 2022 07:30:31 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D45913D5;
        Tue,  3 May 2022 07:30:31 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A9493F774;
        Tue,  3 May 2022 07:30:30 -0700 (PDT)
Date:   Tue, 3 May 2022 15:30:28 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org
Subject: Re: [PATCH] linkage: Fix issue with missing symbol size
Message-ID: <YnE8hLAYY93xkgdv@lakrids>
References: <20220429091859.GS2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429091859.GS2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 11:18:59AM +0200, Peter Zijlstra wrote:
> 
> Occasionally, typically when a function doesn't end with 'ret', an
> alias on that function will have 0 size.
> 
> The difference between what GCC generates and our linkage magic, is
> that GCC doesn't appear to provide .size for the alias'ed symbol at
> all. And indeed, removing this directive cures the issue.
> 
> Additionally, GCC also doesn't emit .type for alias symbols either, so
> also omit that.
> 
> Fixes: e0891269a8c2 ("linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()")
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Sorry about this!

FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  include/linux/linkage.h |   15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/linkage.h
> +++ b/include/linux/linkage.h
> @@ -171,12 +171,9 @@
>  
>  /* SYM_ALIAS -- use only if you have to */
>  #ifndef SYM_ALIAS
> -#define SYM_ALIAS(alias, name, sym_type, linkage)			\
> -	linkage(alias) ASM_NL						\
> -	.set alias, name ASM_NL						\
> -	.type alias sym_type ASM_NL					\
> -	.set .L__sym_size_##alias, .L__sym_size_##name ASM_NL		\
> -	.size alias, .L__sym_size_##alias
> +#define SYM_ALIAS(alias, name, linkage)			\
> +	linkage(alias) ASM_NL				\
> +	.set alias, name ASM_NL
>  #endif
>  
>  /* === code annotations === */
> @@ -261,7 +258,7 @@
>   */
>  #ifndef SYM_FUNC_ALIAS
>  #define SYM_FUNC_ALIAS(alias, name)					\
> -	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_GLOBAL)
> +	SYM_ALIAS(alias, name, SYM_L_GLOBAL)
>  #endif
>  
>  /*
> @@ -269,7 +266,7 @@
>   */
>  #ifndef SYM_FUNC_ALIAS_LOCAL
>  #define SYM_FUNC_ALIAS_LOCAL(alias, name)				\
> -	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_LOCAL)
> +	SYM_ALIAS(alias, name, SYM_L_LOCAL)
>  #endif
>  
>  /*
> @@ -277,7 +274,7 @@
>   */
>  #ifndef SYM_FUNC_ALIAS_WEAK
>  #define SYM_FUNC_ALIAS_WEAK(alias, name)				\
> -	SYM_ALIAS(alias, name, SYM_T_FUNC, SYM_L_WEAK)
> +	SYM_ALIAS(alias, name, SYM_L_WEAK)
>  #endif
>  
>  /* SYM_CODE_START -- use for non-C (special) functions */
> 
