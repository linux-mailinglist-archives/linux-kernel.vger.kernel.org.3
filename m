Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38AD46D43D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhLHNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:22:27 -0500
Received: from mail-eopbgr80088.outbound.protection.outlook.com ([40.107.8.88]:7550
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229613AbhLHNWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:22:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMqGo9GDS+rjgtA407JShd+Byaszs9y1vzBX6r1fjCGbkYZg7wUrPnfHBkJpL0EbTZ2+DiOqcBpccd+IfcFDq1yk0KWcTR6hn8JR9ZwPN+8RRhz78AROgw9BqowPwKTGmxKx8I+BLLWRqpQXPc7DoTLkVgjXaDzwW3CYvg9dD8WaLBgc0Mhz5LcTSFmVfxIYnv7yPDcef2RT3yeVJDZjwTrwebz0GA0i6kSpkF4uNlnoCXoDcDexctbS/+SGKCjcKAoXMH1xvQmRMmQK1SX/Z4GGacR9D/qd5VnijaHuFTG0uVMFBo0e5Sy0YxbHTF91tqpdSAn7b6BV3WbURgPxfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZbNMKw3+wjufaPKVTsljc1zpTsJEjOXmv5hLNiWFew=;
 b=MZ/6gPOexk3Q1Hzt0GyT0RlQ3CsrwOrAQqUIZWbP1pUkC/un7CbB3ENVAnrw+W0gnAWtz7JyzPAoPQ2LfGae86m8fxI801DR+Z0zt9/cGFz54lIJlm3zl7eIhJw5KZX7npGHKTRLlhdq/CAjHPtzKHvIBC75iwUoauzNQTyAsOGKFYDQn4M9Ei72exUtBWeX9Z34074fFbMGZ6+ZRDZd1Bc805RrReySmyIwwxo8mzw+88vUsY9HdyuBD77E9Y1PBNBHEODzZ90RFtHzGHDJX330Emhu14J6C+YUM88+8ViiZ5jyjivNx+q1FlhO+Vxe/yaxGm13+r6GI+ZvivjukQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZbNMKw3+wjufaPKVTsljc1zpTsJEjOXmv5hLNiWFew=;
 b=BHiBAT0l4ZE0sLydwZEdY/NpGm0CYf3VBqxfq3tVLlFXqK0FDArH8tXCjdNDPsClEXQiScyIrQLqZE6G5v1phpYYlI6QJNPOeYYPQxzYZmb9m9DIEymKkpRzZ7CazSRoGVIH9CSO8uaQWkf43TLnsVGHOxdlN/ZgtefOJZbBPMg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 13:18:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Wed, 8 Dec 2021
 13:18:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/3] add i.MX8ULP scmi power domain
Date:   Wed,  8 Dec 2021 21:17:52 +0800
Message-Id: <20211208131755.1799041-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0302CA0008.apcprd03.prod.outlook.com
 (2603:1096:3:2::18) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.66) by SG2PR0302CA0008.apcprd03.prod.outlook.com (2603:1096:3:2::18) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 13:18:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6508344-611f-4f8d-9b10-08d9ba4d4605
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU0PR04MB9496E6EBBC9E64A3AE12B972C96F9@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B8+sAZwU20cifNswsJgi6ev67QZgUjyZMoaAQKNhxmQxFMd43KibHNL4+tMSeuG9yz93mB5sceQ3pFrRFYUEEwr6comaYjn2fHWXSfvbS+LXYscufZVxCO3Z7Ae2s7HyLbdJf/TZLOciKSy6YDKSNpXDhDEyHKR9Ebcm6kiZM3Ulxi1gp/5z4Pc0oZzoLCAYZ8TJfye4sybQ3EUi8mD3dJhJ5NY4m+9Fq/3gdR6B22f3HGqKsI4hqPgBr9cseedi41DSMxT4Ud0VQMMFakAC9bn92HefBsLsBgMuDnu/AjcZ5rmEkjXWRRa6PHeoVJ8FBKXoSLZBgtbU7rCQwIi1HAprgD8Di0IeCwaxTJ6SF0+BxiyRNcV/8/NT1m2+BiZW9qVtnNbnLCqhODl4ds8ncdfoeHKZvSPj6wGWxRxpaO63dQR5i/qpQ/ZUXBbCMJMueEyhdUUMLag0l7zhXDSabFfsdEguk389UzZ0YEF4glOEuF5WNm1rK82WPmND6ULwngnSPdFZFupMCLS0BAFP3DZHa7JaycbQx8GpV4Ub4Ks507ldqfp9HEN8DwqtmF509D8F0wI/ySBVtFctLjm7O2PYHWvs7KDPUV7dXTY/o8Qr0atTjZ4tdoaants40WD/f1yVdz6gkSe9KPZ7ev0sCukwRAV/95dWGB9FU2fn7i/K6J8+0gultLkOQjFhkk69+MqIPuJUB22nIUVYavaA7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(26005)(52116002)(6506007)(6512007)(66476007)(6486002)(5660300002)(66946007)(66556008)(6666004)(86362001)(8676002)(4744005)(4326008)(8936002)(1076003)(956004)(316002)(2616005)(2906002)(38350700002)(38100700002)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOHmAi2kiot4B+MwlL0sa2vOJFHWqZp+t8NtlyeYhEqnhzPVQiAV0A5niFcy?=
 =?us-ascii?Q?AzzMdt6Gse0sRtQ/sUOGno5s1W+CDdNY1dDUDiySeh61qFSDPDxwpLtpv4YZ?=
 =?us-ascii?Q?YMy78ckNSNQ+irUkHuprKubSWxcpnXaG0zrztc/HXmbXLhBN5W0ivVluEU0Q?=
 =?us-ascii?Q?q8sfOgV7udyPF8RQOVezFi+XD83YH6/W1t8rdD2NFO2Pc78/3UxTc40qrsXi?=
 =?us-ascii?Q?gNSw5Z3t9nk1BOKeGGx6ZenVdqQ3eX4lhYhHwliSYm+M98OCe4lyHBnBUArR?=
 =?us-ascii?Q?p+QmRD1+0z6yX8N6V8bEXIyiJ4D+UuZWBlkcp8WUUG4jY5DUgO4Wk533TCYf?=
 =?us-ascii?Q?tS4X+yJY6A0yYBmcycKbatb+JdRAuCMbZ0xqoUu/SzS5aMHgAPUuKQECDeD6?=
 =?us-ascii?Q?UZ3UQ5qXH6p4t52epTGpetJeELw1No8E3pJaAf0m7TmUvgYdEqy3mR8G1W9z?=
 =?us-ascii?Q?x4Wq96lRUNQv3arkkShV8/XP/ro1mID2sPyr5OHLQuBu2LgQ6BDQPjq5m06Y?=
 =?us-ascii?Q?ivH/KLKTTbZf4z4Xh939AhMkPToKTQteo2LXJTHM2+ja8y9M3NgMVawjdeOm?=
 =?us-ascii?Q?svN0yjec3JFpgCyukApj1Z8uO4e7YlNvT05+7CdRkHmEILjyVu4rjl1v8/BE?=
 =?us-ascii?Q?Jmvj6AhIT5AS2ify5K6g4Vc7CwrS2NB74svSOvSor2Yl7V0z/HcgJo46iFZ4?=
 =?us-ascii?Q?FdnNiKuL+tdLv109/u9NYw+TkuuzZexAPDyON65mA9t+iziPHTigQ0TvK7H2?=
 =?us-ascii?Q?Op6CH14oD3UAjR9Mabk+3OJVuWSB3iP+tsbSdakcaWcmfOBBENKH/oUsQYOg?=
 =?us-ascii?Q?PqYU5twFswItmezveCSX9RPH1ja8dxwHu7Ditn+U5iSPHKOteleYvsdRi6cj?=
 =?us-ascii?Q?lUGX2g8R9c7zlJgsP3h89/TXIOADSAKJ3W/UVXI2Zufh9tXaBM4ekGX57N4H?=
 =?us-ascii?Q?/HzTEM04iPs/zIM+ru0xR+YBacRIGLF0myC/y6L9UrUf6IaYQBhvjTnQ8HHQ?=
 =?us-ascii?Q?bQ5Cp9HGhz1aUihqSf+rOUUkFAYZ1SPtlZrjDOWeNFQobYuLzZxNjmBEyD7x?=
 =?us-ascii?Q?7lHeygsMEqPnF0GNbepRNOPO7Xa12RjdqfspGpi/yU7sUvO4VyDjzOcVyIzC?=
 =?us-ascii?Q?9+PhZ3wYK7aswnuEMBzkwWFukDo3lTHJ2IGJHfVpRs2Uiw/O/GPKnqPqU5qY?=
 =?us-ascii?Q?o95kYdHe5TyQR2/BBU3tLAFuq3hywiuG8VcerTfCSEeaJKs1pMFlnNlG9ea5?=
 =?us-ascii?Q?zp15NZABdHmEUDiq0rqbLKnJ0Qh6zsYgJhSlzjavboH/Qh2TD1WsmrsgIUlF?=
 =?us-ascii?Q?cKZKJciWDFP9Ni0ZBY+L01jhQ5VH9uwMLIcmalfIYVOCQBq1DHymbdqrV70/?=
 =?us-ascii?Q?XbKMvf578n96HvG7LMYYtOIbNVEM/e3ECW5SNPwkTXu5i525RzWbKE+bTCgQ?=
 =?us-ascii?Q?RWFIC+N3FDjlmxyuDcXMwibf2q6Ck4+OA8BCGYbkejGurYvT4jg2Rd96siGk?=
 =?us-ascii?Q?mtoVdCaBVRaRA6TJs98fM1i3krjwzowIdnC7/+wllLUswO2F9gn1JF66H+F+?=
 =?us-ascii?Q?ek1ttpOieUkClagOFHpoFQtl7GYdi35vXuPN6Nn6Tf0oyVZFAhm+v/J3Ruu0?=
 =?us-ascii?Q?y9wa7I7hgz9190gwwh4YGYQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6508344-611f-4f8d-9b10-08d9ba4d4605
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:18:50.6416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wd1dL/zZaXYY/Qm5/uePJzaNzIoEnI1IkM8zm3ChDR19eUpNsiN85vAiwyEqaqpq4HyWT8xiYIlG7d8FbYZPdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 There is no dependency now.
 Use Hyphen for node name in patch 2/3
 Add A-b in patch 1/3

This patchset is to add device tree support for i.MX8ULP SCMI firmware,
and enable it for USDHC node

Peng Fan (3):
  dt-bindings: power: imx8ulp: add power domain header file
  arm64: dts: imx8ulp: add scmi firmware node
  arm64: dts: imx8ulp: add power domain entry for usdhc

 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 38 ++++++++++++++++++++++
 include/dt-bindings/power/imx8ulp-power.h  | 26 +++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/power/imx8ulp-power.h

-- 
2.25.1

