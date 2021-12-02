Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668444664FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358496AbhLBOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:19:26 -0500
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:13287
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358445AbhLBOTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:19:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+yO6ejc9WJ2fydpGjTfT0lQXfOxM98FliInVqb4Bnm3giqovTWeJbeYo9mkmSxmHjMyHQBeoHKd6kQURJi1w1IakiL9uFGsGgH1B6+bmBoQTPeiocumRsPxRGpgh/H7c5qevcAGVPq6nXJMlctsid956IE+wyjcRGoxchCAVkpdebnadjM9ek76o6rhLQMgCb0lJYNyhTcCVPmLurjO8qYXwaKbBmm50NUn6wFAgbuT7Jilse2bJrOj+pjIQH2uGUX7yWVEsJkGtVRqUisttYNJUdiBwyBdx/ah+RL/rzEwHFw84pogxeLxXiOHO87Z55dzfpt5ghSdtb2WJoNmAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo5tma/RXJVaHXgx7q10Ei4oKMtUG/3V16btpES2lYU=;
 b=lVZ7ePtlmB/HQGhEYo8jrSCmz29zg0Cpb28nGVFw8KI6EzTySjqJJVvzcIZ0igRLxjCn4vvxien36z+hC5ac95uveku+W0yKuRlx/vP8g1sSwCEsw8LEyVxe1oMFM1/PpC8GRCkpWuEITO/C4eEcw0G2YGph+qv/V7gfXQDpryiOzLSXwclpONWkLKQGRTqPO7Ujh0k2m/mQ9sodiDMj5iI6Vik/Ji5rPcS8Q8WcbenHNgIxt31e2j+f/fPQ6b97yX/UufRbLLKg7bZ8UKJCnWf2WZqbKXc0R2SZbdv3JO+fesMP80+i/O2Fy4nhFoa5gDa63WK2rii3VFwZfFVIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo5tma/RXJVaHXgx7q10Ei4oKMtUG/3V16btpES2lYU=;
 b=UtOi/a1Hmm9NL8K3LSEjS1Njg2mWTuyF7wCW7D1WgVFmypgwZwg43F2flWJpBXYtrcXczMVfr6vwbP9VeM2Ttkmwz8vtbHfiCiGSb/k54RHG4kWLNNPGLVV4vekb6Aha48aZUYXnDwxC96pw82RZZ7Hf2U99S73zoxOMoxPVEkc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 2 Dec
 2021 14:15:51 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::796e:38c:5706:b802%3]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 14:15:51 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: [PATCH 2/4] arm64: dts: ls1028a-rdb: add an alias for the FlexSPI controller
Date:   Thu,  2 Dec 2021 16:15:26 +0200
Message-Id: <20211202141528.2450169-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
References: <20211202141528.2450169-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0110.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::15) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AM0PR01CA0110.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend Transport; Thu, 2 Dec 2021 14:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 083ec9a3-b2d7-4e85-3502-08d9b59e3ea7
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3838:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB383857FF6B329DE2B6B4718BE0699@VI1PR0402MB3838.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:241;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZO7zmeOtd2//pDzJvN3kzrr6tT/mtktrkcC5lAguso0xGVdN9QLXeSHLGYdTmfXxt3liRbQAujVVNVNzS7g8wV0nd++hUtEVl1EdkLo7cyZBEPibxINyolAsI3lN0uzsu2I3RplSni5vQxv7oQTMNUwl05Xle+N7ztv8u/AcnD+vFCDCqrdI34sFki+/TDwG+GC1Me3qRlT23waf/DH5+XLsldtCTKifngxzBQ/CFCJevK5p1jiJw1/ccj+ZGlFKYwwoAh+NOr+P9hd+kqCN2m2bSUs7P+ovyxEBni3v7Y9Y64xJn9eP8GwRFRmMQb+CouXz1uLCU9N5ReHAOOu6NEQKf0wtJAlcp+G3c2nfdMoATefcrT6tcwk6uM3jzwLsoqRM0+3UD1IddEKX0Xo1KagmbizFqlGEhf0e561uxHStWOX2+oHjRDHCQXbH7V83ZDPfyH54Q2hDa73XrvNqQCi/7yUNLmvv8FzzCoUJimpxk3qxWXbQvDFZQmlNzOHGBBdVUTaAGXXqJ//n4T2F/IdxKP+GZrL8Nb/akU7gW/AC/LCkOOPbXLANc7qcIhFDOIg1GWJUlNm8isf67tzMQCKaqj3IQ4t6SHRQkrGOrgGyQpEA7RW00Zqg/NlTbPGabzyZmHCXfL7OhzpN8SK1zVm24PAblIjxPHqlhCYJYhsW7+1PeJ6taBVSYto69FtonTAN23BVJ5LpvNfHQnXhIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(1076003)(6506007)(4744005)(38350700002)(6486002)(44832011)(6666004)(186003)(66946007)(52116002)(956004)(316002)(26005)(508600001)(8676002)(36756003)(6512007)(5660300002)(54906003)(38100700002)(2906002)(66476007)(2616005)(8936002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOwlrdU59VO969LQ+4hHn6u21rphjhCnAMyyopKIzn7Pt1QorX9BKGUJX+rn?=
 =?us-ascii?Q?Kqc3j66fJ1Xc/TSrUgPhk/+n0wH+aBXwOY9/I873RFo3hxjRRh7te6JHMbFN?=
 =?us-ascii?Q?zSopzRvorKhr7vqMWnu2KNTvdhzLx+CK6DIHimojOh4cYhPATF73jXdfRG06?=
 =?us-ascii?Q?DuHXOT0eKErFK21RVDFG6urB1kVpceTYA+h67+t3zyefbRHIvCsKDpqcJLit?=
 =?us-ascii?Q?9goRJWC5T7b0Fvl4+eIgob0K1U5PlY+TIgd2jOINyAyWRK0xgw6jxda2T164?=
 =?us-ascii?Q?j6fc6+Jc/vPjB5QKKKe2n2CKkFXVyaSctfdMHubNZn3FflIOrlPOK7ZmSsXr?=
 =?us-ascii?Q?W2eg4bXRKiLsigFISyhGRuPjnDwT/y/lekNkeP7VWirJ/U/yjkC9SenokjFc?=
 =?us-ascii?Q?+HEP1nKW7MHSdXIdU83cWwIh/fbbDATH+LoEuoekVq6ArKPQSqigs73E5pQM?=
 =?us-ascii?Q?6x3otJZtgyLkkNmfMkBNHg4XomN4EkSavdWP2vsWlqOqkoooHCTyGUD716bB?=
 =?us-ascii?Q?3inTcJ6qgVzhYcXHUDYIsB07/jMH+zXKGS3i2dqgAHOxK9tlflYOuaTstXWj?=
 =?us-ascii?Q?mHiG94pPaUjL64rUaoB8tQapMyp+a9lOyhMY0/CjyCv2FG61kldXN6dLkEl9?=
 =?us-ascii?Q?a44TzgEycr5icW4LQg7lqwZnLCri+aGAGgh+HBuwhBtXd85+NEpd21gs5KfE?=
 =?us-ascii?Q?v475A4RQZABWNOdZNqsOFT+0LfTsBofR0CuT1APw6Lm0BbqxgL9UcfxSvNvX?=
 =?us-ascii?Q?0bWcTom2xOmqkhxobHGR/P9IFVbctxriw08S48P9oxwHI+nrfXKvmVBC7A/1?=
 =?us-ascii?Q?ihOp13ENTJG9FhyB/NVrZbUZRub9PHBom7U936yhERp4o611kW9AxeCUU+MG?=
 =?us-ascii?Q?OlpQKaOsXCZn17pZJolBkcBuZo0Zxpl4MrDFw4VBLw+tuifIcnFU3QR8OQSB?=
 =?us-ascii?Q?oPuzAgcubhWPvEj5M0YGeeDktNEAbcUz9mMC0JqaF5ZL2Tihp6UpHydr0Mp7?=
 =?us-ascii?Q?QtbCGHQ1D9NSawkfjN/oSurQvALY1oTHIiij282+nUT6PrOvPtSQ3ZgqTvGp?=
 =?us-ascii?Q?3+MAMT/YJwFUkKUfJoLyfYZ5d5gA69CSxwVxPhhGIfo+ip2qJWt4m8o4IsQl?=
 =?us-ascii?Q?Q4RRNMJbZHpPfJvKGFMEmNyPJFSzUeaXgnI2lL4tqBUXwoEHdCB4cPadGTK0?=
 =?us-ascii?Q?0dYOHhsgfnPtHQ4BzQMxNlCxZ4zDRNVNnxITym2gEMfOQa3tuWPLOoquA7B/?=
 =?us-ascii?Q?Dm0jO4HwZLOFTcO8jjgGQSLbbcKzJ7eb4Urw6jNJEE+32wlOtaaGhyidinff?=
 =?us-ascii?Q?teveyugo2HanDMBOhhE8XtrtKBjerSoYdKk4nqsS8DI+G5MctM6+3qQMRJvD?=
 =?us-ascii?Q?9NxZupgDdtMdUmgVj114PGwVnefBTuiUcIXlckfGclKRRvvdIYMhbzB8BKJo?=
 =?us-ascii?Q?yR3GRpg65dnl2vNcEzWDMo8sHsxcYMjkVAWPLsdpINEACFLBfLQvPDLo6pmS?=
 =?us-ascii?Q?7UM+ldowrhjdpQrF/Hp+J3ToYMKBbRFqJlperxa26fEiqvrJYnCXdcYVvDGf?=
 =?us-ascii?Q?cBKh4PLuXdklwUlwSMCK7U1TYLX8Fi1YRRzWq/reGXjzC4vgnNDp6Fdldnad?=
 =?us-ascii?Q?W4BvgJGSw4nckMYClNOfnJU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083ec9a3-b2d7-4e85-3502-08d9b59e3ea7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 14:15:51.1960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sUhUZnazIKCt+YJUDeSdzXwQVQrSS0hwoxhwvOvzOYCf5vZLRJhGQDVftnZcKvKNgkkYRtefztYaEc40BJUJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is used by U-Boot and is required for keeping the device trees in
sync.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
index a6f41aa9004a..7e3faa78c706 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
@@ -22,6 +22,7 @@ aliases {
 		mmc0 = &esdhc;
 		mmc1 = &esdhc1;
 		rtc1 = &ftm_alarm0;
+		spi0 = &fspi;
 	};
 
 	chosen {
-- 
2.25.1

