Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD20154E533
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiFPOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbiFPOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:43:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9559A1F2FB;
        Thu, 16 Jun 2022 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655390597; x=1686926597;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rWVbM8rJZf/kGgg+MoVGSQyw47/ojhqYjjLSMGPkWq8=;
  b=Qp07RPqofw67tZXEz96gS6g8tEeiazAwkaQqFFa63e8ww2PUwjz+8o+A
   mcgNv2l+9FGQPWwuMGHRdthChifidjU9R6A2uhwEZi2xJ3wmYyJ6H50S8
   kbmpI41JVpVkm4Jd6pWu/ePdTlKefsGoz2VSiTEGySl8L68wNMufSthXv
   peSUcUEZO2o791ZMk1+/oOqV1dzDnMhCCAzYWqEDiCHD2hLIfgwrO/WvS
   azmOdmggMiXUzr2jXu9MAlitbeuaRPESCt9gkSOtgHg91eJQ1ez/8ghxK
   XSAqeyDHRk1DMqZ0NeuZkIcag93SYXNJWx4fiAJqHoyVG+RTthIPH5aNi
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,305,1650956400"; 
   d="scan'208";a="160662022"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jun 2022 07:43:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 16 Jun 2022 07:43:15 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 16 Jun 2022 07:43:13 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] media: atmel: atmel-isc-base: allow wb ctrls to be changed when isc is not configured
Date:   Thu, 16 Jun 2022 17:42:59 +0300
Message-ID: <20220616144259.226837-1-eugen.hristev@microchip.com>
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

When attempting to change the white balance (WB) ctrls before starting
streaming, e.g.:

 # v4l2-ctl -L

User Controls
..
            blue_component_gain 0x009819c1 (int)    : min=0 max=8191 step=1 default=512 value=512 flags=slider
..
 # v4l2-ctl --set-ctrl=blue_component_gain=500
 # v4l2-ctl -L
..
            blue_component_gain 0x009819c1 (int)    : min=0 max=8191 step=1 default=512 value=500 flags=slider
..

These will not be written to the internal data struct and will not be
written to the WB hardware module.
Thus, after starting streaming, they will be reset to default:

 # v4l2-ctl -L
..
            blue_component_gain 0x009819c1 (int)    : min=0 max=8191 step=1 default=512 value=512 flags=slider
..

It does not make much sense to not be able to configure the WB controls
at all times. Even if the sensor would not be RAW Bayer (and in this case the
WB module is unavailable), the user could configure the ISC itself, as the
ISC should not care about the sensor format.
Thus, when WB module is available (if the sensor changes format e.g.) it will
be already configured as be user's desires.
In consequence, remove the check in isc_s_awb_ctrl that will return if ISC
does not know the sensor format.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index afefd15c3326..72a27a5c0c1e 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1527,10 +1527,6 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		else
 			ctrls->awb = ISC_WB_NONE;
 
-		/* we did not configure ISC yet */
-		if (!isc->config.sd_format)
-			break;
-
 		/* configure the controls with new values from v4l2 */
 		if (ctrl->cluster[ISC_CTRL_R_GAIN]->is_new)
 			ctrls->gain[ISC_HIS_CFG_MODE_R] = isc->r_gain_ctrl->val;
-- 
2.25.1

