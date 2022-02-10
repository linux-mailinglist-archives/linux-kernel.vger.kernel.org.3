Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B610E4B07A0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiBJH61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:58:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235869AbiBJH60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:58:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078171086
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:58:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FD6A60F49
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41661C340ED;
        Thu, 10 Feb 2022 07:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644479906;
        bh=sOyBT9KTJ9e8RVarYf7lEUeFi0anfb6hhv8VDPpph74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=gZhsakv/FrQVIGUkfvVVAwW55nBWiOIfO32gfkRLolyYrguE8cWVQHYadWx8q2iUT
         W1rFyTZ9y96HUL5GQVm1GbVGD+IP/VNBU+80tFbMU70hXTqY/uxWNaFHK86QshWbEM
         grOKkcC4tKeVAE1gjbc1rX1ZJVkTruCwn4nAbSxf9I1oPgnlgpMVo8+xijcN8MVtU8
         OwTToGj4F3DI7Zw7wa9ybSE4dwWrXB1Io0rhZltbTE3NdksFgPPYCJQqidYLFJM65Y
         sMg6xoFe+CERHGWkBPyytYtyxE8l0e0QjInfpRPS9qyk5TzrxQifIBsGCzBA1t9ixc
         CowxeeawoIgWQ==
From:   SeongJae Park <sj@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        SeongJae Park <sj@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-mm 1/2 v2] mm/internal: Implement no-op mlock_page_drain() for !CONFIG_MMU
Date:   Thu, 10 Feb 2022 07:58:24 +0000
Message-Id: <20220210075824.13422-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8eae6026-098-befb-92d3-b9ad2ad57776@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022 20:44:02 -0800 (PST) Hugh Dickins <hughd@google.com> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> Commit 4b3b8bd6c8287 ("mm/munlock: mlock_page() munlock_page() batch by
> pagevec") in -mm tree[1] implements 'mlock_page_drain()' under
> CONFIG_MMU only, but the function is used by 'lru_add_drain_cpu()',
> which defined outside of CONFIG_MMU.  As a result, below build error
> occurs.
> 
>     /linux/mm/swap.c: In function 'lru_add_drain_cpu':
>     /linux/mm/swap.c:637:2: error: implicit declaration of function 'mlock_page_drain' [-Werror=implicit-function-declaration]
>       637 |  mlock_page_drain(cpu);
>           |  ^~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>     /linux/scripts/Makefile.build:289: recipe for target 'mm/swap.o' failed
> 
> This commit fixes it by implementing no-op 'mlock_page_drain()' for
> !CONFIG_MMU case, similar to 'mlock_new_page()'.
> 
> [1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
> 
> [hughd: add need_mlock_page_drain() stub too]
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
> Andrew, Stephen, please add as fix to
> mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
> Thanks!

Thank you, Hugh!


Thanks,
SJ

> 
>  mm/internal.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -508,6 +508,8 @@ static inline void mlock_vma_page(struct page *page,
>  static inline void munlock_vma_page(struct page *page,
>  			struct vm_area_struct *vma, bool compound) { }
>  static inline void mlock_new_page(struct page *page) { }
> +static inline bool need_mlock_page_drain(int cpu) { return false; }
> +static inline void mlock_page_drain(int cpu) { }
>  static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
>  }
> 
