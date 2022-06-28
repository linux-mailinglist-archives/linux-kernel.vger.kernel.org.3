Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C4555D88F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbiF1MXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbiF1MXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390F120AE;
        Tue, 28 Jun 2022 05:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8356B81E03;
        Tue, 28 Jun 2022 12:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DFEC3411D;
        Tue, 28 Jun 2022 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418990;
        bh=rEXIp99qfQP4RlG//sn4CD2PHI+woj98TshooNb5NZQ=;
        h=From:To:Cc:Subject:Date:From;
        b=muvApXaNZ5aCqcwN6Nuwpr6dc1BUN1WCsu4N+QxeVkNWY7ucg7YLJrawG5aNQ+MY+
         SPRaVVaPnC1680P47Y64jMPzvA61172b/aYSuHiyGgpxE47aOm3/V5rcsV2eWZ/lNZ
         naeZTVE9U6dLTxhMa/jy3oIl4DTlCt5lo6VSvokWlG1pyVALNMEVT5oyH1gneP+6Tx
         dK1cBuSx5dkRnOBdZx2KPBKD6u3bDPqgweevzGrtLKFjnBQ84s8gpxFj2z5S1G4sw3
         H/69+tG54Y0bm4l/lAcDnx+0M5nMyPpbD/REnKTqxVEIx6T6wkoEMZrP9PH+3addGq
         Cp4WnAt1HwkGg==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/7] phy: ti: phy-j721e-wiz: Add support for j7200-wiz-10g
Date:   Tue, 28 Jun 2022 15:22:48 +0300
Message-Id: <20220628122255.24265-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The SERDES in J7200 SR2.0 supports 2 reference clocks.
The second reference clock (core_ref1_clk) is hardwired to
MAIN_PLL3_HSDIV4_CLKOUT (100/125/156.25 MHz).

Add a new compatible "j7200-wiz-10g" for this device.

The external clocks to SERDES PLL refclock mapping is now
controlled by a special register in System Control Module
(SCM) space. Add a property "ti,scm" to reference it and
configure it in the driver.

cheers,
-roger

Roger Quadros (4):
  dt-bindings: phy: ti,phy-j721e-wiz: deprecate clock MUX nodes
  dt-bindings: phy: ti,phy-j721e-wiz: Add support for ti,j7200-wiz-10g
  phy: ti: phy-j721e-wiz: add support for j7200-wiz-10g
  phy: ti: phy-j721e-wiz: set PMA_CMN_REFCLK_DIG_DIV based on reflk rate

Siddharth Vadapalli (1):
  phy: ti: phy-j721e-wiz: Add SGMII support in wiz driver for J7200

Swapnil Jakhade (1):
  dt-bindings: phy: Add PHY_TYPE_USXGMII definition

Tanmay Patil (1):
  phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver

 .../bindings/phy/ti,phy-j721e-wiz.yaml        |  24 +-
 drivers/phy/ti/phy-j721e-wiz.c                | 230 ++++++++++++++++--
 include/dt-bindings/phy/phy.h                 |   1 +
 3 files changed, 239 insertions(+), 16 deletions(-)

-- 
2.17.1

