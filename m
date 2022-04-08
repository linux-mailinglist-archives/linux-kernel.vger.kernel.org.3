Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED314F98C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbiDHO72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiDHO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:59:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52785116B79;
        Fri,  8 Apr 2022 07:57:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE012B82BA9;
        Fri,  8 Apr 2022 14:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166A6C385A3;
        Fri,  8 Apr 2022 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649429838;
        bh=WuczYS6ilAC0AV8hX0hQJdmcl49iTXUZaYKgxq2uR1Y=;
        h=From:To:Cc:Subject:Date:From;
        b=UDxdQEexibzMsvBr/rRCMhO/EiYMa86SvH/a4dYsZAFk++FJ7oLXmDPceXRgKgvZQ
         5S7M9m1EsHbTNq6AqO15i0HimsklSJn5PzwGe5V47F7rK+eal5Cn7FhokI2U3njWgF
         h97Wiw3CrWf2HN/x1NYk1KYeQCJURtktp67IH06UpGsnqRKg0cZImz1LSZU4ZNufv1
         zCetyjkRXTMvu1CmQeCm99TOqcUfK0iBMohR7lTledHNQd6RK6UiQ4IrW5rL2ypKY5
         tX+DzC7Z3ZO8Fm/exmhEUt6nqUMDFFRtwmZkcHHhp3c8ZQF2ck2XHvvEngOEbfr48w
         0CROFI1rn2mdg==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v5.18-rc1
Date:   Fri, 08 Apr 2022 15:57:02 +0100
Message-Id: <20220408145718.166A6C385A3@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v5.18-rc1

for you to fetch changes up to 2c7d1b281286c46049cd22b43435cecba560edde:

  spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op() (2022-04-06 15:50:11 +0100)

----------------------------------------------------------------
spi: Fixes for v5.18

A small collection of fixes that have arrived since the merge window,
the most noticable one is a fix for unmapping messages when the mapping
was done with the struct device supplied to do the mapping overridden.

----------------------------------------------------------------
Christophe JAILLET (1):
      spi: mxic: Fix an error handling path in mxic_spi_probe()

Geert Uytterhoeven (1):
      spi: rpc-if: Fix RPM imbalance in probe error path

Kamal Dasu (1):
      spi: bcm-qspi: fix MSPI only access with bcm_qspi_exec_mem_op()

Matthias Schiffer (1):
      spi: cadence-quadspi: fix protocol setup for non-1-1-X operations

Vinod Koul (1):
      spi: core: add dma_map_dev for __spi_unmap_msg()

 drivers/spi/spi-bcm-qspi.c        |  4 ++--
 drivers/spi/spi-cadence-quadspi.c | 46 ++++++++++-----------------------------
 drivers/spi/spi-mxic.c            |  1 +
 drivers/spi/spi-rpc-if.c          |  8 +++++--
 drivers/spi/spi.c                 |  4 ++++
 5 files changed, 25 insertions(+), 38 deletions(-)
