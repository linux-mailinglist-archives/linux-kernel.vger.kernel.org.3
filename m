Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52E4F4C10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575606AbiDEXIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443699AbiDEPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB8184B54
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46B55B81C9B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E608EC385A4;
        Tue,  5 Apr 2022 13:58:00 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 00/10] mm, arm64: Reduce ARCH_KMALLOC_MINALIGN below the cache line size
Date:   Tue,  5 Apr 2022 14:57:48 +0100
Message-Id: <20220405135758.774016-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On arm64 ARCH_DMA_MINALIGN (and therefore ARCH_KMALLOC_MINALIGN) is 128.
While the majority of arm64 SoCs have a 64-byte cache line size (or
rather CWG - cache writeback granule), we chose a less than optimal
value in order to support all SoCs in a single kernel image.

The aim of this series is to allow smaller default ARCH_KMALLOC_MINALIGN
with kmalloc() caches configured at boot time to be safe when an SoC has
a larger DMA alignment requirement.

The first patch decouples ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
with the aim to only use the latter in DMA-specific compile-time
annotations. ARCH_KMALLOC_MINALIGN becomes the minimum (static)
guaranteed kmalloc() alignment but not necessarily safe for non-coherent
DMA. Patches 2-7 change some drivers/ code to use ARCH_DMA_MINALIGN
instead of ARCH_KMALLOC_MINALIGN.

Patch 8 introduces the dynamic arch_kmalloc_minalign() and the slab code
changes to set the corresponding minimum alignment on the newly created
kmalloc() caches. Patch 10 defines arch_kmalloc_minalign() for arm64
returning cache_line_size() together with reducing ARCH_KMALLOC_MINALIGN
to 64. ARCH_DMA_MINALIGN remains 128 on arm64.

I don't have access to it but there's the Fujitsu A64FX with a CWG of
256 (the arm64 cache_line_size() returns 256). This series will bump the
smallest kmalloc cache to kmalloc-256. The platform is known to be fully
cache coherent (or so I think) and we decided long ago not to bump
ARCH_DMA_MINALIGN to 256. If problematic, we could make the dynamic
kmalloc() alignment on arm64 min(ARCH_DMA_MINALIGN, cache_line_size()).

This series is beneficial to arm64 even if it's only reducing the
kmalloc() minimum alignment to 64. While it would be nice to reduce this
further to 8 (or 16) on SoCs known to be fully DMA coherent, detecting
this is via arch_setup_dma_ops() is problematic, especially with late
probed devices. I'd leave it for an additional RFC series on top of
this (there are ideas like bounce buffering for non-coherent devices if
the SoC was deemed coherent).

Thanks.

Catalin Marinas (10):
  mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
  drivers/base: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/gpu: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/md: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/spi: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  drivers/usb: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  crypto: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
  mm/slab: Allow dynamic kmalloc() minimum alignment
  mm/slab: Simplify create_kmalloc_cache() args and make it static
  arm64: Enable dynamic kmalloc() minimum alignment

 arch/arm64/include/asm/cache.h |  1 +
 arch/arm64/kernel/cacheinfo.c  |  7 ++++++
 drivers/base/devres.c          |  4 ++--
 drivers/gpu/drm/drm_managed.c  |  4 ++--
 drivers/md/dm-crypt.c          |  2 +-
 drivers/spi/spidev.c           |  2 +-
 drivers/usb/core/buffer.c      |  8 +++----
 drivers/usb/misc/usbtest.c     |  2 +-
 include/linux/crypto.h         |  2 +-
 include/linux/slab.h           | 25 ++++++++++++++++-----
 mm/slab.c                      |  6 +----
 mm/slab.h                      |  5 ++---
 mm/slab_common.c               | 40 ++++++++++++++++++++++------------
 13 files changed, 69 insertions(+), 39 deletions(-)

