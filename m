Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785F5562B10
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 07:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiGAFuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 01:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiGAFuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 01:50:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2082.outbound.protection.outlook.com [40.107.104.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417B36B275;
        Thu, 30 Jun 2022 22:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRqQhYd9bOMdgDwUfgW5DsCOY5xpuoxu7NhjwIX3vZ8SqfqLvny61nZeZ3CBArRJwGauFI7/Ln04KfJLrHcmK3Te429yXGh6iMnz1L87Jr7jPko/UgjyUDf+S7r9yKqdEpy/D1gzY+PT7xVlwu+etYDcEp1f0oc2LC2sdgJ82p0RL2JBw1OYdHIrIuwV3iOE8pdhnAHnCdQeVbsGTmLUta5CIDRt37iju/6U0VX54oE4gXskQyCjrAxY97ifO2QIiMuCkjLNBZPhi+fuHEATuLpvNR9M2pahrtWNrwoTwRyYa1ZBEV8Kb39wmFYyMrw1OvQeFfFEEiiVYWq4oFJzJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA+HADzhEF6Fn8ezA15bycJ1Aza1BkJccOuGlbMkEaY=;
 b=kjtNI8cugAJZU2BOvnzXW+0Ecv6qjLujFJmxMLhC+siuoNm4SUTB0KHHpr2CQGlDtbw4durgNPC1mFTLAorWnTIWdlmc7rd+EKqlVmbHTeV/XdO9Kc6oGEJBrMcgNtMT+WuyTYQBxyC4Dcd1NZAajUd3toK7oxM6fdgaGv40Go5P0sorIqsMFUvvGzEJLF/5/BQtJ6sbDEwyTx9vXbm24L6USyByeP9RXiNHAj83H67tbaCAQs0LKYL6jGS3QYCp9eGWblqkfle6q8ECV8Fk7dPx9AKieSlCnPvruGv0/tCMAM551RRtdhbeO2iunIygKdBj2faBKGWZRewwCRA+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA+HADzhEF6Fn8ezA15bycJ1Aza1BkJccOuGlbMkEaY=;
 b=o9M0UaxyDMaDOk8PPeXsSNMKGZRWKyg1ZTXKW1RvzZLwzUZfouDAviFGJpeid6AtccILO9wuYV5Wf3DsACxl667+Z8aFjUoWVM1Wt0l4kGUko+7PmeYh30WkBoWDoL669Ju7pPc0SkOBUGis2sC3PwQ5uRJKBhd0gr71uFmAOuU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM0PR04MB5521.eurprd04.prod.outlook.com (2603:10a6:208:111::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 05:50:20 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::3582:eb2f:9652:d98b%5]) with mapi id 15.20.5395.016; Fri, 1 Jul 2022
 05:50:20 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: sync buffer status with firmware during abort
Date:   Fri,  1 Jul 2022 13:50:04 +0800
Message-Id: <20220701055004.20821-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810cb3f6-11db-4ae2-6b11-08da5b259574
X-MS-TrafficTypeDiagnostic: AM0PR04MB5521:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c4OgPrdNUPyNMXMMDFYsc5D3PECH5v+3yuQkJIFpy0BAZnd1f8U2qThbfohUnCkGqqGmFamWva2b8lGD132G9NQfUMAW9q6SHofUgaDtOfLX8ADaNp4444kyw5Rptvtq34cB4Yi3sS2q/uQIk4v3XX2LzKUmI1nvsRe+85cnKSWzWWtCkTjW0VmnXUewbPrvUPucbx1YZaamvPGeC+x2A44rKWfQu9qJTE1/1AJxCx9Pcj35kYnt0TCPXzBH0LyXzcspf3wlQcymGzCg5/yGXQpRXxaeiutdGH9/37Z7WTBSBYFP3zm6F91CXZZyhLhWJO63rdVNh/ncHblRbUf94UYWXmb+OnJM6M8Q3dm9CYUsBfsm/75ThMB/pR/0OJj7DCBR5JiwHB7u9Pr33KnlCnYd+CdEMFXka3S/a3FpcPhqSYPkXKvjytJyzyXnyr2g7sWdmqlHHu+pGx/+ASRrlpilagXe8ndGLkwrGU6gb7sxbtFtWptekVaXPI1ibGGNnv3Y6y+1HbdjCQRLBH/JNUpni8yEt0tAEZ9Uz5sX1b802YNuUCR79ZOXNDyq4x/6PWgbwVgQfmTEQ126NiIAQVnu8KwwlQvIVvVUfvqZXbQCex8nbamKZwRTAjsdzAV8ch3ecdBRMERmDKw7St41RVt1VQ0iscUDVP8dwSlHKiu9ojkNx5bTfHXsFjMA85G/tisZP+oGcKCo+GztEReeJy5OJLkrnSlFCSIP7b6pbO/39xb7uDb9DKEv8pUNGAyRRAZLmnfxrwfk4wDir8KHw34qh975xNRyehMKpC4NreNNgweWa7jN0z+elkDzy2UZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(36756003)(66556008)(5660300002)(44832011)(8676002)(66946007)(316002)(4326008)(6486002)(8936002)(2906002)(7416002)(66476007)(478600001)(2616005)(186003)(1076003)(41300700001)(52116002)(38350700002)(38100700002)(6506007)(6512007)(26005)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mD0Up64EL3Y/c69U61sJhLwFZVuRMClKuJM+MLyoGMs7yJonXKatDbzV56HB?=
 =?us-ascii?Q?YYhQAoXglw2Gc+NyKztFiTnAjPP48WD3KBfOoqaGtoG+iTtDwYPQBf/9R2Rr?=
 =?us-ascii?Q?EpkTFjYeooMtySvTxf/MdL3vXu9/r7yRqCFa5bOdF8xYryQ0U3+tPcG5nwBh?=
 =?us-ascii?Q?R51aEIot+H2RAbzN3K2LxOfAAwp9CFKMI9YFSc+kBYZ3UyKCYoz5f03bUGIf?=
 =?us-ascii?Q?xps+I0LvvU6sBeS3jr5LM/Xu2X4Ow67JcHn9Viy9+tnfJk0poC8jeirPn+ZQ?=
 =?us-ascii?Q?0m4ScKYL20D1SiWMEsrgZGOpUTU9KhCrU4GSb93ISRo7CyALh0vWzgzfn/tw?=
 =?us-ascii?Q?95kQIKahQujPfHot5xO3L9vahYeK/PfYeSFRJ9aUwPhuXylXrJoRzMKO7kX+?=
 =?us-ascii?Q?luYIbEElIHJ7geOqcaWb8eQKEBYpKh2nOMg7RTDnXu3ix+vjp/muqBFCJiSY?=
 =?us-ascii?Q?sqbibyhZwMvTIgf6x5J1n7OOqBAMVLgMlZkKudboijubukZ6i23z/A2L3UTF?=
 =?us-ascii?Q?PsyMbEBMY72XYDX0dUvEHCPvyGDYpVZVRIPcdU+iYohMaXdfe5xSVYelyy6w?=
 =?us-ascii?Q?tLxZOKM0JCddYVvRpIpkI/d270afbnSLLtnfpTqiin2vn1poR41OwjIiv7Qd?=
 =?us-ascii?Q?ak9fsNza25aRVBlFyXwVRxF5dx1opUGzUA3/LK+MP5y9XZCISOLBcE0AIRZL?=
 =?us-ascii?Q?iV1lSyR88Jlb1q/t+7WHmYCRcikpvVimXyZj70AUuK8qZvK6D1002DPguWhV?=
 =?us-ascii?Q?GuGVk85U+RPY1jmnrLedfkD6VMHWAaoiWe5MkiJkpaR6Xk+SFTGHbjqOJzKX?=
 =?us-ascii?Q?Oo6NS70dFCm7E80+PdHPfTLFSbZU2QS/NE9MZ0qw9H2VlCmjSXSV91r4Xez6?=
 =?us-ascii?Q?3BpVfWLZmqFOwbcd2iG5vRmZxVSimWwTgRLj5aosFBoOLH2V2OqAwVvlEqV3?=
 =?us-ascii?Q?L0DCSwzZJnSfPaSSDzvnk96pnSpzfAWqVi1L0f8Oc12hPSue97AUF3PEFk1W?=
 =?us-ascii?Q?U1eaWUS4iQC3TxkxiLfDBrbv0Yo64c3Cx7Y2ozSF8tZAra99m5cEFO8MU9UG?=
 =?us-ascii?Q?QLsCaz3+GY4H4eg2WzRPc7M8fyol09z0VQqXDED9JellsQLICUwFkmQeRV2u?=
 =?us-ascii?Q?f5gZ96k7pPRu8CGkM5qshPpCkILXTRpWFJ3Wy1HmdC/isMhgALxwNwsW4MLl?=
 =?us-ascii?Q?fom1yw6eWNINXzf6KwfRMROjqRTYIK7IhJV4SJsAQzWBfstm5za1SWhO9yKB?=
 =?us-ascii?Q?3sKrFeQp+447FzxBiduGXOAkCMhmOhpisNYlZu08HmthDGhszTzU9RXWWwEk?=
 =?us-ascii?Q?dl8lxRJYardFGJia6k6cTK0ib1f4qwlIULCKQwxJoN/X7SFZMppQOgt6CP69?=
 =?us-ascii?Q?7XEZmKcyN/2kur3c4Ngzf1f9NwxRirSbvHirZgYHFYpI/6mwCjQHgvCshHVX?=
 =?us-ascii?Q?iMlPivBgcRmmukHIHoQyIGW5TQoWJI2d/3b5eB4sYsXw8xxOnGWp5KN4Yc72?=
 =?us-ascii?Q?86ZRIsueWHF0Yc+E0Tf7c1lAVeLFWE8lyd9f3wynGR0xsPkfKfGkNif5ILHU?=
 =?us-ascii?Q?ibNfs61qA12X4IOai4nb8QmYFcXn4KOmM93cAEAZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810cb3f6-11db-4ae2-6b11-08da5b259574
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 05:50:20.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MJDluRbkYHzX2bageSp5G5Cg3U23PK19dUW3gkWucp+hikcf/NNmDseSY7MHIlcVEVRSxvf+QUT0xAoeKoD+0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5521
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. prevent to allocate buffer to firmware during abort
2. release buffer when clear the slots

Fixes: 6de8d628df6ef ("media: amphion: add v4l2 m2m vpu decoder stateful driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vdec.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platform/amphion/vdec.c
index 77a3a5c823f9..9e64041cc1c1 100644
--- a/drivers/media/platform/amphion/vdec.c
+++ b/drivers/media/platform/amphion/vdec.c
@@ -63,6 +63,7 @@ struct vdec_t {
 	bool is_source_changed;
 	u32 source_change;
 	u32 drain;
+	bool aborting;
 };
 
 static const struct vpu_format vdec_formats[] = {
@@ -948,6 +949,9 @@ static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_buffer *vb
 	if (inst->state != VPU_CODEC_STATE_ACTIVE)
 		return -EINVAL;
 
+	if (vdec->aborting)
+		return -EINVAL;
+
 	if (!vdec->req_frame_count)
 		return -EINVAL;
 
@@ -1057,6 +1061,8 @@ static void vdec_clear_slots(struct vpu_inst *inst)
 		vpu_buf = vdec->slots[i];
 		vbuf = &vpu_buf->m2m_buf.vb;
 
+		vpu_trace(inst->dev, "clear slot %d\n", i);
+		vdec_response_fs_release(inst, i, vpu_buf->tag);
 		vdec_recycle_buffer(inst, vbuf);
 		vdec->slots[i]->state = VPU_BUF_STATE_IDLE;
 		vdec->slots[i] = NULL;
@@ -1318,6 +1324,8 @@ static void vdec_abort(struct vpu_inst *inst)
 	int ret;
 
 	vpu_trace(inst->dev, "[%d] state = %d\n", inst->id, inst->state);
+
+	vdec->aborting = true;
 	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
 	vdec->params.end_flag = 1;
 	vpu_iface_set_decode_params(inst, &vdec->params, 1);
@@ -1341,6 +1349,7 @@ static void vdec_abort(struct vpu_inst *inst)
 	vdec->decoded_frame_count = 0;
 	vdec->display_frame_count = 0;
 	vdec->sequence = 0;
+	vdec->aborting = false;
 }
 
 static void vdec_stop(struct vpu_inst *inst, bool free)
-- 
2.36.1

