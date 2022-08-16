Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BEF595A94
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbiHPLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiHPLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:48:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D1D51EB;
        Tue, 16 Aug 2022 04:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F56611DB;
        Tue, 16 Aug 2022 11:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47721C433C1;
        Tue, 16 Aug 2022 11:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660648997;
        bh=tP+ANVAUbFVllTzIr8hC0M9LLYPiJXs4zx3jfrfx2UU=;
        h=From:To:Cc:Subject:Date:From;
        b=GDW98Ayqyaty3Q2pI5fw85snOpnwr8+YMCMuZAYhoMPidh2gW0pnKo6egIeCMrG7X
         uoIk1HFsSR3/6xxBWM8ZQ8H36svnHz2aNJr1v2nKZXxl1/vkVbxcTBVAVvv/Ql1Nb7
         if/Sj88Trwg1JU5CEi294Yq95wXJZ6p+iVrWwatlliR9QQ3YDTb98nEsnaySd9invX
         X1s7Rov4R4XfvyGtU3PUidYxny0ib7uGso77WP/F2o73vz/818R7qaSf6s7JBk3U9E
         Ze6zZ8BeartfkQvSbXD6ER0t5Woq3Jy1tKBE31MwlaA7rZq+VgW77+alqZlyzGyh/X
         JNlyi2rxNCE4g==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.0-rc1
Date:   Tue, 16 Aug 2022 12:23:07 +0100
Message-Id: <20220816112317.47721C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 69243df953e70c134c6735b31ba0e658c53d3cda:

  Add SPI Driver to HPE GXP Architecture (2022-07-29 20:22:22 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.0-rc1

for you to fetch changes up to 2fd92c7b8fe2cfc634613dc093d0f507c7389ea8:

  spi: dt-bindings: Drop Pratyush Yadav (2022-08-11 18:41:45 +0100)

----------------------------------------------------------------
spi: Fixes for v6.0

A few fixes that came in since my pull request, the Meson fix is a
little large since it's fixing all possible cases of the problem that
was observed with the driver and clock API trying to share configuration
by integrating the device clocking fully with the clock API rather than
spot fixing the one instance that was observed.

----------------------------------------------------------------
David Jander (1):
      spi: spi.c: Add missing __percpu annotations in users of spi_statistics

Krzysztof Kozlowski (1):
      spi: dt-bindings: Drop Pratyush Yadav

Lukas Bulwahn (1):
      MAINTAINERS: rectify entry for ARM/HPE GXP ARCHITECTURE

Neil Armstrong (1):
      spi: meson-spicc: add local pow2 clock ops to preserve rate between messages

 .../spi/cdns,qspi-nor-peripheral-props.yaml        |   2 +-
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml     |   2 +-
 .../bindings/spi/spi-peripheral-props.yaml         |   2 +-
 MAINTAINERS                                        |   2 +-
 drivers/spi/spi-meson-spicc.c                      | 129 ++++++++++++++++-----
 drivers/spi/spi.c                                  |  14 +--
 6 files changed, 112 insertions(+), 39 deletions(-)
