Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0E598F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347109AbiHRVYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbiHRVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:23:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B9969F68
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443BC61640
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABBBC433D7;
        Thu, 18 Aug 2022 21:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660857359;
        bh=soe7WkpVDL0rQ3DepAGZmwBW25rHj0k0Dx4IE3FtFio=;
        h=From:To:Cc:Subject:Date:From;
        b=lacB4lImkey8cNH3JqHzjgC+/r9sa6Ioyqet0e8tgdVjFCkz8zNntMBfxJl6MfsiQ
         av721qEqGT562V6DCYFKxIGxzO/UDyUr1KEXiaMfJIxnT0afyK8spDwkxrVEZ/3XML
         ojXySeRlJRAFxhPXJkXTjIQhJCzELNXvMqR+RAAa/CQY6dfJjDR4Uw2pnNS6M6xpP3
         K57LKr9LpohuPFLnoCnxf3/7zyFFIsT0LN0bmRxlZ1tBk9aUEcRX0PNxamgoj0Xdk3
         S3STddbVP5f+cdwn5ByKsE8jw/Qjd1sTLrXfIFRMYewTBH+YVYRyEf/gkrNDT0f4NP
         itiWm7Hq673Wg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 0/4] ARM: footbridge: cleanups
Date:   Thu, 18 Aug 2022 23:15:46 +0200
Message-Id: <20220818211550.3272321-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I had an older patch to remove the addin mode for footbridge,
which nobody is using any more, and I found a few other small
cleanups that are worth doing here.

Footbridge is now the only platform with a custom __virt_to_bus()
for ISA DMA, and a custom phys_to_dma() for PCI devices. Both
just add a fixed offset, so there is probably a better way
of doing the same without a custom helper function.

     Arnd

Arnd Bergmann (4):
  ARM: footbridge: remove addin mode
  ARM: footbridge: remove leftover from personal-server
  ARM: footbridge: move isa-dma support into footbridge
  ARM: footbridge: limit CONFIG_ISA to CATS

 arch/arm/Kconfig                              |  5 --
 arch/arm/include/asm/hardware/dec21285.h      | 13 ----
 arch/arm/kernel/Makefile                      |  1 -
 arch/arm/mach-footbridge/Kconfig              | 30 +-------
 arch/arm/mach-footbridge/Makefile             |  5 +-
 arch/arm/mach-footbridge/common.c             | 73 ++-----------------
 arch/arm/mach-footbridge/dc21285.c            | 61 +++++-----------
 .../arm/{kernel => mach-footbridge}/dma-isa.c |  7 +-
 arch/arm/mach-footbridge/dma.c                | 58 ---------------
 .../mach-footbridge/include/mach/isa-dma.h    | 14 +---
 .../arm/mach-footbridge/include/mach/memory.h | 22 ------
 arch/arm/mach-footbridge/isa.c                | 14 ++--
 drivers/tty/serial/21285.c                    |  3 -
 13 files changed, 42 insertions(+), 264 deletions(-)
 rename arch/arm/{kernel => mach-footbridge}/dma-isa.c (98%)
 delete mode 100644 arch/arm/mach-footbridge/dma.c

-- 
2.29.2

Cc: Russell King <linux@armlinux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Marc Zyngier <maz@kernel.org>
