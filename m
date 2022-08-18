Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFE6597C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243093AbiHRDTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243087AbiHRDSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:18:55 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0818E2FFC8;
        Wed, 17 Aug 2022 20:18:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcHTfTe1rhCbbW68+ez5IJgu2WuFdpk6IkU5ZXsDorpQ9lnlS1c+3CgPS9JFCwyGkJMj2Vmtbd4RHXBIIVG71znslZ2Dfn9iUKJTnx0sItKCMcM+TD+rVhQrQdv0bKwNpMBgC/LM9BN4Pm9skPaopKkT2k4oohWk1+QWdisOR6rT1dON34M77xPn+9JUPMNYmBj3JIgFA5vVFZJIV56NEEO1EzoyzZJJkw1dp48rW7VpIb0H9i3JPC/LbW8AgemjZVbXofVEdMY0e9C3NFcv5AqwWQ6dYLUgYmungStm0JwgIskkopcqYdnAC7IcN8P/6ToS0Qo6q9toDJtUayHpZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewQjS/DhcBE7G6TH4SAkyNBQenLTqJe8Mr7LVdUkFu4=;
 b=HZMrv4hRKUXpSLic6dvSjmV0AGQw+j2oHDzRl/F1g0d10jbBIZxn40v/PFwfPDfWAXqUVGMXA1QyhGCV8+jgQju+nnVBi0TQvR/bqZ+Z2g1SCeHNU6svRAxgsq+cS6bL//oL5rtq0Dw5V/zFQerg/axZdXCdmATgTXSALdmtwLT7mI0q8PkG1xUe/n08kdMd95DXn+tlz51BQIP9XQBKThYQaNLOMoFlrdmH0CE3Lb9D5YZ2KuGzwdv7kC5QagUN84cDPztL2Id8yl6YcVrySWOS0zgi2HVmII1VKfp5EebI4Vkvqp8VfCbIdwhDMVLYdMy3/9iXx4/hJxt9XQ3Yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewQjS/DhcBE7G6TH4SAkyNBQenLTqJe8Mr7LVdUkFu4=;
 b=S4LadglSx1YUWlYIYtl6w/gHUkTpzEij3CeCACtRfTqbHAyDCpbCgk5Ks2jzR+kgKAyi/LO3BvL0yCAG5UAdaQzUcdvZjWok40sV/TWx6iZeFtBV0IBZ7qXYAq6oE8YOE4gEKROJUaAa1mkJ3tmBChyaiMbxAOcPilcX5TOqHc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM6PR04MB4375.eurprd04.prod.outlook.com (2603:10a6:20b:20::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 03:18:50 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.027; Thu, 18 Aug 2022
 03:18:49 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: fix a bug that vpu core may not resume after suspend
Date:   Thu, 18 Aug 2022 11:18:21 +0800
Message-Id: <20220818031821.18802-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096::24) To
 AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31407ef5-8796-41b0-90b4-08da80c85ea3
X-MS-TrafficTypeDiagnostic: AM6PR04MB4375:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aJDJgPLGhBuMxmAmSjSXik58dwFty+rYqLXfjovrTdm+S6w8I6e1yoOQX3TCywdY+pmyAlpIYo6Hto/IbJ/51YEChk2NjMPL4cxageMpVio+JZU08mAHy0oGVFhlzUb207uJV/OEx0Bk0Xalsy6ucc9tI4qkIXCBHMWPNvcuUU1PFTJnor7eOqlmNyCJefftmdKP2DDIsILy+cVoQnyAXLmR2nd+iE8XoY48I0iM0q0Ygsw2yp3r9bS1FaO1SIdqF9wJoFOyNViqE11SJOlKsR1xLRyV8sXYMeLO2SSNgIEeqjRm8WY79NCogGJQakL+XnHTtXeJvvnPsIoxwxe5bGcsXoZX8EoCTzhiz/g8F3lamIRL+N6ADDHBE76vp6O/uYAxveX736JgeNNzvskns4Fv7ui1TeBpSd5Nqp7Sjimd5zQ4osIsxW7uBCi7H5zGtTttBdYuMnwnxkyGWiJogH8FZIw95VZMB3GaaY4Q7RtJazhtG5rmq4EtcoYcstHE0vu1FTEzWtBiokRcB6LDef8YAVZO7qUxasNNWU/ZGPN/LnnkFI6Cg2rvKVB69QhYNflFDQwSh1aFOBm/RkVTGbeRbY0sL9rGQ0rkJoOVqzB4YeNUZdpeUb8vygszKFUi3MVORddc/PWPw2eaeg373Wm6jMjB5PATFpIKW1eKOomEUW1QPHoPZaFXRFjstJZMHFYy1DIQSq36HGWsDuX3IQvonDLKNXptqy2MSh0MerFE1R5iDsofPCa8D+XMcaUSC/WRRZcZisUZ1zTpyZGuvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(26005)(478600001)(186003)(52116002)(8676002)(6486002)(6506007)(41300700001)(6512007)(316002)(2616005)(36756003)(66556008)(66476007)(83380400001)(8936002)(6666004)(66946007)(4326008)(2906002)(1076003)(5660300002)(7416002)(44832011)(15650500001)(86362001)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VzjVUxIYJSAqPLSFVTti/YBd+uPF9qmLHiNDAWrDp7DZ119aC2twSIXHSPl1?=
 =?us-ascii?Q?G18XrDy9ulU2DxNzjutlj7UR8/Np7nUfAYuh8CvA87cYiERVoTgN5EURU4l9?=
 =?us-ascii?Q?/pomk6SH751rhl6HUrA7yQovfCsAZ2DKUkTZx2jn9Fy3U6v5ovTR+pn/4BsC?=
 =?us-ascii?Q?P5mQEbrJMGdXaUHbT4BXGbd08PR2kQpQjgWG7GPH9OiBfBzsbMYxwQjqPAVA?=
 =?us-ascii?Q?nUkjjwvt+odS0+o5Av81yNGWCPElukrmvwJ0w30sfx9wZZrQn8bhGkMbl5Ps?=
 =?us-ascii?Q?xCBNI/y509O4AKY8O6SwQe8lVdoKRtoh1C78FbJLV652DHAhW0EAbk4Z/JJj?=
 =?us-ascii?Q?L4HRehfyLHomizjvHDFKtoTZVbvsxLBbYfcU3fYlxUYsZFz7wWqz6yw8uU2t?=
 =?us-ascii?Q?YbarueyOJ1IMTrq1KIsGtwMT71RIjPqlAIsgE66cQNKAkMtvYip1UCosjGP1?=
 =?us-ascii?Q?qTrH+768jQPJMJU6oAWpinj1BK4riTPd4jFZJ+VbNGu0bqjS9MatGc6Q5V73?=
 =?us-ascii?Q?n4rSnvje5EAFxDW/Wtn0u4sOGWWICDX86K/qAS6qiygGB6tHPf15zQxb7j1Y?=
 =?us-ascii?Q?LOT3EkFB+Avd9GHlHwGmhRHtuQdpUdG/8LAOHWkIwZdE9FTqgXPmOuvqc9Sv?=
 =?us-ascii?Q?dl0MnOgMFV6ggamEZ7aHs7R45NtKgzfcMHIIHnJSkGp0hNXR3oEhqyLQk9Kg?=
 =?us-ascii?Q?5sBSawBiVASI1cMkC8z552kCxgbT/A2Kz7YBfkir/AbEN0xmwUrkJx1C5Y7+?=
 =?us-ascii?Q?i3V3QiyZlE6tCg364VzZYhLABHBAf3LmV+Z488yo/wN0o+l79sJUwuQwlTt7?=
 =?us-ascii?Q?+O521ukq69+h4enDzfLf8mBTGkizKxP5AKwQMYbRR2CNo8q1s2yvtmVY6bSx?=
 =?us-ascii?Q?iFg8LyGUsh+LmDx/ctMzKmJwDTmWONj1Mq7E3w5FlYMex9bToWMS2wlkZLat?=
 =?us-ascii?Q?+eJnArZyQ4JXIMYFZTuLeMK5J8T3soXuEOwuohhREDrF6mYq+xYk9C1sL9UD?=
 =?us-ascii?Q?AUQ4VlR6b75QbJcyJt0Ja89d1XPckG0lsIhO9o4rQMhzdaLMqU2FTT3vFTp5?=
 =?us-ascii?Q?8p+dB+u+v5XtKLb23C2vq8ndTpmxpnQMub01e74DnET8CHHUxS8CINgt8MLH?=
 =?us-ascii?Q?UGBrYUYKYrjXkWiI/Zs+yahbAbLtmN48UxwH1CX7H1tD8DE10BEvrRDQji7p?=
 =?us-ascii?Q?BJD4sQdSd/SH+pcOqK1m4C7bObHUnhv1SdT9OXvoEGmTnhH2a7htgTiwzTJj?=
 =?us-ascii?Q?x6Wio4yNcY89Ftm/hT++/5j2CfJya25hxIomFGKEnx0NmiA4ygGrPTpxcMTI?=
 =?us-ascii?Q?b4U+MVBufr89DEkCQh1dWEEVRseVvZdgcYhNjYfQybZCZDPTpOcwYMH1DG6E?=
 =?us-ascii?Q?qmzHA6JuY3d93yz7812gRCdcNs9DCixswudDAxLlIldfEARWDA9iL21pwS+F?=
 =?us-ascii?Q?xIfcCXiHOAvWwnp3yHzXnQkgV/+v1LlxTbSe1tQE45Vet9cGU/fu8k6ebNt3?=
 =?us-ascii?Q?mYW0vDdJcyKJP9m1lhKetK4ti74U1K6i8zjzyr8Zw9q1RjP4SOSrCwAVKae4?=
 =?us-ascii?Q?+q6cqCrxw64yjMIsQNzGlLdSDZ12Pdtq0RI/HdDU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31407ef5-8796-41b0-90b4-08da80c85ea3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 03:18:49.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBxYDOqlzMBvp8k/H56ph6824+ekXZhiY+9jQoEt/7SvgKnk6m3SdHQvPy7d2cUla3zHSXTHBcu/TY8HnXN5pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4375
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

driver will enable the vpu core when request the first instance
on the core.
one vpu core can only support 8 streaming instances in the same
time, the instance won't be added to core's list before streamon.

so the actual instance count may be greater then the number in
the core's list.

in pm resume callback, driver will resume the core immediately if
core's list is not empty.
but this check is not accurate,
if suspend during one instance is requested, but not streamon,
then after suspend, the core won't be resume, and led to instance failure.

use the request_count instead of the core's list to check
whether is the core needed to resume immediately after suspend.

And it can make the pm suspend and resume callback more clear.

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu.h      |  1 -
 drivers/media/platform/amphion/vpu_core.c | 84 ++++++++++++-----------
 drivers/media/platform/amphion/vpu_core.h |  1 +
 drivers/media/platform/amphion/vpu_dbg.c  |  9 ++-
 4 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu.h b/drivers/media/platform/amphion/vpu.h
index 998591fa5b85..73e34b3ec0e3 100644
--- a/drivers/media/platform/amphion/vpu.h
+++ b/drivers/media/platform/amphion/vpu.h
@@ -121,7 +121,6 @@ struct vpu_mbox {
 enum vpu_core_state {
 	VPU_CORE_DEINIT = 0,
 	VPU_CORE_ACTIVE,
-	VPU_CORE_SNAPSHOT,
 	VPU_CORE_HANG
 };
 
diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 73faa50d2865..f9ec1753f7c8 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -89,7 +89,7 @@ static int vpu_core_boot_done(struct vpu_core *core)
 		core->supported_instance_count = min(core->supported_instance_count, count);
 	}
 	core->fw_version = fw_version;
-	core->state = VPU_CORE_ACTIVE;
+	vpu_core_set_state(core, VPU_CORE_ACTIVE);
 
 	return 0;
 }
@@ -172,10 +172,26 @@ int vpu_alloc_dma(struct vpu_core *core, struct vpu_buffer *buf)
 	return __vpu_alloc_dma(core->dev, buf);
 }
 
-static void vpu_core_check_hang(struct vpu_core *core)
+void vpu_core_set_state(struct vpu_core *core, enum vpu_core_state state)
 {
-	if (core->hang_mask)
-		core->state = VPU_CORE_HANG;
+	if (state != core->state)
+		vpu_trace(core->dev, "vpu core state change from %d to %d\n", core->state, state);
+	core->state = state;
+	if (core->state == VPU_CORE_DEINIT)
+		core->hang_mask = 0;
+}
+
+static void vpu_core_update_state(struct vpu_core *core)
+{
+	if (!vpu_iface_get_power_state(core)) {
+		if (core->request_count)
+			vpu_core_set_state(core, VPU_CORE_HANG);
+		else
+			vpu_core_set_state(core, VPU_CORE_DEINIT);
+
+	} else if (core->state == VPU_CORE_ACTIVE && core->hang_mask) {
+		vpu_core_set_state(core, VPU_CORE_HANG);
+	}
 }
 
 static struct vpu_core *vpu_core_find_proper_by_type(struct vpu_dev *vpu, u32 type)
@@ -188,11 +204,13 @@ static struct vpu_core *vpu_core_find_proper_by_type(struct vpu_dev *vpu, u32 ty
 		dev_dbg(c->dev, "instance_mask = 0x%lx, state = %d\n", c->instance_mask, c->state);
 		if (c->type != type)
 			continue;
+		mutex_lock(&c->lock);
+		vpu_core_update_state(c);
+		mutex_unlock(&c->lock);
 		if (c->state == VPU_CORE_DEINIT) {
 			core = c;
 			break;
 		}
-		vpu_core_check_hang(c);
 		if (c->state != VPU_CORE_ACTIVE)
 			continue;
 		if (c->request_count < request_count) {
@@ -409,6 +427,12 @@ int vpu_inst_register(struct vpu_inst *inst)
 	}
 
 	mutex_lock(&core->lock);
+	if (core->state != VPU_CORE_ACTIVE) {
+		dev_err(core->dev, "vpu core is not active, state = %d\n", core->state);
+		ret = -EINVAL;
+		goto exit;
+	}
+
 	if (inst->id >= 0 && inst->id < core->supported_instance_count)
 		goto exit;
 
@@ -450,7 +474,7 @@ int vpu_inst_unregister(struct vpu_inst *inst)
 		vpu_core_release_instance(core, inst->id);
 		inst->id = VPU_INST_NULL_ID;
 	}
-	vpu_core_check_hang(core);
+	vpu_core_update_state(core);
 	if (core->state == VPU_CORE_HANG && !core->instance_mask) {
 		int err;
 
@@ -459,7 +483,7 @@ int vpu_inst_unregister(struct vpu_inst *inst)
 		err = vpu_core_sw_reset(core);
 		mutex_lock(&core->lock);
 		if (!err) {
-			core->state = VPU_CORE_ACTIVE;
+			vpu_core_set_state(core, VPU_CORE_ACTIVE);
 			core->hang_mask = 0;
 		}
 	}
@@ -609,7 +633,7 @@ static int vpu_core_probe(struct platform_device *pdev)
 	mutex_init(&core->cmd_lock);
 	init_completion(&core->cmp);
 	init_waitqueue_head(&core->ack_wq);
-	core->state = VPU_CORE_DEINIT;
+	vpu_core_set_state(core, VPU_CORE_DEINIT);
 
 	core->res = of_device_get_match_data(dev);
 	if (!core->res)
@@ -758,33 +782,18 @@ static int __maybe_unused vpu_core_resume(struct device *dev)
 	mutex_lock(&core->lock);
 	pm_runtime_resume_and_get(dev);
 	vpu_core_get_vpu(core);
-	if (core->state != VPU_CORE_SNAPSHOT)
-		goto exit;
 
-	if (!vpu_iface_get_power_state(core)) {
-		if (!list_empty(&core->instances)) {
+	if (core->request_count) {
+		if (!vpu_iface_get_power_state(core))
 			ret = vpu_core_boot(core, false);
-			if (ret) {
-				dev_err(core->dev, "%s boot fail\n", __func__);
-				core->state = VPU_CORE_DEINIT;
-				goto exit;
-			}
-		} else {
-			core->state = VPU_CORE_DEINIT;
-		}
-	} else {
-		if (!list_empty(&core->instances)) {
+		else
 			ret = vpu_core_sw_reset(core);
-			if (ret) {
-				dev_err(core->dev, "%s sw_reset fail\n", __func__);
-				core->state = VPU_CORE_HANG;
-				goto exit;
-			}
+		if (ret) {
+			dev_err(core->dev, "resume fail\n");
+			vpu_core_set_state(core, VPU_CORE_HANG);
 		}
-		core->state = VPU_CORE_ACTIVE;
 	}
-
-exit:
+	vpu_core_update_state(core);
 	pm_runtime_put_sync(dev);
 	mutex_unlock(&core->lock);
 
@@ -798,18 +807,11 @@ static int __maybe_unused vpu_core_suspend(struct device *dev)
 	int ret = 0;
 
 	mutex_lock(&core->lock);
-	if (core->state == VPU_CORE_ACTIVE) {
-		if (!list_empty(&core->instances)) {
-			ret = vpu_core_snapshot(core);
-			if (ret) {
-				mutex_unlock(&core->lock);
-				return ret;
-			}
-		}
-
-		core->state = VPU_CORE_SNAPSHOT;
-	}
+	if (core->request_count)
+		ret = vpu_core_snapshot(core);
 	mutex_unlock(&core->lock);
+	if (ret)
+		return ret;
 
 	vpu_core_cancel_work(core);
 
diff --git a/drivers/media/platform/amphion/vpu_core.h b/drivers/media/platform/amphion/vpu_core.h
index 00a662997da4..65b562642603 100644
--- a/drivers/media/platform/amphion/vpu_core.h
+++ b/drivers/media/platform/amphion/vpu_core.h
@@ -11,5 +11,6 @@ u32 csr_readl(struct vpu_core *core, u32 reg);
 int vpu_alloc_dma(struct vpu_core *core, struct vpu_buffer *buf);
 void vpu_free_dma(struct vpu_buffer *buf);
 struct vpu_inst *vpu_core_find_instance(struct vpu_core *core, u32 index);
+void vpu_core_set_state(struct vpu_core *core, enum vpu_core_state state);
 
 #endif
diff --git a/drivers/media/platform/amphion/vpu_dbg.c b/drivers/media/platform/amphion/vpu_dbg.c
index c41c9896912c..44b830ae01d8 100644
--- a/drivers/media/platform/amphion/vpu_dbg.c
+++ b/drivers/media/platform/amphion/vpu_dbg.c
@@ -15,6 +15,7 @@
 #include <linux/debugfs.h>
 #include "vpu.h"
 #include "vpu_defs.h"
+#include "vpu_core.h"
 #include "vpu_helpers.h"
 #include "vpu_cmds.h"
 #include "vpu_rpc.h"
@@ -233,6 +234,10 @@ static int vpu_dbg_core(struct seq_file *s, void *data)
 	if (seq_write(s, str, num))
 		return 0;
 
+	num = scnprintf(str, sizeof(str), "power %s\n",
+			vpu_iface_get_power_state(core) ? "on" : "off");
+	if (seq_write(s, str, num))
+		return 0;
 	num = scnprintf(str, sizeof(str), "state = %d\n", core->state);
 	if (seq_write(s, str, num))
 		return 0;
@@ -346,10 +351,10 @@ static ssize_t vpu_dbg_core_write(struct file *file,
 
 	pm_runtime_resume_and_get(core->dev);
 	mutex_lock(&core->lock);
-	if (core->state != VPU_CORE_DEINIT && !core->instance_mask) {
+	if (vpu_iface_get_power_state(core) && !core->request_count) {
 		dev_info(core->dev, "reset\n");
 		if (!vpu_core_sw_reset(core)) {
-			core->state = VPU_CORE_ACTIVE;
+			vpu_core_set_state(core, VPU_CORE_ACTIVE);
 			core->hang_mask = 0;
 		}
 	}
-- 
2.37.1

