Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806244D8779
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 15:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiCNOyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 10:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiCNOy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 10:54:26 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C1FD2610D;
        Mon, 14 Mar 2022 07:53:16 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1nTm4N-0006nG-01; Mon, 14 Mar 2022 15:53:11 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id B3FF9C2E31; Mon, 14 Mar 2022 15:51:08 +0100 (CET)
Date:   Mon, 14 Mar 2022 15:51:08 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     yaliang.wang@windriver.com
Cc:     rppt@kernel.org, huangpei@loongson.cn, akpm@linux-foundation.org,
        kumba@gentoo.org, geert@linux-m68k.org, anshuman.khandual@arm.com,
        penberg@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: pgalloc: fix memory leak caused by pgd_free()
Message-ID: <20220314145108.GB13438@alpha.franken.de>
References: <20220310113116.2068859-1-yaliang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310113116.2068859-1-yaliang.wang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:31:16PM +0800, yaliang.wang@windriver.com wrote:
> From: Yaliang Wang <Yaliang.Wang@windriver.com>
> 
> pgd page is freed by generic implementation pgd_free() since commit
> f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()"),
> however, there are scenarios that the system uses more than one page as
> the pgd table, in such cases the generic implementation pgd_free() won't
> be applicable anymore. For example, when PAGE_SIZE_4KB is enabled and
> MIPS_VA_BITS_48 is not enabled in a 64bit system, the macro "PGD_ORDER"
> will be set as "1", which will cause allocating two pages as the pgd
> table. Well, at the same time, the generic implementation pgd_free()
> just free one pgd page, which will result in the memory leak.
> 
> The memory leak can be easily detected by executing shell command:
> "while true; do ls > /dev/null; grep MemFree /proc/meminfo; done"
> 
> Fixes: f9cb654cb550 ("asm-generic: pgalloc: provide generic pgd_free()")
> Signed-off-by: Yaliang Wang <Yaliang.Wang@windriver.com>
> ---
>  arch/mips/include/asm/pgalloc.h | 6 ++++++
>  1 file changed, 6 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
