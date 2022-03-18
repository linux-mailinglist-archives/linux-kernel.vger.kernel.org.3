Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA964DD70F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234449AbiCRJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiCRJ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:28:16 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4732DCBC5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1647595611; x=1679131611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T4z41I87uBSo9ltyIZ0egwxkvn/iVqG79Oo4uvvncYk=;
  b=EhkLB8KpjFgtoNhQl4j0Qr+TXCcwIzOspi/br3PKxxBuqCpP5KVfjmO7
   m6Ufpy233bKctH+uJ2Qdgv+DIDbO0Jh433BsA3oJ5H7ol+lv0xdV9SUUQ
   CA/j7ggVEEq/1a5pqnrezZeQmY98Q7y1DiZvKM/35NzZIpbwazaWRWR2i
   LfrsY9PCD+vlsLP3xoWMzWnNgt07BxV2F9/2IJ43SC7qShVB0rHf31bR2
   zQNv6RoADvsbCdRfSFi2/CXfA2bwou+zc3ibz3re/4sQNLxiFlC0nOLGW
   A/oOII3C1Fpao4/mG9rRzxFlHzQT1VMxg+4Ukm6Xtoo57mCEOuvM217Px
   A==;
X-IronPort-AV: E=Sophos;i="5.90,191,1643698800"; 
   d="scan'208";a="89376626"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Mar 2022 02:26:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Mar 2022 02:26:50 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Mar 2022 02:26:49 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ASoC: atmel: mchp-pdmc: print the correct property name
Date:   Fri, 18 Mar 2022 11:26:09 +0200
Message-ID: <20220318092609.130901-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct property is 'microchip,mic-pos', not 'mchp,mic-pos', so
replace all occurences of 'mchp,mic-pos' with 'microchip,mic-pos'.
Fix a multi-line comment format while we are at it.

Fixes: 50291652af52 ("ASoC: atmel: mchp-pdmc: add PDMC driver")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index e0aec5fe8a26..1a7802fbf23c 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -879,13 +879,13 @@ static int mchp_pdmc_dt_init(struct mchp_pdmc *dd)
 
 	dd->mic_no = of_property_count_u32_elems(np, "microchip,mic-pos");
 	if (dd->mic_no < 0) {
-		dev_err(dd->dev, "failed to get mchp,mic-pos: %d",
+		dev_err(dd->dev, "failed to get microchip,mic-pos: %d",
 			dd->mic_no);
 		return dd->mic_no;
 	}
 	if (!dd->mic_no || dd->mic_no % 2 ||
 	    dd->mic_no / 2 > MCHP_PDMC_MAX_CHANNELS) {
-		dev_err(dd->dev, "invalid array length for mchp,mic-pos: %d",
+		dev_err(dd->dev, "invalid array length for microchip,mic-pos: %d",
 			dd->mic_no);
 		return -EINVAL;
 	}
@@ -894,9 +894,10 @@ static int mchp_pdmc_dt_init(struct mchp_pdmc *dd)
 
 	dev_info(dd->dev, "%d PDM microphones declared\n", dd->mic_no);
 
-	/* by default, we consider the order of microphones in mchp,mic-pos to
-	 * be the same with the channel mapping; 1st microphone channel 0, 2nd
-	 * microphone channel 1, etc.
+	/*
+	 * by default, we consider the order of microphones in
+	 * microchip,mic-pos to be the same with the channel mapping;
+	 * 1st microphone channel 0, 2nd microphone channel 1, etc.
 	 */
 	for (i = 0; i < dd->mic_no; i++) {
 		int ds;
-- 
2.32.0

