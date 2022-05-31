Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2F539654
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347059AbiEaSbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347060AbiEaSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:31:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D1769496;
        Tue, 31 May 2022 11:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654021888; x=1685557888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NcY+/RHrHOgS2GNME8uvnAPvcP1euOHTrg8mlxIo820=;
  b=kYtSXHptzVChWU6vewXWlcVVjFcfFc9hmo0al+TEmUa1wlUc9iqxHhJd
   hthojrZ2HIvhW78zIrIMqiIiBzckyzCks/gGgaY5BpPToLkfDEznf83y+
   k6RxtHxNM7wz+ZxaorHaqD41ExiE3RRh3BrwYSGVEiNQ0SuDz05wlKRrF
   U=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 31 May 2022 11:31:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 11:31:27 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 11:31:26 -0700
Received: from codeaurora.org (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 11:31:24 -0700
From:   Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
To:     Sebastian Reichel <sre@kernel.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@google.com>,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Subject: [RESEND 2/2] power_supply: Use of-thermal cdev registration API
Date:   Wed, 1 Jun 2022 00:00:54 +0530
Message-ID: <20220531183054.6476-2-quic_manafm@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220531183054.6476-1-quic_manafm@quicinc.com>
References: <20220531183054.6476-1-quic_manafm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With thermal frameworks of-thermal interface, thermal zone parameters can
be defined in devicetree. This includes cooling device mitigation levels
for a thermal zone. To take advantage of this, cooling device should use
the thermal_of_cooling_device_register API to register a cooling device.

Use thermal_of_cooling_device_register API to register the power supply
cooling device. This enables power supply cooling device be included in the
thermal zone parameter in devicetree.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
---
 drivers/power/supply/power_supply_core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 74623c4977db..4593450920a4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1157,9 +1157,15 @@ static int psy_register_cooler(struct power_supply *psy)
 	for (i = 0; i < psy->desc->num_properties; i++) {
 		if (psy->desc->properties[i] ==
 				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
-			psy->tcd = thermal_cooling_device_register(
-							(char *)psy->desc->name,
-							psy, &psy_tcd_ops);
+			if (psy->dev.parent)
+				psy->tcd = thermal_of_cooling_device_register(
+						dev_of_node(psy->dev.parent),
+						(char *)psy->desc->name,
+						psy, &psy_tcd_ops);
+			else
+				psy->tcd = thermal_cooling_device_register(
+						(char *)psy->desc->name,
+						psy, &psy_tcd_ops);
 			return PTR_ERR_OR_ZERO(psy->tcd);
 		}
 	}
