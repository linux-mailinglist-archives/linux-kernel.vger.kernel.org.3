Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37521513194
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiD1Ktf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiD1Kte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:49:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DA89303
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0365BB82919
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:46:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A27C385A9;
        Thu, 28 Apr 2022 10:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651142777;
        bh=7d3KnRH8ThdyiB4wx6AsCSrAqSAqq2CeEmVPr9bXaMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsxKHEbwPJ+ERWv4xFPxudVHN/ZFT89PFk3wAQfxVmmtOFWcHd0kZ4P6GnqQykjOz
         TtrjG6BWHD1wP64zTQa6tkwUS/eT7M96FHeUg0GQQdJcxGMSNYIkE4cMB6Qf3l3Hx+
         zDLGVLUya9GDNZxjdA6mYLw+wRDIYK9+DAqlwINAnKSyffLCVDCT6TsuvKjk51mzP/
         /EqlK+COM+eJYFnf2l7eB5xFHvme6k1HiYPmXnDHHLVKwNTuoRlEY6UInSh+3nUdLY
         5PCCzW5A/UGiOm5yUR/oSlHoUTSUGcczWIbC8EhGCs+fUQkOK8gAXMJ/IsSvzR/bAH
         98LNx7//CzjZA==
Date:   Thu, 28 Apr 2022 11:46:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/4] arm64: Cleanup ioremap() and support ioremap_prot()
Message-ID: <20220428104612.GA14515@willie-the-truck>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 08:14:09PM +0800, Kefeng Wang wrote:
> Let's arm64 use GENERIC_IOREMAP to cleanup code, and
> support ioremap_prot()/HAVE_IOREMAP_PROT, which could
> enable generic_access_phys().
> 
> Kefeng Wang (4):
>   mm: ioremap: Setup phys_addr of struct vm_struct
>   mm: ioremap: Add arch_ioremap/iounmap_check()
>   arm64: mm: Convert to GENERIC_IOREMAP
>   arm64: Add HAVE_IOREMAP_PROT support
> 
>  .../features/vm/ioremap_prot/arch-support.txt |  2 +-
>  arch/arm64/Kconfig                            |  2 +
>  arch/arm64/include/asm/io.h                   | 14 +--
>  arch/arm64/include/asm/pgtable.h              | 10 +++
>  arch/arm64/kernel/acpi.c                      |  2 +-
>  arch/arm64/mm/hugetlbpage.c                   | 10 ---
>  arch/arm64/mm/ioremap.c                       | 86 +++----------------
>  include/asm-generic/io.h                      |  3 +
>  mm/ioremap.c                                  | 21 ++++-
>  9 files changed, 56 insertions(+), 94 deletions(-)

That's not a massively compelling diffstat for a cleanup, in all honesty.
I looked at generic_access_phys() to try to figure out why we would want
that on arm64, but it seems like it's related to mmap() of devices in
userspace. Bearing in mind that CONFIG_STRICT_DEVMEM=y by default, please
can you justify why this is something worth doing?

Will
