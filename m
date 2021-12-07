Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6546C7F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbhLGXGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:06:35 -0500
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:56343
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242452AbhLGXG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:06:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fNql9jl7uHmOvdcwk4AvmRExbBUnISjP9+3NucMd3QzmdTEWF3cu+3UvFU7IT54HgpnBvUOU7sfW5n4zzfEVaAU2Q0vKqlbjNjPa8wXm+06zRTdNZj0eP1aVTt2lGG79SyJEYhlfZs3kl9TlNqg2egR94P6XHjSo6JCrFyTsfBBhC7/XRS3k0w4fziKY+A+t8bko37t3J8+W6VXQj/EQ0Qq5/mNSkuMT480ZguTvv1oqOLUh86bp2lacmjE8XFGErcNbZlsbjYRdihkYsKa0LGbhvp96H0EPhzLGii3kpUSygbmQkNmhcKMy7ociyZrDcLLWwUUx8LUUPVtbTmT0Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz6Guv71csNPLlk2okwUaQDALlCC3UxWIgs6ifO5E8o=;
 b=HWXAQT5RGbJWvTc2ugI4JC9lBt3p/yP4RcSHzeqK4t5OhWr32sX/R+YdYjxhJLSreu1CF85CAhbyxYt1C7ZvX5t0/2I0eSooERenkm///aF04Vu8bHVADzg2zffstE9LOGZjUsOooGm/u4iuDByn3KAPFHagPZBobkRSLPqtrq7sG80QRqvvI7g0qF0fNdHdFl9hDtIEIQqAoxGvAPYALGeNzDP6Hwj1clsLO3Qd8uN+9AL5TsBMs8fsHVXF8edXZDp5dyhEKkEO2+lGN9dxm8D5bjSXZV7ZZh5UmtG890Y138qO0CfZTFryOY1nE7lr6/1ibQAXl1ZSSRTUxAYkFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz6Guv71csNPLlk2okwUaQDALlCC3UxWIgs6ifO5E8o=;
 b=QP5h3KBVqCDqKx3jyB1cbQQWCZmE1+106JkwjGDnImEzNhirHQ5NsE628ocFWmlIV4/MktB2mtw52MMmmPxtBHxiHYkAIeFzBhkFDIHF3yVAVfOV5Ne8/cMrCIV0m2PsCCcKXEZ5g/ZljL2Y3yLgAo9sgEHqghmOmX78Zj6PiP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com (2603:10a6:802:c::17)
 by VI1PR0602MB2910.eurprd06.prod.outlook.com (2603:10a6:800:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 23:02:55 +0000
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf]) by VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf%4]) with mapi id 15.20.4734.031; Tue, 7 Dec 2021
 23:02:55 +0000
From:   Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
To:     linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, michael@walle.cc,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, horia.geanta@nxp.com, pankaj.gupta@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        l.stach@pengutronix.de, qiangqing.zhang@nxp.com, peng.fan@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, frieder.schrempf@kontron.de,
        krzk@kernel.org, shengjiu.wang@nxp.com, gregkh@linuxfoundation.org,
        ping.bai@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        marex@denx.de, thunder.leizhen@huawei.com, martink@posteo.de,
        leonard.crestez@nxp.com, hongxing.zhu@nxp.com, agx@sigxcpu.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Subject: [PATCH v3 2/2] arm64: dts: imx8m: define proper status for caam jr
Date:   Wed,  8 Dec 2021 00:02:06 +0100
Message-Id: <20211207230206.14637-3-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
 <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0069.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::46) To VI1PR06MB3102.eurprd06.prod.outlook.com
 (2603:10a6:802:c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GEO-HfyyrYQLnZo.lgs-net.com (146.185.2.7) by AM6P192CA0069.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 23:02:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac097029-890a-4f60-e1b5-08d9b9d5b3f4
X-MS-TrafficTypeDiagnostic: VI1PR0602MB2910:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB29109AA717F06551B75A240AA66E9@VI1PR0602MB2910.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oaW+Hddih713Ng7grySTpzv3KS+jZE2E0Urb3iSYPnUqR4dPtQVyufdkbB3T/ifev1baulx6i9ZhXI0NnNVBwAlhU9FgNMziX1lA6dIceusj4Ve630m+U/2xAdtaua7BSB97t8jtCGgBJadiF3WJCZcm+ypAI0ojyxx6D7RbKsZEs8xOgv72RgFzngB9K5KadTNPTyz6UFquhzbWzinD7/LYh653vGLsH6iKNs/0AJ+XRC50TyrbWCRptmV5OVdkfA46kvRlWNTquJElduZvLcNdk550ubp/oZTrVi0Eq8JZCgJZYyW2VwoCY1XZ/u26mfQZUnf5C65VZnRjFBYNGqXxKazem744I38JBPrchOpoIS6h4MWbF6ZwAhs81rSE+QygbpK4Hs6sQIfMNTeuiYH57wk3erzbXFd0keZa2XKxWgOuAjtAU4/D7wDsBM7DUwcIl0MhKmQ804tGk8owWg762COjj3S0rRjpwgt3dmyEioAkp1q1wu/+mRxzXY+oqAa6wCggUUB6xZ2gJ2nQnOu85I7whyECYeiO8G27I2KV7t/Zc5lSDFVw1JVHe+MjUFJ3tNOk392ZWvxWfY2oecO4y2p6bXbRBZbwg4PJ6jVA4X8XgaAMdaAQChxn4Q16auWuEjn9yUE3O5+YXxRD4az24l0qQmobquwTyzfSbeZE31AvsC1CkwoVZtUwxT98aQPx3L71snASVf3GpnMXi0GsVUCDL2QrD3Sq2pVjVXXDd2Z0AKgmXGPz6FKahkN5DpumPzcktWZNcHWEwxe1BffUPf9lT7kiiJALMQd+kyWA7u6y4U+9fpIdspkoQuPo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB3102.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(316002)(86362001)(83380400001)(52116002)(38100700002)(6486002)(6512007)(66556008)(66946007)(38350700002)(6506007)(956004)(6916009)(2616005)(4326008)(6666004)(7416002)(2906002)(7406005)(26005)(186003)(107886003)(44832011)(8676002)(966005)(8936002)(1076003)(66476007)(5660300002)(45080400002)(508600001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUsJqFLrmftfQ7UgGWjnhGg/7vfLyRshzPndftB/wWOqFp9Gs5mGtIx3w1nE?=
 =?us-ascii?Q?pTd1J4vWeVJhB7/DI/LCB6n1+Q13tC0tCK8f4ZNatB92Nxwwy2pWTlYXDDIN?=
 =?us-ascii?Q?eLODdFG9QWuuyHijZCwZldPzEsw1ZWdm0Qr45xEWLQUcOXwB0nP9lDivsi/Y?=
 =?us-ascii?Q?aW3EhrvH01BgjnWg0H2eMs+AsVO0+FCScFVUYwWFfcmPgIaRlc9niPt9AkOH?=
 =?us-ascii?Q?S8X18hf8O1JKN2fUfMQ61oJqVDsDehdmmFQClLRmN1IZuur8rMHN2BF10GMg?=
 =?us-ascii?Q?cIZutz8+fcmAwfj6y04BfbbMOZJ/zn1sQngOdayJKLFm2zqEz2WOeJI87sE2?=
 =?us-ascii?Q?N/6vdjpdD3ejb423B/tVtlce1rl2F0dhAKdxbqImthDCYE4sTQD1+Dax6BCi?=
 =?us-ascii?Q?GiRyzmLIqqhFMkuLUi8aAPdyX2oV3ZR/KJeihP+DzgWu9+wylfPfO5bDJyvp?=
 =?us-ascii?Q?sqs3ACPqRwz8sIUEt9AFzb4BjeqfbRWLCk2x4RU2JnYX4JzVAvDWzHVdyTp1?=
 =?us-ascii?Q?32XfvxWlTsjozD9F+Ji/3CYXkybgwMV3V6Ko6JbUvDPrn9AZKxod4jS0F1Ps?=
 =?us-ascii?Q?n2ustSaS4xGo2VGsBrRy7cQ8eJNfcYt+wOPJIHxCnMLcx/0UG5WlQBENPnu/?=
 =?us-ascii?Q?7l8vE7sXx/fYMPNqqprcYL78XKQ+tVj+MVvjoBtkyF3ZoHQUPx0S8quoxynS?=
 =?us-ascii?Q?uGGcUyZ9wRHaHDy5MQGd3DbdSUaB0gKg/kOmDNZOyIy831PAF+JwhavyW6h+?=
 =?us-ascii?Q?ByJmBr8WKH87qDScmFs9/yErKTSl+4455DeGU7yH/VD55RgDyec6lhyvnHKn?=
 =?us-ascii?Q?7hyfeXHPLOXPlQ3paTtdsYHmElcHkaqiTrdshGhDzrIXhr7gOWBrS1lLhRrW?=
 =?us-ascii?Q?y2tiXKBv53Y7uNVD6i3XOPsBMRZ9S+WSnr/FSOnR9ALSqYZkgvkGa8Nnxgkg?=
 =?us-ascii?Q?8TRlqisBNs1pXc/uL5GrowAVB89Z5G0LmZkr8cA386Mu+6JtNesXf6oTuISw?=
 =?us-ascii?Q?atzjFCNssvCbf3MIXzFaY6EOg7WhSNRAa72Y0v7CCpEDMZIc68gFPbpFdNaT?=
 =?us-ascii?Q?8uJ380o9uhu8TY2im4NjMP8ZYnzyjUuEUqLpqdRyxGumd5WibPWppu3PLlYL?=
 =?us-ascii?Q?hgibZR8Pih4H3BNK1+yPVup6Ai3xT4AYIp5ITGvuhh3qf1+WNRYU5SNOsK/o?=
 =?us-ascii?Q?ZAQSr0imuD7bPHVrkaNmGHzz68knfImTluuBMcltMWkmumibyFfUq5PSnA05?=
 =?us-ascii?Q?DDAsctRsIsePvRTwehpw1DI9soJPtVDseDHXgnPk4S1PmPCylmWxTInyraOm?=
 =?us-ascii?Q?2jR3wF/wDZOJAupGgMr+z75KiJeOfIXW5x6Kyf5my88AnztSLBIsxIynSTru?=
 =?us-ascii?Q?4DKOvV1eY5fF9Hg8e3ovivdvymReVPSc6DIDZQWu8yofj3j1Oxk6tQQPwiUn?=
 =?us-ascii?Q?3XRhNU68gEALyNp6zyTsq3gIjuvd/GpmpiGZ92b8fBGe7rsxXVs7BXpExHPD?=
 =?us-ascii?Q?lI9auauNb6DOU1hDwCMKqftjCjh7ItuyPSrJGRS7+JMHl2G9ZbhyqNYy8aQL?=
 =?us-ascii?Q?8jshVvF1+losAB34sPZP3E6kzKAWpS3DG5mAn1ZGfgfiuEG1sqdcbu0SqGDF?=
 =?us-ascii?Q?00LX7LzH0sESVXTzDwot/gz9W+L4qdYMFN+SjSQYMD99IpvzQ64DOwjA+sm6?=
 =?us-ascii?Q?r7xcXM0J810mH0CLOlUJNwhBtxo=3D?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac097029-890a-4f60-e1b5-08d9b9d5b3f4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB3102.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 23:02:54.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAQ08USSx5VuqYzeu+0hRbsmYFnjJTyssscSwQz7YceaMwvCon0s87KKvKtqXxzpjfk1ns/66P/1y79ZasDQAYC4nUJMayIuc7IN1pDIvcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB2910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAAM JR nodes are configured by BootROM and are used by various software
entities during the boot process before they reach the Kernel.

Default BootROM configuration have JR0 and JR1 reserved for S-only
access, while JR2 is generally available for both S and NS access. HAB
feature of i.MX8M family does require that JR0 is reserved exclusively
in S-only world, while JR1 and JR2 are both released to NS-World. OP-TEE
can later reclaim the JR2 via dt_enable_secure_status() call, and modify
the DID to hold it in S-World only.

The above setup has been discovered during review of CAAM patchset
presented to U-Boot integration [1], and does not correspond to the
status on jr nodes in FDT.

This missing status settings leads to the following error message during
jr node probing:
[    1.509894] caam 30900000.crypto: job rings = 3, qi = 0
[    1.525201] caam_jr 30901000.jr: failed to flush job ring 0
[    1.525214] caam_jr: probe of 30901000.jr failed with error -5

JR register readout after BootROM execution shows the following values:
JR0DID_MS = 0x8011
JR1DID_MS = 0x8011
JR2DID_MS = 0x0

This shows that JR0 and JR1 have TZ_OWN bit set, which marks them to be
reserved for S-World, while JR2 remains accessible from NS-World.

Provide the correct status for JR nodes in imx8m derivatives, which have
a following meaning:
- JR0: S-only
- JR1: visible in both
- JR2: NS-only

Note, that JR2 is initially marked to be NS-only which does correspond
to DID readout when OP-TEE is not present. Once present, OP-TEE will
reclaim the JR2 and set both "status" and "secure-status" to claim JR2
for S-only access.

Signed-off-by: Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>
Link: [1]: https://lore.kernel.org/u-boot/AM6PR06MB4691FC905FE5658BE4B15C11A6609@AM6PR06MB4691.eurprd06.prod.outlook.com/
---
Changes in V3:
- No change, new patch introduced

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 4 ++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 5b9c2cca9ac4..51465974c4ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -914,18 +914,22 @@ sec_jr0: jr@1000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x1000 0x1000>;
 					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+					secure-status = "okay";
 				};
 
 				sec_jr1: jr@2000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x2000 0x1000>;
 					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "okay";
 				};
 
 				sec_jr2: jr@3000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x3000 0x1000>;
 					interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "disabled";
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ba23b416b5e6..e5edf14319b1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -808,18 +808,22 @@ sec_jr0: jr@1000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x1000 0x1000>;
 					 interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+					 status = "disabled";
+					 secure-status = "okay";
 				};
 
 				sec_jr1: jr@2000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x2000 0x1000>;
 					 interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+					 secure-status = "okay";
 				};
 
 				sec_jr2: jr@3000 {
 					 compatible = "fsl,sec-v4.0-job-ring";
 					 reg = <0x3000 0x1000>;
 					 interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+					 secure-status = "disabled";
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 977783784342..3c23bf5c3910 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -661,18 +661,22 @@ sec_jr0: jr@1000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x1000 0x1000>;
 					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+					secure-status = "okay";
 				};
 
 				sec_jr1: jr@2000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x2000 0x1000>;
 					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "okay";
 				};
 
 				sec_jr2: jr@3000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x3000 0x1000>;
 					interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "disabled";
 				};
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 95d8b95d6120..16c4c9110ce7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -999,18 +999,22 @@ sec_jr0: jr@1000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x1000 0x1000>;
 					interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+					secure-status = "okay";
 				};
 
 				sec_jr1: jr@2000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x2000 0x1000>;
 					interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "okay";
 				};
 
 				sec_jr2: jr@3000 {
 					compatible = "fsl,sec-v4.0-job-ring";
 					reg = <0x3000 0x1000>;
 					interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
+					secure-status = "disabled";
 				};
 			};
 
-- 
2.25.1

