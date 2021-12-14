Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A728473A4F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbhLNBi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:38:56 -0500
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:44962
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244725AbhLNBiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:38:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EULEI7j6rerNqaj3lwGjsKv/J+nmJD0CvbOHHtE4eJtX1uMB2AB8JfA1WTdw0fbAOojDuMA1NtBixW2v43eGrB4eKxUk39MRH8dH/HxzeJfLlCA6m2Zc5W3QmLrUH/0/lCP2mPnwJFkgv033UCloYXzHD8v8XPM/DemDcHwJyxmLJkoVq2/wN4veazKYneBsukKTv1fOI+yQhLPBDPquwxYEQ5liakxFJrz7ve5UFGtTJSBQychm/Ev8KYYeXJ1ssXWHax6ODa+wSWU4ZDwBvL/ykJfZEw6lwqbOaJwPyK/9IYuaL6aM82sw0+iKrOxTDTASzh95k4NK+Zuyh84k+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFf6DuKWjoK+JuDZB0rYr7d1/AbdLUpoDSJ+yVrAjYI=;
 b=StEuHUeTCB1p6Si90Bx3qB4BLNZZKrZ2OQbH65L+jDcwxYCyD8r7GmCPSpBwN7V0iwEQZZNBZtrz0pbiplMBRC6Mc6uaAMvOgyqcYZFfg46FURMON0zHdHExlBFYX+3IWyUM3zM3Xv5h+8xAbiQVKo4Uw1TKp45fEaPQIKmUWOK0YoP4+kIZj/Bzv6SJuSWenEF805xKIgsrHnuNEv3qyb0/TLcFNBbtJKhaag/2lwAMT30r8BaK//KtgpXQ3wTtgOjK7+ICcAD/mHo6wRbR1Iu7SdZPsUuhr8yqLmpN76FSN9NOrVkbUlp4aUV5CwpvX0WxXwQw2cgmiNCZEObUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFf6DuKWjoK+JuDZB0rYr7d1/AbdLUpoDSJ+yVrAjYI=;
 b=nLt2Ya0V/FPtzX0t7xqLWFPuv+9s9L++HItTSZz2EnqwMkXeyQsWCUJdJXKoZpLp/J+TwyqI2jEjcDEdiDjHxUjERVEAy0CFjIwWO+llRa/wN4VzX6v60EpNsNFafa4m80F639H54ue5Q0il/UU8ZRbl5DUK2S8ASKxHAtbxue0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6944.eurprd04.prod.outlook.com (2603:10a6:803:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Tue, 14 Dec
 2021 01:38:41 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 01:38:41 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [RFC PATCH devicetree 06/10] arm64: dts: ls1088a: rename the "interrupt-map" of the extirq node to "fsl,extirq-map"
Date:   Tue, 14 Dec 2021 03:37:56 +0200
Message-Id: <20211214013800.2703568-7-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
References: <20211214013800.2703568-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS8PR04CA0168.eurprd04.prod.outlook.com
 (2603:10a6:20b:331::23) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by AS8PR04CA0168.eurprd04.prod.outlook.com (2603:10a6:20b:331::23) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 01:38:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 688a9374-8f4f-4c78-a80f-08d9bea27586
X-MS-TrafficTypeDiagnostic: VI1PR04MB6944:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB69448F8B138DDD9AB4DC74BDE0759@VI1PR04MB6944.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tqeFyUDvqbvvxCA5FiRJksNfJG6z+mZZdv6g0hdKc2SbmaGS4CT3aUi6ulzQvXdKFUrsv6lUIpO9bI2znNoUE2bqoSWoH6E2JGh4F6/YXYY9ukbOv3jj2qh6AAZqaTAYD2fL+NBEK75FvaAYrraIegGe0+UF3H3HcZ3uSiVr7uCK2o1ZAmUKp83Yv11w27uJe7npgVCbdEstxg2rn/asUYJIGiFJYK6vjjbel0QmxCLHLGtv7Bc3DPEoJ3n0bzEhpRpksGkSw+nXi7yzcwK7TKHXv9bg6XEB9IFvAhSQq/fALmv32v7U18y1hCMxLnU7afZb3hljyrN85a3oL5Lv6+Qg6YnClSnernWV3twP2EM8eIW5A7DVUgZF6Lci/CRngZ7I6Sxtk6MN3mQ5uIJ4J+julo6zBBHcUGzihPhaNo/ybVgS5IPvmQpBkfB28eKJsTSh5MdrgEAsi2WbL5LyQc60KN+ZHR6XWnZkxr0Ie6Yuw7SxZALyg0c2M+E9CJZ10QdXAgCDOem881/Njt55Bec/ncDI+4reAsSowVTeH6BMLI/goJByKxiA9cIXjSdDhooia4jnRahOilrPaF/Px8LVcKgBhse6QW6qemKmKmzm3JgSgRlKBHlbVcpHHX3RVOMt1o5I32h6f8jBKfJ3gu1x0cGmEMVyubR+hz4fCDtdEw6GpDKA7j8GslB7+Ws6ms9rPYm2tgKLlwPU6DcuvYKCJbG/gPW9hpVaZFbyrFytZxv84vtbC/QPyPw03Hnv2ky0M8WOEWiO0zMhuyHaiLy9MjPpaml2ohsCx7KXwIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(1076003)(66556008)(956004)(54906003)(36756003)(8936002)(6506007)(2616005)(86362001)(508600001)(83380400001)(66476007)(66946007)(52116002)(316002)(6486002)(186003)(2906002)(4326008)(44832011)(38350700002)(6512007)(6666004)(38100700002)(26005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6P9PrIC4Z+jqHsT1Xji9FTS9V6Hr4AfMZJRwBorMU6Qq52iodeFnZfU/b2f7?=
 =?us-ascii?Q?rMJb4U0uIBN18AtHbfrKqKMdaEHhaYRvNuxkVrGN/rd9edmfGn2nOHaSOpx6?=
 =?us-ascii?Q?UxXZ6ieARVPqyyUdq02O8sR2EXDDIuwW/fi00SU41Ew61TTf0D+2Iqxs82J5?=
 =?us-ascii?Q?jGqjrazPwu5IAb6csn2ydmCLPz2kPZvhx/J3EuTghlBhxixAnWQT20LEKhGu?=
 =?us-ascii?Q?K08bvfJtU5m/FD5WquIJbrcFcrAnpIGm7D3LZlmszTdd4LvIwDQ2+kuB7dhc?=
 =?us-ascii?Q?KaV4RItq1DkSFnM60aC4yFUa+UeC3kZ4+vv/6mxCcAvB7gjMH2dNP4zTPKeK?=
 =?us-ascii?Q?hVmPcD/Q4LeP3WnszY45CP6Em94I1dFXyt5Je/wvzFTnOqEHxLoJxB7lDlwk?=
 =?us-ascii?Q?q55TTW9A9iEF8dnjf3eucZVjN2Z6+kyGSD4WNj2I6aN4mdnNLhN86kFLMyot?=
 =?us-ascii?Q?ph8LKGD8BOT5L5CGo/lcDWae+Dbx7By3unSBSpx9Z5zdrgv4EjvdsJbycJDF?=
 =?us-ascii?Q?Hc7h1+B2SOlMDmvxU2BJy+cTHNMBCISntRzMm0Mt+Z8ZsYfyTR0zFrGgb+3E?=
 =?us-ascii?Q?LnydExfCWZ+bYBl2+/c9e0VrJzVptmIcO6BDcIIdJzASibmwdOSohJFQjvNv?=
 =?us-ascii?Q?pV8CAdw8mzIOTvF5Ym2b/rUxu82id4sYi/kAqrJIfIqrGr8lcB9mHE1jXCL/?=
 =?us-ascii?Q?nVXQiMw3/+SwroxdYwPQ+Yj5cUmGD5BSK3/b89TJ3tb3GvxnOf2EczUGsCXV?=
 =?us-ascii?Q?63PGrp4lvZlqhJ708HZe5vfEe2aEw6LL7rT3P912E8Ciy0pfLuNPo4Hs1jY7?=
 =?us-ascii?Q?dSywiNSZP6HSb4IiBDI1uXTQpR7xsKsm7ikq+5T2UWGz/Laj6Hf1F0B/twBF?=
 =?us-ascii?Q?hdMih/uLkgMlHexFmCCSIHucGVsrnpdCtV/HsGehDN5tfU3hWOA63I845S7M?=
 =?us-ascii?Q?dJtVyMMsZDDCtEbJ1I5BZvgDEJDiadQQ/DBtYkevVRPpUM/02SlPmiaZFYbW?=
 =?us-ascii?Q?SJ8zbtEvur/EU6OXcrlrMQIppx28JJjqLSdiV5NBFQEZ5avVMCP49t9gycUN?=
 =?us-ascii?Q?qcACZegw6nuEd5++jaaHZ0NOnAu8bqyf8Vj2JB/4Y9ijfc9OmP2wZ1o8tqf9?=
 =?us-ascii?Q?myUZYzzh+cdFCUJVLcIzpwb+uJbezg0uRbROPw1rN0ih+AqjMJtUzqIna44d?=
 =?us-ascii?Q?RB97Rr8eN3/YI5sOm/BbTYhbkljRWjjR00x6phVQ6PPikZMwhdFG9HHsYrlg?=
 =?us-ascii?Q?rULQeYpeU8YGmg21+HidoFF14istznDGDrh+fByq4AgnIthUQD5N6LMKECVZ?=
 =?us-ascii?Q?JQ7+njIKv3tE53reLWu3kyn56rhTH624qE2ZTg3Xv/VBXBze/F9lCNZd1apQ?=
 =?us-ascii?Q?DbYmFW6DozJpsmViOogWIpJBU0CDrFmP+JwX86NOuOnQT2QTwJPD/tm7ZNY6?=
 =?us-ascii?Q?IftnZsJ3pKADLJRpW9F1GLWGWFXb8qc1UoQZLSwIoAcYBOiKTfIBfHGnQIO0?=
 =?us-ascii?Q?cwD+MFqDfxCOdo2nngdsMxb1OTe51j8MqxiQTtiouOh11byeJqyQkI9kPVJr?=
 =?us-ascii?Q?JQ6ffw8b9bJJwDmQJ6l8vmzI9uKKXPNKq0TyLO+snBx+HvJTjRi8fsrTJNkX?=
 =?us-ascii?Q?qH8fnopzBg84sMU444si5o8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688a9374-8f4f-4c78-a80f-08d9bea27586
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 01:38:41.6624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /TygdA+J5O44eNm341CKc3Wgq2eLDCB2rvUM1EOYAGHLbiEu8UcqipGDaSwTQ267VmT4fb5VnoMn1DD3bsm7Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the discussions here:
https://lore.kernel.org/all/CAMuHMdXM34nNz1nfowNqDvdsdg+d69Bo3_ufs6fbcq65iYd5-A@mail.gmail.com/T/#m3449390080c5a0c8f59b8f8286a87e31e093b98b
Marc Zyngier points out that the ls-extirq driver should have never used
the "interrupt-map" keyword for mapping its channels to GIC interrupts.

This change modifies the device trees for the LS1088A to use a
driver-specific OF property for that purpose. The change is intended to
target stable kernels, to accelerate the conversion and ultimate removal
of the improperly used "interrupt-map" property.

Note that "interrupt-map-mask" isn't needed now (nor was it needed
before, it was just there to keep an apparent compatibility in form with
the reserved "interrupt-map" property). So delete it.

Fixes: 0e88b5fd565d ("arm64: dts: ls1088a: add DT node for external interrupt lines")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 605072317243..53ecc25a24a2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -240,7 +240,7 @@ extirq: interrupt-controller@14 {
 				#address-cells = <0>;
 				interrupt-controller;
 				reg = <0x14 4>;
-				interrupt-map =
+				fsl,extirq-map =
 					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
 					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
 					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
@@ -253,7 +253,6 @@ extirq: interrupt-controller@14 {
 					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
 					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
 					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
 
-- 
2.25.1

