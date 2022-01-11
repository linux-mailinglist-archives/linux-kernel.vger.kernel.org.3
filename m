Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F124C48A941
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348860AbiAKIVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:21:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37090 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348867AbiAKIVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:21:35 -0500
X-UUID: 921fa6657b114919a390e5442bc561b8-20220111
X-UUID: 921fa6657b114919a390e5442bc561b8-20220111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 216767899; Tue, 11 Jan 2022 16:21:32 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 11 Jan 2022 16:21:30 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 16:21:30 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 Jan 2022 16:21:30 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Miles Chen <miles.chen@mediatek.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] thermal: mtk_thermal: fix kernel-doc warnings
Date:   Tue, 11 Jan 2022 16:21:27 +0800
Message-ID: <20220111082129.13459-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warnings:
drivers/thermal/mtk_thermal.c:562: warning: expecting prototype for raw_to_mcelsius(). Prototype was for raw_to_mcelsius_v1() instead

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index ede94eadddda..0df369edfb7a 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -550,7 +550,7 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
 };
 
 /**
- * raw_to_mcelsius - convert a raw ADC value to mcelsius
+ * raw_to_mcelsius_v1 - convert a raw ADC value to mcelsius v1
  * @mt:	The thermal controller
  * @sensno:	sensor number
  * @raw:	raw ADC value
@@ -573,6 +573,15 @@ static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
 	return mt->degc_cali * 500 - tmp;
 }
 
+/**
+ * raw_to_mcelsius_v2 - convert a raw ADC value to mcelsius v2
+ * @mt:	The thermal controller
+ * @sensno:	sensor number
+ * @raw:	raw ADC value
+ *
+ * This converts the raw ADC value to mcelsius using the SoC specific
+ * calibration constants
+ */
 static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
 {
 	s32 format_1;
-- 
2.18.0

