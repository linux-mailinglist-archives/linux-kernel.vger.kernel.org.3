Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D383472E27
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhLMNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:55:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:25529 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhLMNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:55:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403721; x=1670939721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kICjwcYgnlN/vC0Y/CALYqqZD73fHuSRwpC4LyuLypo=;
  b=wlYO59R0xz9+Ui4JgYYO1oVs/8Ggc/9V1mU06VHsVwhBZlbJhkUUO7dZ
   zwHI988K1h0cMTPAB6FHuAGvwn7w9IfK0FDZHDmikxTof0wcNHuEEtbl0
   hjJjwQqLpvkpAtT4SK7YksjKnQz09jJ4JiDXfyhjKIPK8noj3f41QmV2+
   OKlHUUFUmEKPDypqXwsTO0Sfk5CgteR2s9Bcag5nRuJgjbSOcEoTQdntz
   I0BH2blO27MLNRnuc/YF51E5VYsQRSRpEOPRQPiKfUmeTl+r8ofTQT4b5
   ctX/N8apz/iVuCsDaP/ysDz78tVc9DbNWfffrmvpMp7qw8UPAH0HCfwao
   w==;
IronPort-SDR: RdVCTj6jOGRh3fZrZp35jgld4KmUpNYcVVi7Q8OL0eQcRT3gUTziejp6HAz4EGHqGwCB6fv4kK
 o3+bHAC7O159HuB9wbvrA2KyQso5m8Y7QKykSmpXZDC0HxskR+l2kfA0/j2kVkuyisaD+sQ3HX
 r/61utN/FzNY6xOLvkctgDX4JkhB4WaBQIejy/OCYG8+2LENwjmbvc9MVKQ/uzYAMxgNfoeSrq
 0u1B21jEAna73wxi//cZNt8wX+/h8CHSTXwYOXB1wgbYHQCiQdqIdlh2GyxFDwru3sHkqbLCaX
 XCSdTwTgHqvgRdIL6TX97l4p
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="155270152"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:55:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:55:20 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:54:52 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 18/23] media: atmel: atmel-isc-base: add wb debug messages
Date:   Mon, 13 Dec 2021 15:49:35 +0200
Message-ID: <20211213134940.324266-19-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debug messages that make it easier to debug white balance algorithm.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 53cac1aac0fd..f1f1019f9d82 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1329,10 +1329,15 @@ static void isc_hist_count(struct isc_device *isc, u32 *min, u32 *max)
 
 	if (!*min)
 		*min = 1;
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb: hist_id %u, hist_count %u",
+		 ctrls->hist_id, *hist_count);
 }
 
 static void isc_wb_update(struct isc_ctrls *ctrls)
 {
+	struct isc_device *isc = container_of(ctrls, struct isc_device, ctrls);
 	u32 *hist_count = &ctrls->hist_count[0];
 	u32 c, offset[4];
 	u64 avg = 0;
@@ -1349,6 +1354,9 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		(u64)hist_count[ISC_HIS_CFG_MODE_GB];
 	avg >>= 1;
 
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb: green components average %llu\n", avg);
+
 	/* Green histogram is null, nothing to do */
 	if (!avg)
 		return;
@@ -1401,9 +1409,15 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		else
 			gw_gain[c] = 1 << 9;
 
+		v4l2_dbg(1, debug, &isc->v4l2_dev,
+			 "isc wb: component %d, s_gain %u, gw_gain %u\n",
+			 c, s_gain[c], gw_gain[c]);
 		/* multiply both gains and adjust for decimals */
 		ctrls->gain[c] = s_gain[c] * gw_gain[c];
 		ctrls->gain[c] >>= 9;
+		v4l2_dbg(1, debug, &isc->v4l2_dev,
+			 "isc wb: component %d, final gain %u\n",
+			 c, ctrls->gain[c]);
 	}
 }
 
@@ -1423,6 +1437,10 @@ static void isc_awb_work(struct work_struct *w)
 		return;
 
 	isc_hist_count(isc, &min, &max);
+
+	v4l2_dbg(1, debug, &isc->v4l2_dev,
+		 "isc wb mode %d: hist min %u , max %u\n", hist_id, min, max);
+
 	ctrls->hist_minmax[hist_id][HIST_MIN_INDEX] = min;
 	ctrls->hist_minmax[hist_id][HIST_MAX_INDEX] = max;
 
-- 
2.25.1

