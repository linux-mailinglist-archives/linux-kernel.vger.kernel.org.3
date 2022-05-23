Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A04530F56
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiEWNMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236055AbiEWNMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:12:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA52AE3E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E8E2B810AC
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF8FC385AA;
        Mon, 23 May 2022 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653311533;
        bh=V/9AvIndy2K3nYYZ4Y1SppzdBIvXUWiWnGwvGlEgoLs=;
        h=From:To:Cc:Subject:Date:From;
        b=oIPbDA9WDHIxFn9oVveegCQw9xHLcvP6DOo+WVujqjHwMMMa998mqDzlFKJ3fnIgI
         ApSerdrBnhXXOSQtq9YI2ZLPUHy9sZb2KeDLo/Yr7c11q6KAUD3gzmTXuw79KbOs+c
         LLySzm/JXZmIoWxlS02jWJ96pZp+4GeTPMuOAsclZ0egoyC8gimHh4f5TFPhkbF05Q
         zk1jx8zSr2ofWiaDntApWEEu1uN83rF2ncNF1jfOr8Rl8iASMJ2jcFRc6tmrSdRoBZ
         afqk8ZiyLN5YzwpggvcEvXaJ45eaeuKbg+IT5RFtuC8ZzUFzmgIW/QXBj0CFeYfvCN
         0apixhl6A/EoA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.19
Date:   Mon, 23 May 2022 14:11:56 +0100
Message-Id: <20220523131213.5DF8FC385AA@smtp.kernel.org>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.19

for you to fetch changes up to 5c422f0b970d287efa864b8390a02face404db5d:

  regmap: Add missing map->bus check (2022-05-09 12:48:45 +0100)

----------------------------------------------------------------
regmap: Updates for v5.19

The main change here is Marek's addition of bulk read/write callbacks
for individual regmaps, we've supported single register operations for a
while but there's enough hardware out there which can use bulk equivalents
to make it worthwhile.

----------------------------------------------------------------
Jeongtae Park (1):
      regmap: cache: set max_register with reg_stride

Marek Vasut (2):
      regmap: Add bulk read/write callbacks into regmap_config
      regmap: Add missing map->bus check

Mark Brown (1):
      regmap: Custom bulk operations for regmaps

Rikard Falkeborn (1):
      regmap: Constify static regmap_bus structs

 drivers/base/regmap/internal.h       |  4 ++
 drivers/base/regmap/regcache.c       |  4 +-
 drivers/base/regmap/regmap-i3c.c     |  2 +-
 drivers/base/regmap/regmap-sccb.c    |  2 +-
 drivers/base/regmap/regmap-sdw-mbq.c |  2 +-
 drivers/base/regmap/regmap-sdw.c     |  2 +-
 drivers/base/regmap/regmap-slimbus.c |  2 +-
 drivers/base/regmap/regmap-w1.c      |  6 +--
 drivers/base/regmap/regmap.c         | 78 +++++++++++++++++++-----------------
 include/linux/regmap.h               | 12 ++++++
 10 files changed, 67 insertions(+), 47 deletions(-)
