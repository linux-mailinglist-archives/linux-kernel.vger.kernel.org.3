Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE673495F91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380604AbiAUNPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:15:53 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:17375 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350597AbiAUNPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1642770947; x=1674306947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q6diDbG5W/BH3EeOJNaDQg5HrHiclFaPCU00lATXlck=;
  b=Bgq8i50eYvUHhFKQ2zkU/hFiLcXG/suAObsApfvdCI1+PjLL8ovi1nCZ
   Od7MZWxaQoyP+YmJMYPOlLWTaz3fBR5z2Tr7tfPMcDi7JbXlhBcBg526W
   nmKsWSS4jdVI/3aONJV60vKNq4pJccX0Z0ayL7PBlwjNqV2evhKxNcc54
   89jUSz9J/kRhmDhGzDYwHGroD7afAVmDJx83aSn0ddXSynWDm2gsvTUyO
   AgSS7GLxygAqIzTgSy0VHUNPAdhzSytZyEywM46nIZBTNIkECSkm5SjjT
   Vg22/VkqDUKCqNwr4M0i0vLHpPFrMNgFSwBU+iwhxTM2LmqAS0dosJ3kw
   w==;
IronPort-SDR: A8pX1NTLUJFtnWabChMLOeYhxCF3dtDlowAbHtEJYUnkROjvDf7mMCSReYyX/QrfY87VnwNJ4M
 pBBS97+M/IqyH4S7i7q1HV4RZy2mnzQWSA2OMBG2S7YBTO/Ov/H/TIGnuuTQWW9gCOPnAJ7TiB
 hGiTKZEf8DfSo6Q5731EaF2CZGQUAMFfDa1RLAxFGAKJ7T8pjN/2sVBZ7yXl6nQx1mE7qAFlGw
 bu48Vif2//B1WyFbokaSRN4GXM70y2+dEABY3bJQFQs5ObbKIl7dwVaLCSgv0ZTBBHyOs7JjN2
 EVESyxsTMQhT1s4x7Q0JmSZm
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="146183423"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2022 06:15:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 21 Jan 2022 06:15:44 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 21 Jan 2022 06:15:38 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <robh+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <jacopo+renesas@jmondi.org>, <hverkuil-cisco@xs4all.nl>
CC:     <nicolas.ferre@microchip.com>, <sakari.ailus@iki.fi>,
        <laurent.pinchart@ideasonboard.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v4 04/11] media: atmel: atmel-sama5d2-isc: fix wrong mask in YUYV format check
Date:   Fri, 21 Jan 2022 15:14:09 +0200
Message-ID: <20220121131416.603972-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220121131416.603972-1-eugen.hristev@microchip.com>
References: <20220121131416.603972-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While this does not happen in production, this check should be done
versus the mask, as checking with the YCYC value may not include
some bits that may be set.
Is it correct and safe to check the whole mask.

Fixes: 123aaf816b95 ("media: atmel: atmel-sama5d2-isc: fix YUYV format")
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-sama5d2-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index c244682ea22f..025c3e8a7e95 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -291,7 +291,7 @@ static void isc_sama5d2_config_rlp(struct isc_device *isc)
 	 * Thus, if the YCYC mode is selected, replace it with the
 	 * sama5d2-compliant mode which is YYCC .
 	 */
-	if ((rlp_mode & ISC_RLP_CFG_MODE_YCYC) == ISC_RLP_CFG_MODE_YCYC) {
+	if ((rlp_mode & ISC_RLP_CFG_MODE_MASK) == ISC_RLP_CFG_MODE_YCYC) {
 		rlp_mode &= ~ISC_RLP_CFG_MODE_MASK;
 		rlp_mode |= ISC_RLP_CFG_MODE_YYCC;
 	}
-- 
2.25.1

