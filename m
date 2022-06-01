Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABB153A3E3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbiFALWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344037AbiFALWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:16 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB60F42A08;
        Wed,  1 Jun 2022 04:22:13 -0700 (PDT)
X-UUID: ebcf26889c404718b295ac3823ad1664-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1f741c7a-ec17-4916-9855-996018afb70d,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:a2648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: ebcf26889c404718b295ac3823ad1664-20220601
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1630622834; Wed, 01 Jun 2022 19:22:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 1 Jun 2022 19:22:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:06 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 15/15] mfd: cros_ec: Add SCP core 1 as a new CrOS EC MCU
Date:   Wed, 1 Jun 2022 19:22:01 +0800
Message-ID: <20220601112201.15510-16-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
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
index 596731caf407..07cc31d92edc 100644
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
index 8cfa8cfca77e..9fbf1c5eb8d3 100644
--- a/include/linux/platform_data/cros_ec_commands.h
+++ b/include/linux/platform_data/cros_ec_commands.h
@@ -1300,6 +1300,8 @@ enum ec_feature_code {
 	 * mux.
 	 */
 	EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK = 43,
+	/* The MCU is a System Companion Processor (SCP) 2nd Core. */
+	EC_FEATURE_SCP_C1 = 45,
 };
 
 #define EC_FEATURE_MASK_0(event_code) BIT(event_code % 32)
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 138fd912c808..da06dc7cf1cb 100644
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

