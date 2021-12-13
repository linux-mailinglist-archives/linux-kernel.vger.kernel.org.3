Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B0E472E2A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhLMNzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:55:44 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:8802 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhLMNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639403742; x=1670939742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKT4TsQbf9WhAC/BzpiLxsl35EXH1/8qpv9zRIsAbvo=;
  b=bRYqplLljQDAqtV6FZTkqa8PnhAv8et2tdKh8ZkehFqolHf1DZGS9MPy
   VWXA46P75KFKGVoi0Kyz/FWqFoZD201Y13e1sCktlvsLxJXm9HN+yYc35
   2EWNrO5JzHeCrb8ATYvALeTUwxymH6FXb3rY/c7qCx1rzoLh30y12NT+0
   8V+gAuC32fdHNO6lZslz3UEoNvIzz6cjs7Ea909BpfyHy3cZjkotUkf1h
   k/0E+uEO/fJlqwfMQ14971N4ba9CLr3Rv1WR2Aj9GUIYFllls6xmvxT2U
   nITFkSkkDNIHd/RtkXYuIKsU/C6Gd94aDz/SD+VlbeXvNsxcgIIidvG7y
   w==;
IronPort-SDR: Sq4wjjOofCWVGyZv5eAq0hyYwQ/zg8wi+Ss0cDbu04rvODVG5OiCUpKDM3476jcg0AIPbExT2A
 80EZBygae7WIOW3RZ/VGXqprbe2Jp4I6xxH+we1wqaGmPm7tZVFvgXC01FgmufxSi29Dh2u+Ba
 RaRn1FxcH/drgRbAOzGpBmcTNG4rr3/YUXik5uSpZLhnOTQP2QEJUredyAnEFIl5Iqs5GZOqWa
 h4w/gfxw8jeYs83IOg/nGzLuLzFnqKPa4SrOIiy3RQO7smLJon0gQXiwaspzvxra51O7bXmLQc
 NIDKXVR8jDw/078kzsvmzVGS
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="147032929"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Dec 2021 06:55:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 06:55:41 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 13 Dec 2021 06:55:21 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <robh+dt@kernel.org>,
        <jacopo@jmondi.org>, <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@iki.fi>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <nicolas.ferre@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v3 19/23] media: atmel: atmel-isc-base: clamp wb gain coefficients
Date:   Mon, 13 Dec 2021 15:49:36 +0200
Message-ID: <20211213134940.324266-20-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211213134940.324266-1-eugen.hristev@microchip.com>
References: <20211213134940.324266-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

White balance computed gains can overflow above the 13 bits hardware
coefficient that can be used, in some specific scenarios like a subexposure
from the sensor when the image is mostly black.
In this case the computed gain has to be clamped to the maximum value
allowed by the hardware.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index f1f1019f9d82..31c8e3029eee 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1415,6 +1415,10 @@ static void isc_wb_update(struct isc_ctrls *ctrls)
 		/* multiply both gains and adjust for decimals */
 		ctrls->gain[c] = s_gain[c] * gw_gain[c];
 		ctrls->gain[c] >>= 9;
+
+		/* make sure we are not out of range */
+		ctrls->gain[c] = clamp_val(ctrls->gain[c], 0, GENMASK(12, 0));
+
 		v4l2_dbg(1, debug, &isc->v4l2_dev,
 			 "isc wb: component %d, final gain %u\n",
 			 c, ctrls->gain[c]);
-- 
2.25.1

