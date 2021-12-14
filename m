Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA2473A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbhLNBiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:54 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244703AbhLNBio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1tHc1WOssyJYN7K4QOoPZ01bsWbiUDr5i/acCUTa4lM/JwpDXcUhO3LdxcUWPon49obCCYJ55ghGouV1B8Dai+OO0N8pVkzKNtEMkdPePXxwPSp963Mtj1FAvmgncckUVUZGGVf9imzhmc/HNm/8hMbOs4q9N/gmsGvS6/walSL97b/0vfAa5yrbqc4bN/Fl/wiOn+dgx6KWu1bxXr6eJ3GBJgT2iCTJkdZ+eCCZG5L/66hkH6axUxOTZPHyay+qExaC+0v+8Qw52CXt5uT5K6MDx24JZGLnKAVW+T/64IPSeS9rR5aK+I1e3Mz35+apbtm6I9Dk3VctN7yUxUQlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKGSUYEkZAOYSTtDZxDoZWqR+ZVSlGdLUkt5TrEIUE0=;
 b=P0mxX+cfjjMZQU+HA2jO6APT5xOmHZdRJ58H6Z5ezX6C/BfE4w8bV+2UCX+gZghZoSuYLMuyoQZbRwowTPjm25EC5nUcDWJCSYPVeM4Od4m1oKsNGLBG8hwQaibF3Hsf/sAWcRlQ2G+l3mlgoZMMFtd5H4HVmjXJNTxK7XArugHqcgI4gVfUkhZFjv747omBoGMsmx/RSoYomD+Mj/Nnj3ezulnUmAtDZNk+jlBwRIyoMK6qZIWRLY5JCeAgKHHHkyeSk26KAoU4bxT5zsnC8FapHuAxmAz8NHnH4zIk+gdHPXTkSCTluGq1OO8Gjj9nEze+jhV+dNVYo635PU8laA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKGSUYEkZAOYSTtDZxDoZWqR+ZVSlGdLUkt5TrEIUE0=;
 b=jW8C7aA2WAHZ3CYqWGwzNkIgBsWdC0GHSeGwKmeZM1A8tSnGoO8hdTsqydznIhBhLPRn8n6zilOp6lljES0KW6KGEsEDBEhzQPh6Fa0xzleSaJCVTuLuzf9g9o7nhvVoGCJI50vcemqmShNTZbyhka0mIh3hC0474JZfqyTrDH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:40 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:40 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 05/10] arm64: dts: ls1046a: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:55 +0200
Message-Id: <20211214013800.2703568-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3570e709-0199-4421-164b-08d9bea274cf
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB69441D843B2B49E73F64D90AE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hfxy6phUKef7QMy145z7zg0KsKlBnYJFtAM3seNEeC5cM0WcjBywA/FV5sC7xUJhiatBA9E2VCDmlO2q25GmGry4ospy+Hb4h1ouW9q7L+jahZUXzPkFjvyLBceGjmRquSl1r2fXpy1X2iWf62wezaPkRilA0HTRnBpF6nkRAO7W7nDjajgX02iSMEtKTtjlODehKtXkgob8M9EFEh/4abErDkwdjC75ADTEwiC4wB65MW6SlqslQ7c3E2FcqKkbcOGyd8L2d0TB+5jh5CG0+YV2ClZTvVdYs15G9FzCH/fAVz4wQyhKtUSvZ5VaD/5oG5JKoSHH3UQGG8RISk/Mxwj9LFReCVyWFSXMkGTIF5LRWZFFfCqTarNylsLaAnE3dvLrkgVKw4j8gHJM3HzwBu6QSlRJ1xbWP3pKky5+4fl7sd73w1RhHcxGHPOb5d79DVWMcrlQQA6CVHObqzqXh3c1iNj6ep07wZ/J9mKoJ340TICxSDByHoQrZ/8r8VwrEvU56PdC2qX+9D4EAnYpV9KU4f4Jm45nTvZWxGwi/fv+Tpx3/ChObcGqNlS3clOrSy9yfIpSwLPW67oUQc7cMo+ey14/C5VU85/9u/7w4/XmysM9WpO/0i3oHXA8moJl+PczbgQuUybsyw7bbJ0J+FV9/rWGqG9wpFXW5alAqgeVSn+wJIVVqhCEww2NifdSpqxY2tnzZzQisnb1kNRXZjy2TZe+n+FcXfZFzO2ufScb19HNwS+bgcHkZRWIAS2mSxFB1iSAC1JqE46a+/kpJE426p+xvif+crigQTDbLJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xdTJyyfYlEE6JqluvnuqXnAt45OCldlj0euya531HBqpismsoYk0moDQykzO?=
 =?us-ascii?Q?hGNcCSB2+n0nzg4gfGzwL+MJtpCuWvm/cj6f8Hg02JXSVCXsDi4Jn5Udpm0i?=
 =?us-ascii?Q?A9DuxHZw+plKOq+kXMh8nQ1Eoxj3c0WfHpqmKxR+/3cInnGh0ybP6O00sLEI?=
 =?us-ascii?Q?VG3l3PuQVhKVBYHx1nprTrNHSCLZ6MneFUgMX3QZMn1oYjpYlvvmr1Ez9EFZ?=
 =?us-ascii?Q?pdEWA0Q+oq4t+u+1Uv/Jg3zZAjSeDB265j2E9wAT56xY6kl5QqzSd4uGPahu?=
 =?us-ascii?Q?Mw+cAZkiWxPVYRrbMIaZaWUxnL3jNx7CNurg7JbpLbgcJ6HXmCrsJ2k76cSh?=
 =?us-ascii?Q?I7kBQwenEBAFq2CorFABjzeBmsdgzJUDLI7ApBbL+Mew+rkF/gbSQ0BTF3AS?=
 =?us-ascii?Q?3lJ4CWJHHtVWYKUpgssTu/HGISAiVxy+x35cf6CJRhCXnazJ6edijACN/WDM?=
 =?us-ascii?Q?Iyd6kjQ0bBO8K2KsOy+FZ++F97R0totaXpNBAdyz9olPnPq5ZWlnzUHXWsGR?=
 =?us-ascii?Q?FvBOJoWkfODjYzxTZQobMO/DNu4jy//NmoH3V1cl9TvIHK5kvTnbpseEOMV+?=
 =?us-ascii?Q?tipSH7/2wD9Gc7I4ohITpGrYpCgzn1fiGxJjuOnOLIndq2yNMBo8cxYYbRJA?=
 =?us-ascii?Q?c7XEj140/MCQ5J3Qp6PUe+PXVRo5mWckBtSqR+Ve2Z7oJ4WP5ao54McO54NZ?=
 =?us-ascii?Q?FEbR+fu5DQEwDmLO7FD79WlYsBYZgLuWIhO5ebgtEFjXIR9LYDUlmMHoauxJ?=
 =?us-ascii?Q?s5gUs0OLWbMVRxFIcpEEWkRW5v13Xl7ieeMZD0Rvf8yIsonj8qMwA2jJn6zg?=
 =?us-ascii?Q?xf9gX05jJ4D6qtcS5biD11EtZLAn5LjQXG8xbIa2cc3NRwQAHrHlVNwIZnf1?=
 =?us-ascii?Q?d/Dz7p1yQD1VvSIZ2bZbtbP2qnocO3WRhu34kkyUEzVrjTNEbMGMOVKtrVoE?=
 =?us-ascii?Q?wqgzBeQJ5EgdUKx8wCzuwVqF4t0DnReQM9bqEu3kN0EPw4z9DFArDP8do4xr?=
 =?us-ascii?Q?r1FhnQ7tgeeeZCLZTo0Glps7E/LSBXvr2SrP6/lyrFRUsj0HfZb01XC9iRdc?=
 =?us-ascii?Q?++TuIDPBrwASFUk9dIFCbj9rxEp4CWR8hDJSodWiT76mqfu9B7vR3M/5P8EF?=
 =?us-ascii?Q?j9GRSwYH+SuYExvSjkCK1mUz7gWqISDK7veIED6L3O30eiPPtG9pDbpSL3nC?=
 =?us-ascii?Q?pBkMDmyI+2flX7GoiLOdHuxF1Wd7Mds+JBX0RsGKtxfM5+GJ+rPeE5i0wMOs?=
 =?us-ascii?Q?UZ4cJdSvBArA8BJvFNRu/0gUiM7ADVT8Il6DdpyF1TbsM+JW4YkHsz7oGxZH?=
 =?us-ascii?Q?gHpP3TwbmmVm3W3VUPKUplLuW0OBZCRQEktXX+Z20T7EnzrKPEcmBHuH3Ull?=
 =?us-ascii?Q?6ecpZ3VmdwQvuZ1czU7KchzTquzmgd9E03XvBZJtOzBG/CuQbd6VcATp+ORS?=
 =?us-ascii?Q?qstTlvVrAZ1Pm8PvwpiyQIh2/2gccHtLx+6OVK9b51Ny7Dug8NAxxzJlfExk?=
 =?us-ascii?Q?fQcxp9qHUiDcpQBG2yhk0AumV0EUTk5VZhs6R7rNIt5GbZoZgOoluqG7eZFD?=
 =?us-ascii?Q?n5ZlmzhqE54jPHadWX1USazZp4Elz0rdC2T434LhwL9OX3LMK8xNrjSJ0HUP?=
 =?us-ascii?Q?gpHAiuJ7zuRYZxsYl1yhbOA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3570e709-0199-4421-164b-08d9bea274cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:40.4906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpyX+SD7i420TKVVr8hyP/VoDNUbB/OwfAzgn/pmPWrN6ccALvxoE4+Z8ocsSG3n4HmQga9CT5Uv2gQ02+yj1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for the LS1046A to use a
driver-specific OF property for that purpose. The change is intended to
target stable kernels, to accelerate the conversion and ultimate removal
of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: 7968344126e5 ("arm64: dts: ls1046a: add DT node for external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 687fea6d8afa..c735469010b7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -328,7 +328,7 @@ extirq: interrupt-controller@1ac {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x1ac 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
@@ -341,7 +341,6 @@ extirq: interrupt-controller@1ac {
 					<9 0 &gic GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

