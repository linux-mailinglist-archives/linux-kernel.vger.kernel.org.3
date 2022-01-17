Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2744491202
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 23:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbiAQW4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 17:56:12 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39612 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiAQW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 17:56:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52750611EC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2023C36AE7;
        Mon, 17 Jan 2022 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642460169;
        bh=qvmPclBKDpmSxW957MvT1pemDeU3jcl+8YWb+YVrSO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3ezhzSIXZqON9LT8WXqJ8NBBUmHy36LF3NDeiS6txvIi1gRIu3YqY2NPpk8cCxZs
         iERN3SjX2xxkRrueQRXrsg+gCrf8q2/ldFp2MWnRf8y0nuJIWEi237POaHra3nZcDT
         oUSC16vvJSSflW7t0Ta7Bs/HfZLUASR/lVlRwH5iP9Qf2hM96K1Pm+E2lFCENmOPAc
         tIb1iCd7OA4kddPHM3dbTL5QwCHfso0rVp+d4Cn8BNGNoKsl9QQ3bwHsYgppLhxrNx
         fhxNaN7OrEXuQd5cZGoesbV+2kmGJGzpeNg8Q+wVlaI7SHCpUrtRE26Rm9UDFjC4Xl
         2t2A5iyWLaLog==
Date:   Mon, 17 Jan 2022 15:56:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Yinan Liu <yinan@linux.alibaba.com>
Cc:     rostedt@goodmis.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] script/sorttable: fix some initialization problems
Message-ID: <YeX0BQOQYKI+95eP@archlinux-ax161>
References: <20220115225920.0e5939aa@gandalf.local.home>
 <20220117062344.15633-1-yinan@linux.alibaba.com>
 <20220117062344.15633-2-yinan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117062344.15633-2-yinan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 02:23:44PM +0800, Yinan Liu wrote:
> elf_mcount_loc and mcount_sort_thread definitions are not
> initialized immediately within the function, which can cause
> the judgment logic to use uninitialized values when the
> initialization logic of subsequent code fails.
> 
> Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com
> 
> Fixes:72b3942a173c (scripts: ftrace - move the sort-processing in ftrace_init)

This should be:

Fixes: 72b3942a173c ("scripts: ftrace - move the sort-processing in ftrace_init")

You can add an alias to always get the format right, like:

$ git config --global alias.fixes 'show -s --format="Fixes: %h (\"%s\")"'

$ git fixes 72b3942a173c387b27860ba1069636726e208777
Fixes: 72b3942a173c ("scripts: ftrace - move the sort-processing in ftrace_init")

> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>

This resolves the warnings I reported and does not introduce any new
ones. It seems reasonable to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  scripts/sorttable.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/sorttable.h b/scripts/sorttable.h
> index 1e8b77928fa4..13ae3262ec96 100644
> --- a/scripts/sorttable.h
> +++ b/scripts/sorttable.h
> @@ -199,6 +199,8 @@ static int compare_extable(const void *a, const void *b)
>  	return 0;
>  }
>  #ifdef MCOUNT_SORT_ENABLED
> +pthread_t mcount_sort_thread;
> +
>  struct elf_mcount_loc {
>  	Elf_Ehdr *ehdr;
>  	Elf_Shdr *init_data_sec;
> @@ -282,10 +284,9 @@ static int do_sort(Elf_Ehdr *ehdr,
>  	unsigned int shnum;
>  	unsigned int shstrndx;
>  #ifdef MCOUNT_SORT_ENABLED
> -	struct elf_mcount_loc mstruct;
> +	struct elf_mcount_loc mstruct = {NULL, NULL, 0, 0};

Wonder if this would be better using either '= {}' or '= {0}'?

>  	uint_t _start_mcount_loc = 0;
>  	uint_t _stop_mcount_loc = 0;
> -	pthread_t mcount_sort_thread;
>  #endif
>  #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
>  	unsigned int orc_ip_size = 0;
> -- 
> 2.19.1.6.gb485710b
> 
> 
