Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA046303B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhK3JxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:53:22 -0500
Received: from mail-eopbgr50049.outbound.protection.outlook.com ([40.107.5.49]:37188
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240511AbhK3Jwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:52:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jL24wvqL8T2iLh3dQLnlH+l64nuiE7HTg+V3BCxuv2KpqkMtPith6P4BCMQND6AILrwKvVe4eN+JmS38EZJQwyX0zuw85DmW4CwygcbTOIJOHz+zDP1ipfa/PCnZuH973U4x6W5JtEQiCVMPmO9NHvVjqxgwxZX3U01r775xmzqXD5U0Sgg2YA8RO3NyJDJqyHP3690UrUTtRSWLq5DmO96NZzktE+lPIrCEMyE5pqcTco4+tw8hs62ccwutjmjlq1afrO2/KPZ9+KnwK3HD6HalrHmpBskhOOJn6MTCL+/2ZXsdUEh2eN7Z5OTbN82z/5s2zx4I1XKJBzOz6DmN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=Q0xURYkEgE/be3vFX1U3JKm9sa4HyblfTyan2Lj25uDJusJRl57qHQHhlVIoPLPv+mJDmkc2gvCHuGEP2VotuCveq84Lu82iSAr/prZh3UjYdlUY+D3qvGB+UJJvzbw4xu64ywoTm6/glWB/05OghsjDbi3aL7z5hvmOP4S3e/6j1Ev81C4JYTtcgVhBlhLyL/JxOuej+HxxAoT348sowP2Dbe5IR+n0yvZNPIWKTyiFzt5Ifg3TGjJsfTsduwHAEMSTQdphzDA6IUP0Ha6NeGbHPKXLJH4HfnFOEZbOX7BsuwRcdviVkeA/dg+bw1/AC6xFP5660V6XxY5Jn6xrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHWDSG3+IlihVMRDW1j90pRI3F/slKG4Im7hct5HmzA=;
 b=niqFew1rpKrDgUeSCqmJXIhGtQmMumetSd4Akh3R8nJsqyz3GGXkh/P3DMzhqPYVqEYGJBS8nQbPYCCxsJmlxT/w1JdMOXxmXisDwqy7xrqWPYJl0iVIQxXzDhhC772AhUzH7r1v7kt7BxblpvvGCI+T/cgtswxxxTIRyMaAKCg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR0402MB2884.eurprd04.prod.outlook.com (2603:10a6:203:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 09:49:28 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::fc3a:8aea:2c92:3886%5]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:49:28 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v13 12/13] firmware: imx: scu-pd: imx8q: add vpu mu resources
Date:   Tue, 30 Nov 2021 17:48:13 +0800
Message-Id: <92ff12d58d0ae8aa1d09c30dcb5e163a0592f7be.1638263914.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1638263914.git.ming.qian@nxp.com>
References: <cover.1638263914.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
Received: from lsv11149.swis.cn-sha01.nxp.com (119.31.174.70) by SI2P153CA0025.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 30 Nov 2021 09:49:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d8c8e3-c570-4970-e110-08d9b3e6b319
X-MS-TrafficTypeDiagnostic: AM5PR0402MB2884:
X-Microsoft-Antispam-PRVS: <AM5PR0402MB288480BA17174F472DD587E0E7679@AM5PR0402MB2884.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpZamsi88KQjmRdI1SqE25VttDbdd1auINfvD9MLeBYGCdY1cL7xiInOXNDqOWiuMWn2+lfxKzIJG2a52fd/RD+n/MjLvSAR4qetjM7G40sfOVxQgKPG3sDG2DWJ7umigJvq4UJr4vVDyPTVASQpGhOwDkHR6GSz0d2YtbqaaZzQvO+C21dSWmsMXT8kBEvEIdJNqjjWUMLyritTZ4B4PQguVgjLP6r8TjVmdtiP/z8dymOCHI/1OsNrTJLuqYg8JlF1LzSxHzE8QzCkaIlqf/JsZzomqef8pykjpnSaVtSdrvMX5IQUV18+oqnah4hn6YbU3JP5s4tYpZd33PrxaQk5Au4idsKcfOKDbeO6FcOJbhZwP1YL2deUeb89yKCVP5lwXtK/8NaqZ0oibh5cky0+GimSblR1GB055Dz2B64mR0oxZ/PwuEanb+wMZZWRV+BLjzdfR0jGIgNMbBwqQf9Sib6X4XBuEGuXtPrfG7MPyaLbYhO12jDuilC1C+dpm1dG8sf6tqjgMbyoiRYoA8ZuBKHKRpGwRBVfVHxdPezjSd2eHfR+VXwdlW+D9CD9KDoyp+ph6CWqikpxTC/yKsYKQXvkZc5bQHzZPAyrowZDeoPbMAiOhcYMWmAcUqOIfuwBtfYCBZ9rLbUcE+TD9PJVyU078AR/un87DR/G10uujoMeprBbDEn/UJIO9ODdnWDEUTsK41670OPbvkP1NPHc3OdzUySgbtKkDpllKrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(36756003)(86362001)(52116002)(66556008)(186003)(4326008)(2906002)(7416002)(6486002)(316002)(8936002)(8676002)(38100700002)(7696005)(6666004)(38350700002)(956004)(44832011)(26005)(5660300002)(4744005)(508600001)(66476007)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jdoy6wPxTj8/JpdR4bvwhTckFXoDBrPA5rdG8mNQQ1hL3uYJcnuuc9Ue1TRS?=
 =?us-ascii?Q?NshgTuVcXQ8U9ESb5pLdohzu5DjeJcA2sk7UKfKciN5wFDKlKInVzX+x1WG8?=
 =?us-ascii?Q?PyXt/oUQYmjodIqcMC3Z31ap7SzmCiUWdBsbEybLHyvg4/Y9S96zvBrSZ6IL?=
 =?us-ascii?Q?Zsxwlj9/Oqrjfe6KI4qq5LiHHc1TgMS21Z7w+8hYn+MVGn6aTcImaIsMAbgc?=
 =?us-ascii?Q?ro23kcy1lGEiztEZ0Rr5V0JOzOmt07eytVrbE2VSJc+pAF7ugWkqyEgfnmnm?=
 =?us-ascii?Q?8gkDC7sLyDC1GhHHFr3pZGa/3d5HFaa+uHF+zeOD78bpURcSRIGHCQW7gTAq?=
 =?us-ascii?Q?b84Hy9MjdpJasa0ELmqc2DUzdwGuisqBozlskqBXTRwywALo0CNU6b2+9Bd2?=
 =?us-ascii?Q?TAf0N+9ivxzdQOrfT0XAaeBYgm946AZ48TMUvhWuDjfivpyx36F3yrjckDxh?=
 =?us-ascii?Q?lA77i6y/cxc3MR6O1XFk6QEferWuuMxHxqftpgWPDF+SszbAJOkrg/t7HEJp?=
 =?us-ascii?Q?9QpmgjGXYpIao/CS8gIEK1/Xo3Xfsqw+mvAmIGvFzeG9rBUphZ5P/r2kis7B?=
 =?us-ascii?Q?FbnT+tBGcPNyIWHCkqTKj7dFJMSg4kkmJeTSzp6QeUbcwbOx2mvDBSpQEnVR?=
 =?us-ascii?Q?yte0yuACXPAg+aLvvSeH1egqwQvV1+gwX9HfKcIkKpwHnAjGxkrBbye1wioU?=
 =?us-ascii?Q?CXfaEJmAiMSzo9pz0HXOeErLbZb5uccFeyac+KvkbgqpHVdqupgBbg7HZJgh?=
 =?us-ascii?Q?M4TEytD0nNizF9fj5kF78UVp4O+ll+vEnFjp5C8hF8mR0i4ErQ8UiV2zpR3L?=
 =?us-ascii?Q?s+aJKByrFHuskFP4RhSzNAzYKNI554m5ZYHKiPd70myGNAXE5QI9/BzJmP9N?=
 =?us-ascii?Q?FrzmjJXp8QmTcwlfRIEjX4uLCkssHySetAynxLgb1uDI9mBdjUfdHrwcruxs?=
 =?us-ascii?Q?9f3JZpHBSo8KYy7Ei+8AOiy8v35XfeuCuA5OL+Tjof0Yv6xHsQz+nQ/UbfFO?=
 =?us-ascii?Q?oN4VuGen0nppJGNvjX75NtO6PSNSTwvKeQaN02wczxJ+o3gcDc7SBzdLBI0U?=
 =?us-ascii?Q?cuizEA1MUV53p2xhm+MpTmY6vnPaptZvzFnm3snKj+6iLOVpqXI/bdXbUcvl?=
 =?us-ascii?Q?d8cilP2EB8ThIsIvHu+OsQWkBpO1FLjPv+avtXsil1TuubMyg1qUna7EJsDq?=
 =?us-ascii?Q?Upgy0P1I51tcnjzt4/4liVRnUFTr/XuPV6IWqOzxpKxuVH0fthLS0AMSu4BC?=
 =?us-ascii?Q?a2LQwYYCAYiAm9W3Q5bQUtAieBWP1fjrz0LJayZJny98lv9q259ct6fNuLOA?=
 =?us-ascii?Q?4kXY5kW3wQmZ8VGQAlTmfuZj40KTefxQqJaY9FK6K6RkylBeeUp3cz2zk7VF?=
 =?us-ascii?Q?T5ei2lsfTKwF1OxQ5czNlhMrRcCAkusJQ3Obl50vdb97PRO88saRhYK+NHDh?=
 =?us-ascii?Q?taBmGh1FzXPKXT54x5lCLBsurLJfiU5NqrnPaDjKd8BblgPRgsvcrpdtR8G3?=
 =?us-ascii?Q?zEQNLk8ZKjLrKS7EFnlH+8MletHcgWLZ4QdG+bUmOSuUWZ4wWPcToHxLPje5?=
 =?us-ascii?Q?K7+SG8S5bOiaQu2YccMC46pzH8IyTsQLkKYJJcj77X1QF+njoZlFr1kjGSnS?=
 =?us-ascii?Q?5JE0LIeofUjRwMi/pVI2xm8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d8c8e3-c570-4970-e110-08d9b3e6b319
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 09:49:28.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ObQI5ZptTmZPdLOXq2E7Xev9DippLDQB2Nvyf8GB2G/IBCwQZX/GO/Etod51IAdQnC7ICEoXZArfligJ1KqQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2884
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

