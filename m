Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B725A4252
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 07:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiH2Fdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 01:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiH2Fdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:33:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C833E45076;
        Sun, 28 Aug 2022 22:33:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFIceoG3OqDlcpcXC3sxkrxrwmrdd8MxCFC+DtqOZ93lidDUNWhN8LgMSiUP8FbuTWoQKabpmiHeGCUy4yHZv/6dRe034MHMVPmMV9VtCdi1zuqR01Rr+Lf/oFJD3jx1WcLnDh74BlBAPQkS5Td7OeVdI0HACN2BXqFVlfGj0QiT2a9A/NO8aoA5xtrIOxTQipK+hw+P+myxMgN3FtawO0T7rlyOwgYumxC4fGJglEdqrnbpD8rUeRXAtQymt1zHF4JEp0yuKwiHtfjnwxQUJqnLi9l7tpTZbPUzeQriV/I/sTgh9/7rao0Nuf7uVsBhCscc9RmVS664KkVpojqhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgUExjkV93fgAbDHLNb7ZzE2Ps7MMzWd/UXjJBP9w2k=;
 b=jgE6BOkhfM68D3W19Ii7X12DNTx5mzk91OfZcsVmPJM97aAAA7S5FJ+RsQZtA6bAEnaN8U9XELIlcGz07qfLMZVZ7RIvOcpKQ2M1AEQKIrThLwDroV62bodb7hYftej9qeNWvFfrMcy4SS7ZK0X/AJqk3gavhIsuwNgYWoeNwZ/NN/zuTOaCNFVY5Be5udWSDCoWwTzsFdNE7Fap3IORG3c9VLBymJLA2A7iVuJNG+ASvv317UnjdV/g823BX5OcnAgRBh5jdCTtTZe1llihVPkNYTOFrrpuCFbKllWy22WM3Gpd3IhOvvrTI9eRdikd5pTrdxuM2FieQOYK48Fn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgUExjkV93fgAbDHLNb7ZzE2Ps7MMzWd/UXjJBP9w2k=;
 b=JKAWJi6ITdlXs3eLDhTrHPI/ZrmgLpp++C9KTTB1zZ9ROlpfW/Wkwr6XDzz0DHdFIg2av4EpvgCSPEOr9BZ6RoaV+XoL7VNAJHHCGr0yjZlvLYDab496gcBEt8Sp/H1V+thl2HCMADLFr33nFQLgV45l+QSp5R01Sn4z6wfwmZM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB9PR04MB9452.eurprd04.prod.outlook.com (2603:10a6:10:367::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 05:33:31 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cd23:6d52:9925:4f38]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::cd23:6d52:9925:4f38%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 05:33:30 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: release m2m ctx when releasing vpu instance
Date:   Mon, 29 Aug 2022 13:33:16 +0800
Message-Id: <20220829053316.19400-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fdd24a0-1855-43b5-15bd-08da898001d8
X-MS-TrafficTypeDiagnostic: DB9PR04MB9452:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/k5UbHcg/rxN2nAaR3c6a/Gfnj4zoXrrudOVTB4yWwBDPrBNDQNdcVN4EUV150vQ8tr72LCSDEH7KHwqDUVGyLdiki4YjI5nA0xr6QDZU31w71AZN8dqUDt6vsjv3qlro5U706UW1TcNg1khRDzbPPj0RmjEcU6+9Whc9lDFE7wI54EFYlGucF3oJy2X2IQA+lG9gPXL2LSdZVa+b9R0PjM+wRVKLDmmUTyq/uo/Cg6hQMi93+70CGvwDA2GDg3B5VTlqmsFxll8xskVS5LT0AjgtU8iOs3k2X/6dyJdJuALXhFdTvjp6wCFOWN3gcnvnIkVvt7ohzEugJMgaJxO0fXg6CiYFXsAwz9lpqT/x9dWA5LUu4zBeo+WIXqQVHkZpimhMUjT5YFSpPlksmJUmI6g8kOpkSptpNNvBkin4aA5rp6cInl5ritcbz40gmXEK6QX7X8wx/DqPza+3gpMMvt8H2KwTnrwHJ+xTujmOtECnuVKvhKD+/MuGC9lQV0eGbsuu0xKo8OAVyDzQwEQB+twrIf8WguKtecgKw0tBR3XaHcJnjftqqqhjj9TuMNEaxPR3+2F/52D0MC+Td9Qg2x3iLaXnF7vHZMRi6NcBwGpFtxAY9Cj1EmVtEyOoiVbjXY8832QoWbWLaqGaj56BdTb4+Lxtj0csohyGR8ZXNvMwWAODKe0lBQ6NaCvBa3Q3aId/sVN28LuwNRu8BU7VE6aO1Xt4tWd1RxCCHdpCiqMpmujA2L4RPwV29T99S3NT8DeWJDPRrY1ggmhP7Y8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(2906002)(4326008)(7416002)(66946007)(8676002)(66476007)(66556008)(8936002)(6666004)(6506007)(6512007)(478600001)(316002)(26005)(41300700001)(6486002)(52116002)(86362001)(38350700002)(186003)(1076003)(2616005)(83380400001)(5660300002)(36756003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGCN6n5rqAYqUApIX1l0jroWX3uyDHo93yhQWx6UIy6jxjmU7o3/eL5BnM/k?=
 =?us-ascii?Q?b2roLWC3ylCCyA7JilkV1iMr3/CMsh5Ut/4hf68JrS/El/z1iJ8juAO1uTWW?=
 =?us-ascii?Q?d9/Gx3/GTJm8Dv/5uwsmCoqWxY04qNghLdZnXFM6Jj0eTDtCDfogS125jSnF?=
 =?us-ascii?Q?YxUpGtop6i+TiXqBlblSVfog8U8kgkHzsedHI+bsRgS61AuxgKVK72pTkdgx?=
 =?us-ascii?Q?K/SyLb+DQEvNcfL6PmZWh/6d6oX+xGdjngLCGCxRMnqCwJJV5emSaxhjvzi0?=
 =?us-ascii?Q?RUj3a8wbSVbwodNIxb1hmVxetFo0SwQnt1S9+n+cIgVAzQtuIZgdW7Zr4/nK?=
 =?us-ascii?Q?D3HELWK2a5OeLCFntg+J5kwbD0swW0P7L6Da17FKNhR7pNeoWq84oiDwo/LX?=
 =?us-ascii?Q?FqB/ZH9s1d89tEjNMNYK0TU/3b2GiG17yaYYnF46qHcnE/kcukg1zDFngdE/?=
 =?us-ascii?Q?LJTqjlJ7GT5pG9DucplWKwsEnUpw8BBV80qnX3cuaKF/nUurZwYPgmgxkVM8?=
 =?us-ascii?Q?1myIIPU6RM4ex2MU1zVq5M4IoJkucQqvNPwhrg5PpdO16j0p7Q6lvWK34R9X?=
 =?us-ascii?Q?mPDhKP+G4dZp5Us/LYBUe4LXVeqCn6OCmQX0NcdEe3tt9QcBQpM71X3qz2Fv?=
 =?us-ascii?Q?5/aRRV6T0YMC+dFO45R8XE6vJ3UuvYCwtdjukPRVPipnmm6QoherxnGUYzRT?=
 =?us-ascii?Q?S31qIqq2pFPSvS0OPwddpc0SMEo1NtGVyCcab6Bjn+/5RN05cLfcrg3HMYLu?=
 =?us-ascii?Q?mJL5gasN4iROR/3v89HyXHDtCi88lBPyGOVNSiOcnDFt3el+6izKrC99ZAYM?=
 =?us-ascii?Q?05fs2Yu8L/b5wxsMzUODj9zOCSFVq0RuQVZDCRd2G/ITp6yM63OppaJvIztO?=
 =?us-ascii?Q?g5SsCoDYmOWUQz7AUAZ+P1dCbBnVADGI2V8fVK/yYuRRlbV1XaDGo0th6BMR?=
 =?us-ascii?Q?R3GZbJ4Qrfp2WGo/gzgq6GpCgcnen0kfAlNTDxWJnOnDQpsOWeVV5i3wEuzo?=
 =?us-ascii?Q?C4sLk4P0QLdykro8J/bKr6T4Gs/Ecw3OIZNDn5VPSL192++5OG+5dYIzpxNy?=
 =?us-ascii?Q?HEFKD1fLkpqb2VYW0NcE0TpXbhvMDpjyiNiTICKZn82UAqYOrtp+lp1DInom?=
 =?us-ascii?Q?yunsKQwdi53+pFkJLfDhulBX0O+CE7zLDgPOoxdkiDfYBA53qmTM99PwiFue?=
 =?us-ascii?Q?PjRfF+AxCBCBB54F6gN4oiurf1n9vl32fpnPk406wDkwQ+rJe3E8EMyBfV4G?=
 =?us-ascii?Q?ek4h+ED8ScylgsVR+3hguxLVGPB2X551/SD/lnlAlIna/mgPh36BYBaEid0C?=
 =?us-ascii?Q?4+rZ2C9TW6jXs1TL1S+1bo1EEN3nYuDMsr56lWt/5HT8XYssDdsO4z5dKZoM?=
 =?us-ascii?Q?Rzz1QzTkDlJoFcIH3Pxu16CiebGdph+vFWYER6ymY+BQ223iLkBUTrDWds8B?=
 =?us-ascii?Q?xfOno8tM3cw6MSI8DhJ4ccNAbzQ+iyUDy1jkE/XYxHiC1mupB7G+DrsVJ8cS?=
 =?us-ascii?Q?8gj7ghFUQctWgoDcaJvev3SoYt7G+cyjDUAOoYnKtNsKVBZuz4boMFttSt2G?=
 =?us-ascii?Q?SFzoyWFU/gvfs8BCbLxTDgAdhZeHg5SzhC/K3lVw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fdd24a0-1855-43b5-15bd-08da898001d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 05:33:30.9072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS9FZEuBQQ4vf7hsG6hftQ4ly1B7glRX1O49mg9MFOrUeSUth/eUlcitXKmiDAxFWC1PPjanOHYcF5+BgPuHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

release m2m ctx in the callback function that
release the vpu instance, then there is no need
to add lock around releasing m2m ctx.

Fixes: 3cd084519c6f ("media: amphion: add vpu v4l2 m2m support")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_v4l2.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 1f18289aa47a..99ad2f1c5a53 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -688,6 +688,10 @@ static int vpu_v4l2_release(struct vpu_inst *inst)
 		inst->workqueue = NULL;
 	}
 
+	if (inst->fh.m2m_ctx) {
+		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
+		inst->fh.m2m_ctx = NULL;
+	}
 	v4l2_ctrl_handler_free(&inst->ctrl_handler);
 	mutex_destroy(&inst->lock);
 	v4l2_fh_del(&inst->fh);
@@ -770,13 +774,6 @@ int vpu_v4l2_close(struct file *file)
 
 	vpu_trace(vpu->dev, "tgid = %d, pid = %d, inst = %p\n", inst->tgid, inst->pid, inst);
 
-	vpu_inst_lock(inst);
-	if (inst->fh.m2m_ctx) {
-		v4l2_m2m_ctx_release(inst->fh.m2m_ctx);
-		inst->fh.m2m_ctx = NULL;
-	}
-	vpu_inst_unlock(inst);
-
 	call_void_vop(inst, release);
 	vpu_inst_unregister(inst);
 	vpu_inst_put(inst);
-- 
2.37.1

