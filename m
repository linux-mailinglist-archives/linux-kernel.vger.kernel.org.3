Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964924C2221
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiBXDNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiBXDMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:12:35 -0500
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554AB1520E6;
        Wed, 23 Feb 2022 19:11:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAKAXGNDQudGFyH3HoCCCfBtPtGkb8L/Y09wiSwywnU+7oKSO5xBZszQST8zZbehiiF6XCgLf9U3TcCs+2P0lmvpZo8oi00ZD40fdvZ69ZWVphoANC6KWVo/y5hG1J3ke7eY6NRSG9BZJqRH1Hc2nGGduxC8aOUe7SOOvUIMRJdNhfRHGAnJd2EyTuDDdSrqzpAMb5h/LpvzYXAexZkMW1zPHWoUDShq+NBq2F1HFDyP8WkKJ78fqXLDaisnbw0LsL40YjRUDkl5eMlvapWjuyabfLsm6TodZ8MZgNrYoJ8wpgdk9r7Qnf2CEeE5uHHN8lZIhXN2dKLavEvZpG31cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=nOuRWnHxFkiyjypnzQZuDA3wY0gunygoMEJbLDYYFWZmCUjfc4XdnLELUw1B9s09LlNXogT3oJF3vekLqTfAP6fs7YQxcqqY1EcGjdtKmNsYBQeCOfLcOyO7ISQYYgRCJCUn33xXC5EBmUe3uZv8DovuZ0D0a6KR70lERfkhh63LSxmqFWTZOA4UcmToNRUxDbvsopfKPuPzl0IYKc8hQS1YEXvE/aZjnWxMVWM9i2zs1AK1pYzq8ZPih5lBrBLCWvcY91CoeuCKVHw0sYZslgg+XEDBeH0qv7rI38YL36xvQepKUEbfxhr5xa6QaPlvyOpoMecxHJmbjNslAxSVIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDHOpRkvaL8TBkStfB3/tjhywB2nWYq3xxwNn1TQsnA=;
 b=RjMNp7/0iXdeLicr/tRBEN9CyRwR9FQvCoYCTSmNgnhMHrIkf4B1n4zWoHsHpJq9rczGJfvOybo2v/KdZ3+yi7MItLFB8t79UsjJWkbplAjQw1joAF7Zj332yRVPKOnEraNhp3o+Hqh3DXO9HC3ge5qmCXQoiOMAb7ZW1hJZNpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by PA4PR04MB8013.eurprd04.prod.outlook.com (2603:10a6:102:c4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 03:11:54 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5017.024; Thu, 24 Feb 2022
 03:11:54 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v18 13/15] MAINTAINERS: add AMPHION VPU CODEC V4L2 driver entry
Date:   Thu, 24 Feb 2022 11:10:11 +0800
Message-Id: <c53f4fbce795e6c87c44eeb5bbe6c91c7d96e617.1645670589.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1645670589.git.ming.qian@nxp.com>
References: <cover.1645670589.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e1c1b83-260b-4fd8-2eaa-08d9f74368d8
X-MS-TrafficTypeDiagnostic: PA4PR04MB8013:EE_
X-Microsoft-Antispam-PRVS: <PA4PR04MB8013C50BE601F6C4962904ECE73D9@PA4PR04MB8013.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1VhGgu5e+J42BKC4ss9DmBzqTGOsGaRULAojVmgRgzpNL4Vtu1bxJNuBPGRVGSyhj2+SJSGubqwFEG70RpX2iVWIBvVvwM8BVAcUdtcS8AmxEoxoD/t8og5PbsWkjc9968aPxnj9Y61uQCGCQMgB8BDwSmGgGPogB2zYbrvwZ7HZoo5cZDkTJQe3uLg2X98q0Gz7vUsvmSdQE6AQPSUfjzzWnQTUJOkFavLhlx6iM8GD82oSFL1H5khlWX/OIGkIJzq4W7af7V6Q1Ac0DwAkcOBKiTq3A8n0B8tDHj8Ib/She6neDVuxweMeLJQOi16AVZP/nvWo7U6ynY1sJdXwTII8a/vMvhPgHyIKp+B9VZfmjPcoIGicoOzj4NTRfWUt6llwCplp9NueNOmQBtj27rnHzWIHikKzPO2zutFusKjBAvO0eP3Fc+bMyUwBvQ5WX5cemlMPgjbAfD8t01Gt4oUr+3Tpiag4/MmndhVO7OC61WBCehcovk9eCws0jGW4G5KZfDFvipZ8SLoL40rLoTVJKNvwpFtCoBGvBTu0mon/Z+cQkAHoClyXu3szXeYUEBzcDgr2uNxGTWyehLHm+vAFtBlTFgz0VAWnVa2v7GNlwrW6b4O5c64P8iey6vaBf9ivSONOJK/nONL6BxNyGO4w7KqjItZSYxF3w46B/W2vmpFkZCSIjg22Vgvou9V1TFodk0tjASzUhXVsb8voQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(2616005)(44832011)(6512007)(38100700002)(38350700002)(186003)(26005)(5660300002)(508600001)(6486002)(52116002)(6506007)(4744005)(86362001)(6666004)(7416002)(66946007)(8936002)(2906002)(8676002)(4326008)(66476007)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFpeWgJmaQOtMaIGPLnfG+Pc0E7qaktK/wDEoR1LL08jO82vb6zj/lS5IIfw?=
 =?us-ascii?Q?vRRZzjFtW9rM/+eXWlXWIm+nQw9LgHlLeQ8SvWpGMHxJo/EbEbHteyEoZFoY?=
 =?us-ascii?Q?5GzvM9/IEMKNPUymrVLHt/TPam1Qrhe0gF557oiye0nlSgEWj7ITBDd5HEOg?=
 =?us-ascii?Q?VR6B0XYcJom0+jzU8ZJXcx3n0L+Xe11l9i/0OQBjaTMOqZY1COoher4YHTiX?=
 =?us-ascii?Q?WrJ3FYizJfQNCLsnW0queXfT4FdJ8vF/mPyPfEbHjwkq3Eq04h0yuuLXIEn0?=
 =?us-ascii?Q?+nw5F6lfjyhiY5RI2WL4vBOcfeI/SfiDHRb74r788btWTYqs+kaFAEnVfkuW?=
 =?us-ascii?Q?NSXvRE3j2OU966B2et3DWMg4dKEVPWCAbeNFETKByM+3WeUEkb7fT8KR5FXK?=
 =?us-ascii?Q?2/3+QjxEDGBzAgn0sOzGP2mmswrZypX6EZYFQl4yt2WFsytqfJ7hp4UZqbsn?=
 =?us-ascii?Q?CUap1p5yttMKLxj5UE4D0l0qeOJANq5Gb6BpBSwy57GmjwfRWnK7X3MPmhM1?=
 =?us-ascii?Q?Z90CgDy7sMhmPeqskvU3qN1mEhLB8mpQQeZUQhOtSovTRznjWE9ziRv0iPDT?=
 =?us-ascii?Q?7pIQ1mGWoQfZ2YF6jIwvhE7hgx0V1hgqMU+cpf9CmQQ4SBTSX/KCwJIxQ+Zc?=
 =?us-ascii?Q?gvQx/EbDmHhQc1fcpcKAJ3zK6ujnmzqAQBEaWwBs2oaueMflpheDWHICMNPI?=
 =?us-ascii?Q?glKjEY5602ixSioogyAJz7BRUdHE8mkWxWWNIUqcnIBAI2wEzdbuJ0BKWj/p?=
 =?us-ascii?Q?EVo17kWf0w/PVfSJCUJmViDk9HzOlSaNjLc3MgQest6MDjNN6kc6YiPra7i4?=
 =?us-ascii?Q?p1SPnB3S0k7/mo6m9baWmsj0KtbJxoFbnru/LXSqCjU+fFLO04X81KU7c4w4?=
 =?us-ascii?Q?fc8tdZSBN+DcVGpKOpPBz94ljt/1lP4ijuOVTJgJOLlpHlC1+YBeO90bYeAg?=
 =?us-ascii?Q?anOoo4wn1DkWIkR13QqBpZ6W3INg3uROhPl3TN6SGw+Ddf8jCdAr+IrP4Pxt?=
 =?us-ascii?Q?4dUHM+giQYYsVaX6CVnRX+emcGagu6vNOf8VSE9SZ5Kw78fuwmnx2RCExZ8V?=
 =?us-ascii?Q?rljugXSdvZHKuObRzKZYAVKy9kdS2jfZtLiqOzkihi9pN5dO9xJyRyL0UEDi?=
 =?us-ascii?Q?tHIMK/xc7Pr2wLvCNhcN/S2vHOQ4oz3Rw5XVMamhMelnd2xc0RzGDbmP4+im?=
 =?us-ascii?Q?vHNByW2gGl3SsvGAQ4zsRTyRLEZ92SbaN5slVSiLszVFX7j1mCaBORrXg2gp?=
 =?us-ascii?Q?sL2LDe6ISj1ismH/6J8OsUBOtoDMF9xG88Woo4bYyE+s2qW49uxSNiswmOgd?=
 =?us-ascii?Q?kR1dWK3J3ymldVncGlrz5oy5BTl8sye/U36xFjyfglxzDkh/I+6TDsQDsGAX?=
 =?us-ascii?Q?0f4fxUXZuOeh/UW/4st3NOVNK+Ik7ExuEv4mXr1swQQOxEeWWW13ERk4O1Vt?=
 =?us-ascii?Q?zaV+cgvqKh7rKmV429cFRn2dleybop/noRSOCaDwHm52yPGZRPSvXzgxcqZV?=
 =?us-ascii?Q?hSfgJVVaJHRwW9ldYReAeRtR1IK9anjmK43F1m1Sd9eyYW7ENcPYOc887kAM?=
 =?us-ascii?Q?Sg1UbXnTAPGL50+ziDdDm7KByWlinuyTfuzcYNS37hn+QMeOYakMTaFkgZOZ?=
 =?us-ascii?Q?PfggEZpqwTGknATyS/KM+3o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1c1b83-260b-4fd8-2eaa-08d9f74368d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 03:11:54.6159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z0Bu5nnoKvZHQiNp45o8i6dhdpY0dQIlIrKWzVkOVBpoM5ZX6vGnQjO7sTW6xxHfzRF2eQjdzpGfik8nVgWqJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8013
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AMPHION VPU CODEC v4l2 driver entry

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 83d27b57016f..80b21f36702c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,15 @@ S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
 
+AMPHION VPU CODEC V4L2 DRIVER
+M:	Ming Qian <ming.qian@nxp.com>
+M:	Shijie Qin <shijie.qin@nxp.com>
+M:	Zhou Peng <eagle.zhou@nxp.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/media/amphion,vpu.yaml
+F:	drivers/media/platform/amphion/
+
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
 L:	linux-iio@vger.kernel.org
-- 
2.33.0

