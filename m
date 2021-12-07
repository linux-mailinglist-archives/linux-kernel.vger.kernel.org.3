Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7160646C7F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbhLGXGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:06:15 -0500
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:56288
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234310AbhLGXGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:06:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyLXN+eyy1n7Nub+IKhhCjtIzxGgsoTWjQhjypDWO6+RsbYEDRS0EQ1/CbvF8pvNYiq9M9iaqNLoH4Q0MZA7EknC4FjmVYEsfmva8KS+t7BaNqbNO3YcrrbsQiQylmR6UgdswgCHjCK6SrA27mdJTVaDEX4mAyF7GPJ/WINs1AJx0yjG89pCE5lUaf8f+s52g3K7MHCuLkVbFxs+Xhw4iVSGFiAeJPbyRUB66VoVmu+CAQJZM+ptvUgi8vWYUycWlb5I/KqqrUrV8nvzclix6ANDqghiCYz9zbbSlVwcqAxHmGpgcYE4Tlp+iI6ecZjLYrfhAQ4gTlZwW09PexSZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDpH36F9nvIPoLFlkslZMVxBZ4XnFBTT8Rhe+rZNPAw=;
 b=K8FROsZcbIQnFkZ1lA/tANZDQXIlUDShIdA292sqkn7qiYygu9uElyzSfge//eforTZivggZU72DFezubNtjup7v0ymNvoVE14l7OJ01EZAyncRmMePyQuPh4zZDKrLbPPUuLqwz51GKVos1ajkJBaUCNJnPvR4ldNXVjSvomIdITdzGxGd/NaNSbeYoJYd5NJ1oXHQi8DWHROtPPlT+x1AEwTNKMRj2uttQRyyj7eRZfclUr+GxpaxaZMq8DiaAiT5ZxEEPvIAEfuOvWLDytqHLrPPK9ttkbbYcgr2SFgUQGAyYY3kn0VwwgPpjsY0U5C2/yT31nIUkVrEoY4qbhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDpH36F9nvIPoLFlkslZMVxBZ4XnFBTT8Rhe+rZNPAw=;
 b=T+z8dkWfuj2xcfIJ7oE7Iu8scsZWLdAH1NMYZfXiIHpBXptkoXpSL/y6rYuJnC1ItWUl/zqzBcO4O7xTdHm9EU0eJ0RH/IDCWFeJJXvbYgHUmnxT9IcX6Sb6JgtTQYCrQUCjdhC1txgxGf954ohQWJkqArN1y1UmABsAIPG7ikU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com (2603:10a6:802:c::17)
 by VI1PR0602MB2910.eurprd06.prod.outlook.com (2603:10a6:800:b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 23:02:39 +0000
Received: from VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf]) by VI1PR06MB3102.eurprd06.prod.outlook.com
 ([fe80::9c38:9d12:599a:a1cf%4]) with mapi id 15.20.4734.031; Tue, 7 Dec 2021
 23:02:38 +0000
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
Subject: [PATCH v3 0/2] CAAM Driver: re-factor and set proper JR status
Date:   Wed,  8 Dec 2021 00:02:04 +0100
Message-Id: <20211207230206.14637-1-andrey.zhizhikin@leica-geosystems.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
References: <20211111164601.13135-1-andrey.zhizhikin@leica-geosystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0069.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::46) To VI1PR06MB3102.eurprd06.prod.outlook.com
 (2603:10a6:802:c::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GEO-HfyyrYQLnZo.lgs-net.com (146.185.2.7) by AM6P192CA0069.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Tue, 7 Dec 2021 23:02:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7192a0f3-449a-4916-6fc8-08d9b9d5aa36
X-MS-TrafficTypeDiagnostic: VI1PR0602MB2910:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0602MB2910EFA4FBA6C8F482CBA5A3A66E9@VI1PR0602MB2910.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6rYZ7wQQiinyNjhMH5LQq7NfuL1ZKvYXohYdcHh08I/aoTW7gbL3ou0kCtskZP6+xvkexhnfQ5NjYssMwCBBPohUOr/GOF64isdYR5uRjEYYgDSZ0gCypA/49996+XIFsIHk7P/IrN4DidWGucPxpZieBs0PB3uXhik5zANDfhedOzc1oJr9quWRLwDblJGrXuuSYmkPKtwnbW+Rhdeba3bt9AVTtKGXbKd+fxt2FxEnjcrNh9zCk4sByHK7DSs41gqqvtQ8nD5oCuDm5CzXQFKlZ/ZYAqu9niACO10ZGTECoKzIns5o8zMBY4ZKWZqm75N6UFm260nLCtkPBkAipwfOOYIQ3K+e1s831DjVcQtsDcGcZC0xOimmKCn0ezXnDW9/fxqpR9CG7X0D1B4aJwBogKEq1fOCzQQg8aEAoVn4jVJRheplORA6i5P/YczESQsho8pjqRoOBtYbKCKwJotSAHywfsb4r8a43ZAiMdoyy6ISWk37vD699Ag7f+beb7Nseit4tZnw7WCXuJE9zWbzxyljhV3hHerX9nrdESsKxN1r675EUuewVyj51I2o1Cd68vI/p1tN0/HARsd2RTFidWSep9RQkst8L4jhCJlyniuxsCgwm6D/6CjQwb1J1V95C9qTPG/6x14AMAe8CgHjusoRsNK7StGoefkl+zlK+FDBKifNX4GADjko/6xeuj5mCUt8dlcEz9zoh6sYRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR06MB3102.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(316002)(86362001)(83380400001)(52116002)(38100700002)(6486002)(6512007)(66556008)(66946007)(38350700002)(6506007)(956004)(6916009)(2616005)(4326008)(6666004)(7416002)(2906002)(7406005)(26005)(186003)(107886003)(44832011)(8676002)(8936002)(1076003)(66476007)(5660300002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?20v7vVAjULvXNMIEjlA0LZH+Hxticse3ktwgsDR08UGU6rtpK5lv/GvDG1d7?=
 =?us-ascii?Q?mmgd32HmgOMrbj6bP5e8OLUlGQxjDUS+Cucw58U3p0k+peJLPIqb3JIWQi8t?=
 =?us-ascii?Q?TBkLh+lVAPajTWYqtMojqwAyadZmys3a+2CCw6KPxMBb9fciGptrxPUDSj4k?=
 =?us-ascii?Q?3Z0OW/SUMHAILUbY7H5agIy1CTeVlbgu1THOYffc10U0Seyvmwo9PXYUQWKs?=
 =?us-ascii?Q?XepgCKfDohxKy8dptxACMKjHg1ZYpNsUzir++NeJqKOKDOY/tBNp4DUaXPaL?=
 =?us-ascii?Q?RqX3qgcTRs9ZgDb/lUXcuylvT0ignwLT21QydAS5K53ju4piCEYxvGUYzTRF?=
 =?us-ascii?Q?dM+SMTej3yZVS8kD6Fec6FcVN435iXfWoWxqC1Vxud9QLDMM/j0+aYpm6yXj?=
 =?us-ascii?Q?EfvhPRB/ALmWa60F4xPtoMuGEr3TANruN1zkX0UHWF18niRpeMOXUdWCbhOB?=
 =?us-ascii?Q?9mWvMKChZwIfrX1Q1aZtLY0a9oD69UoJidn/tGWXryNTpVo7y+SumkGNiuuq?=
 =?us-ascii?Q?5kVYGy6Bpia0thuw8MPwSKrK7lF8X2VzCod77XhMpBhIDSstgzflmSYVjWYU?=
 =?us-ascii?Q?j8G6FmkesLr8U9FBLIB+luf2Gfml2MM7ebJU6jwUAzz0T1TCmddh2dcpP0AB?=
 =?us-ascii?Q?Ztk4tjHi6+No+5JFVB9MMw9nCLWsEDaii6g/PJIpRNodxr9yrAfonyNftklb?=
 =?us-ascii?Q?2dWOs2x93dMl6+MlBOLgAuAbt+NxHm8f3o9wOB1vAa4n40lOEJ7IkZuZEctP?=
 =?us-ascii?Q?XgJZMuW835aPjfuEVWiYpeiJT7ZqsAkuhxIQPNmn1zKouYTJiCG3Sl3iiB+Z?=
 =?us-ascii?Q?C0M2TrdwvDzavE9gd6kSnKYY2BwIJit5BkUJajmnD1iysL2fkI+7DNb8++9U?=
 =?us-ascii?Q?FJuhUaslb/fQ5ZciTJSMbQ+ATR4IKpskYpGOKiL3PFK1zBHOeKOzVuRX/KyZ?=
 =?us-ascii?Q?vhLk2SUaS2bKUtiCeo3c4aEYJshVtUzeNX9BCCrk9tw7N0mn+7YgUqzL12p/?=
 =?us-ascii?Q?raZAsO+TdqDCAWXyruFZMw1feXJMpMNnQMPxRZwHnH9pCr1AWxUBBvCXr1tv?=
 =?us-ascii?Q?XaN4/JpIs1oqlNOxn/aUXh8jnEK0csYvtJFPVpcM3STzHxRfjfwROSKwNms8?=
 =?us-ascii?Q?i1f9ZbdonaMjdV3AV/eAkFkfwnGA8AjW64/dyXOLtkOWE/k7dwnBEJLemDk4?=
 =?us-ascii?Q?CDbQZuzgWAVvyDR0bokr+8LzHwkk+jce4YlLVLGtE8yIWdOs83YlSNyIMNuh?=
 =?us-ascii?Q?Qus0Z4Wy0xpN6qpy+XpYHI+PFUlff4DA88HYzUxepI0nyQcsvTcABNhLk4uv?=
 =?us-ascii?Q?9Id8ujfAJhoajwdIa62wwFhOuLmTDdrt/Z0r8hYdS7Mx0zncrpivJSas4RXm?=
 =?us-ascii?Q?LZQFJElzsKW/S2yE3p1RuJsH2DXyN5em7EvAxGiXfu8wuunPDG7fYywtAyWM?=
 =?us-ascii?Q?5lTzWtmNcSWhiKMUQPyLuX6sdl28c+YAYs5svRGpdzT35U57ZFMCKdFf1twZ?=
 =?us-ascii?Q?jKMsSvs+cYl2vuIiRx4EyU/r/UB/4o8u0cx8lzyK2Y2xyBVgoXsOYgaHsB4c?=
 =?us-ascii?Q?UOHGSpzbGRztY5+mgME1kYI1D0MiLkzRqmgY/IbRCNyg3bwZzq5aT7Rvh67a?=
 =?us-ascii?Q?yNq5kFi3KPLLWktODauBlSZlw1hab1u8/IEZbn7I0ZlZviY/bPH8O2sQLdww?=
 =?us-ascii?Q?iQxk0v+jNeJC7B9vuFuhDIdgmvc=3D?=
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192a0f3-449a-4916-6fc8-08d9b9d5aa36
X-MS-Exchange-CrossTenant-AuthSource: VI1PR06MB3102.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 23:02:38.7231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph7tZnwliYFsXoHH9fSHTt9wLEyACvHtKT14PQG/Zel3N2nENxJfzrSD/65IutyrfBID1Me5Yh4OooPeiMX22g+NX2HCXDygHgp2QRdsQXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0602MB2910
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This V3 series covers points uncovered during the review of the previous
series, one major point being that register readout should not be used
for dynamic JR availability check due to its unreliability.

Instead, JR should have a proper status set in FDT which indicates the
availability of the ring in NS-World. This status is aligned with what
BootROM code configures, and can be modified by all actors in the boot
chain.

Therefore, patch in V2 series that was handling the dynamic JR
availability check is dropped in this series and replaced by the patch
which sets proper DT status for JR nodes.

Andrey Zhizhikin (2):
  crypto: caam - convert to use capabilities
  arm64: dts: imx8m: define proper status for caam jr

 arch/arm64/boot/dts/freescale/imx8mm.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mn.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mp.dtsi |   4 +
 arch/arm64/boot/dts/freescale/imx8mq.dtsi |   4 +
 drivers/crypto/caam/caamalg_qi.c          |   2 +-
 drivers/crypto/caam/ctrl.c                | 115 ++++++++++++++--------
 drivers/crypto/caam/intern.h              |  20 ++--
 drivers/crypto/caam/jr.c                  |  19 +++-
 drivers/crypto/caam/regs.h                |   2 -
 9 files changed, 122 insertions(+), 52 deletions(-)


base-commit: 04fe99a8d936d46a310ca61b8b63dc270962bf01
-- 
2.25.1

