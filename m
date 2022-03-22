Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1414E474F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiCVUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiCVUPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:15:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2060.outbound.protection.outlook.com [40.92.20.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97BFDF63;
        Tue, 22 Mar 2022 13:14:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR7OdXqul9SIZcI+DMr4egApol6kZ4fz2N1rQKGYQNKkljxP3quBi7fpmoSaPtbLpX35QBx1wlJJVKjtMOp3gkIilQKJCC3ov7I8aGMkQJXgcIHxVeew/3B1yiS1xQjx9zeBwg3YXsRDU/pqEQf6IxYkOVJPBYT2B9Ucik8WZ92O8a8La2Ofl59Zr7ptViiMrCBZaXr9TvQ8YnMYPlNWdP9Js/SeDwKHIuD8aW9cCex84Bbc74TH1o97DZh5m9WIVqYunIdsMY2K78GF3HIqxLENkSTp+ZQE0kZxov+1ky8BxCGzfmFGyQlPTJZ1TKl2NKCrsZxECY0d0aO7gb9vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFbvMZoEnRIj1hXG53utVqyxuf4e5prW49IEdyuFKYQ=;
 b=L2ulqK1EkSZAWNKkHvSO7x3EyKADc5glXOzlIBE7vii665cPkjRPf+5g52mC05PSaOiC6pz1HSFJd6+j/Y0KKpQECGDt37H8xfhqwa8Q2XQBOzgJBVL/O39NotKR1bsatz2JxoJ5LxsfVGbqCO0HyDSgVTOJSJLX+vOyoVNkO41j02xMXrjal3rzx4OnEgrkpBMAb/hOhvmMKHMkNsBmoikDTZBemZzqrMZv9jmDqjyvr0FCsEdqy3EAr1hWNzasW7uzUuqCOj17xRfb7GFDdXSE/Qv89ulRrqMqLLxAfsOo89gdtaax5na+uoSsbHKLLa3oW5TNrme27HVES1xbTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20)
 by BN6PR04MB0660.namprd04.prod.outlook.com (2603:10b6:404:d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 20:14:19 +0000
Received: from CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070]) by CY4PR04MB0567.namprd04.prod.outlook.com
 ([fe80::451b:e5ed:c1a3:4070%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 20:14:19 +0000
From:   Jonathan Bakker <xc-racer2@live.ca>
To:     krzk@kernel.org, alim.akhtar@samsung.com
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Bakker <xc-racer2@live.ca>
Subject: [PATCH 1/7] ARM: dts: s5pv210: Split memory nodes to match spec
Date:   Tue, 22 Mar 2022 13:11:38 -0700
Message-ID: <CY4PR04MB0567E33A07D8761C2D485327CB179@CY4PR04MB0567.namprd04.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220322201144.20320-1-xc-racer2@live.ca>
References: <20220322201144.20320-1-xc-racer2@live.ca>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [aP9eTJQxIdQImTd5NrhT45+PVcU3gxJ5RsCTJrxYvYv1VlDKIOSiS0ygtlMyf+PZ]
X-ClientProxiedBy: MWHPR17CA0094.namprd17.prod.outlook.com
 (2603:10b6:300:c2::32) To CY4PR04MB0567.namprd04.prod.outlook.com
 (2603:10b6:903:b1::20)
X-Microsoft-Original-Message-ID: <20220322201144.20320-2-xc-racer2@live.ca>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e0647f0-0ac6-4f90-cc13-08da0c408b52
X-MS-TrafficTypeDiagnostic: BN6PR04MB0660:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmlgAVCS9tJFo/ucG26D/nZ0N++V27bcz+vAnOlEe2eT4mfPoTCjKg7GXqn0iNhGMry6EIAxi3wXRizVok25gcQ0ujawS7JhZALtKTsXZ9pm0uQniyvYE5SynlkapEDhlDxzPHvUX3jNSEblx23GqYfzi8yRCKEm4R0hcUJdYxLUTvuZXMtuaGeEZ5pH0WNcpmzhIGqD7jbVFsD/k1nnOczGN2/WoQ2GYHM2LNQCc0M8Als0JB8KCbSr6jQMvMrc42lL89pjiZb1bT9B9cmM9/q3Txq+0GcSTW5xKI5P7B/Qg5lXpp0c38r2QvmfxqJzlz+gBHpf/A7HVbMx9cXCYobxMtyq/8ttH0EtaKUuUrmFl5XRvzj3EztrC7r14X9IoQ3OKkzn2+q5r1NEWul7sGGxvaY+0xKloQUrzpcYPL5pJ8HMVrwdtzfqEuNlgX9VyXGkr8qsMWGIaY3uZ3NgC9/MOyylsAcd7p1wmi2rY/ui3oAyIYswRBLWiXmrvOTaAiHBJ4PrVVsJG5cf+WAebJzCKN65cciq2XoMcBWGZI9CeHYTfHumkqIr2vzZRXYpp4OZNkWYiwyH1RyffEBSuQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?en81dzpjnJHzrGFX8dNHWvMFv5RkTyJaGwGPiaaH3ayeQO5BkqG3x7xOsuyd?=
 =?us-ascii?Q?mZxT8PKNjeJuviXIyirTVJ0MTOG81b8StQJklQKaUqZ/vQlBqrGQnYtvtM+x?=
 =?us-ascii?Q?BdhjwPyHki0Accmn0fuK4XhQbSWdwPE/jvv57dwipVBHhMfFASfQk15QE/d2?=
 =?us-ascii?Q?gR7lM8ta6/J7hlVJKeiokwYnmuK+cSFYzFwAQ2JFiB62vwtMUWkOBJopJCVu?=
 =?us-ascii?Q?rf0galT02bDCxPFkV3U2/pylMh4Tip0A1VFIgkOkLSI7Hp6elcZNVPOZsoFr?=
 =?us-ascii?Q?FyzKtm6J/eaJtS0B5HUGoFKk9ibRLLocVJcbxoTY2KuLSdoqxpDlXliAtWYS?=
 =?us-ascii?Q?00N5bmqR0qOfDWnx8z4/zxWS5ECOome4I/PdZLdYpH3PpnG6D0/SwObOpeYK?=
 =?us-ascii?Q?Gk+loq4MEa9UvTX3ZI3UqRILnSbuSm73GQ5szekuC8RvWr2AV3m7Uqc8jtBc?=
 =?us-ascii?Q?kAXZ3at1as8NQVwwBT62mXJRL6u+BmYC88L0zsw7BETnrTvxuzUJD8K94iDN?=
 =?us-ascii?Q?X5Tc7Mru8+hRS/s/cl/h0DgjpAPLdWXywPj2UizTt61PwOJlC+mftTXE2rQZ?=
 =?us-ascii?Q?7yglNZjWRByro0LxuGuaqB7sDvvYkmH/KZRMLSZIO8Ifxc20YwTSBa34E5C6?=
 =?us-ascii?Q?nAJ57afJdJofLWRmKBpeb5kOf7bjoqusY4XdgaYri+E7VLexw4XqGi/tsknN?=
 =?us-ascii?Q?AElxRu5BgA7L4J8zDG1aoZeArNQA2w4wNJjrbyaRSq54CSl3hxmJusqtAbI3?=
 =?us-ascii?Q?v2MZxyhNXZvGnbRqC2oalA7aJ6bPOUulafLnvNOzy+XSny5XGwEfHcYct9lu?=
 =?us-ascii?Q?J7bFeD6BTsaMbgwV7qRv8/ncVqHs6fPvWgsTjSTG+7Oy8OnpwjeNE71uVXvr?=
 =?us-ascii?Q?XpF/urSxP2SogDe6SXqIyOp2lh9HtPjp4XGMJpXlncth8YSohD5I4S13wJE/?=
 =?us-ascii?Q?7rxuJMNpiF/UHnVy/aJBO+cNrQ+ELf8phCuHkqNAu/ZTYaTfn2pLZOEjEYO0?=
 =?us-ascii?Q?mgShJvQzQKgWPFFCOiYR13WYb9hf82r7LitxWZoFN1Fg2soOBNEo/I/9tAvh?=
 =?us-ascii?Q?Uvh7hE9zJAhvpDQHQMSyfZ/wxYSSxFPq6148XYS6Snc4p/ty770Ymnpxjwt7?=
 =?us-ascii?Q?HAvdpumeNiJVMzG933w8FvJqSp9aVkXIbcuRZxSa6+BA/Ob8mqePN200YCdR?=
 =?us-ascii?Q?u4M9q/vadOKpnF4Wmt/B5bkmqnCuyhV3DeGimQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-edb50.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e0647f0-0ac6-4f90-cc13-08da0c408b52
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB0567.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 20:14:19.3120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0660
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory nodes should only have a singular reg property in them, so
split the memory nodes such that there is only per node.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
---
 arch/arm/boot/dts/s5pv210-aquila.dts |  8 ++++++--
 arch/arm/boot/dts/s5pv210-aries.dtsi | 14 +++++++++++---
 arch/arm/boot/dts/s5pv210-goni.dts   | 14 +++++++++++---
 3 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-aquila.dts b/arch/arm/boot/dts/s5pv210-aquila.dts
index 6423348034b6..6984479ddba3 100644
--- a/arch/arm/boot/dts/s5pv210-aquila.dts
+++ b/arch/arm/boot/dts/s5pv210-aquila.dts
@@ -29,8 +29,12 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x18000000>;
+		reg = <0x30000000 0x05000000>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x18000000>;
 	};
 
 	pmic_ap_clk: clock-0 {
diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index 160f8cd9a68d..70ff56daf4cb 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -24,9 +24,17 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x10000000
-			0x50000000 0x08000000>;
+		reg = <0x30000000 0x05000000>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x10000000>;
+	};
+
+	memory@50000000 {
+		device_type = "memory";
+		reg = <0x50000000 0x08000000>;
 	};
 
 	reserved-memory {
diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index c6f39147cb96..2c66ec5cbfbb 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -30,9 +30,17 @@
 
 	memory@30000000 {
 		device_type = "memory";
-		reg = <0x30000000 0x05000000
-			0x40000000 0x10000000
-			0x50000000 0x08000000>;
+		reg = <0x30000000 0x05000000>;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x40000000 0x10000000>;
+	};
+
+	memory@50000000 {
+		device_type = "memory";
+		reg = <0x50000000 0x08000000>;
 	};
 
 	pmic_ap_clk: clock-0 {
-- 
2.20.1

