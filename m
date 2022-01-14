Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A1648ECFF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 16:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiANPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 10:19:11 -0500
Received: from mail-gv0che01on2108.outbound.protection.outlook.com ([40.107.23.108]:64257
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232400AbiANPTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 10:19:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsnjECzYAiae9FrmzrdHtJonBGZRQVlMrEirEsjImryE05Vz5BiSesRqYTGWXcjWrqFKlstHoZ946sP4cfps2nxTgXqo6LKnnFlu6MPOtFaZ42tTn9+ILaltggVb2VQmTwJw4y8OVEtykBJFAmbp5r1vINjiUvdHyv22sz5s06j5GeWxlZ7srGSMY9/sLHZrog/IqmV60O4V0rBEMleY/r51zhJKmVooiUYPC6zJ8JmJqskGReJ1SGWNqpJ1OaAtjp8RPnjv8Ig0lz2JIF8IdVXP5IEW/mSGqVGmv011BCFtNBRzKYDS2rtf4/WKqlms05+H0X5vzVDkWBoxgDXCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OZ6Dx16qXtafE5LB02I1rNL4YOgWBSwIzRNI7E26ync=;
 b=d/OMsWIKIhgD3YANOU6n638gbJcSF1c3VWmAOFCvk0yC97sAjkeRpbxrFaTlJTsh/cG7j0tsE78o8/ZndZupLS7R9GDV/kGB2nIScjYKbVhMH+TKMbpbz6ctTFkjZys94+terUJo1CdS3SWjt9NPIBEyMwx5lColpZMpT8drQZdSOZoVkCP0Kraro9QFqoS23nJI4OIdw7lhmT8c4xQBraq4OhW1uB7+8XND0Q4tUtIzj8vkPCRPBeH7dQKDR3k5WW+cIuKrdGLkUfyOeMu58CfcnWrivj7jm9ohPPRLBEG1KC0KqSKwOrq91YamdWmT/FkEFOHLEjTG5Tbtt6oAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OZ6Dx16qXtafE5LB02I1rNL4YOgWBSwIzRNI7E26ync=;
 b=qli2ZMCje9pniQ+YrWwXYkc7sZIIXRFM8e9EHZg65xXiBqc2KVv6DnEJa37yFFDEGxiUMgUbzqVoKFdly6+ZuUxOIVPN6nw01b0Vw+e0tNe8JSAinfwJTYwv/tFldaEQOiygxe5OxnsQC5UiG+bbihsIvoPIBzRQ4hgSWdVn8cc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:13::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 15:19:04 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d837:7398:e400:25f0%2]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 15:19:04 +0000
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Denys Drozdov <denys.drozdov@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] ARM: dts: imx7s: Define operating points table for cpufreq
Date:   Fri, 14 Jan 2022 16:18:46 +0100
Message-Id: <20220114151847.290518-2-francesco.dolcini@toradex.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114151847.290518-1-francesco.dolcini@toradex.com>
References: <20220114151847.290518-1-francesco.dolcini@toradex.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2a::7) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3430a882-3d81-47b3-f05f-08d9d77133a9
X-MS-TrafficTypeDiagnostic: ZRAP278MB0080:EE_
X-Microsoft-Antispam-PRVS: <ZRAP278MB0080E69DDBD80F8E348B0BB0E2549@ZRAP278MB0080.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SvV2L5LaLL3xiHLUNK1HQvddPI/Wiyc1NCw8bos5LIMbDWJKXXI7wuz+BIyP1AIJipWhRKI4SSlLKRwK8DEaqYAKGd1mrqSNWqE3KHPeydo2lPV7W88vWiWizVpPYWLvmmdRjK36XOnlOAuVFhO5K/4yfu4nH6c+G5tGX0Zi/nvfNY8jGvPFJemeWm3JCTb6fLE3nTTxJ6fIoI30XFI0szu50/kGx0kNgGNNkcfCD5FBVt2/IqpwNibEHUf2Zvc/iuCUdxa+5l6llvOWqAJAvndKFDYBar1bcLZQau4CDLo5Lhmj0ilTugxaon/HiaiXQ5Bu1G0NsJc0VD8tUvcbW1/FaYzzPvbZKCQOR8XYMWrWFIeblHsyCUw5NZIQ/aB4mnrp78aEUxuDH0PT7PoJsYINLUJe2SuyGQzgI7zTV1EdOBSFhS8ew7Owog6ndttGboaPeS5jPen+Wu4O3RZGBh7H5g4hjYUPocf4CtaCSztvRJD17FUrDUbnXTJXj//z1nvmp5n2+TDYZA7Gy+acbHnyMmLl0shw63BOtTkU7VMHZKZEzG78T+5g4NEe68cVK/1Fi/sJVOOnk6UoNEtQHh4NdgVqIwn/eaDF4UwTJh4Oh+QVQ9Md3UTUDtaV331qCF4K3ObikaKeMFhf+i0zIuvYwH8DSSSh83xsBIYNF6Jc/yYgBNf/+ix3AyddrEqU10u9dQ84KEt8+Qur6vGfaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(36756003)(110136005)(86362001)(5660300002)(2616005)(316002)(54906003)(38350700002)(6506007)(26005)(52116002)(8676002)(66946007)(66476007)(66556008)(186003)(44832011)(83380400001)(1076003)(107886003)(6512007)(7416002)(6666004)(6486002)(38100700002)(508600001)(4326008)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XXls+rtGCg3IIDvwUTL+ACUotX1/2122gzX4xS6+hTsGvbBsVIBavZojCrEF?=
 =?us-ascii?Q?q45lgT5MCGXxWuvl/11z+W8aIo8RUnoxcIhSGbGGwwLz/nvgvPoTRMfmohAi?=
 =?us-ascii?Q?cZdogPB0hAs6BtDdeBNsNkZz2nIwlJfw6saSxMSvyfs4We0RgcS6AJnTaVyA?=
 =?us-ascii?Q?Z57mktpGND4CXyf0VxORsLkyScb5pR8E8jSZ/Av2XPVS2DnKdqz+V1dN5zjQ?=
 =?us-ascii?Q?7wUNncIwKulKzpTkl0mQDb9w2i04ccguX/RdhgtBuQdzgyw+g6KYtGnC/0nE?=
 =?us-ascii?Q?Pj6m+LOH/v1KWZGsuRUc0KWjV8OsogpfM7g65mSyqN75wu7rkJ8of61YG2k3?=
 =?us-ascii?Q?1Ffz6kAMD9YjMkrrSUMl4/gHZaxAPdS7r6zLDErkzmAudv49OioTUtZvuAnU?=
 =?us-ascii?Q?4WjHnEb5o8k+kkJcXwCX1iAAA80gWHhZwLOOcqqCGMc+A1leIsWC3iQm8Ira?=
 =?us-ascii?Q?p/f9Irp/JU4dx/VsVuCCvgvZhu9S3dF29kpx42V4r2RWfSXsGe9yRAVDJjHJ?=
 =?us-ascii?Q?8O8TqyQ9dY/YH+AKH6T+zSRqaA407OdovHzQi5Dqox04z5tG5pE6l2tg+jXe?=
 =?us-ascii?Q?GK7m47aX+0a1UY8TQxAJEqLffKAHjl+J+9WNCAdUChIcdpLfZv+OgPdTBp7l?=
 =?us-ascii?Q?Tr3MutD7rMoXU9qvOszt6357gppFTiRA1MMj/UCNm8JSqa/OK0NcAo1Fc4QM?=
 =?us-ascii?Q?BPc6aFO1BtfpiPw0zeobzfv5x4hjPowoLbrY5Wv18TlQUSsFlH+bbHpRCRkC?=
 =?us-ascii?Q?hoEhhtg0re4Pf1f9Vs/yGxJcz1NoXMmymw2Is+n/5qvS/VbBl+fHF8Sq/eei?=
 =?us-ascii?Q?Oqh/sA7roMQKp5yRALWb4l9KxeT9h/WhI0M4MpO57UMX+vRulheHvXER6H5c?=
 =?us-ascii?Q?jVRlFMouAge0HCCM6c1WuomUK9/cD77/F0lTJZcIuxuN6Edx0M/0yzk4ryiI?=
 =?us-ascii?Q?X1o+PKu9QgwhnvDcltalClB9AtHG3AL11oRvmhCS/08FksEfWt2ErWOxE+cn?=
 =?us-ascii?Q?7EEyRgjSCiGzw9VQFfPX9F8OJp4Y993GRgrPSYmW/WMrRzcxF3ggZb/nl50h?=
 =?us-ascii?Q?eC0ThmafgQCkHPVqORrdKYDi0CIs/kEwBHDvvdavchrh768N7jL1sZbpDggx?=
 =?us-ascii?Q?XUf8lV4JQNH5PwJlY6q6GSoFRrSjhdni0FKgz0nEm5rsO6o9v3PZfagL1+8d?=
 =?us-ascii?Q?jHBAWGaNAwkFPhgddeYC/m+m6neeTHUmjskAQnrT3FaOGH7/7M0HFW+BcZwV?=
 =?us-ascii?Q?w3BXC2q3dWKtpXEepPyEw3D3IK0UFQnIHGPC++yBMxY77adu+bOU/HNPmm4n?=
 =?us-ascii?Q?jxM4DcMHA3piyCJywwEmHlZAj/Ot4foOj06WEx8HJWOgP2PsnamEG92hV9Bo?=
 =?us-ascii?Q?AY4HP15ykFEQydQNzfO8r20PLpwUWRJSglXTCKaaoplNVa2sG67CntA9b8xW?=
 =?us-ascii?Q?0RHK92P/nDQ/mJ+yIek/ubkttPUY8BdYubOxxjZO1KGAjpRHyr9Fa97zhlUz?=
 =?us-ascii?Q?Qz6I0A97YfXF7ncwvmpL5DQOZVk5UrorRXghtvAh6ilcvDkC99KpsoHmL7hy?=
 =?us-ascii?Q?8w4AFJizHqLeA3gCrkkF3R5gE4ZMvxN2BSC6F7hudVPxAwwljFOZXs2H5oav?=
 =?us-ascii?Q?wPOm0h03+LgscjBR6GBrbGePm8dZk+Qp4I/K8H1TTDx2a5hN5uod/olu1BUd?=
 =?us-ascii?Q?6hbkNg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3430a882-3d81-47b3-f05f-08d9d77133a9
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 15:19:04.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3rrkv+T9CpZggUJUJLoNLLTIi+n0mhEScdKVK+Yu30xUBxfAL4h8rXS77nSK/cBCHKYH0UUywwJLwwYnFOPtmTTi8gCxr5lYwODHTxaEsX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denys Drozdov <denys.drozdov@toradex.com>

Processor operating points for imx7s.dtsi should be properly defined to
perform correct imx-cpufreq-dt probe and registration and provide an
access to the temperature sensors using the i.MX thermal driver.

Signed-off-by: Denys Drozdov <denys.drozdov@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/boot/dts/imx7s.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 52a9aeecdbb2..5af6d58666f4 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -76,6 +76,22 @@ cpu0: cpu@0 {
 			clock-latency = <61036>; /* two CLK32 periods */
 			clocks = <&clks IMX7D_CLK_ARM>;
 			cpu-idle-states = <&cpu_sleep_wait>;
+			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+			nvmem-cells = <&fuse_grade>;
+			nvmem-cell-names = "speed_grade";
+		};
+	};
+
+	cpu0_opp_table: opp-table {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-792000000 {
+			opp-hz = /bits/ 64 <792000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <150000>;
+			opp-supported-hw = <0xf>, <0xf>;
 		};
 	};
 
-- 
2.25.1

