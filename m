Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07967542B1E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbiFHJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbiFHJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1276A1E7349;
        Wed,  8 Jun 2022 01:36:12 -0700 (PDT)
X-UUID: 569b3735fca34859a0ff75c044fca289-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4df39298-de03-4d3e-b3bb-0ce690f802b3,OB:50,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:4df39298-de03-4d3e-b3bb-0ce690f802b3,OB:50,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:907d9f7e-c8dc-403a-96e8-6237210dceee,C
        OID:ab9fe7398c47,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 569b3735fca34859a0ff75c044fca289-20220608
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 586299730; Wed, 08 Jun 2022 16:36:04 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 8 Jun 2022 16:36:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:03 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Guenter Roeck" <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 9/9] mfd: cros_ec: Add SCP core 1 as a new CrOS EC MCU
Date:   Wed, 8 Jun 2022 16:35:53 +0800
Message-ID: <20220608083553.8697-10-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608083553.8697-1-tinghan.shen@mediatek.com>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 System Companion Processors(SCP) is a dual-core RISC-V MCU.
Add a new cros feature id to represent the SCP 2nd core.

The 1st core is referred to as 'core 0', and the 2nd core is referred
to as 'core 1'.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/mfd/cros_ec_dev.c                      | 5 +++++
 include/linux/platform_data/cros_ec_commands.h | 2 ++
 include/linux/platform_data/cros_ec_proto.h    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 546feef851ab..7be2e23525e1 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -64,6 +64,11 @@ static const struct cros_feature_to_name cros_mcu_devices[] = {
 		.name	= CROS_EC_DEV_SCP_NAME,
 		.desc	= "System Control Processor",
 	},
+	{
+		.id	= EC_FEATURE_SCP_C1,
+		.name	= CROS_EC_DEV_SCP_C1_NAME,
+		.desc	= "System Control Processor 2nd Core",
+	},
 	{
 		.id	= EC_FEATURE_TOUCHPAD,
 		.name	= CROS_EC_DEV_TP_NAME,
diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
index c23554531961..1176cdc92d23 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1296,6 +1296,8 @@ enum ec_feature_code {
 	 * mux.
 	 */
 	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK = 43,
+	/* The MCU is a System Companion Processor (SCP) 2nd Core. */
+	EC_FEATURE_SCP_C1 = 45,
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index df3c78c92ca2..12fc60f3c90d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -19,6 +19,7 @@
 #define CROS_EC_DEV_ISH_NAME	"cros_ish"
 #define CROS_EC_DEV_PD_NAME	"cros_pd"
 #define CROS_EC_DEV_SCP_NAME	"cros_scp"
+#define CROS_EC_DEV_SCP_C1_NAME	"cros_scp_c1"
 #define CROS_EC_DEV_TP_NAME	"cros_tp"
 
 /*
-- 
2.18.0

