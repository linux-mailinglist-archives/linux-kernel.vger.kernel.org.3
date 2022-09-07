Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BBA5B0769
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiIGOqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIGOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:46:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB367FF9E;
        Wed,  7 Sep 2022 07:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561997; x=1694097997;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DABEQqz4QfwbbWYVa5sSadQTpuSR2LafHiafic1pYk=;
  b=QG4tZIn3o0DQ80ymE06Ms1rxblvGB4ZRoSixTRalnvtEt66BJCAzpARy
   Uw62TmWJoraH64RSjE6nk9S/6TJqWM1d8G1dmh1BRQSkJAY8HoSqBvDmT
   ae6lkquKaNDSOSQOx6lomcBIkb9enVMs3cYZGQr0XLz+cwCO/YRyyyVti
   B99/yPjimygxp9qomdCTIQ0Co7rw5oHEMynZwmB7WdCvnWSzgrEO2y9GB
   kUpln2LFQzCOMFPbuxq+HZtKjBpbF9Q93XCjA/sNIgAB2CcwvP2GSQN1p
   M+A2LGAok6+JI8dS7dmHq8fgEQuUwMtgFxYo7Z7g7Wm1MZyHD5QRJ6iqX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047486"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2022 16:46:31 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 07 Sep 2022 16:46:31 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 07 Sep 2022 16:46:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1662561991; x=1694097991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+DABEQqz4QfwbbWYVa5sSadQTpuSR2LafHiafic1pYk=;
  b=A2viJqYjOx9fjTMy4XjpIg5a3gskrYMDm3/t/6/5YWSWTILtfWQgHf6t
   db8/lLyrgxGxKDHGHzFng+/zmqMs099C5bWSWHKaJvBT9kjPTQ3L+Uhml
   ipZvMx0Ppr3kix0oif4FfPXVUljXuo7+r05zrA45p1R0ZaBV52MnvJJDy
   MFSMRQkY1b+V8GN8noWvcJ7AZETWU1Mh3bOWnEjezTpliaQD5FRAAaToR
   /4UOzhWvJDCnuvMV8U4bJNLpKU7XoLhTDQm2hSTj0c9m/95r6nXhh13TX
   04yxPPJXk/kn1vlqPL7hleX6gcmkY0TKSoSJHcXQGh+Qe0DOShMOG/nVH
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,297,1654552800"; 
   d="scan'208";a="26047485"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2022 16:46:30 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A2A7F280056;
        Wed,  7 Sep 2022 16:46:30 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, Li Jun <jun.li@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] usb: dwc3: core: add gfladj_refclk_lpm_sel quirk
Date:   Wed,  7 Sep 2022 16:46:22 +0200
Message-Id: <20220907144624.2810117-3-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
References: <20220907144624.2810117-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This selects the SOF/ITP counter be running on ref_clk. As documented
U2_FREECLK_EXISTS has to be set to 0 as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/usb/dwc3/core.c | 8 +++++++-
 drivers/usb/dwc3/core.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 8c8e32651473..12e8e7d34cb8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -408,6 +408,10 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
 	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+
+	if (dwc->gfladj_refclk_lpm_sel)
+		reg |=  DWC3_GFLADJ_REFCLK_LPM_SEL;
+
 	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
 }
 
@@ -789,7 +793,7 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	else
 		reg |= DWC3_GUSB2PHYCFG_ENBLSLPM;
 
-	if (dwc->dis_u2_freeclk_exists_quirk)
+	if (dwc->dis_u2_freeclk_exists_quirk || dwc->gfladj_refclk_lpm_sel)
 		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
@@ -1525,6 +1529,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-tx-ipgap-linecheck-quirk");
 	dwc->parkmode_disable_ss_quirk = device_property_read_bool(dev,
 				"snps,parkmode-disable-ss-quirk");
+	dwc->gfladj_refclk_lpm_sel = device_property_read_bool(dev,
+				"snps,gfladj-refclk-lpm-sel-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 4fe4287dc934..11975a03316f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -391,6 +391,7 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 #define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_REFCLK_LPM_SEL		BIT(23)
 #define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
 #define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
@@ -1312,6 +1313,7 @@ struct dwc3 {
 	unsigned		dis_del_phy_power_chg_quirk:1;
 	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 	unsigned		parkmode_disable_ss_quirk:1;
+	unsigned		gfladj_refclk_lpm_sel:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
-- 
2.25.1

