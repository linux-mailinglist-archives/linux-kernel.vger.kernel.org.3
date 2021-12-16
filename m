Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C7247774C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 17:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235809AbhLPQLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 11:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhLPQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 11:11:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08692C061574;
        Thu, 16 Dec 2021 08:11:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46C71B824BA;
        Thu, 16 Dec 2021 16:11:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00C3C36AE0;
        Thu, 16 Dec 2021 16:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639671098;
        bh=fhSrIE9HXnpLAePIPe5kX88KewxwOd5SeCeH2Agq+dU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MxPgKfBmLudM/C0tGXdUpYGFcXulZRtvH4bY8gKjELG40F6EE+p83JMh+hP6MrmzD
         qHKHMj7lKzKKYs/RQK7N025FBjy3JRisluccE4aGJqFMwrTNajV6hlmmqd3ZEf4pIX
         GhOyh4RxeUDkc/sY7FAt+LaaoXw3lznMCwIKkV4AJQSJX8GcAha9AP+Aln/sQ8CgmC
         9iAZ6S7wmcXdRjTxpRDjcXmLCYJNQlhrrFQvWpDi0KJHUglzCObJZwTC7jjNZuWH1b
         0K6nV8BqxnfaoSNyxebAh2JpWDQzMJMxsja+QUaLH4akTyQKa8EavUj3Vea+VdERGM
         0TzhpKJi/XbvQ==
Date:   Thu, 16 Dec 2021 09:11:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Fix build errors using clang
Message-ID: <YbtlNT7WUi3b8Dqh@archlinux-ax161>
References: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:50:14PM +0800, Tianjia Zhang wrote:
> A large number of the following errors is reported when compiling
> with clang:
> 
>   cvmx-bootinfo.h:326:3: error: adding 'int' to a string does not append to the string [-Werror,-Wstring-plus-int]
>                   ENUM_BRD_TYPE_CASE(CVMX_BOARD_TYPE_NULL)
>                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
>           case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                          ~~~^~~~
>   cvmx-bootinfo.h:326:3: note: use array indexing to silence this warning
>   cvmx-bootinfo.h:321:20: note: expanded from macro 'ENUM_BRD_TYPE_CASE'
>           case x: return(#x + 16);        /* Skip CVMX_BOARD_TYPE_ */
>                           ^
> 
> Follow the prompts to use the address operator '&' to fix this error.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/octeon/cvmx-bootinfo.h b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> index 0e6bf220db61..6c61e0a63924 100644
> --- a/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> +++ b/arch/mips/include/asm/octeon/cvmx-bootinfo.h
> @@ -318,7 +318,7 @@ enum cvmx_chip_types_enum {
>  
>  /* Functions to return string based on type */
>  #define ENUM_BRD_TYPE_CASE(x) \
> -	case x: return(#x + 16);	/* Skip CVMX_BOARD_TYPE_ */
> +	case x: return (&#x[16]);	/* Skip CVMX_BOARD_TYPE_ */
>  static inline const char *cvmx_board_type_to_string(enum
>  						    cvmx_board_types_enum type)
>  {
> @@ -410,7 +410,7 @@ static inline const char *cvmx_board_type_to_string(enum
>  }
>  
>  #define ENUM_CHIP_TYPE_CASE(x) \
> -	case x: return(#x + 15);	/* Skip CVMX_CHIP_TYPE */
> +	case x: return (&#x[15]);	/* Skip CVMX_CHIP_TYPE */
>  static inline const char *cvmx_chip_type_to_string(enum
>  						   cvmx_chip_types_enum type)
>  {
> -- 
> 2.32.0
> 
