Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795075B1CB0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiIHMVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiIHMVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879051316DA;
        Thu,  8 Sep 2022 05:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C67461CD4;
        Thu,  8 Sep 2022 12:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0BDC433D6;
        Thu,  8 Sep 2022 12:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662639692;
        bh=holoJC7k/mCyBOzapjBumEYJ6+C0KD4dODVUkOFKXcc=;
        h=From:To:Cc:Subject:Date:From;
        b=Vza+rTw1sbAO7TAn9OxaiIfhWPzd+vmCVjZl2wHpNDlgX8PIxu0MyM46j+yRD++hd
         q1Na9S8ow3494CKwI2YtEZ7ExNh6Q7DNPpju6NVOaCfBWjiv4B1R5FDlrurmLzG8gX
         OI096/7hOGGmJVAQ+ivjCDDQiyIPR2hoD+EN8ogi7PGf1l9pkZMg2qT2SU9lvUAcZc
         8B6Po/Nt8Xa65QM9zj4p3RG47ui4laEFRjL3sufVKmSKMJrBS05nHc7vcKJVvP1HBZ
         06GHprADe7RRGtJjn12iVHIfImyNyShPfFdzAwfMf41NVKbFpKc18JCqAdmYvXKIzV
         mQdfk22cyFGYA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.0-rc4
Date:   Thu, 08 Sep 2022 13:21:23 +0100
Message-Id: <20220908122132.2A0BDC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc4

for you to fetch changes up to 9c9c9da7aa108e6bf952c18289527a5234e4fc59:

  spi: spi: Fix queue hang if previous transfer failed (2022-09-02 13:27:48 +0100)

----------------------------------------------------------------
spi: Fixes for v6.0

Several fixes that came in since the merge window, the major one being a
fix for the spi-mux driver which was broken by the performance
optimisations due to it peering inside the core's data structures more
than it should.

----------------------------------------------------------------
David Jander (1):
      spi: spi: Fix queue hang if previous transfer failed

Mark Brown (1):
      spi: mux: Fix mux interaction with fast path optimisations

Niravkumar L Rabara (1):
      spi: cadence-quadspi: Disable irqs during indirect reads

Robin Murphy (1):
      spi: bitbang: Fix lsb-first Rx

 drivers/spi/spi-bitbang-txrx.h    |  6 ++++--
 drivers/spi/spi-cadence-quadspi.c | 38 ++++++++++++++++++++++++++++++++++----
 drivers/spi/spi-mux.c             |  1 +
 drivers/spi/spi.c                 |  5 ++---
 include/linux/spi/spi.h           |  2 ++
 5 files changed, 43 insertions(+), 9 deletions(-)
