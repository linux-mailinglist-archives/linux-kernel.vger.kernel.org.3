Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68EFB4867CE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241369AbiAFQmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:42:05 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:18017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241300AbiAFQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:42:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5bl5FevYy/vKTnPQ661LzLD9KkcbusWIAL1r74TKY7DwGNTFOpj7gHgpqI8V2YGftvuYx32s2YT03ZmThpVNZ72GXIVXnI9yyrBWp9DH9Hb5238asZFLfBULILRgd5ochvbF+Inzb1giCzwfgOyfDoSCrxb4rp7c+gMkLzX11D7cCE839QPl2WGziSRhclGT/4ux3dCe2iUhGt8NP4yNVgmtxfjRP0LcuUd5dHYKExInoiEaEZShFcUiI3qkuMf5yMW9Z6a91h5OFtHSlnOGqXTzxKw1/qvDG/bObQrKkzBPr4tECGvFjBz7HGL6OFwpRsfsm7mgrvazvkAigmhMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vz3co8YVP1JpiPU2N+9NzojUDhvP35L65QFVm0uRmuk=;
 b=HK5RskwW622lddJx8YoNzfIG4PRjff8IM0ekJseejHv6UWGk/pKdLEXEfL6tdPVV1on6vfgDto6si6gEqS1fEVAf5qAxiPv8gG+ONWe1D3PTBdVWQDIqy0xEPlEUcw3bxvSJu8kh3+Gc1bhB7dt0lE8MQU3xuUBxO0QSybolfX4w7W1JLqN+94OMiZhxi2N2MCCTpK9+5u5AHKxXqkK9Ms/8YYvy3HH6o8iccM4TYL6G8MxCom4aYHNJIP1rFh49MW7h89niuODz47CuLknkMo4dZqyiCkpK1EGkWxJypuA7PyCoQnPv0cdmW/hN6rmIs2ixNkEBAM8q7la61tWiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vz3co8YVP1JpiPU2N+9NzojUDhvP35L65QFVm0uRmuk=;
 b=BWYOen5UK1WS/6RNnvxtPa9MbhPcsIwMUVnRCbk8M0cuATHoGyhnwRY1LoqZjrCjstsfdGeI3UUdhJOHJsG7pkPMmbD56XJfKmHzGDJYYZ98jM6vDAxLmq8VANkKMrIUiaw3i9B/JqEurj7OeCMqr0NUodudmdJ80RWGUTuoZYs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3837.eurprd04.prod.outlook.com (2603:10a6:803:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 16:42:00 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 16:42:00 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: interconnect: imx8m-noc: Add fsl,icc-id property
Date:   Thu,  6 Jan 2022 18:41:48 +0200
Message-Id: <20220106164150.3474048-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:802:2::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc3ff8c1-2f0c-4d3e-2051-08d9d1337600
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3837:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB38372C777AE9C4333FD4AC24F64C9@VI1PR0402MB3837.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n98QhfGwUH3bKpXYoRrTvr28+v47qx/sGDHO7llGTvQiEyHbuJk0lDrPGkxjoqFSne+mid3YUBgFWUDDAWTzJOAY60w4emOZYNlZbWqNSChIY85CrmcTpl3ybPdM2tDv4T+c2ToxT4qwJUh3ThBazw0gl4pBRVLEp2g0mY0gHfp0ZZE4VrRXmWCrbb/IR5QXlKYUNNzeTfNQGPBe/8Fb7pnZPDMDpyzh5rptGk0uRqTfraaH/zqnzyYe+Bzxfxq7TwqZ6YqIq4U6hYfiU6+rH7cb7uLa4NKluJChB+s2LcFuIgxejy1/N8CzxD+YBZuFHuFiXfXGsseoTePZ1fRJ1Ez1cQWNhebINPbRmGQ4ssRNmembaTHypGD5dD/vWvSNNMN5AAeXVqiUzvq4dTwoQ7tPHTSZoEDx3E3qFrBxEOiLBmwb1QJ6ZDbgb+iIidMwqBG4RB/ZIc7X0b3EYjBye5FV8e6ya+1gbLBfB/2ZwY7qPDLo0pRrhk9q4ElVE/qNALV3FY1NTZQ1++uWAHhrU4ZsPlcjAAUAoRuyv8XIpi1NdSAwbAs0IuBuKQajLmhSrS3GbUpgWOIlhP2GZvlmQA2PSbS3rpwXeu+NOsvBAtwW3+UR4WsgKjJYsrDQQBbW+xJtaw7k/isogcHGm0z5kJ4zLULRUPvPHyFkpCqhzRwSrnvO7oEXFet02daxvoBaNlptz9W8UHJJzwa+V3au+m+hp/aDpZrrTaSAZXfoJvw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(8936002)(52116002)(110136005)(54906003)(26005)(6512007)(508600001)(2906002)(2616005)(6486002)(4326008)(6666004)(1076003)(186003)(66946007)(86362001)(66556008)(4744005)(44832011)(66476007)(5660300002)(316002)(36756003)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ieqcXdXEF8iFI+pU/W0jRM41ab9INE82VVIbEnQaPVh3ZqRSj81XmGusMXn7?=
 =?us-ascii?Q?IqFOF2cw/HRXrYGSlPrtr9xjKrmSrGalYoRvisrVrPpbjXdEWLt6DZ82yRHp?=
 =?us-ascii?Q?O+7kX8zgxw26+74ByrPz1MYsEl/Vz2zv98NPtBm1QGLkA0f5SM3adkizHBS1?=
 =?us-ascii?Q?fOV2Ogvu0JFO3fhn+NYJtwnc+AIh/yWStibV/evlJM0vOIvrpoNHDkUo8JgK?=
 =?us-ascii?Q?KJbY4NzeMFcV+lRGDTE9125iGvZXY0xXat/BWxo6odUkBJH3MBWMqxZ62h2z?=
 =?us-ascii?Q?mLtMUImqtaCfsO89xmuj3+hDfpU65iKtR8dQ4r9aqxNoull7ZPkQ2YEKFiqn?=
 =?us-ascii?Q?VGxCpYgU21n3licEu7X9wmhsComnK0DQ2S3O0NgoOnQoPtaa1WhaHbnKUoCP?=
 =?us-ascii?Q?z8fsOuw0DlT/Aecm4VQYe9jQHRGD5ReZWFne2ytv7g054BldJwh3VxKdANVt?=
 =?us-ascii?Q?B4QyRiYGYVAyOp5oxtS9CQu1FsTXGrgIvmF3qx10ohnqUYDzdEj3rGNv10fy?=
 =?us-ascii?Q?Dkf0bKCBgdcEjgRpuZhMT8SakhkSw/qjOCHjulK2Lq0+K7dUgbfKD0I9ppkn?=
 =?us-ascii?Q?5sInk7nJwsggxaVkyH967wYfWHVHmXx3gP7WBnkHlpOfj7DKQGwJyG98i7hK?=
 =?us-ascii?Q?9mY+oCvn09HmSfTcpnKOc+JqITxq1NAjodyM09UZrVFgRhJe+BwkBf5J/Lw4?=
 =?us-ascii?Q?g4FqIIh8EsnJ7/SHwPyfJSuZwKJCM0i1AjuqutlBQ1JWtBU2NRWUovVByAjV?=
 =?us-ascii?Q?ITnjimoi5erism+5ACtXUdvSHqF2KZGOWcDu0kNKG0UpOZB6qhXr9jf99z4y?=
 =?us-ascii?Q?63d8YTPytdydobLKRANItfiJj0MnIRKIAg36Szve50dqnBsVRQJAlNTJB1XM?=
 =?us-ascii?Q?eg4Tx1MaEZRPNkE3sErIUz7D86z4x2v9d8JaPWpXNPjo9hVa6xkl1b2m4Tj8?=
 =?us-ascii?Q?caEA3tT39eCqH/S421B+TO1mTDG0xg1406moYamebykrOotL1fe8O1wV+fVF?=
 =?us-ascii?Q?NSqXlJsLc/50fwMPhSsJEPIlD9V2BNrjMs7IY9eoPsOGg04T6FzCCvNBd9cD?=
 =?us-ascii?Q?CAAvP6uQEXZfIpbMdFKPJEKBa45VY+QiDm9vBfFiUkye9ue5XxKFyP/e2Ofa?=
 =?us-ascii?Q?N53Is9bbmNruDZiUY4V28P3FRHOCjEIQ5CGaXo2tifJdbY5L5Spxq1sB4yCi?=
 =?us-ascii?Q?JfrfJftk+FOha8en61GkgVgNJFDAHWEQVAKEjGUlVyUGAGO3KSoyXjv1wfl5?=
 =?us-ascii?Q?PmJnyCZ6EKZsl9F54LCpuNmHBdEY4mpSvFwAeOfW0UtWxxVLJfvThBR8zLHm?=
 =?us-ascii?Q?LGihCdE8hVWAatlhC5xdOYg2kHXGfWVFcp6rxi9JunZsKcWSzsehkTfJXS1b?=
 =?us-ascii?Q?Es++GqdHZSyjDTrcRB7tYi1LGHrVIuXb9nHZpkM9qQGo/qz3t4LpvfIRkQgp?=
 =?us-ascii?Q?ecC2RHLcsQTgk2sB2NHJ6rzs7XUBRPMuPzj5zvHTSwNtQVRrrvY/2RlEFyZ7?=
 =?us-ascii?Q?lcRQaysCzmsu3vLkknraPd572Kma6BgIT8l4m8E+iY1Pe7M95NfA/W1pcIyE?=
 =?us-ascii?Q?l28j0P8OTY5JxzwbAU6cf627zpsMO6s2FsSsIfxZYZwQOufWgjUsgL85zrPG?=
 =?us-ascii?Q?i+WeaTIWPcygo64kHvP9SwM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc3ff8c1-2f0c-4d3e-2051-08d9d1337600
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:42:00.5261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3f1SWR7w33ypRCGNQU4l9X5lvVqLIHyMq8Q2Qzwt5vnxOgnecv+AYlVyech/GxZQyWWhAkgKNDqnlvJsDVkn8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for fsl,icc-id property.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v3:
 * fixed typo in property description

 .../devicetree/bindings/interconnect/fsl,imx8m-noc.yaml      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
index b8204ed22dd5..dc7f6b6f508a 100644
--- a/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
+++ b/Documentation/devicetree/bindings/interconnect/fsl,imx8m-noc.yaml
@@ -47,6 +47,11 @@ properties:
   operating-points-v2: true
   opp-table: true
 
+  fsl,icc-id:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      unique ID used for linking i.MX bus or ddrc node to interconnect
+
   fsl,ddrc:
     $ref: "/schemas/types.yaml#/definitions/phandle"
     description:
-- 
2.31.1

