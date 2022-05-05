Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7900751C08B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359799AbiEEN16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 09:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiEEN1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 09:27:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B725C44A0A;
        Thu,  5 May 2022 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651757057; x=1683293057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e3n9VV+HBd1xZd89g2TZIbaen3NwdU0EFHUwQChhEZU=;
  b=N7SYWOo9plgBunKk7MA1+aOoGNR8s1g/UThcLapXvdlzTcRdtY3f6en0
   Q9ng1/s+QA/ooJQ/Dj9a1GHg+hJIPgpNKZEyuEVh5SkNQF1cnRJ/+M7no
   cc+m9CpJUqVJCd6eC9jpfo+KphP0tybxHb0n0xERVYchvILpjdqBbhjbR
   upRZrpvNFv3cq4Cx58jKy9awbuCS+3wff8v78oeEK5GJjNpEpb6jUCT71
   E5fH5V1nr+5gYMaG1l/dvwlp1BYWWrDQwXdD8rM54ZbIDeQLXbkUvuvlJ
   cSakM92TRVZB0dMhW8XCMzCwggTOMEt5IczJvc4ckqnZ8JvNq075oKtKY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="94662095"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:24:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:24:15 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 5 May 2022 06:24:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jacopo@jmondi.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] media: atmel: microchip-csi2dc: add link validation support
Date:   Thu, 5 May 2022 16:23:58 +0300
Message-ID: <20220505132358.51232-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With this, the csi2dc will take part in the media pipeline graph walk
and validate the links with it's entities.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/microchip-csi2dc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/atmel/microchip-csi2dc.c b/drivers/media/platform/atmel/microchip-csi2dc.c
index 2487978db1f1..d5b359f607ae 100644
--- a/drivers/media/platform/atmel/microchip-csi2dc.c
+++ b/drivers/media/platform/atmel/microchip-csi2dc.c
@@ -454,6 +454,10 @@ static int csi2dc_init_cfg(struct v4l2_subdev *csi2dc_sd,
 	return 0;
 }
 
+static const struct media_entity_operations csi2dc_entity_ops = {
+	.link_validate = v4l2_subdev_link_validate,
+};
+
 static const struct v4l2_subdev_pad_ops csi2dc_pad_ops = {
 	.enum_mbus_code = csi2dc_enum_mbus_code,
 	.set_fmt = csi2dc_set_fmt,
@@ -683,6 +687,7 @@ static int csi2dc_probe(struct platform_device *pdev)
 
 	csi2dc->csi2dc_sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
 	csi2dc->csi2dc_sd.entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
+	csi2dc->csi2dc_sd.entity.ops = &csi2dc_entity_ops;
 
 	platform_set_drvdata(pdev, csi2dc);
 
-- 
2.25.1

