Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967154C557
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344430AbiFOKC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343985AbiFOKCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:02:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899DA1CFD8;
        Wed, 15 Jun 2022 03:02:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3843AB81D43;
        Wed, 15 Jun 2022 10:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6C4C34115;
        Wed, 15 Jun 2022 10:02:43 +0000 (UTC)
Date:   Wed, 15 Jun 2022 11:02:40 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Wupeng Ma <mawupeng1@huawei.com>
Cc:     corbet@lwn.net, will@kernel.org, ardb@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        dvhart@infradead.org, andy@infradead.org, rppt@kernel.org,
        akpm@linux-foundation.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, paulmck@kernel.org,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        swboyd@chromium.org, wei.liu@kernel.org, robin.murphy@arm.com,
        david@redhat.com, anshuman.khandual@arm.com,
        thunder.leizhen@huawei.com, wangkefeng.wang@huawei.com,
        gpiccoli@igalia.com, chenhuacai@kernel.org, geert@linux-m68k.org,
        vijayb@linux.microsoft.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/5] efi: arm64: Introduce ability to find mirrored
 memory ranges
Message-ID: <YqmuQIpkY7TJHAh6@arm.com>
References: <20220614092156.1972846-1-mawupeng1@huawei.com>
 <20220614092156.1972846-2-mawupeng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614092156.1972846-2-mawupeng1@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 05:21:52PM +0800, Wupeng Ma wrote:
> From: Ma Wupeng <mawupeng1@huawei.com>
> 
> Commit b05b9f5f9dcf ("x86, mirror: x86 enabling - find mirrored memory
> ranges") introduce the efi_find_mirror() function on x86. In order to reuse
> the API we make it public.
> 
> Arm64 can support mirrored memory too, so function efi_find_mirror() is added to
> efi_init() to this support for arm64.
> 
> Since efi_init() is shared by ARM, arm64 and riscv, this patch will bring
> mirror memory support for these architectures, but this support is only tested
> in arm64.
> 
> Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
> ---
>  arch/x86/include/asm/efi.h      |  4 ----
>  arch/x86/platform/efi/efi.c     | 23 -----------------------
>  drivers/firmware/efi/efi-init.c |  1 +
>  drivers/firmware/efi/efi.c      | 23 +++++++++++++++++++++++
>  include/linux/efi.h             |  3 +++

The subject prefix says "efi: arm64: " but it looks like x86 diffstat
here. You may want to get an ack from the x86 maintainers.

-- 
Catalin
