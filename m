Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4F495E57
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380169AbiAULXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:23:03 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:53830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380135AbiAULWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:22:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gXVaBvLIX4z6LUskL1w9PkK6/YStmyJm6vAywBjs5d8jDgao/RHEMgBZdPBdVR0cqbWRzqPM5mjwDao/WhUnn8lF37A1EC0KqcXmXuc3KKiEzMwF11kB1/kcEY2cpmA74TUjCKzOrESh5f6D2RfNRslCVwGHdyLaJdThKjBxriHOLnd36mhCubcDvLwLIFd0TfQmoirMenkWXIZeTLn5Zy9ntNPdZuD2jNQfImGfZhB7vIHlHGC0Vvk0eZEprfoGDsbRjwdUaWeZOLaLAQnCfMbwN++2MJFp/nCYo/Wyjle3sJS78ZkPxaNgIUchIM0oP01rpd0BR+dY/yLi18Q/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG+NRdA9x4fxcHP4UobbuLjrnZ9XW/BELvx3bKO0u1M=;
 b=WzHXcmSOe5nKV+fHMhl0qjQO2Fecgwzlw4WgOag7qwM8F5gvm6wCJ+O6VftP9YGWymdXujwNKietwMjGLe5B2tsAGKosuZoxuDVlPBm8ECagtiTO0pNcYN+7w1XuAwu1dcPVU0w1N9ozIzgzu0azcQC2/YfYcxNUw64GZJESLsn2KygXqRCi64W1Xr3r7zwDqXYSooQnzboxwKF6liUpzZ6E/S9ePhMmkE2BYvyzaBNfbbxqueydH/rEmC4pWkhstk6rfGowvtDpjcmKlyFMlf3sdTqX7gngGQhkMa7fO0yxmxy3OoRGBT/g6CU00DCuwMLdCzB2MaVP8+QspNn9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG+NRdA9x4fxcHP4UobbuLjrnZ9XW/BELvx3bKO0u1M=;
 b=EnhK+RAoARCNZeA+KIAo8jLAOYtq8+S2C5yZz9AXs4QVu0WoC8IpNXEQl21IpRNa1RjRkZ7Hqn1PGef2CneLZzqnuiWBxdnegtan/tGmUwA4pIW8/OQKeFSQ8F5CUTgkPoPU1mx4mbHvbTei/QBJgBX9dDk3z0Vf/UzhWATzPeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB8PR04MB6731.eurprd04.prod.outlook.com (2603:10a6:10:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 11:22:52 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 11:22:52 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 0/3] soc: imx: Refactor BLK CTRL driver
Date:   Fri, 21 Jan 2022 13:22:35 +0200
Message-Id: <20220121112238.47281-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ff607d2-6719-44d4-e989-08d9dcd05ccc
X-MS-TrafficTypeDiagnostic: DB8PR04MB6731:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB6731AFF473EE7A9DC6655623F65B9@DB8PR04MB6731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJmKfwBnMQQm4+thIobh8MHzZXvJhofOx0YrMcI8kgB2A41V39d90YOCAjbYc3fu9Kj2ekpe4kqJmIQ8jPqAODuychMSvZnbfm4pULxyaXMurEGELMb+PhIqJpziflijQiP5JL2hv59A9xWbwo7rDTADTZ5IdY0diGz3arREh4EVpGyxI7ZLjow2smrum/BqJWNOT3bUGHNuUwQD1wb/B/WGre8SUoRFTrX3EDJKHcsOMIxY2ok1sFVF5c0rxx2Gs3x7rHvNKDZOag7mu4H4uGMkYeGrBsAm1g7SnmYK2ZbRy7p5DsXVrFILe/htvOABG4QRWtnKiqzSWCI+DsjewgBPIrGRuYa9wQanje7ow/gtKkcNUz05dZ3DczdeE3OsFUppslN07RXqr6kL8n5gbNbS4jw/0FkQRw+yuHRmK1YKD53i2IFlChyO+l0XEaD3nlmqlLqjizdN9nShHvpkeiqu0pvx3Hvo95t9WzcJj8UPMOVcpaLDmtvRWu3tG3yVot/2YCwpOmcsxWNbPfZ3SAzkDj0rkbD1OUOfTHoAHo0ZCOM/vRZQdswLXR97foElMdL41spc4GUutY1N36TBvvhKSddzhHv63r1xLsGtARdOe/eModKAGoxW9wyv54y8DL61kRHjlF+EXWKLkIiIpGen8Rl98kVq2fR6Y28QWx2nMyEbRkr7KOvGkELR8d0xhGp9RtFpHdgWnWhVmKOE5BOCOOSvGfXPAuqhtcVAaGTfP6at4kYCM7PZT2Hj5xY59ZGXG4cBplSlv5tuhG2bnihC6J8rVn+bF+KgkK0NLw4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(52116002)(2616005)(8676002)(6512007)(1076003)(6666004)(316002)(110136005)(54906003)(86362001)(6506007)(6486002)(966005)(66946007)(5660300002)(4326008)(66556008)(66476007)(8936002)(36756003)(44832011)(83380400001)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vDNf5EGPAlpfZqB7Kb6W7yhWAqArd0ORalQGosn3EHW95T81IK69ehhlZrC3?=
 =?us-ascii?Q?pfI5V/lQtppny4i7CKHKOd29xwE1wIOhpO4ptMPx/YS0i7edgaja++cWO2Mm?=
 =?us-ascii?Q?5YgXj7NWi8xPnBmKNAXdwe+KEVydCgf1g25bPajBPMoPE/PS6oC7Ael/uvpL?=
 =?us-ascii?Q?WEU4vWQ0bLwy9sKN9p2wPCXhiNapbq62zG6L2mX/ngHZ49UKpS3VJrv4yYZq?=
 =?us-ascii?Q?CndZYcSXXNrxktMmqJcS1Ga2GAUoadNtx6KAWMWcw7dAtjorhg7EM6xiGDmd?=
 =?us-ascii?Q?+AEvwiT7GtiEBasz2tYiCPDbi9G8y9bdNkMcfPNSUsl/j3PUVIuojYJBc6dZ?=
 =?us-ascii?Q?ZN6W9yLSdkAEnBtqLwMUYX9WRrvbP33D0J99jFEZKQMdDBoefwuVcQEeqjVR?=
 =?us-ascii?Q?hMG9sqfC8UqLuCavl9qV1ttjVMFSwkXFDglyx0vEBOi0pEpKF5l2GYuRPTBa?=
 =?us-ascii?Q?aVM98fswWO1wGefj2y67JGW8fZWt87awnvQDsC0BmpFEbapbZROHzM/+aMCm?=
 =?us-ascii?Q?K+bnNzKf3Y8QfWw/Mmh/MW/PLzS0roNKX4HWO4PvNpLmjjBksFmgh5WUBxZl?=
 =?us-ascii?Q?ee2oTOPZ78/KUZv5FwYkdxtepngng/P9+p7GQb509H/YyiYoDBJvQ04ZzA1k?=
 =?us-ascii?Q?diSRouhTPPTMY7bcXGa8A1Ogur8gJTk7qgxMRcb1gZrTnFjAX+TISXB4F80H?=
 =?us-ascii?Q?mm+R17a3+sNBYCrXNwIKDqLmetjhDS9Cwxt90OvpQ+Rxx90f/XcCk7EQkScH?=
 =?us-ascii?Q?t7HUs/WcsPWmoQpHOSH0z3fXVAFU9ECX7GXgFr+fIV9fAVRZTrdECUosiXnI?=
 =?us-ascii?Q?NpppKg1XnLEJ9V6/LooE0/2VQ1kcMFJSb7giLQjFKJu0LTEArb0pl6xtb5KE?=
 =?us-ascii?Q?EPWFMpB+k9OCuNWtr97veGdOcLSnBypv4L/uzA8CdCo6+YpNlUEfzlfGOTLL?=
 =?us-ascii?Q?w3QA2OtsYf6mRkSiloWJULD/Jkr71sJQSV24rcJJ3OQt/POdATSi1d3wfk2N?=
 =?us-ascii?Q?D+otyTptTVn/LNDdEGWKIRvsU8kYcb+ZCvcSNiG6pTWVztPExqraqlNQYrjI?=
 =?us-ascii?Q?O1DBvS8fwC9WJr+fMLw9jUJqr9dVkgBQnNnF7Qxu6Q6fvXLcO87C5WA26C9d?=
 =?us-ascii?Q?tRAqpxs9xSsDiw0bDvxejKcYCNa4fB0jzwcwcBO/UxLgXAUI5elupkN1yRXK?=
 =?us-ascii?Q?w53bGTjMs/TqoUggxMXmAyXXqUo1BNM1RPMCGj+9HChOMleQn8ifEj5q9Pwa?=
 =?us-ascii?Q?TWnFYCS6KDiznS3mg0sswccBZbYIHAlL3yp6FbNit4nu3BM1XAnz6skCWoEu?=
 =?us-ascii?Q?sASJEn8EXNbVwdAi05yjl8qmaUkT0Y+xhL2QwIkNrXHjKaNg7/cVjSW/pJaa?=
 =?us-ascii?Q?73ihBgYHti+fF14IptbtajhX4QYM1/YclFik9O5qFBp5aD5uF9mufOV4VJ1z?=
 =?us-ascii?Q?Ff6++HDcmxge/F47lsNkL/dETdfqFMS8Smz1/VbDtpNJ8BlCng0lTxWClEFl?=
 =?us-ascii?Q?SEkngJUugoI1ByOnHN4mxUW0qpJYJpZy6fiNVeo12qChxHacwwHjT+JXrURr?=
 =?us-ascii?Q?wxx3UH1SdHwC1Ev885wsrrwPHA8KrZPvJ6Sp8AR+3YfV4bB1/S1gtpjcEDmT?=
 =?us-ascii?Q?u/d+Ea6xRmotf0RYfWeOQtQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff607d2-6719-44d4-e989-08d9dcd05ccc
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:22:51.9439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGK6a9Z39w3hFpCzgU6REFy7D8TqS1PO6qgwEO4wC4+CZFvBEu+Fb9iu1hkrQgiPYi8m/QbtiYmNHpjhzY9XpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This splits the SoC specific parts into separate drivers for i.MX8MM and
i.MX8MN. Should be more readable and easier to maintain.

As for the i.MX8MP BLK CTRL driver (sent by Lucas here:
https://lore.kernel.org/linux-arm-kernel/20220119134027.2931945-7-l.stach@pengutronix.de/raw)
It can remain as a separate driver until we figure out what is the
overlap and how can we make it use the generic part.

This patchset doesn't rely on the above-mentioned patch and does not
impact it in any way.

Abel Vesa (3):
  soc: imx: make i.MX8MM BLK CTRL a separate driver
  soc: imx: make i.MX8MN BLK CTRL a separate driver
  soc: imx: Rename generic BLK CTRL driver to suggest future usability

 drivers/soc/imx/Kconfig           |  14 +
 drivers/soc/imx/Makefile          |   4 +-
 drivers/soc/imx/imx-blk-ctrl.c    | 322 ++++++++++++++++
 drivers/soc/imx/imx-blk-ctrl.h    |  72 ++++
 drivers/soc/imx/imx8m-blk-ctrl.c  | 617 ------------------------------
 drivers/soc/imx/imx8mm-blk-ctrl.c | 173 +++++++++
 drivers/soc/imx/imx8mn-blk-ctrl.c | 101 +++++
 7 files changed, 685 insertions(+), 618 deletions(-)
 create mode 100644 drivers/soc/imx/imx-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx-blk-ctrl.h
 delete mode 100644 drivers/soc/imx/imx8m-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx8mm-blk-ctrl.c
 create mode 100644 drivers/soc/imx/imx8mn-blk-ctrl.c

-- 
2.31.1

