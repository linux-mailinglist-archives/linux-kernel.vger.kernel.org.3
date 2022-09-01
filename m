Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1925C5A8B36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiIACI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiIACIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:08:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2CED007;
        Wed, 31 Aug 2022 19:08:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRdWTE9/EGaTq/NH1azmxBg5H9sV78p+/93AivMBqwERPCDzzCu7A4arwptTnfkBczK/h9aGHTj9WouGIQH2UIzs7bbBLYyrsTssLakKlJjqRTi4tAlmL5ZF1lfLjEDiLYnP/vZRJi30dnT+jWQ3hm2zZqpvYZNaFZ6H0OQy/pCv6sH1WvtAsly156mZB0QKCXZc9PR9FKS0p4esr79ieym40XA6ijp+I1Mn2wH7cEId2a7LdruVW3qdPIQbk1mAsb12rD8GP9cDx1fZ88JiNUq5onWPDlFfJDIzMpqx1slNBRLb8C5ca2kf1JThvAl7KHCSdjC5FhvFn2euU0D8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SWEablSH9OldUQ826cJb97/PiZwyJuRCBFuLVqyHZ0=;
 b=dIM+udumFDlLKl+6okvkZ188T+UnIptjMTDZKwYeSmce7dp0nl5vWqpZejsf27i9y2RF5rMIWqAvbdOSthRbTXggeOBSw//WskLkKI6fYD/GBjWNfisvDTPrmRsTVk+Gx6Q+Q6XdnPNRZhbzmn8ATdDCPtRYVKYEO1onrdPR+CSDJaMxleuZ6mat9iZuVwcJFT/NJLAlxwhGXc6z+QJLLcloE9P1g4O6fN5oLueMuFKTbbz23xZREHhj4dCE23CA3bUFXfCSzn4T4zrLT21tbEEPtQrCLjJ1nktcEbtc7YPOxa5CnE2ZZI+imXKwhW7K6oJllIanpTekVjqtngnbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SWEablSH9OldUQ826cJb97/PiZwyJuRCBFuLVqyHZ0=;
 b=J1ZhgN73WiKGaslFxlYnuNfdHMv0Z/hmbSVhsHuB+EDDuEdz5b5Eq9W0inAUd/gNMyi9vlAF1I7iBrwK+76T3mNPy4327+OoiKDleNnJvuT0SY4+voS/GS6tVt/T8NOOUxUt7AGh9L9QlirtMWvHpnLhb3CDz8eXxO5/jl0H+ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com (2603:10a6:20b:ab::19)
 by AM5PR0401MB2644.eurprd04.prod.outlook.com (2603:10a6:203:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 02:08:21 +0000
Received: from AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198]) by AM6PR04MB5925.eurprd04.prod.outlook.com
 ([fe80::704a:fa82:a28e:d198%6]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 02:08:21 +0000
From:   Joy Zou <joy.zou@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-imx@nxp.com, dev@lynxeye.de, martink@posteo.de,
        peng.fan@nxp.com, Markus.Niebel@ew.tq-group.com,
        qiangqing.zhang@nxp.com, david@ixit.cz, aford173@gmail.com,
        hongxing.zhu@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/4] arm64: dts: imx8mq: update sdma node name format
Date:   Thu,  1 Sep 2022 10:08:51 +0800
Message-Id: <20220901020851.50262-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901020851.50262-1-joy.zou@nxp.com>
References: <20220901020851.50262-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:195::8) To AM6PR04MB5925.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0128ab77-7c6e-4575-28b7-08da8bbed7bf
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBJiEx4ctv3oxaF4HkAJGz1pOiLueJDhKlDDCeAVAlrn8rNPbk82pNmk/j2kOR7dpguvkdqFcp23VIhgJtF9MNV+9VeWhMB2mGicwoeQZEgmRUWsP/CIwqpu+n7czs4dBd4DfJUVIx+fYCMsMFm4sC5CVttKRzkZfB7RUFmuwLJKJ5cynDqOqeT9T0OeNcSrj73WsmZ7aSvBN6O1UijjDmNQV2DSWykF9mUqxsrRd9n+gWS3XCz4YkAQ6Key0JfOhbOyXLRXBPUB/A4e9Yq/0Qn1wwxv45iKwl+/freDB3pUfnqm/Ao+fuDj7xplO2sQx2k8TwXBX5OiGM2tzXWbMc3u1eAqduEF+MCtD++nnfL7HSj53DgcqJlPENp0nfaErPipGt7DyqpBRbet5NNH6O5ESfUajoB8McKXbDCUMdhB5X1yiU35F94DGWE+liqZLqzCtrF2Zovv0baPHnrfJYVeP5Tfl3FUoA4cJwSMVKzX4RZr3TSsJ7DpQcsJpIiToQ61WgcQUoAP1RTB8tLKajuwjKMoryxGyC8xbdQQaPPBlgj26BJcMzLTD1Dd8Kf29J4qfP87uOaba7lgWUa70+klC4jDietKFm6duF/fdnTKaDpjJ4WD+aWWZkoJ0fPFscukBUMthGFrR9RO2RQjrL8DAX00E7mReOFqZTAF8eSJ0MwGuFMb/2l1RqNHINWfOTDoFHeh20tM/VA3MCQQDmRycUZ4V+QyU6ZWL3so4ZKq23TSQLvuQkkD0l0QXJZ1ZjiHGAE5tPosZsyAjuzpDhtftfMheifK7e8MVmU68Vk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5925.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(6666004)(66556008)(66946007)(66476007)(6512007)(8936002)(6506007)(52116002)(26005)(86362001)(6486002)(2906002)(41300700001)(478600001)(8676002)(186003)(38100700002)(38350700002)(2616005)(4326008)(83380400001)(7416002)(36756003)(5660300002)(44832011)(316002)(1076003)(4744005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?naa11/9uRovuOvJrqEZRDTixFayKrspdoWjG8q5ZadEufmEj42HIRMOm/QgU?=
 =?us-ascii?Q?m3LDxkMmwu6RA5JMYCr8/BWq8U/YLnNua4D2Xi0NSFy0X12582HTjo6hrXgp?=
 =?us-ascii?Q?kGF/3bvw/wNNuwpuzmTEHkZ0mbUs1P15ubsE2QXTeKKOUIZx4tTo5Qej8yra?=
 =?us-ascii?Q?VxV72+JAv02/mITC5utZY6SgS+Aq/awGZ0t4PJ/uBX7Va75piGt8WyMJo6o4?=
 =?us-ascii?Q?jK8CGr6oCos2L+8wTg2KfHpxZ3yb0sh/dzO2wuCQcEF3aAeVpOs06McW4FTW?=
 =?us-ascii?Q?FF1CnjzE6WGh1Vorm9P8SYZn2LXsOHv4QQJD02EsezhN38yzk7VlUJ1vAlIX?=
 =?us-ascii?Q?cHTCwhamwty1GhXjO1IAs1JmvrC2foGYts2/jgcZVqszv2yMawU7mTsGve2F?=
 =?us-ascii?Q?3HTqnXVDc2kuP3INYVz5gpSrMU/SdX8cQi00shouJ92Gc1xedBN5eheJn+P9?=
 =?us-ascii?Q?5ukch5cgWwbl4u4l78UumunbbKem5C1qG1O+p0CsszgVHycPP5+kavtR4u2U?=
 =?us-ascii?Q?gdvR8/NH/xv/X+Vbed7i7uNXXoK3+zN52sQxs8W6c3EwBGOBJdmC0/Tl05+X?=
 =?us-ascii?Q?Hr/ZM4ozfVPGjmj9nmwp8VV6Nt1XEv/JPHQD14N5BCCNG+BP6z7KiwQx+upy?=
 =?us-ascii?Q?IYdApABeWPKgFZQ5iM3AgKS89mYgHHODF5HyJLE5OG1DZ3MqHqgHCraVACUz?=
 =?us-ascii?Q?sNvJmOM2ffN8tQleg9E5vg0V5ELQeGyIIWaqRonDmQSGQyLrS9Lnz7kiIayf?=
 =?us-ascii?Q?gNp8kQryaVwIlPWI1rsK9iOk3YpK1+0mVEwwCl0tkcQ1PPHPlaf1Ysz9EPuY?=
 =?us-ascii?Q?Oi5Wa3HrNqgX4OE4zD+62PHwS1dhXB9aFPaoxZ00vIUfKIJVEy+jKW1FWZOK?=
 =?us-ascii?Q?/pmmYhLTg6xUngE+TLMDkQLt8OgTL0NjSRXv+rmur6R0M5Bvu1E9k60b/8ta?=
 =?us-ascii?Q?v78GhIejIIng58Ap5kDWZZZPOqaiJAhl4dd2qtnDhjms47D5ra2MluB8xgKu?=
 =?us-ascii?Q?iMywq2m2jmptR0WhZsV6WzY5xiF+XSi2pUh+4ut85yvg2DzSnxwkvWG/l8Mc?=
 =?us-ascii?Q?8EKyd+nehfzOf/0FtlGCX9w4QgEyYHAV6DReYi5lPaAGG4egtj9LuX0Edr0a?=
 =?us-ascii?Q?9VJY3w94Qxlpbzfqvy2EaOl3Fo+lGPGIfE8h3l40o3bFrlyTPCUsDM5xJarY?=
 =?us-ascii?Q?jMoIlUBETI9cBJ1MHVMeP1u05NvaywCzhfQ225qV2H8ewjWRRPHSf1HdTfAU?=
 =?us-ascii?Q?00FPLRNgBQ7yYpkdq/Hqhr2+/6+L2I2nVhPo+uOBmqhF9N0DkuDUTR6ACbZs?=
 =?us-ascii?Q?6I3uHLlQJIufNcUtGlJqYzNkLXPjDEBURujxq2KeNh6o3CuHYJiaTzGi1osz?=
 =?us-ascii?Q?L5fEtduMRj1tnfHdbJ8p/q5t4/Z1WGTfPxeK4zeI41S+BtWVCfg2U4w/0Pnl?=
 =?us-ascii?Q?3jRtxvYTzg4URKt0cLO6nWurNEzE1fmeDK+cFC9bPi12pqF6gx2/GadjZlY1?=
 =?us-ascii?Q?6R8Yi8lweCeKmqq4lhS4pZqQ8pmkjazftSUTm2RdCif2w3oEfSblvJZwnqV/?=
 =?us-ascii?Q?aWIpYmRhyuB+HuVQLWfIBVKw+RhVUI8HIoTGNOwD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0128ab77-7c6e-4575-28b7-08da8bbed7bf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5925.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 02:08:20.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjtPM7YzGFR1m51V2Zh0bOd/EIkyvp2d+KXP77DqSN3ge9df+/XbJJ8ei4yMaM9p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2644
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change the sdma node name format 'sdma' into 'dma-controller'.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index e9f0cdd10ab6..19eaa523564d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -534,7 +534,7 @@ wdog3: watchdog@302a0000 {
 				status = "disabled";
 			};
 
-			sdma2: sdma@302c0000 {
+			sdma2: dma-controller@302c0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x302c0000 0x10000>;
 				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
@@ -1302,7 +1302,7 @@ qspi0: spi@30bb0000 {
 				status = "disabled";
 			};
 
-			sdma1: sdma@30bd0000 {
+			sdma1: dma-controller@30bd0000 {
 				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
 				reg = <0x30bd0000 0x10000>;
 				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.37.1

