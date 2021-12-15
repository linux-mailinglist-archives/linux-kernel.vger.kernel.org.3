Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F90475288
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 07:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235888AbhLOGIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 01:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239983AbhLOGIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 01:08:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:08:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE2FF6180F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 06:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A51EC34600;
        Wed, 15 Dec 2021 06:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639548527;
        bh=qP3M0j38d5fBfa1rRuQH/PROtJBFzHMElQ75VTNhRP8=;
        h=From:To:Cc:Subject:Date:From;
        b=K/jSxlGBl11wJVxJFEHe7GHCM7GmZ0nyK4s9VOBws+sSVdxoWgfWuVG21AmMdtxpa
         rGif7IoukBHi248vCjMu4SNFJQh8xySFRPfvtSsVGiJYK18zxn+2uKpL9DdenR9S2a
         9xClcU/55j9H8UzG6BxVyfd7nvW9FAUx1v0XlJpg5XH9ZkcxbSKwZag8T0eqBWCLGN
         nHmMsNhODlBlB+H/ytNkjDca5IuaRNLjH9HJKdmcQ5V94d9j6kZtSwKdJYdNwBsk+s
         zfu9mncHlbfujKFPeNAeQfviwU9OK7mrisBkDNpI9Ki7zN1Cjippj8WvAVaLnV46+m
         eAlVwX904qoOA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] phy: freescale: pcie: explictly add bitfield.h
Date:   Wed, 15 Dec 2021 11:38:34 +0530
Message-Id: <20211215060834.921617-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot complains about missing FIELD_PREP, so include
bitfield.h for that

drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:37: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]
drivers/phy/freescale/phy-fsl-imx8m-pcie.c:41:41: error: implicit declaration of function 'FIELD_PREP' [-Werror=implicit-function-declaration]

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index f6502463d49a..04b1aafb29f4 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -3,6 +3,7 @@
  * Copyright 2021 NXP
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
-- 
2.31.1

