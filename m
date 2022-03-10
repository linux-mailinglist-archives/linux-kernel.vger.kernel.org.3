Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3B4D4447
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbiCJKI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbiCJKIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:08:53 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DEE12609;
        Thu, 10 Mar 2022 02:07:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wl6EzDqVQGWsvomz2YF02pqAqVLHO4oBbw6LsU50HKzH7cLyxGTOSAuelTirW3A3cIGdeDZNPHX3D9F58u7MfN+DpCebyi09XG+suoW+se0SucLC6gSC6s+ot2wEGBx4me3i8Ixr3KtfVsXbRm2V/sO+GO4omafWBGdoUgJM6eJI7uNBMKzdqEzopydKbLHOoruKdICGYMvmcxcfSyoH/LbB3d5Dl+Zpoql373GcvWqMqemtZlaBF+xgbxquk1ZUZTzyLZuMrgoH5zcnfn0Y7/74Iz+GSGfw9BcMQV9K6cMpG79eMyicpl3P7FbzLvxH4uoGOtGYzqvlDVwjlZk2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVSYOdtcA7TmJ9SGDzUoTRPtxRlN6jgQ83xVhLMfPts=;
 b=XL655tsekXBUhf4OFkrTiyGyGKoNiZnaNK6Nhe9Zr1xCsTzIvzwUWSeBgopMngXanxRNUjpXSEq0PJJGMUMjX/YwVmtRdN+dnX16oef0cfYtlJQ38Z1tskXU7Pv17eXudyGDUH3dFa42utxve+EWEgL65D8Vh6416+3UhCctKUpVnlshEh7jUltjigqhvfxo46FoWki7NigZnJ4/JotB8Pyr5G/AXb24TeMgcuH4fqeepaU50pjtaiu4pgUNfy54B7W5EhWkLYwznCMlmUqbdgc4pwAtWfafsvnyO1C/ln3CkHdAkbdPSweHFatuBYxh5ypJT2pn7BP4YJDnAkr/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVSYOdtcA7TmJ9SGDzUoTRPtxRlN6jgQ83xVhLMfPts=;
 b=CRPn1BzvtstPGb69tLN2dmaUhSn05iEcnaG+9aMdUv8tieLFsKQ6SUnmWMDXt4qC3p2R7Wpue1FaRSag0tGDAuRg8azacBVD8PEgDNQusBEaJi2eSGyKYYolpPL/nD7nwOroemyfdhJmVrLOTjACMqaFIq2xqrexo9X3ob+N6tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB6PR0401MB2677.eurprd04.prod.outlook.com (2603:10a6:4:38::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Thu, 10 Mar
 2022 10:07:47 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 10:07:46 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix some issues to improve robust
Date:   Thu, 10 Mar 2022 18:07:31 +0800
Message-Id: <20220310100731.5417-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:194::21) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f6e3435-aac9-4b45-1820-08da027dd354
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2677:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2677FEF706BD0DAC1AB89F14E70B9@DB6PR0401MB2677.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tw/MDyn0plhEmKVaKy+5DWDeuIog+8lYICo3ajG1piWrFBjaspF8gSDdRGnUUhkBwkU90yyvqHF9QRZG/xf8cR7gxrJAbuB3zZTlGNGFJDK0WYLSW3G4Rl0i5TmImz2VmqiL6hB44OH6rmYsJL4SnbD25cKFldf5LGPgjRUqKMEH7abOoZ/vk8LbYM+yfgviXLtWPfm6QdMkt/IxRO8LTxYe+FxOsBmyBtC+utAHGtNyjRPnaMFcTMzMJQV5/GKfUUOHxVrF4pGidAZXfKXoCZVqBVD5RiouDtnjDy7KvuohR9G2NSiKUfvG2xo1gKJceHiVFukeZhxShvVmDsENLLHq1PJBmFUQDfIk1zxtforP6ox6IBhwdonLYY23ktC/UJrf6m7CWccuRNdLfFu7MJY7YZ+nmAiMuedJPrqyo/USa3ZVPa077smEQuIDx0lbcZe7GchzAM2irFG2+38btUAoEBpa3ewgj/6zPhIFTP/2QYVhVGBO5RoszBrqmZ8LRazWkKEUMlEQnbYTgRyaLzz/eq3iwBkFVOcShRzxDzsGq10xS+CR/oQrhwnzwp3CWrbPthDK1c7+2tonZXcd3SdyZFzHiDH44ytiMQZYRn+fBP938zWiA7xRGehDo2yvde3Fjy/a6PjklfSHqX1+WaQgpJYBXrvRI4ICAspDvFCZymKI71ON1ZaqJPe5CGYKXDo31ttK725awW6zj08OtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(8676002)(5660300002)(4326008)(86362001)(6666004)(66946007)(30864003)(316002)(7416002)(2906002)(38350700002)(8936002)(38100700002)(44832011)(1076003)(2616005)(36756003)(26005)(186003)(6512007)(6506007)(52116002)(508600001)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fSaaxKeBc8KeGN+2k7Xvz0sY/V40UbY9xzrND7hCeXAcWTMehmN3iY+j1Bkf?=
 =?us-ascii?Q?d2hkd4BtxGSFNd7NJZV1xt1EDWILeFm7j19xVfdbqmap3HjQnd6uZ8qWT0ZC?=
 =?us-ascii?Q?cguHluHXZwMePyT++z3BEqtNk2T4bVZ2LVc/fT4hhYZA0wY+RnwqCyHgIPBW?=
 =?us-ascii?Q?fSVj+yEnP6EHgDV2fyJ4BR23hXi3Z+f8+38Ty9+gysqugk/Kyx9kVT/sBPLB?=
 =?us-ascii?Q?EeOsk4/Bp6i7jD5oHqytSE7DmfjxSmVuq2PCz+LOrAC04bz+bXDTL3Nnu23G?=
 =?us-ascii?Q?50ibfgKExrByZOILJXV3v6OdrHI8jOdEB5RNdae7A2IIqvHyx5msia9M0Smt?=
 =?us-ascii?Q?fc7tqo0Ybx9G1zcWGZYWrNHG0O3UVuyp4ALL0LE8k2a/lYwvsGB2rQbEA1Fi?=
 =?us-ascii?Q?dSNJ1hfjCJTpmosLNJCbVA6GrmLvZ7VmsGi/GTBV93yFiYEEywnTDo93hVMw?=
 =?us-ascii?Q?RxJ1t0uXkl/qC4EW8GSkA83oz778KFB3N/MkiTI99FGTExnGQchqU2EktYbP?=
 =?us-ascii?Q?ovYxyTGaeo2EuemQfbcu5OLW+cx7rDOIY2efxTwpxtJZpmxvpOrbx3FODG+r?=
 =?us-ascii?Q?1klHAjjBccDwdxLXCkF/dUYdAyNQngLZVK3pQjrHhMnpSDSLXZ8xhcEigRiV?=
 =?us-ascii?Q?174SVtd0QjMo9WgDZQDZu8yO1yTW5zufczjgeP5B73mFy4jHBMOl7rAl1Qlx?=
 =?us-ascii?Q?4BVRx5RG7UZ+YwlLv8FIKEExRCzBGLM2VVsKciNKiafjJwuCveyEqpwLpMiP?=
 =?us-ascii?Q?GU7jDSQUHCTL8xB8XNJ23coZv2sx3heaYgO3X/dNf3GTDjwf8VD1WZ7XmhG1?=
 =?us-ascii?Q?VhA+HygeblqbclGT5vsG4iHey7jGPTX+hrh3ee8xS/B0mHeU6Ave4Hy0ZSyu?=
 =?us-ascii?Q?jN7JQySxALPox953YviCtpqAtIR6s4pPktnhFHR9Ql749k9coCya2SMC9L/t?=
 =?us-ascii?Q?D9ZnlFnRJc9hTbTkIZeQPN2UyXVYIXvp149BVkU/sgV1Em4vpF24sjeREflJ?=
 =?us-ascii?Q?0mgxYA6j4T28IJOuHbVNpLYcwFaIr7NovnX/WEgMXAL1fyRmgx78P4np2qTj?=
 =?us-ascii?Q?asaWxJf9JLXTjC4KUJcLk6M9Cu/Jk20xDUF6HTDuBH1kGSy+D+Ci2FDDz266?=
 =?us-ascii?Q?4TyrqUVDVK/TScUplOlpFPenNJtsleELeygnoZaBorjpBuywaY8BS27FgQpX?=
 =?us-ascii?Q?kTRNX6fJGvW0s4cZSgAiWhKvYyv7tRt+ij6aZV4fYNS6nY93C/JsriJiGzna?=
 =?us-ascii?Q?FO8uZKXn27wjhFxmacxk1fRFMxujR9tE9esWXx8cj26rYc4ulXzXic0bm6+l?=
 =?us-ascii?Q?XD1RvuglF+JnFXlZHvntU8z8ypTvzBTyA15/FBLEtSoJpCjkoBC9HRP5NsBM?=
 =?us-ascii?Q?on8w72o69N6ZTR2pxwvZyJi3364ZO5NshQZJ3+FZBwfRor3pl5OV3LwW3lRg?=
 =?us-ascii?Q?aPfKrFlq0l6ug/rUrTELr6+Uz6N55ZruvDqYsQy5iWgET68v9AQ0BB9ZpXEM?=
 =?us-ascii?Q?dmffkLhugCyxtxYW+Ay3hr1zcZbzY4qM74PunLNbzac6iCJkRDXsA8JM4eK3?=
 =?us-ascii?Q?FGUc9PHIn1bPalA5MfQnQyHUe8iTqo6QRFArbQXqAab/Xb+kA6DiCnFqRX4/?=
 =?us-ascii?Q?SHWPWS4TO7tYdKnblFl3pmw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6e3435-aac9-4b45-1820-08da027dd354
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 10:07:46.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77Q3qBfT9rPV+miK3rV4i3s3nzyuNe1n5jgZocJt5/E7pMc1NQoP3j4SbU776EH1CHN2zBJoLrNEs6dOY28yrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix some issues reported by Dan,
1. fix some signedness bug
2. don't use u32 as function return value
3. prevent a divide by zero bug
4. Just return zero on success, don't return a known parameter
5. check the validity of some variables
6. reset buffer state when return buffers

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/media/platform/amphion/vpu_core.c    |  2 +-
 drivers/media/platform/amphion/vpu_helpers.c | 13 +++--
 drivers/media/platform/amphion/vpu_helpers.h |  6 +-
 drivers/media/platform/amphion/vpu_imx8q.c   |  2 +-
 drivers/media/platform/amphion/vpu_imx8q.h   |  2 +-
 drivers/media/platform/amphion/vpu_malone.c  | 59 ++++++++++++--------
 drivers/media/platform/amphion/vpu_msgs.c    |  6 +-
 drivers/media/platform/amphion/vpu_rpc.c     |  4 +-
 drivers/media/platform/amphion/vpu_rpc.h     |  4 +-
 drivers/media/platform/amphion/vpu_v4l2.c    |  8 ++-
 drivers/media/platform/amphion/vpu_windsor.c |  6 ++
 11 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 968b578700e3..a5dcb4abf954 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -472,7 +472,7 @@ struct vpu_inst *vpu_core_find_instance(struct vpu_core *core, u32 index)
 	struct vpu_inst *tmp;
 
 	mutex_lock(&core->lock);
-	if (!test_bit(index, &core->instance_mask))
+	if (index >= core->supported_instance_count || !test_bit(index, &core->instance_mask))
 		goto exit;
 	list_for_each_entry(tmp, &core->instances, list) {
 		if (tmp->id == index) {
diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
index 768abf89e606..e9aeb3453dfc 100644
--- a/drivers/media/platform/amphion/vpu_helpers.c
+++ b/drivers/media/platform/amphion/vpu_helpers.c
@@ -197,7 +197,7 @@ u32 vpu_helper_get_plane_size(u32 fmt, u32 w, u32 h, int plane_no,
 	}
 }
 
-u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
 				       u32 *rptr, u32 size, void *dst)
 {
 	u32 offset;
@@ -227,10 +227,11 @@ u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
 	}
 
 	*rptr = vpu_helper_step_walk(stream_buffer, offset, size);
-	return size;
+
+	return 0;
 }
 
-u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
 				     u32 *wptr, u32 size, void *src)
 {
 	u32 offset;
@@ -260,10 +261,10 @@ u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
 
 	*wptr = vpu_helper_step_walk(stream_buffer, offset, size);
 
-	return size;
+	return 0;
 }
 
-u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
 				    u32 *wptr, u8 val, u32 size)
 {
 	u32 offset;
@@ -297,7 +298,7 @@ u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
 
 	*wptr = offset;
 
-	return size;
+	return 0;
 }
 
 u32 vpu_helper_get_free_space(struct vpu_inst *inst)
diff --git a/drivers/media/platform/amphion/vpu_helpers.h b/drivers/media/platform/amphion/vpu_helpers.h
index 130d1357c032..bc28350958be 100644
--- a/drivers/media/platform/amphion/vpu_helpers.h
+++ b/drivers/media/platform/amphion/vpu_helpers.h
@@ -19,11 +19,11 @@ u32 vpu_helper_valid_frame_width(struct vpu_inst *inst, u32 width);
 u32 vpu_helper_valid_frame_height(struct vpu_inst *inst, u32 height);
 u32 vpu_helper_get_plane_size(u32 fmt, u32 width, u32 height, int plane_no,
 			      u32 stride, u32 interlaced, u32 *pbl);
-u32 vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_copy_from_stream_buffer(struct vpu_buffer *stream_buffer,
 				       u32 *rptr, u32 size, void *dst);
-u32 vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_copy_to_stream_buffer(struct vpu_buffer *stream_buffer,
 				     u32 *wptr, u32 size, void *src);
-u32 vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
+int vpu_helper_memset_stream_buffer(struct vpu_buffer *stream_buffer,
 				    u32 *wptr, u8 val, u32 size);
 u32 vpu_helper_get_free_space(struct vpu_inst *inst);
 u32 vpu_helper_get_used_space(struct vpu_inst *inst);
diff --git a/drivers/media/platform/amphion/vpu_imx8q.c b/drivers/media/platform/amphion/vpu_imx8q.c
index 606cc53125f8..f14c2b8312a8 100644
--- a/drivers/media/platform/amphion/vpu_imx8q.c
+++ b/drivers/media/platform/amphion/vpu_imx8q.c
@@ -165,7 +165,7 @@ int vpu_imx8q_on_firmware_loaded(struct vpu_core *core)
 	return 0;
 }
 
-u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size)
+int vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size)
 {
 	const struct vpu_rpc_region_t imx8q_regions[] = {
 		{0x00000000, 0x08000000, VPU_CORE_MEMORY_CACHED},
diff --git a/drivers/media/platform/amphion/vpu_imx8q.h b/drivers/media/platform/amphion/vpu_imx8q.h
index d63a2747e29c..9deffd7dde42 100644
--- a/drivers/media/platform/amphion/vpu_imx8q.h
+++ b/drivers/media/platform/amphion/vpu_imx8q.h
@@ -108,7 +108,7 @@ int vpu_imx8q_set_system_cfg_common(struct vpu_rpc_system_config *config, u32 re
 int vpu_imx8q_boot_core(struct vpu_core *core);
 int vpu_imx8q_get_power_state(struct vpu_core *core);
 int vpu_imx8q_on_firmware_loaded(struct vpu_core *core);
-u32 vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size);
+int vpu_imx8q_check_memory_region(dma_addr_t base, dma_addr_t addr, u32 size);
 bool vpu_imx8q_check_codec(enum vpu_core_type type);
 bool vpu_imx8q_check_fmt(enum vpu_core_type type, u32 pixelfmt);
 
diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index d9cecbb42b2a..1212f7919957 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1006,8 +1006,8 @@ static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
 					u32 pixelformat, u32 scode_type)
 {
 	u32 wptr;
-	u32 size;
-	u32 total_size = 0;
+	int size;
+	int total_size = 0;
 	const struct malone_padding_scode *ps;
 	const u32 padding_size = 4096;
 	int ret;
@@ -1024,7 +1024,7 @@ static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
 
 	size = sizeof(ps->data);
 	ret = vpu_helper_copy_to_stream_buffer(stream_buffer, &wptr, size, (void *)ps->data);
-	if (ret < size)
+	if (ret < 0)
 		return -EINVAL;
 	total_size += size;
 
@@ -1234,12 +1234,15 @@ static int vpu_malone_insert_scode_seq(struct malone_scode_t *scode, u32 codec_i
 					       &scode->wptr,
 					       sizeof(hdr),
 					       hdr);
-	return ret;
+	if (ret < 0)
+		return ret;
+	return sizeof(hdr);
 }
 
 static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_id, u32 ext_size)
 {
 	u8 hdr[MALONE_PAYLOAD_HEADER_SIZE];
+	int ret;
 
 	set_payload_hdr(hdr,
 			SCODE_PICTURE,
@@ -1247,10 +1250,13 @@ static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_i
 			ext_size + vb2_get_plane_payload(scode->vb, 0),
 			scode->inst->out_format.width,
 			scode->inst->out_format.height);
-	return vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
-						&scode->wptr,
-						sizeof(hdr),
-						hdr);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+					       &scode->wptr,
+					       sizeof(hdr),
+					       hdr);
+	if (ret < 0)
+		return ret;
+	return sizeof(hdr);
 }
 
 static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
@@ -1258,6 +1264,7 @@ static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 	struct vb2_v4l2_buffer *vbuf;
 	u8 nal_hdr[MALONE_VC1_NAL_HEADER_LEN];
 	u32 *data = NULL;
+	int ret;
 
 	vbuf = to_vb2_v4l2_buffer(scode->vb);
 	data = vb2_plane_vaddr(scode->vb, 0);
@@ -1268,10 +1275,13 @@ static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 		return 0;
 
 	create_vc1_nal_pichdr(nal_hdr);
-	return vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
-						&scode->wptr,
-						sizeof(nal_hdr),
-						nal_hdr);
+	ret = vpu_helper_copy_to_stream_buffer(&scode->inst->stream_buffer,
+					       &scode->wptr,
+					       sizeof(nal_hdr),
+					       nal_hdr);
+	if (ret < 0)
+		return ret;
+	return sizeof(nal_hdr);
 }
 
 static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
@@ -1282,8 +1292,7 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 
 	scode->need_data = 0;
 
-	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE,
-					  sizeof(rcv_seqhdr));
+	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr));
 	if (ret < 0)
 		return ret;
 	size = ret;
@@ -1299,7 +1308,7 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(rcv_seqhdr);
 	return size;
 }
 
@@ -1322,7 +1331,7 @@ static int vpu_malone_insert_scode_vc1_l_pic(struct malone_scode_t *scode)
 					       rcv_pichdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(rcv_pichdr);
 	return size;
 }
 
@@ -1346,7 +1355,7 @@ static int vpu_malone_insert_scode_vp8_seq(struct malone_scode_t *scode)
 					       ivf_hdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(ivf_hdr);
 
 	return size;
 }
@@ -1369,7 +1378,7 @@ static int vpu_malone_insert_scode_vp8_pic(struct malone_scode_t *scode)
 					       ivf_hdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(ivf_hdr);
 
 	return size;
 }
@@ -1470,9 +1479,9 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 					       &wptr,
 					       vb2_get_plane_payload(vb, 0),
 					       vb2_plane_vaddr(vb, 0));
-	if (ret < vb2_get_plane_payload(vb, 0))
+	if (ret < 0)
 		return -ENOMEM;
-	size += ret;
+	size += vb2_get_plane_payload(vb, 0);
 
 	vpu_malone_update_wptr(str_buf, wptr);
 
@@ -1500,7 +1509,7 @@ static int vpu_malone_input_stream_data(struct vpu_malone_str_buffer __iomem *st
 					       &wptr,
 					       vb2_get_plane_payload(vb, 0),
 					       vb2_plane_vaddr(vb, 0));
-	if (ret < vb2_get_plane_payload(vb, 0))
+	if (ret < 0)
 		return -ENOMEM;
 
 	vpu_malone_update_wptr(str_buf, wptr);
@@ -1566,9 +1575,13 @@ static bool vpu_malone_check_ready(struct vpu_shared_addr *shared, u32 instance)
 	u32 size = desc->end - desc->start;
 	u32 rptr = desc->rptr;
 	u32 wptr = desc->wptr;
-	u32 used = (wptr + size - rptr) % size;
+	u32 used;
+
+	if (!size)
+		return true;
 
-	if (!size || used < (size >> 1))
+	used = (wptr + size - rptr) % size;
+	if (used < (size >> 1))
 		return true;
 
 	return false;
diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
index 68df43913904..58502c51ddb3 100644
--- a/drivers/media/platform/amphion/vpu_msgs.c
+++ b/drivers/media/platform/amphion/vpu_msgs.c
@@ -214,7 +214,7 @@ static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *m
 
 static bool vpu_inst_receive_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	u32 bytes = sizeof(struct vpu_rpc_event_header);
+	unsigned long bytes = sizeof(struct vpu_rpc_event_header);
 	u32 ret;
 
 	memset(pkt, 0, sizeof(*pkt));
@@ -246,7 +246,7 @@ void vpu_inst_run_work(struct work_struct *work)
 
 static void vpu_inst_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
 {
-	u32 bytes;
+	unsigned long bytes;
 	u32 id = pkt->hdr.id;
 	int ret;
 
@@ -337,7 +337,7 @@ void vpu_msg_delayed_work(struct work_struct *work)
 {
 	struct vpu_core *core;
 	struct delayed_work *dwork;
-	u32 bytes = sizeof(bytes);
+	unsigned long bytes = sizeof(u32);
 	u32 i;
 
 	if (!work)
diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/amphion/vpu_rpc.c
index 6e01abaa5d16..18a164766409 100644
--- a/drivers/media/platform/amphion/vpu_rpc.c
+++ b/drivers/media/platform/amphion/vpu_rpc.c
@@ -20,7 +20,7 @@
 #include "vpu_windsor.h"
 #include "vpu_malone.h"
 
-u32 vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size)
+int vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size)
 {
 	struct vpu_iface_ops *ops = vpu_core_get_iface(core);
 
@@ -63,6 +63,8 @@ static int vpu_rpc_send_cmd_buf(struct vpu_shared_addr *shared, struct vpu_rpc_e
 	u32 wptr;
 	u32 i;
 
+	if (cmd->hdr.num > 0xff || cmd->hdr.num >= ARRAY_SIZE(cmd->data))
+		return -EINVAL;
 	desc = shared->cmd_desc;
 	space = vpu_rpc_check_buffer_space(desc, true);
 	if (space < (((cmd->hdr.num + 1) << 2) + 16))
diff --git a/drivers/media/platform/amphion/vpu_rpc.h b/drivers/media/platform/amphion/vpu_rpc.h
index c764ff52d026..5ea4f8aff846 100644
--- a/drivers/media/platform/amphion/vpu_rpc.h
+++ b/drivers/media/platform/amphion/vpu_rpc.h
@@ -43,7 +43,7 @@ struct vpu_iface_ops {
 	bool (*check_codec)(enum vpu_core_type type);
 	bool (*check_fmt)(enum vpu_core_type type, u32 pixelfmt);
 	u32 (*get_data_size)(void);
-	u32 (*check_memory_region)(dma_addr_t base, dma_addr_t addr, u32 size);
+	int (*check_memory_region)(dma_addr_t base, dma_addr_t addr, u32 size);
 	int (*boot_core)(struct vpu_core *core);
 	int (*shutdown_core)(struct vpu_core *core);
 	int (*restore_core)(struct vpu_core *core);
@@ -113,7 +113,7 @@ struct vpu_rpc_region_t {
 
 struct vpu_iface_ops *vpu_core_get_iface(struct vpu_core *core);
 struct vpu_iface_ops *vpu_inst_get_iface(struct vpu_inst *inst);
-u32 vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size);
+int vpu_iface_check_memory_region(struct vpu_core *core, dma_addr_t addr, u32 size);
 
 static inline bool vpu_iface_check_codec(struct vpu_core *core)
 {
diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
index 6fe077a685e8..9c0704cd5766 100644
--- a/drivers/media/platform/amphion/vpu_v4l2.c
+++ b/drivers/media/platform/amphion/vpu_v4l2.c
@@ -403,11 +403,15 @@ void vpu_vb2_buffers_return(struct vpu_inst *inst, unsigned int type, enum vb2_b
 	struct vb2_v4l2_buffer *buf;
 
 	if (V4L2_TYPE_IS_OUTPUT(type)) {
-		while ((buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx)))
+		while ((buf = v4l2_m2m_src_buf_remove(inst->fh.m2m_ctx))) {
+			vpu_set_buffer_state(buf, VPU_BUF_STATE_IDLE);
 			v4l2_m2m_buf_done(buf, state);
+		}
 	} else {
-		while ((buf = v4l2_m2m_dst_buf_remove(inst->fh.m2m_ctx)))
+		while ((buf = v4l2_m2m_dst_buf_remove(inst->fh.m2m_ctx))) {
+			vpu_set_buffer_state(buf, VPU_BUF_STATE_IDLE);
 			v4l2_m2m_buf_done(buf, state);
+		}
 	}
 }
 
diff --git a/drivers/media/platform/amphion/vpu_windsor.c b/drivers/media/platform/amphion/vpu_windsor.c
index a056ad624e9b..1526af2ef9da 100644
--- a/drivers/media/platform/amphion/vpu_windsor.c
+++ b/drivers/media/platform/amphion/vpu_windsor.c
@@ -818,12 +818,18 @@ int vpu_windsor_config_memory_resource(struct vpu_shared_addr *shared,
 
 	switch (type) {
 	case MEM_RES_ENC:
+		if (index >= ARRAY_SIZE(pool->enc_frames))
+			return -EINVAL;
 		res = &pool->enc_frames[index];
 		break;
 	case MEM_RES_REF:
+		if (index >= ARRAY_SIZE(pool->ref_frames))
+			return -EINVAL;
 		res = &pool->ref_frames[index];
 		break;
 	case MEM_RES_ACT:
+		if (index)
+			return -EINVAL;
 		res = &pool->act_frame;
 		break;
 	default:
-- 
2.33.0

