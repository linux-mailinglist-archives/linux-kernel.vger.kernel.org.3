Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55D559EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiFXQy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 12:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiFXQyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:54:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1371E4755A;
        Fri, 24 Jun 2022 09:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C31F8B82AA2;
        Fri, 24 Jun 2022 16:54:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384A3C34114;
        Fri, 24 Jun 2022 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656089661;
        bh=RzqE3B/5GHZ+jAPAK54x0+g/kw+4spEKs2JkHSnmbdc=;
        h=From:To:Cc:Subject:Date:From;
        b=adTXx0XqPIQVjGO8sMeuZPcj0MJdvashS3SmvQh7qGwjoKptVTg19LHj1KSPB9KsL
         UyNX+HsyQcw43vtxHRNT3UG7ZJinnuUfCfqcH3xiw9Zpjmn1tTklgQAH1RT81scd+u
         wGawBNrWRZZtXu43omylckrHz+cdOLdsiq0RXUD9rAtxZqBoiyHV/xB2Bol8M3OOX7
         lr1VX75EnTJlZjsbENzscqzZzLwNjL907zARYdhXeCm5pgURbU5xSGSwnAv8IXdl6+
         hOxnercb9fAzX8FbhkmCtlJ0+jb3YY/iX3fSr3zfMKpx3ed/M1T6Kgk+djzAe3By4Q
         rblF8AkxIDhfA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.19-rc3
Date:   Fri, 24 Jun 2022 17:54:07 +0100
Message-Id: <20220624165421.384A3C34114@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.19-rc3

for you to fetch changes up to 419bc8f681a0dc63588cee693b6d45e7caa6006c:

  spi: rockchip: Unmask IRQ at the final to avoid preemption (2022-06-20 11:35:43 +0100)

----------------------------------------------------------------
spi: Fixes for v5.19

A bunch of driver specific fixes, plus a fix for spi-mem's status
polling for devices that use GPIO chip selects and a DT bindings
examples fix that helps with the validation work.

----------------------------------------------------------------
Jon Lin (1):
      spi: rockchip: Unmask IRQ at the final to avoid preemption

Lars-Peter Clausen (1):
      spi: cadence: Detect transmit FIFO depth

Patrice Chotard (1):
      spi: spi-mem: Fix spi_mem_poll_status()

Rob Herring (1):
      spi: dt-bindings: Fix unevaluatedProperties warnings in examples

Sai Krishna Potthuri (1):
      spi: spi-cadence: Fix SPI CS gets toggling sporadically

 .../bindings/spi/microchip,mpfs-spi.yaml           |  1 -
 .../bindings/spi/qcom,spi-geni-qcom.yaml           |  1 -
 drivers/spi/spi-cadence.c                          | 37 ++++++++++++++++++----
 drivers/spi/spi-mem.c                              |  2 +-
 drivers/spi/spi-rockchip.c                         | 11 ++++---
 5 files changed, 39 insertions(+), 13 deletions(-)
