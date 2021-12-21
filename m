Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4226047C117
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238318AbhLUN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:58:02 -0500
Received: from elvis.franken.de ([193.175.24.41]:58826 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238308AbhLUN6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:58:01 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1mzfeR-0000gu-01; Tue, 21 Dec 2021 14:57:59 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 67A92C09D8; Tue, 21 Dec 2021 14:57:36 +0100 (CET)
Date:   Tue, 21 Dec 2021 14:57:36 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Adrian Schmutzler <freifunk@adrianschmutzler.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Octeon: Fix build errors using clang
Message-ID: <20211221135736.GB9153@alpha.franken.de>
References: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216095014.11918-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
> ---
>  arch/mips/include/asm/octeon/cvmx-bootinfo.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
