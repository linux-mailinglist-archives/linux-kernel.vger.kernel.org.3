Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117265885C5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiHCC3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiHCC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:28:53 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130057.outbound.protection.outlook.com [40.107.13.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2F85467C;
        Tue,  2 Aug 2022 19:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWA25vHrVCuEyJl18matP0mowD6bDjtIqmdFlBl2AG+VvkBeWu4xsKmWbOzPcnHpy0nHK1muBnLqclNbdAZw0ML1izhBalH9D2Q5GAQNz3YS/s+t/Ieg9QutQlrtu1Otsf5GVFgKtX/xg8XQJXoukiyAqQHM4nK3Eejszc9QdbDAvvRJHpIZ73T0PwJrULvmMGuADDbsHe4UdYjOg854HYVgv3POT0HLvkYq02a00hWRySJfnDK+tzYiTvscM4ZehQChHyUTZe51WIzZxPSrEPp23jpUPUn4N3KVi+Qde41upLMd+LwTFpfcloySLm//EbO4aHo+bF0A7X9P22aNhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=B35z5IPVN1D0IuKVq+3SDYGDN/R/VPFMo2fQpX/pNuuMd12MJ2hBTRt0v8k4x1DgUP43BmDuF3KaVXLlQUHj/BIZm7fZGX361IPB8h4TxKTBn0G8t5FIDy1HGHIPZG20dM+CHW6LoPRPhP+gofsnauWeRmHOxPjwOdJap1/Q0WXMK3BSTpMHW83AagB0RvI0FePZEUS5qPLyiXHps9OTCDfT3blNFRECHyAVhT8gu1BOevkhcJKtzshe+RYgRsFAqbY+KeQCcTVBurREgHG23WlOE4zz3B/4ZDMpnQ0/2JjUIc3kaseMrhViEXqJ19FoK9v7gWVuN1sWafrva4Y6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kN1Qwcq9eoWUxIJU9Yd2T4IGLMbZMN7Zb5GLCZFJBrk=;
 b=fjf4pP9vLzJDSYQas0cSNV01iwrE/OTihdpaL/Ny80+I2gkJlbECnCdguiK4Rz/lkg1FNOyITBnfQzUpCNVtiYKzFX51l4ts8z5NqWz8KYQXThM+H2RxxnmtVXkrvY6KOjd+oz0MsBD7NPWcB6JcwyeicCTfioLuJoF11A/+JK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR04MB3077.eurprd04.prod.outlook.com (2603:10a6:6:8::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.13; Wed, 3 Aug 2022 02:28:49 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 02:28:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 4/4] media: amphion: encoder add support for contiguous planes
Date:   Wed,  3 Aug 2022 10:27:22 +0800
Message-Id: <9d563ad6ad660414e433a1197125b57b1ce8906d.1659493105.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659493105.git.ming.qian@nxp.com>
References: <cover.1659493105.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0022.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::9)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1586e37c-32cf-449e-95d9-08da74f7e5cc
X-MS-TrafficTypeDiagnostic: DB6PR04MB3077:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kXi1YvNSxzkRggry4EY2pRRMg6do0mF0hdCxvfCuoRpx2peWlkn3dPLzoGK8EACAlfk1Pba8Cd8HHMug3Ongxxs33Nx/EGhESYtYxuKXgzCDvIEuB9BlEep+sh349wpUWlsfz9fwXNxt29yLdKXPWP6YuDVIu7hSIhalVhyPk3vl44BQDANuGD3HveHjC0P3S/xwfe7z5SSASiA2NCtY9da2uL+h9rc6N2teLi7kT5i9goF0QxWVqswkK61BuEZyDfEVfKDEZL7iFXtgGZUQBZb3F97OHrZHpjcUG5BacRZT67XfpcHLACT3peYalYrbKaTULTih5g+V1oFbOnWru7PAUcMzX0/ubliYHRGY1TDt+p7xsGS5wz/Nn/lwWDcQqTvGoue3jBcgmykv93QE2HfOlgZOn/u8QdweWdwKrqQ48VJMNQvA6pkpORyVHX8kTOlx7mSC6g1DRncJWh51ofisV6CZ2lrP+VvEnGyk0eQrJMOo053ThA1763+XPDdPkjreIrCw95CP3wyjQJ6RdDoNIheceTgQYhgjLzLBSbLEKG5dKpAYad1MoDPqbex7+iZKopMePbkPi2HRi5+m/ZS4zVwVsG1hi52N7X36jk+C8DPX/gBwwr0Prjsf/9AOrUIOmM1T4VDrKhOFPwZuuccA2BZTlqPZQa6ldMkEswF6xY32/LUOgB0UtPtXei2Q4nuq8Asv/zBmxv24XyH3ChKgqfanyfIacaJPF8IoW1Ifsul52sRDWWSQi/vijdRhQLPObZ6v3/b4yCPShQrUvkJoltZgPKzSfqjPiMbFyL5dk65Zx9KVwTD+FsR/+yYy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(44832011)(5660300002)(8676002)(4326008)(66476007)(66556008)(66946007)(8936002)(4744005)(7416002)(2906002)(36756003)(86362001)(38100700002)(6486002)(478600001)(41300700001)(38350700002)(316002)(186003)(2616005)(26005)(6666004)(6506007)(6512007)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BcKvHULpYAM90ye5Mi5EKIdt4u/q5kgpfq1YFWXW0kn0sh/54zhqgUDOGLMX?=
 =?us-ascii?Q?EG3/qlWrqGR90MGC7ad5Ceq74aVOuH6BsgcaV4CPLb8xjnacWpIoDMThJiMY?=
 =?us-ascii?Q?ydfo5Jd/xLZrYO7dRYERn4a5uUciGpBDzcXD9+Q7reFqfXaUqTyqh2JSIfD2?=
 =?us-ascii?Q?RxBPvOZc60rLM+EDRJgJn+w8H+1jp9WMO217gX8ggy9KMcVpwb8yNRs/hpMf?=
 =?us-ascii?Q?hl/L47rUFI61rnBY4ta76UWCNLMQES6zpmBXR8kObT/q2ZtP5L8AcJogR7Ns?=
 =?us-ascii?Q?gJDsGd+692g/hB4f9aKM5CtmIJI1TZOgbv7AU3DLJPaCyGkhrUaYL9j00leB?=
 =?us-ascii?Q?1TUmGP29wayh2clVspxrGHbwIrj3weHqjgFlJCjlnr92n8qJUu85zH6XtDtd?=
 =?us-ascii?Q?rsv5MDHmx1b0vHhGPnfDNc0T6xc8bpyDo4JlBvK0eloshNiHKsjto22K6+7o?=
 =?us-ascii?Q?yRCFIPmYtQjRHDQr2RxB9qnPxjuMuXVTCKASfbDvwUDXcJstZ+i5IwdgJhkX?=
 =?us-ascii?Q?z7rq4YbtpH0FAwrGJD3ky2CAGc46ROJObCqeQSkYvnWJOx3g0Ar9y1FoW1GR?=
 =?us-ascii?Q?2wluJTNcjNkjYN1PpuiPkV7l/X1EQpOAtod2IZ46FBoPkbWDqFUdoU7ELKm6?=
 =?us-ascii?Q?nw+UqrNXoh9Pdo57ENFMag19fayFh8Dd3HdJ328U2nlPy3exHeuxFK73Tyyl?=
 =?us-ascii?Q?ZcqfEEt1rqbe6mO+uWgFdvfQE5RcI31ymxboXK/9ywwNRY9iRQFe0VzBxJqp?=
 =?us-ascii?Q?PuNvFdOyLJFLFWtLiWQMNZYxmYztTu9K5tC70vO8XwPbrSX7xFkO/VZx5P57?=
 =?us-ascii?Q?oe13lnCeQikHkcGB3HTAmYb7B38owxVgJeTMgwgdPdtO5FstwWvoFYw2TvrN?=
 =?us-ascii?Q?2xXZ8Fpl0q/u682v/cajrSTWSM5bS+Fze8H1fYoPtw9HRZ3E0IvJglK906MM?=
 =?us-ascii?Q?rqJfzGjbAgnm3HiMBn03nQRB+OAiUaV2b0kJovjuq5MXp+0xtIlhN9s0U8GD?=
 =?us-ascii?Q?+/5OEBqgVhiUp/Z+nLEKYsilqevoFqiA0/ogysHr2bFkjD161UXj/HdC4cRK?=
 =?us-ascii?Q?2B2x+EJc03kByZYSTd9Fwt3Q/dad65xnba9Pcrz4qL4RS5cLSNIyy11/+Yxp?=
 =?us-ascii?Q?4iEzcUVbIPIUCmvxxWSX9fokCk6MwzmgmqofpuyOG5Pd77IiGQFvBEWf3XWu?=
 =?us-ascii?Q?+vM3uaqhcD5yLeTyDt12seh3ElQKYQBWe/HtI1TPQpwxxm/Ia7crOgi4JOto?=
 =?us-ascii?Q?N82I4o1TVKwjmYT+pFeuuKsKh6nntyThJ9H8mgOjwWCNgt0i4CgedxM3xUcS?=
 =?us-ascii?Q?lxnOD/LYFYdYvjmqpIim4raO71wq6r7AEd2CjQLzrb3j27p0wOw00E9UtDuh?=
 =?us-ascii?Q?4i6oYr3vlr0WwX8x5SM9yHGoU405J99QPfi6R6Y3vtg3bDMovA/a2bLeLeVD?=
 =?us-ascii?Q?9e8kBhEtYtV2KqnUxseH1u22tTJrEfShKpRWpYU+rJOrLZitLJwVqas3Ffdd?=
 =?us-ascii?Q?NfxKHAxgi8QWVenQ+ivfMDjvBgfvsB8WSqphK4cxuJZAw5Wn13A5pyX1J+1m?=
 =?us-ascii?Q?tQysDnMkEooSaM4kEfFuxNOW8Cwqke9dkKd1LeZQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1586e37c-32cf-449e-95d9-08da74f7e5cc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 02:28:49.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbTwy5wJWqcOHjH2ezG0VyHEAtKRNiqbhE4PUVawiNOVXp0TpCyVVi0MroYouIwmdC2dQ3Rd5TMzqXHGWdA+Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

encoder add support for contiguous formats NV12

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/venc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/media/platform/amphion/venc.c b/drivers/media/platform/amphion/venc.c
index 060a1ee78b17..3cbe8ce637e5 100644
--- a/drivers/media/platform/amphion/venc.c
+++ b/drivers/media/platform/amphion/venc.c
@@ -72,6 +72,14 @@ static const struct vpu_format venc_formats[] = {
 		.mem_planes = 2,
 		.comp_planes = 2,
 		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12,
+	},
+	{
+		.pixfmt = V4L2_PIX_FMT_NV12,
+		.mem_planes = 1,
+		.comp_planes = 2,
+		.type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
+		.sibling = V4L2_PIX_FMT_NV12M,
 	},
 	{
 		.pixfmt = V4L2_PIX_FMT_H264,
-- 
2.37.1

