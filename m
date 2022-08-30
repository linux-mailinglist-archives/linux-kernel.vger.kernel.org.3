Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66C5A6675
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiH3Okl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiH3Oki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795E12C12C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FC0FB80EF4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 14:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B0C433C1;
        Tue, 30 Aug 2022 14:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661870434;
        bh=/3OQPzQeZByYa7GYP7YBcP1lmtBiXFL2ZTsz2biZiMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SU6LkW2gWKLtQ2bdjJbMq9unFMwkSW5i2oGhdrR7tO4HHRFH0MOYX2/pNxUyvQj5l
         Qn22IxSF5P7xPR6c7IBtGlQ2sM/fmzaQJPIwdAnTpPACmhciLhaoM9d7vFmaKNMSek
         1NggdkYRXC3FvqIHI3RjEODHfHjnV3SLEzMXpzVckeYNGYNiUdIDQoLdf7RsblEH/d
         KRTCFLDeFPGBg0Yq8x0bCa7N1TXxbQNcUSTdg9XyP/X9xKideuC6s2v2gJ3di/E4BK
         c2MwQUEOwMwyQd9+zVn5XVwtWqsTcZ/TBhQCBatkoWDAte8IwHU/HKF3n9lEeKIJHr
         vilyXuSpAHu8Q==
Date:   Tue, 30 Aug 2022 22:31:19 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Message-ID: <Yw4fN/9L2yAsCgXk@xhacker>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
 <YwzI7VmfFnOvYWgf@xhacker>
 <4037b310-47c4-ca30-d4b6-a284e87da437@microchip.com>
 <Yw4XwsVQBB1HRw04@xhacker>
 <d9331af0-58bc-ed3b-10f5-8509795e3198@microchip.com>
 <22c254ae-2b84-1342-4b2d-f532f34e2c94@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22c254ae-2b84-1342-4b2d-f532f34e2c94@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:26:38PM +0000, Conor.Dooley@microchip.com wrote:
> On 30/08/2022 15:15, Conor Dooley - M52691 wrote:
> > On 30/08/2022 14:59, Jisheng Zhang wrote:
> >> On Mon, Aug 29, 2022 at 05:27:48PM +0000, Conor.Dooley@microchip.com wrote:
> >>> On 29/08/2022 15:10, Jisheng Zhang wrote:
> >>>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>>>
> >>>> On Sat, Aug 27, 2022 at 09:13:03PM +0000, Conor.Dooley@microchip.com wrote:
> >>>>> Hey Jisheng,
> >>>>
> >>>> Hi Conor,
> >>>>
> >>>>> On 27/08/2022 10:58, Jisheng Zhang wrote:
> >>>>>> I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> >>>>>> memory optimizations such as swap on zram are helpful. As is seen
> >>>>>> in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> >>>>>> commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> >>>>>> swapped out"), THP_SWAP can improve the swap throughput significantly.
> >>>>>>
> >>>>>> Enable THP_SWAP for RV64, testing the micro-benchmark which is
> >>>>>> introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> >>>>>> shows below numbers on the Lichee RV dock board:
> >>>>>>
> >>>>>> thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> >>>>>> thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
> >>>>>
> >>>>> I know the original commit message contains this, but it's a little
> >>>>> odd. If the patch /enables/ THP then how would there be THP swap
> >>>>> prior to the patch?
> >>>>
> >>>> hmm, it's swap I'll send a v3 to correct the description.
> >>>>
> >>>>>
> >>>>>>
> >>>>>> Improved by 382%!
> >>>>>
> >>>>> I could not replicate the after numbers on my nezha, so I suspect
> >>>>> I am missing something in my config/setup. zswap is enabled and is
> >>>>
> >>>> swap on zram rather than zswap ;)
> >>>
> >>> I think I tried about 30 different config variations, initially not
> >>> using zswap and later using it.
> >>> My zramctl looks like so (although I did try zstd too) after running
> >>> the demo application from that commit:
> >>>
> >>> NAME       ALGORITHM DISKSIZE DATA COMPR TOTAL STREAMS MOUNTPOINT
> >>> /dev/zram0 lzo-rle       241M  22M  8.4M  9.1M       1 [SWAP]
> >>>
> >>> I am using the default riscv defconfig + the following:
> >>> CONFIG_ZRAM=y
> >>> CONFIG_CRYPTO_DEFLATE=y
> >>> CONFIG_CRYPTO_LZO=y
> >>> CONFIG_CRYPTO_ZSTD=y
> >>> CONFIG_ZRAM_MEMORY_TRACKING=y
> >>> CONFIG_TRANSPARENT_HUGEPAGE=y
> >>> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> >>> CONFIG_THP_SWAP=y
> >>>
> >>> Am I just missing something obvious here?
> >>
> >> similar config options here. what's your rootfs? Is your board busy
> >> with something? I used a minimal rootfs built from buildroot.
> >> can you plz show your numbers w/ and w/o the patch?
> > 
> > I was using fedora for the testing, downloaded directly from
> > koji. My before/after numbers varied, but were around 80,000
> > bytes/ms most of the time.
> > 
> > If I increased the size to 500 * 1024 * 1024 I got around 130k.
> 
> 130k before & after.**
> 
> > 
> > Before/after the patch, the numbers did not really change, but
> > things did fluctuate quite wildly - from about 50k to 90k using
> > the 400 size.
> 
> What I mean is: before/after the patch had visible performance
> difference because it was always flucuating in the same range.

I see the difference -- w/ minial buildroot rootfs, the numbers isn't
kept the same but the difference is trivial, I even got two or three
the same numbers during 10 times of testing. But your numbers were
always flucuating, so I guess your system maybe busy with with
something in a shore period, I.E the os env is full of noise. 

I guess you may get similar improvement percentage when trying buildroot
> 
> > 
> >>
> >> I also tried the simple benchmark on qemu(just for reference, since
> >> I have no other riscv boards except the lichee RV dock board):
> >> swp out w/o patch: 30066 bytes/ms (mean of 10 tests)
> >> swp out w/ patch: 130055 bytes/ms (mean of 10 tests)
> >> so improved by 332.7% 
> > 
> > I'll give QEMU a go so :)
> 
