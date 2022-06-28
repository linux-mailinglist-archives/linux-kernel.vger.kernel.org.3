Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE6C55E1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbiF1K3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 06:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiF1K3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A068B2E9F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 03:29:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37D45618F8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF16C3411D;
        Tue, 28 Jun 2022 10:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656412148;
        bh=+YIuG1Dsd0HeHOGBZVaaHHzCNV1scW8f/GDWrpvaTgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7tM/ZPU6SO5+GzGwBpa/Gm78NTdkVjUYN/gGRSA9HumjmIxnx5h0nEc+TLzGwiuP
         4/6v/JK+wVj+2rbcuWtx0eEVl3FwxN+6sbcfNQmqfJ2e0G/pFAB3X5hU1JepRhWpZl
         qrlHvaKgG7brJFCcdAo9InJmEWK00AAka9wMITObRplPoiXlsnMUV87OrYc0wgC6hG
         nmZnjYq5QMIUZT0hwVDwil0EC7i6DwtwWD7UiRLBJ3xOVMRzkMupHwZYpTQiDHBBfR
         b6X+nhf0qoVBc0MZEOAIxnEu/2xa4qADQFSuyZpbq7ouCLfi83etTAh6lI9iI8kLBS
         64nHOY2oTKZdg==
Date:   Tue, 28 Jun 2022 13:28:55 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     masahiroy@kernel.org, mmarek@suse.cz, paul.gortmaker@windriver.com,
        arnd@arndb.de, bp@alien8.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] kconfig: Add implicit CONFIG_ prefix to
 IS_ENABLED() and co
Message-ID: <YrrX594QO2pnpLxM@kernel.org>
References: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrrQOifFIiISf/3g@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:56:10AM +0200, Peter Zijlstra wrote:
> 
> Since IS_ENABLED() (and friends) are clearly meant to be used on
> CONFIG_foo symbols and IS_ENABLED(CONFIG_ is so long and almost an
> tautology, allow the more compact usage of: IS_ENABLED(foo).
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

FWIW: 
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> With this on, something like:
> 
>   for i in IS_BUILTIN IS_MODULE IS_REACHABLE IS_ENABLED;
>   do
> 	git grep -wl $i | while read file;
> 	do
> 		sed -ie "s/${i}(CONFIG_/${i}(/g" $file;
>       done;
>   done
> 
> can be used to convert all existing instance. Allowing, after time
> passes, to remove the CONFIG_ usage if so desired.
> 
> ---
>  tools/include/linux/kconfig.h   |    7 ++++---
>  include/linux/kconfig.h         |    7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/kconfig.h
> +++ b/include/linux/kconfig.h
> @@ -38,6 +38,7 @@
>   * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
>   * the last step cherry picks the 2nd arg, we get a zero.
>   */
> +#define _is_defined(x)			__or(__is_defined(x), __is_defined(CONFIG_##x))
>  #define __is_defined(x)			___is_defined(x)
>  #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
>  #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
> @@ -47,14 +48,14 @@
>   * otherwise. For boolean options, this is equivalent to
>   * IS_ENABLED(CONFIG_FOO).
>   */
> -#define IS_BUILTIN(option) __is_defined(option)
> +#define IS_BUILTIN(option) _is_defined(option)
>  
>  /*
>   * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
>   * otherwise.  CONFIG_FOO=m results in "#define CONFIG_FOO_MODULE 1" in
>   * autoconf.h.
>   */
> -#define IS_MODULE(option) __is_defined(option##_MODULE)
> +#define IS_MODULE(option) _is_defined(option##_MODULE)
>  
>  /*
>   * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
> @@ -63,7 +64,7 @@
>   * built-in code when CONFIG_FOO is set to 'm'.
>   */
>  #define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
> -				__and(IS_MODULE(option), __is_defined(MODULE)))
> +				__and(IS_MODULE(option), _is_defined(MODULE)))
>  
>  /*
>   * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
> --- a/tools/include/linux/kconfig.h
> +++ b/tools/include/linux/kconfig.h
> @@ -32,6 +32,7 @@
>   * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
>   * the last step cherry picks the 2nd arg, we get a zero.
>   */
> +#define _is_defined(x)			__or(__is_defined(x), __is_defined(CONFIG_##x))
>  #define __is_defined(x)			___is_defined(x)
>  #define ___is_defined(val)		____is_defined(__ARG_PLACEHOLDER_##val)
>  #define ____is_defined(arg1_or_junk)	__take_second_arg(arg1_or_junk 1, 0)
> @@ -41,13 +42,13 @@
>   * otherwise. For boolean options, this is equivalent to
>   * IS_ENABLED(CONFIG_FOO).
>   */
> -#define IS_BUILTIN(option) __is_defined(option)
> +#define IS_BUILTIN(option) _is_defined(option)
>  
>  /*
>   * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
>   * otherwise.
>   */
> -#define IS_MODULE(option) __is_defined(option##_MODULE)
> +#define IS_MODULE(option) _is_defined(option##_MODULE)
>  
>  /*
>   * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
> @@ -56,7 +57,7 @@
>   * built-in code when CONFIG_FOO is set to 'm'.
>   */
>  #define IS_REACHABLE(option) __or(IS_BUILTIN(option), \
> -				__and(IS_MODULE(option), __is_defined(MODULE)))
> +				__and(IS_MODULE(option), _is_defined(MODULE)))
>  
>  /*
>   * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
> 

-- 
Sincerely yours,
Mike.
