Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA74F49AD6D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443911AbiAYHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:18:06 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:22952
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1443293AbiAYHOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:14:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tkr7EyNVABR/ZOjm7AnQ34Fn+v5EO+0Nj/BFiyX661pmnpxJzmD0ZxEgrw+Taa8WpbejKbp7G6ctnDK2hAWyIsAnQbYQNUePLII9LPrhJpooufovxsTK5b7u32CzymOXuhSex9Ceohj09wq5wYdEMfHq3InknBwYDGgiIjhJaXGvBEdv59ryw36ihSZF3IASmSQDZEIUJWWnaRaYnQSTNMIcNcAMyHIwhZw4/dTV+3vSyLe9L28EH71BIvKGYrWA+5sH95YuFFCrvkH9r70nDUIAG6L5eij1xTWbz622fm+cZa3FPUfRQQCcVztMNE+CpitjWzLjv8GI67vq5/C8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=bVod3oTMPzjRtoYnEq+E29Zdc0Qfp1PoxAJ66Hpz8VRFrRGs/Eh/tJJHoc2vt4tv113sgKLV+g3PBB2nqd9i1Rv6xJvpIiFVLXKHyxOFeWsc9t0/cSDLWBlmZI6tUtB/37CM8oBNlI5u6ecs0RVmP4DKZMsgxerjOEV03RdfUocpYe7h1LTxCggKmoB0tJc7iTPlgViHBomg8U3AVQS9bHtBOhPJdBAyU2Wx7eXj8p+NjkH3hVkfPp7gjMd6wYduvNCLDNWoWVBxjVTJEMP8qKDr7eY8WpKTtE5bu2UHeiK7T4XaD/Ef3b15MXnv1Gu1b6uWRx/K5NwEDS5oxNlYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=spyEnalri7Btyj8Pr53goOtxcjvjMOpesBjDxb5d1Fo5pRW5Cg2xRTPkx5OnVAu9FbgBY1qX9UtD/iVpcZGCd6eP2doZg20BsDHiZ1QSae5JXu6/firLysjtwfcE/ev7oygqyefSoTc1ddjMRvVm39QgdmKDZru2YbcubpbX5QM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VI1PR04MB6157.eurprd04.prod.outlook.com (2603:10a6:803:f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 07:12:42 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3d7e:6627:fdd0:9d13%4]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 07:12:42 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v15 12/13] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Tue, 25 Jan 2022 15:11:28 +0800
Message-Id: <8717d91000002047c7d0925f5eae66fc7f795e27.1643077283.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1643077283.git.ming.qian@nxp.com>
References: <cover.1643077283.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0172.apcprd04.prod.outlook.com (2603:1096:4::34)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d251e20-03b0-48ae-e0a7-08d9dfd213da
X-MS-TrafficTypeDiagnostic: VI1PR04MB6157:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB615776F3A6245509781C436CE75F9@VI1PR04MB6157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zZ3QnNqDzQbIRuncXvFAxN7KU9MSgt8lgGzG/ZPN+EGXKn+aYJTNAMXyJoD2DhvTd+ZvOu8Vmor4zdHjZ9/+Pig5AG2QVKP9/PMqPrQ9AAZhMFOisEBY3bFkmBVAgOqHV7R+h/+wXx1fq4sLkzqrOcSyIdlO2PY6ILz/Fl5VsGVsmcTLp4rm813pMhnJdVTAy6vrAmhb9o8I531D4ZVuU27ues2yuFRbSXzA1eNUIqo83xUS0vq8xAtuJoUIn+exCqUDVnLIcO8qyRaAYHXktWAucJtv7KuBMaFJufKlEfi+BqC4hb4BMPwB/w6CbIBmbW0iiLRdGzYUoAqU5ayb+LEEH6Wkwrwnpe2bDvwturKCp5pTXGXERrT77DXBzsekArKtkExeWJjyfyncXnJgf1IWMoHL/Bggd4bkINfBR3nL1FZKqee9tBkZnD55dz5GoM554WDsQWgKKfm4phqzNCXyCf/h3KpT0bmdOLGWXZweh5skxcgYcfE6gl+s8nvF4a4NFQKSG2Cz43V5TvbyWKGlE9siEA9urBXnd96FZB8MIxDcg22IXQFXEZgqePUSW70OyjCcz7KxNxlbILfKLmIrdD099LcDil8xiPe6/7+Ib6pUgI5E20hHEXEZH3Wa0VyDHkTTbKM3mcSyUBtLxC5Q5+MTSwiZ9AR0Vw/19hVMLPoA8OAco+RvBhG7fsgOKYiSOTin6LEfSlvcz8lLxUvHz0tt1ANJ+TSjdQXFAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(186003)(26005)(2616005)(38100700002)(4744005)(2906002)(66946007)(66476007)(66556008)(7416002)(44832011)(36756003)(8936002)(5660300002)(4326008)(8676002)(508600001)(52116002)(86362001)(316002)(6506007)(6512007)(6666004)(6486002)(32563001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAx5zAqF2Xms6GquFkr5GFKjYl2G5lz9pQNgwxZTbW1X3H/oVkVqeO4et5FA?=
 =?us-ascii?Q?GV6lByoKXhFcek9Vw8Tu6zhyMACXm2bOmAPZBMLM1nHrxCidtRQodIiEC45Q?=
 =?us-ascii?Q?6VlNYwJs3r+tik4KGg0oJpuGoOxPAP6hPX4MWmr9CNX6gJAFPHu+3b4iHpIs?=
 =?us-ascii?Q?ZNgrbZtkwQ18tsFwP8mvyBio3LKeR7/MU/h44fwzRA1vANuCR1t39utNH/Of?=
 =?us-ascii?Q?FKnln7cx9HsbI8DSiGxxTZaPzWCZLWCjMPa6vSkAuowesKe0GeSTN53yM5FH?=
 =?us-ascii?Q?rXQrFQOj1MA9xzHim4lb40iF8bMK323MUcNBnyNxmZp6+NdrNShhnUjrmXkk?=
 =?us-ascii?Q?swGtbLvk1Ae7wz/mNhH7i+PCGlCccv7LwloHmi99QnN9TMuAhl2/23m5q2lp?=
 =?us-ascii?Q?xaqBDgyy8BmoERPblQNNHy32ZVFgxygdZGZCL1O7PNASjIQXz/GPTe1E5JAs?=
 =?us-ascii?Q?Fy73XxFCE8reY/QWTgoI15qVJ/P6tsQ3lB4eZh826CVTztJ/aRz84bKV28t5?=
 =?us-ascii?Q?PKY7OOEtxTHkSHatGT8xkHh5qQxfPz1kcrXJQTvMIyCF5cf5weRFTRuUWiki?=
 =?us-ascii?Q?LHra3+fFXvO6u7ZBw+5mAZiNrnHO/Td3uuTKWfqbfMi2YEn3AK7b3VM/t1Jp?=
 =?us-ascii?Q?EybpHFLyhpseqjq7pT+ZbnLUoHxvtBj6T8EUdIjYdtKgMyNlA7OCYZ3pCLnv?=
 =?us-ascii?Q?/Yu4COeQvvDPirBG6QmL2lNVfNQ8oAXn7hjDzhdPipHd1zJPJVc8ZBZG5BTQ?=
 =?us-ascii?Q?Qozk89briBL5CD4wSHRxqgKjBt5LiC5wQbUxbRlPG1rCf9j6doteU8vjzowW?=
 =?us-ascii?Q?EbBPzSiLhgw0MA/z2W21e5EU6hM2aFUV8Onnuq+IQF5ZghN/8w94fJA3kY4G?=
 =?us-ascii?Q?D5iMUqKk6UN6Xz1/yGRQmAA95i3azRHfshvyarge0UoBqrA45yC4rCcIk5ID?=
 =?us-ascii?Q?JxrKIBnspM1eRLqA5uXseeMRIYAL0kwvqQanPG/263lNEG73nC6UwkmbKyAP?=
 =?us-ascii?Q?EQYf2GkuQDVXw/l6p2v9TOYr6d6sQsbdfvUOpouY7solHuZtAYbFo/1cNfks?=
 =?us-ascii?Q?yFzLHNP/r3UsTVuTiiXQB3QiNy72gEXg7IJtwMFN8Uvrg5fdsJxo7/45knS2?=
 =?us-ascii?Q?EU2zGj/VhfoPw1Zk7PYx+m/Z7+v656C6AKnbz8pV9EYEWgoV5yXvGJ0LgLDk?=
 =?us-ascii?Q?afiN5HTae89cS2AcU7bpzq1yqFTgf5hSijVIPIR7zSXb2/8eiE3kQ9neyalp?=
 =?us-ascii?Q?grjzMWAzKnzZMy8Tt+0i9dyxDxrWHYLR09XbTI5GTcOn11AgXTHG9zNLspfD?=
 =?us-ascii?Q?IVNPyvO+zG08YYdPSMvVXsk1xQ6o5EifVgwyotwcsmYJAgEIZc7RQTuNt8/5?=
 =?us-ascii?Q?yvY654oCDuX2hp39F7LY2tR53Nl1wbYozZVeYXxQ9EF4/jOaMsoFqSrW4kTZ?=
 =?us-ascii?Q?aPn/vEnqWyCoghv8uvYMiUOZfV0PTxhmjvgHPFB6Com+wrig6fAVjc7b1YQe?=
 =?us-ascii?Q?XlYDPKpNlkd726HZwdYjJgvCXCVwRbL8eM8dmuLqiNTnMwrzVtKiXAfLreEN?=
 =?us-ascii?Q?2c96FYuZjI9KoGLCOTYjF/4Bria767WSwU1bbxE+XSpMAll14NzsUx4t4unJ?=
 =?us-ascii?Q?g+VoBHTQBwpX+LQ7MvfGCFI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d251e20-03b0-48ae-e0a7-08d9dfd213da
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 07:12:42.1998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: treQ/QEbyrRkKKLxuGqs5VKALOLIFKTsieLPufW6+5WTCVwTKX3lw7oVVeDrYU6dipYPZrjIxI7S2gm5wbkr0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the vpu core depends on the mu resources.
if they're missed, the vpu can't work.

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index ff6569c4a53b..af3d057e6421 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -155,6 +155,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "vpu-pid", IMX_SC_R_VPU_PID0, 8, true, 0 },
 	{ "vpu-dec0", IMX_SC_R_VPU_DEC_0, 1, false, 0 },
 	{ "vpu-enc0", IMX_SC_R_VPU_ENC_0, 1, false, 0 },
+	{ "vpu-enc1", IMX_SC_R_VPU_ENC_1, 1, false, 0 },
+	{ "vpu-mu0", IMX_SC_R_VPU_MU_0, 1, false, 0 },
+	{ "vpu-mu1", IMX_SC_R_VPU_MU_1, 1, false, 0 },
+	{ "vpu-mu2", IMX_SC_R_VPU_MU_2, 1, false, 0 },
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
-- 
2.33.0

