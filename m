Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18CB4D5A5E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbiCKFSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346387AbiCKFSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:18:35 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A3344D2;
        Thu, 10 Mar 2022 21:17:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDNVZFbgm5uZs/rEu7DZTXtrCWMQOVCr5IcWJQELz3NiltFjZiHZ5PVjoM1APOw3wLrWsBrQxQdym4zKoiOKT3oUypp993+/6vfPzLra3P6597jLeMbkbbKt7+WRrWsVxZN60hFFSP8NT68FvUFPDiPztgyw++qX0MqrI2M7E8IbU2xlenTSSC/X6ShLKBuggPYfnoEjsMUX4vwwaDF9REuhKvdbS9m1i9aEzrNdMA/3xPwqE0m6lhL/in9dN2UzArLJJiI8iHXB3NQ+8uZh3yFBk6kbxuh1RBVO1ksOPVmbnBw0q3GbVPlh0xWiW79/OzP/Lp0Dsuqzy/WOKTwf0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZCX741rwktWnBLOHGuEVtfQDQNbMoxSKFS+7vTuFEE=;
 b=LdpWzRBbnK23Xq6vB7xqNZZrCspGPbyakgTvGG2G1IzuZHsYukzgXeYeYUBFDwtU3DV9Cgujzw1U7cuE+QoMf5c+YaTjTTAMOeb+gp0ZcO+5SE+GIYsFlyeGfUd+6KBPKQZr4ZJV6Dpz13+8qctri8UR/fdXtJiLNcyhUKF6hedneDognfVcSXXNQRZYhZOrh+mDus/haXpmcKc7BkHCLvcsX3CJ8ek2UH6a4EaK6jrj2m0gcHq/rmmZ4sTXCX5VNXpy9W+EbXSCU5vaiIPAiLRYjdvBAUqQi2L9upbUotl6F3hGOgoPiD9dgtDL4j1QneYCYs8/1gC2SrQaiKoHLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZCX741rwktWnBLOHGuEVtfQDQNbMoxSKFS+7vTuFEE=;
 b=ZVHtiDZqbimRvs6o4HNxdx3GakLz7NdkvkqvnmVtM1HzH5GQ8GgwXN/I+G4AWYVsE52IIMYWHYmOrjheQrsSIRX0FDGuxSkK44NvDTPH0206zxauMPuVd3dAdHMnH/WqLq7u8SYWaFm/cygRttlOGN+y72TCOKEUqCYBoVIX2xc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AM5PR04MB3284.eurprd04.prod.outlook.com (2603:10a6:206:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 05:17:24 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::c39:69cf:c4ea:967%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 05:17:24 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, shawnguo@kernel.org
Cc:     hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] media: amphion: fix some issues to improve robust
Date:   Fri, 11 Mar 2022 13:17:07 +0800
Message-Id: <20220311051707.28563-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.33.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07249de1-1ba6-428d-c56a-08da031e6d0c
X-MS-TrafficTypeDiagnostic: AM5PR04MB3284:EE_
X-Microsoft-Antispam-PRVS: <AM5PR04MB3284435BC189ACF1918F07A5E70C9@AM5PR04MB3284.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyMW8Fsf086yQO5PN92wB3ZvZM3YYb+VVBbmV3E9Xq9jdsib/U0BXknq1WDvwuidfuE+TrcLfq4eo6RFNypAa+rchxA54ZhvPRIgwUoX5PBnB9zRNZiOT8AUAqELiMh5lf2AiU4gg1CLGNqb4Yf1kGjOukTEtSdRjcDK1P29zjnZdLVfn4c4A7C5IaJ6euP8bPMroQlCZwexqdsBgVwS1FTH1QERQdzdvnk9vyM8N2DxZCU4JdzDQOesWcA/UJucUXR86QrqHKdxoMG23LCoii+lS8FTuyRpmz2XbrruIrVgDev7cZyuLZ4PstoC7BsbpJnq+CB1EIA3QJIrzcM3ZSRS83X996Qyjt/pfSjltSiDFAJs0eJW8cs9EAJwDOVN1UfOjCxNitOyh3rxWnycBXP/plAjaNX9YuZ7zdgs97moUrakngFmW+Dkl1fsQbSV5MEajfjCRPrgqJCKD1SQxh4K2oVqt3afiNDqDWk5ENkVdlBSuheBUBhIOdfnURTXcSvd1zLpeptAXXiEUQIO8KyWQbi/u3Px+qHbriElkgga2k1FQW+tSXkARrpMdR1OGLSBhInxgMr38uCTtl8got/YGvNXdnN0rBtrcSzdMAbOrsfqsWfpiIwXpxlJaQj+xzUhLddkQ1zOFpEYF2g7JkfQ81MjHTztP43jYBk/aQVLrHMOt1OlfGpp17RP50nIdUXvrHiS6wtLB6aa8igv7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(44832011)(36756003)(508600001)(5660300002)(86362001)(8936002)(2616005)(1076003)(30864003)(6486002)(66476007)(2906002)(6666004)(6512007)(66946007)(83380400001)(38350700002)(186003)(66556008)(38100700002)(4326008)(52116002)(316002)(6506007)(8676002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EXPYC7hoPvac3MWAlgpVR9EeJJrEfsqdcuWg5u2dmdRnrXU6UH9tPXzTAnb5?=
 =?us-ascii?Q?qFqc/sb0kLG/Yz91dWSYrLo/s/24xSNPydDfdGbEq/A2Xqm89DzA2SH+nr4z?=
 =?us-ascii?Q?WcQz0V6pEELZYpod7rfd9IwGp9nk2VxjvkIlD8hHGu3r0ZelXb+2l1QTFQzQ?=
 =?us-ascii?Q?jEwrUvFXoGrpzy9C1KgdDuirm8qvxkLfZMKpIFgqvsJBQ+TJtLvQkwFL5e7L?=
 =?us-ascii?Q?R7nETFKqL2VnISohHlmSdBe0eZk5IaMhy0ShIdaDFoGKYa5Vr8a4BB2daFof?=
 =?us-ascii?Q?x/i9q2b84ZRUCDVQTWw9PCU0wV96FXy4Gvs/L9LemLyBh1JFJTwx8/JDsQVR?=
 =?us-ascii?Q?p0eXyRkR+jRI/Gr6vQ8ktck2m/LarKDMbe8QXNCN2+dXu77I7B6wKtpmUjrH?=
 =?us-ascii?Q?wfvePZWx4mfjuvY0Vq1kQaTKLjcAualzlK9PpTgzt2aNXS7sY/Sqe0EaA3Ww?=
 =?us-ascii?Q?zZ9e7F1T4CZHQfL03W7Jh2ABjE8ZbbckXMsdRFXMEtE+u9EmGTJHKPx7h7qR?=
 =?us-ascii?Q?Ldp8oR/SBP11/K/p25rVRiLTiR8HKDzjFIo5BDHnCGGjve0uJIbiOpbWeODi?=
 =?us-ascii?Q?y1Gh/+XOr1jY5ccPixW4ybqgJQ/PdHpcbKiEO8aKHhF8/r/xLtHCvCtE3MUd?=
 =?us-ascii?Q?Ag6BSCRSrigZ2giN38j2NkPrlxlw5O76ZPBa+imeIjqhZaWAUeIi4q7uMJdD?=
 =?us-ascii?Q?BnJSdBDDebeMyL1L7EFbUfq8zT8811n9rpnQNJYT38j8Mqev1NHA5terbId7?=
 =?us-ascii?Q?K+/44SA8R8PeuttqFYkXwEminV3tVz7czObS1cjx/1n/dt3Lpz6/h5ilsr/W?=
 =?us-ascii?Q?0EgCw1t1zTEsF9Qm086Pa5cvWhWVBNsT6lt3avCAu3tUd5+SbpovJpla/iVx?=
 =?us-ascii?Q?x+n69KDBhUThDPhu0VExrefSyzElWeCpfby5JfDjCIxVVoRoN2RvKyHt5J2p?=
 =?us-ascii?Q?mpEEL/dM02K5GBVaRWEkn0v7qhh3X25q8caZNY1U0xFYU5LwhiNK8AfV/AsH?=
 =?us-ascii?Q?JBkZEj7cZ672Z8CLqV+fnDhpUG3XKUs72aw1LKJjB0ZjCnro0qApY7tC2WbU?=
 =?us-ascii?Q?Lp8yDd+5hi1TgggvSkMS63rl8U+iCoKANPEMynvMg3v7iDD8/uIXVy6oYoKs?=
 =?us-ascii?Q?pvTw+z9wGyvNXMTaqab9fKLyb0i3AMAMi7O3N4amyUuD6A8wf1+9Mv9JLuW6?=
 =?us-ascii?Q?dUoxJdADVn1w3fVW6xG2bUR0U2cq9FW+FtkhrQY4Q1NO7HytZwmbDugcZ2aX?=
 =?us-ascii?Q?cYAUPUru83O5p6fPd+FG3bH4jFCAOLptVgCnI0ns56UxEGik0VLfl6bOX3ii?=
 =?us-ascii?Q?0XaPY12tkiDqinbz2QCq4xFxVUe6t3JWEtoXCUjCK8i0vfuijIwDEt7wbA+u?=
 =?us-ascii?Q?42wewIgbzn4EswIwNZRUEmzGFxBeeYew0JkIdekQe70/Nh83i2IEiOxunn4u?=
 =?us-ascii?Q?xhnhWRQJ+lVnh9u85XS6xejfmT+2j8Ry?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07249de1-1ba6-428d-c56a-08da031e6d0c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 05:17:24.1989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w8OamX8C4hywA8CWw/K7v89qVXFFJiRs3WUhfeV5Qszv8F+9I8XLJReQcP9gZKLBvYgPe7Rd/PgC1KxWm3fZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3284
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
7. make sure the ALIGN won't wrap to zero

Signed-off-by: Ming Qian <ming.qian@nxp.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/media/platform/amphion/vpu_core.c    |  2 +-
 drivers/media/platform/amphion/vpu_helpers.c | 13 ++--
 drivers/media/platform/amphion/vpu_helpers.h |  6 +-
 drivers/media/platform/amphion/vpu_imx8q.c   |  2 +-
 drivers/media/platform/amphion/vpu_imx8q.h   |  2 +-
 drivers/media/platform/amphion/vpu_malone.c  | 63 +++++++++++++-------
 drivers/media/platform/amphion/vpu_msgs.c    |  6 +-
 drivers/media/platform/amphion/vpu_rpc.c     |  4 +-
 drivers/media/platform/amphion/vpu_rpc.h     |  9 ++-
 drivers/media/platform/amphion/vpu_v4l2.c    |  8 ++-
 drivers/media/platform/amphion/vpu_windsor.c |  6 ++
 11 files changed, 78 insertions(+), 43 deletions(-)

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
index 80ba3ad9045c..446a9de0cc11 100644
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
@@ -1017,6 +1017,10 @@ static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
 		return -EINVAL;
 
 	wptr = readl(&str_buf->wptr);
+	if (wptr < stream_buffer->phys || wptr > stream_buffer->phys + stream_buffer->length)
+		return -EINVAL;
+	if (wptr == stream_buffer->phys + stream_buffer->length)
+		wptr = stream_buffer->phys;
 	size = ALIGN(wptr, 4) - wptr;
 	if (size)
 		vpu_helper_memset_stream_buffer(stream_buffer, &wptr, 0, size);
@@ -1024,7 +1028,7 @@ static int vpu_malone_add_padding_scode(struct vpu_buffer *stream_buffer,
 
 	size = sizeof(ps->data);
 	ret = vpu_helper_copy_to_stream_buffer(stream_buffer, &wptr, size, (void *)ps->data);
-	if (ret < size)
+	if (ret < 0)
 		return -EINVAL;
 	total_size += size;
 
@@ -1234,12 +1238,15 @@ static int vpu_malone_insert_scode_seq(struct malone_scode_t *scode, u32 codec_i
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
@@ -1247,10 +1254,13 @@ static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_i
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
@@ -1258,6 +1268,7 @@ static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 	struct vb2_v4l2_buffer *vbuf;
 	u8 nal_hdr[MALONE_VC1_NAL_HEADER_LEN];
 	u32 *data = NULL;
+	int ret;
 
 	vbuf = to_vb2_v4l2_buffer(scode->vb);
 	data = vb2_plane_vaddr(scode->vb, 0);
@@ -1268,10 +1279,13 @@ static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
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
@@ -1282,8 +1296,7 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 
 	scode->need_data = 0;
 
-	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE,
-					  sizeof(rcv_seqhdr));
+	ret = vpu_malone_insert_scode_seq(scode, MALONE_CODEC_ID_VC1_SIMPLE, sizeof(rcv_seqhdr));
 	if (ret < 0)
 		return ret;
 	size = ret;
@@ -1299,7 +1312,7 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(rcv_seqhdr);
 	return size;
 }
 
@@ -1322,7 +1335,7 @@ static int vpu_malone_insert_scode_vc1_l_pic(struct malone_scode_t *scode)
 					       rcv_pichdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(rcv_pichdr);
 	return size;
 }
 
@@ -1346,7 +1359,7 @@ static int vpu_malone_insert_scode_vp8_seq(struct malone_scode_t *scode)
 					       ivf_hdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(ivf_hdr);
 
 	return size;
 }
@@ -1369,7 +1382,7 @@ static int vpu_malone_insert_scode_vp8_pic(struct malone_scode_t *scode)
 					       ivf_hdr);
 	if (ret < 0)
 		return ret;
-	size += ret;
+	size += sizeof(ivf_hdr);
 
 	return size;
 }
@@ -1470,9 +1483,9 @@ static int vpu_malone_input_frame_data(struct vpu_malone_str_buffer __iomem *str
 					       &wptr,
 					       vb2_get_plane_payload(vb, 0),
 					       vb2_plane_vaddr(vb, 0));
-	if (ret < vb2_get_plane_payload(vb, 0))
+	if (ret < 0)
 		return -ENOMEM;
-	size += ret;
+	size += vb2_get_plane_payload(vb, 0);
 
 	vpu_malone_update_wptr(str_buf, wptr);
 
@@ -1500,7 +1513,7 @@ static int vpu_malone_input_stream_data(struct vpu_malone_str_buffer __iomem *st
 					       &wptr,
 					       vb2_get_plane_payload(vb, 0),
 					       vb2_plane_vaddr(vb, 0));
-	if (ret < vb2_get_plane_payload(vb, 0))
+	if (ret < 0)
 		return -ENOMEM;
 
 	vpu_malone_update_wptr(str_buf, wptr);
@@ -1566,9 +1579,13 @@ static bool vpu_malone_check_ready(struct vpu_shared_addr *shared, u32 instance)
 	u32 size = desc->end - desc->start;
 	u32 rptr = desc->rptr;
 	u32 wptr = desc->wptr;
-	u32 used = (wptr + size - rptr) % size;
+	u32 used;
+
+	if (!size)
+		return true;
 
-	if (!size || used < size / 2)
+	used = (wptr + size - rptr) % size;
+	if (used < (size / 2))
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
index c764ff52d026..25119e5e807e 100644
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
@@ -342,6 +342,11 @@ static inline int vpu_iface_config_stream_buffer(struct vpu_inst *inst,
 	if (!ops || !ops->config_stream_buffer || inst->id < 0)
 		return -EINVAL;
 
+	if ((buf->phys % 4) || (buf->length % 4))
+		return -EINVAL;
+	if (buf->phys + buf->length > (u64)UINT_MAX)
+		return -EINVAL;
+
 	return ops->config_stream_buffer(inst->core->iface, inst->id, buf);
 }
 
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

