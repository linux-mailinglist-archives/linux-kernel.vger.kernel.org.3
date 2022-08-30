Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D415A65EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiH3OIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH3OIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:08:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A63F8265
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:08:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 02954B81C15
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C147C433C1;
        Tue, 30 Aug 2022 14:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661868526;
        bh=m/u8XyF+U/qV44PkAv5tgc86ePYtwDWmP547g4BF5ZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THhOWVfhqu7k9+uWQ3/WwmgdvA6rsqI7C9Ha5p76pC1c0YUwr84gcNNu7VCQaUaS6
         eSb8tp0bzNc4rEqn54RSKGjUsXZkvn/sUF4T+DjFCGjoJosFmWbSY5/sWQCKvfmFyI
         nS0a9QcMfocrWVCEMER6OEW+dHqqjkf0CKYNuQyG/EdEjFZhLfIFF9BOMUyVcO3n3i
         /fq5qh2xrNPu0T5dUNvkXmjxsUgqX3V30Rks5rto1rk+yABEHAoUzIy8JprFlpGTVz
         bsqM80r9rgxXCNZDsSLEoaYCNStmKNzY1aTOclPFX0ll0yWMXF2HZpSxnW5xElTB4j
         NpbZE+K/gjgtg==
Date:   Tue, 30 Aug 2022 21:59:30 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Message-ID: <Yw4XwsVQBB1HRw04@xhacker>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
 <YwzI7VmfFnOvYWgf@xhacker>
 <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 05:27:48PM +0000, Conor.Dooley@microchip.com wrote:
> On 29/08/2022 15:10, Jisheng Zhang wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Sat, Aug 27, 2022 at 09:13:03PM +0000, Conor.Dooley@microchip.com wrote:
> >> Hey Jisheng,
> > 
> > Hi Conor,
> > 
> >> On 27/08/2022 10:58, Jisheng Zhang wrote:
> >>> I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> >>> memory optimizations such as swap on zram are helpful. As is seen
> >>> in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> >>> commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> >>> swapped out"), THP_SWAP can improve the swap throughput significantly.
> >>>
> >>> Enable THP_SWAP for RV64, testing the micro-benchmark which is
> >>> introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> >>> shows below numbers on the Lichee RV dock board:
> >>>
> >>> thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> >>> thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
> >>
> >> I know the original commit message contains this, but it's a little
> >> odd. If the patch /enables/ THP then how would there be THP swap
> >> prior to the patch?
> > 
> > hmm, it's swap I'll send a v3 to correct the description.
> > 
> >>
> >>>
> >>> Improved by 382%!
> >>
> >> I could not replicate the after numbers on my nezha, so I suspect
> >> I am missing something in my config/setup. zswap is enabled and is
> > 
> > swap on zram rather than zswap ;)
> 
> I think I tried about 30 different config variations, initially not
> using zswap and later using it.
> My zramctl looks like so (although I did try zstd too) after running
> the demo application from that commit:
> 
> NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
> /dev/zram0 lzo-rle       241M  22M  8.4M  9.1M       1 [SWAP]
> 
> I am using the default riscv defconfig + the following:
> CONFIG_ZRAM=y
> CONFIG_CRYPTO_DEFLATE=y
> CONFIG_CRYPTO_LZO=y
> CONFIG_CRYPTO_ZSTD=y
> CONFIG_ZRAM_MEMORY_TRACKING=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_THP_SWAP=y
> 
> Am I just missing something obvious here?

similar config options here. what's your rootfs? Is your board busy
with something? I used a minimal rootfs built from buildroot.
can you plz show your numbers w/ and w/o the patch?

I also tried the simple benchmark on qemu(just for reference, since
I have no other riscv boards except the lichee RV dock board):
swp out w/o patch: 30066 bytes/ms (mean of 10 tests)
swp out w/ patch: 130055 bytes/ms (mean of 10 tests)
so improved by 332.7% 
