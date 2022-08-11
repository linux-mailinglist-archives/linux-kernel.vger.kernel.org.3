Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89864590875
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiHKV6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbiHKV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:58:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B9CA00E2;
        Thu, 11 Aug 2022 14:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 372FC614FB;
        Thu, 11 Aug 2022 21:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0524BC433C1;
        Thu, 11 Aug 2022 21:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1660255109;
        bh=49zAkC4NEbp3XZMI4LrxZVUb78dcWzxz8e4v7RDgeIs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q27mOMtgOHkMq+0kgmtbcaRxRObU+nOTFrEP3s3Ut8f37CzSWCEA6s/Kb9UWdh+3F
         fRIqkszPmMNuonLYuYFshBoaf7QazDTnDglNiafa8nCntf8Sf6SOaD/3tXsCEWAZqp
         /13K6MRs3Tdz4LzNdY1vIk/5U0JoDFq/2FnBHRQg=
Date:   Thu, 11 Aug 2022 14:58:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Cc:     masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, nathan@kernel.org, peterz@infradead.org,
        keescook@chromium.org, jpoimboe@kernel.org,
        dan.j.williams@intel.com, isabbasso@riseup.net,
        edumazet@google.com, vbabka@suse.cz, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] kbuild: add option to set max level of debug info
Message-Id: <20220811145828.89b64e663a18fbb8d7fdea06@linux-foundation.org>
In-Reply-To: <20220804223504.4739-1-dmitrii.bundin.a@gmail.com>
References: <20220804223504.4739-1-dmitrii.bundin.a@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  5 Aug 2022 01:35:04 +0300 Dmitrii Bundin <dmitrii.bundin.a@gmail.com> wrote:

> When compiling with -g3 option and debugging with gdb it provides some
> extra abilities like macro expand, info macro etc... It's sometimes
> useful to unerstand behavior of complicated macros.
> 
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -304,6 +304,15 @@ config DEBUG_INFO_REDUCED
>  	  DEBUG_INFO build and compile times are reduced too.
>  	  Only works with newer gcc versions.
>  
> +config DEBUG_INFO_MAXLEVEL
> +	bool "Maximum debug information level"
> +	depends on !DEBUG_INFO_REDUCED
> +	default n
> +	help
> +	  Sets the maximum level of debug information compilers may generate
> +	  (-g3). Enabling this option will require significantly more disk space
> +	  and increase built time, but it's useful for debugging purposes.
> +
>  config DEBUG_INFO_COMPRESSED
>  	bool "Compressed debugging information"
>  	depends on $(cc-option,-gz=zlib)
> diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
> index 9f39b0130551..7e1d8beecfc4 100644
> --- a/scripts/Makefile.debug
> +++ b/scripts/Makefile.debug
> @@ -2,6 +2,8 @@ DEBUG_CFLAGS	:=
>  
>  ifdef CONFIG_DEBUG_INFO_SPLIT
>  DEBUG_CFLAGS	+= -gsplit-dwarf
> +else ifdef CONFIG_DEBUG_INFO_MAXLEVEL
> +DEBUG_CFLAGS	+= -g3
>  else
>  DEBUG_CFLAGS	+= -g
>  endif

What happens when the gcc developers add -g4?  Or if a user wants -g2?

In other words, can we make this a Kconfig-selectable level, with the
default `1'?
