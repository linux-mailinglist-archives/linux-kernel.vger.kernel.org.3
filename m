Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6494252CE95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235442AbiESIoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiESIoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:44:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC67E1EB;
        Thu, 19 May 2022 01:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTtd2IImCoDev7s5ooJ3mLX2CXQsr17J4zO4NZF4ti8c3gNMf6ZTwOmcRxsupkyLTkFSrlipYjKE5hhhP90d2+s2A676fKAqomUhch+PVqxHy/HE53IpwqOtLnQ2JAcmVPUXwHi/WBy3l+MdvV+5Jgd6BCJj0RqVHPdCPP6eg5w87c4GVxzduGH94r8aJGOqQ1RPFqzStAeFkmLn30ZAxgnSAV5SKvXoCMrPNxGZcy1Stsr6yLPoB3lP5LSUodYP8G+OICSL3xoq8GhCFHOE1M8Vjt9y94Pd2nyur8Aj5f1afNzG0I3cqfb7/c3F1CwQnwXdmE6ANRRq8I66O3LWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUjaLxzVVdtL+fuLrmbxhQnlpb3XPb7ukNFYwYUJjQg=;
 b=jelf5yvO2KuNzzWcbIN/RuTuhfhO/RKWhDjaXvOJdZDwHKZ7MEq0VmbLZE+FXaaQFDo8dOru7TaFYEEHTbR+5bHhV6pNu0QTtCnOswZUVR1ocJPTCg+mZ+3fSAoHPThsSkmvm1yqwy2m+jVIzYZyxrHMknOng/Ipc6Z355tYcETpPEXgPLaneX9IJteTr6UVD2wzubJkDb/96wwwt2DPx3eZbEds+sxdX0ki4PAh2VGtdwY+jWsAIX9wDut+wKBS+rtO1TwIvEv5U7yoV4Dr5qeu8e9OAurO5ns8Gb/giYt7XAT4w+XP2+LXVUnRHUggx/dbP4zXzZOfwqoC4x4PLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUjaLxzVVdtL+fuLrmbxhQnlpb3XPb7ukNFYwYUJjQg=;
 b=XqT+GXlVfMZ92QBW001a0ykPY5ONXJ1zDQ6JivAHbrV1MTF4AonuxlRu7lIc/4wBxXmZ9iJmYQS5EVdCCEd7KfV2POWGxPHPLlt7sF//tUQNsjEGX6320oT5S2KHEQw2uhVtRB54IF5TR0SNZ4vRjKrZ2ho+jwVNNF6INeXUIPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by DB3PR0402MB3740.eurprd04.prod.outlook.com (2603:10a6:8:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Thu, 19 May
 2022 08:44:04 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::bc48:7565:c619:62c3%7]) with mapi id 15.20.5273.015; Thu, 19 May 2022
 08:44:04 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: amphion: vdec check format in enum_fmt
Date:   Thu, 19 May 2022 16:43:46 +0800
Message-Id: <20220519084346.10538-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0021.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::8)
 To AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be8bc8b7-8499-498f-cb8a-08da3973ba84
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3740:EE_
X-Microsoft-Antispam-PRVS: <DB3PR0402MB374033E19D27FA2954B49BE0E7D09@DB3PR0402MB3740.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZqPlS+yZSdqt9SG0HXdgeOm/V8pxK+0IA6bordoI+/QVeLuEkCrnsRrfcEcSQ3ZP1Mw2NYCvwEc+FUSthOxWysJS1FblwBVbirw6+cSIKi98O9ZN9WCQtfu9eZwackK+2CYOBRdoGbh2Z4+YvkzEhRJz+PC5YmrKVTrxhuFjio8QVQTZixVorlaNVEt5fcSFcpWpxmGd8ob+PsW791MdgEGqb2d7rsqGeYjnv9Ehe80t1Oyxg6lUkTfIAGV+aZhxNRTTzfh0D6Y8ASYJK1yrQZAMwuGQXUPqfYEU4rHwHlfiHJu8W/PvVTaFu0j7K62g63Q4bQIkoYVvfIlNfW91nFiqCAz0CDlshsCx7wN4TkkRWxN0buWI6rVCxX37gZz6tWlAQIWoAdFB3yorj0Yy2jr0tnNsgpr8+/oZ23Tx20BFT3VPrCYUiLsefKgKCowOR/nQALyVS0rRspeZb7m0XbyG3s/JDG3xrFFopr+qdNeijq3ECs83YEdy8hoz8fHxquG0EL5Nlu8Qa9Y8pHGOgSNi5JzgpEIEqzAfcRabHRIGq9NM8snbKBBqcgCO9UEetHW5zrKtLcFY6lCtVqtIy7IymWctOU/b7lcCL8MghZkGBsNE6imBlE5/TkKWL28C+rxTLZlVfvrL8vUiOmesuZUoCtlT76txl1iwaN/A7NtPPWlTlhrN/RCU/iPAKa1EsqluElOViIZLc++SDs8E1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(186003)(2616005)(7416002)(38100700002)(26005)(66556008)(52116002)(316002)(508600001)(86362001)(36756003)(8936002)(66476007)(1076003)(6486002)(4326008)(8676002)(5660300002)(2906002)(38350700002)(44832011)(6512007)(83380400001)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q16XCYR8PAMv55IiPc0JyBW1YycKMtfpOdvQ2Q2Q8+9rTI63KpCPh3fb701E?=
 =?us-ascii?Q?Nj6pwuw0Rg/GjP++HM9PjQRy14RhxSdiO6fXfKRgpEyX67w3eZv0iYKypr6y?=
 =?us-ascii?Q?z6Q2v3w/6/RNGfy9zKwL9TXz3efYxk5qeMNX2bu+xeX1B4oZIetYiSgSFkHs?=
 =?us-ascii?Q?BPG+GZiwvxKbqYYCFYS+di6wxfwdZppMo9Ics2ljT77HPjbQb3DTB3mI0FFE?=
 =?us-ascii?Q?zsddgjACnEKt4tCRj1uVnRjAAc1kh3FVbnROSUL+0nlRnZ7/9HYdBabFa4pj?=
 =?us-ascii?Q?u18HSv5GcCgr5SBZ4Jd+2YS/AlCwzFCvCcK3t9Rz4ptMWx0+vW1rC1nz7JtO?=
 =?us-ascii?Q?oNrISPVpxuuvdcyWbGOf16EKIG7zucKK7X6Y/QxVm+s+iZOkE+hKnM0Y0rtY?=
 =?us-ascii?Q?dyaOU6YvGxUu2QxMCwlni0XeMNy2ZC209mzLR1k6YOx4Yq9q8K2PJURTe4su?=
 =?us-ascii?Q?FujistuqhhkF2C10rNw2zYracx92TQkftNHbgtkv9pO6ygdevjulKHMtemBZ?=
 =?us-ascii?Q?pHi9gNqCqbTgZpWFSjME6km0JQsBwi/bZi3NizwMf2DHPNb2ee2uZzQEDWYD?=
 =?us-ascii?Q?c9cHPpeAW+g9k/ilf0mIcP4X63uODeMjDcvQ1hUeLq6Yctvu0/fG+SdgOhRe?=
 =?us-ascii?Q?ff0TKyvIf6QuPeyj3GqYj4FB+kGnow7F4m7KGgCTD+7K9SEGcuTl2UykyTtW?=
 =?us-ascii?Q?u+ZCziQPKnK78/A3mWQY+WwlAwFcuDG1CS2v0tcBQh4ClJEX4vVvcFVnMTxS?=
 =?us-ascii?Q?VUzbl7NK4ClsiWVt89Rtjaacc8tFII/T4STpdA03svJLTCi78V70bmfmJ1yL?=
 =?us-ascii?Q?dLQqVXX3kOK8hlS+BSMoulecGPvp0eoG2LJ0VSq9ywDH5OcNcuLLmcsBogtt?=
 =?us-ascii?Q?FVayk42LAo3HKMyPJF4IdGKxNJ+okdrwSpSt+HBf0dGrNxkTl1Ivo6vfmyhf?=
 =?us-ascii?Q?ttPJanBMrfS0+bu+sPxrXNss2eQDPCOnInSqPCJwKHV1GRZP8g9HAEVn0x+1?=
 =?us-ascii?Q?ZvQeZ9wetSHP1a6xRPtNipowGGFiU/h6QIZnJ7uB7r8L4i4ARszrr637lvrh?=
 =?us-ascii?Q?/yGYKhooc7VJO5ee0b07NcOz/5jLthJY99xhULop2S0rauCtW1e5Z28tNqOp?=
 =?us-ascii?Q?O2NTQ8EocfuIzjrTICpZOY8LRxZOvU0+I+iFFxpvh1HmUn2P4Vnbp48DQp42?=
 =?us-ascii?Q?MCzPXeBg2hbKQdJchivIXYJIvA4TU8XfS5Y2iVuAjHdukhx0Q6vQ52DXjZaR?=
 =?us-ascii?Q?7EtDQ//Ylsh/settSeuYeiGLIrsQtVigBeQG2fKh6g4RYlZzvkduN5b725S6?=
 =?us-ascii?Q?yJ6q8OT+xvvu4w6qfJnKamL8P2Cnyo5fPieZB1V1ImBamp2gIHIBTvLWzozZ?=
 =?us-ascii?Q?whjyMjVZeJFn50goJh6T4uAcOQTEwZt0qil0pBpE/XYJt0ZNXyEiVFH955UT?=
 =?us-ascii?Q?s/21JxjhGutE+ffqYTfHac6BnZ0jaFQlnebwLBFvOpu3cwE+TgIOd/hCCzhx?=
 =?us-ascii?Q?wupCg+cTA34O8fRJNveRXMgT8tcSZykeSFdGgXfGqsFQGnxzs3X7h/Q9ivii?=
 =?us-ascii?Q?U0EO7UKYwosBccXn07q4N1HJbUHDgJZS+163S49iTZch1XqkJVdz07vkNPXV?=
 =?us-ascii?Q?c3kTpnNXW+37xOATTUL69EPRmX8QJdXK+OMoFuBFYcZrnnlRkhQXmDipkSdn?=
 =?us-ascii?Q?W/Cu+4U9llvksUMGY7Kb0WXS5hUjbxq/XIVa4pNt/+UAwhTcFRtEPdWR6OcL?=
 =?us-ascii?Q?K8+hrHaj0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be8bc8b7-8499-498f-cb8a-08da3973ba84
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 08:44:04.2133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EA2dQ1bld+6azlQzqfz9gTRsFL7yQYG2cVlndim5JwtCBafnHdAvlc8N3z+7Qg5MEbhUmIEZcx4lY8vNDaxipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3740
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdec check the pixel format is supported by vpu,
or is it disabled.
And don't report it if the result is false

Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_malone.c | 16 ++++++++++++++++
 drivers/media/platform/amphion/vpu_malone.h |  1 +
 drivers/media/platform/amphion/vpu_rpc.c    |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 0930b6ba8c42..ec4cd9db3076 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -309,6 +309,7 @@ struct malone_padding_scode {
 struct malone_fmt_mapping {
 	u32 pixelformat;
 	enum vpu_malone_format malone_format;
+	u32 is_disabled;
 };
 
 struct malone_scode_t {
@@ -568,6 +569,8 @@ static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
 	u32 i;
 
 	for (i = 0; i < ARRAY_SIZE(fmt_mappings); i++) {
+		if (fmt_mappings[i].is_disabled)
+			continue;
 		if (pixelformat == fmt_mappings[i].pixelformat)
 			return fmt_mappings[i].malone_format;
 	}
@@ -575,6 +578,19 @@ static enum vpu_malone_format vpu_malone_format_remap(u32 pixelformat)
 	return MALONE_FMT_NULL;
 }
 
+bool vpu_malone_check_fmt(enum vpu_core_type type, u32 pixelfmt)
+{
+	if (!vpu_imx8q_check_fmt(type, pixelfmt))
+		return false;
+
+	if (pixelfmt == V4L2_PIX_FMT_NV12M_8L128 || pixelfmt == V4L2_PIX_FMT_NV12M_10BE_8L128)
+		return true;
+	if (vpu_malone_format_remap(pixelfmt) == MALONE_FMT_NULL)
+		return false;
+
+	return true;
+}
+
 static void vpu_malone_set_stream_cfg(struct vpu_shared_addr *shared,
 				      u32 instance,
 				      enum vpu_malone_format malone_format)
diff --git a/drivers/media/platform/amphion/vpu_malone.h b/drivers/media/platform/amphion/vpu_malone.h
index e5a5cbe9843e..02a9d9530970 100644
--- a/drivers/media/platform/amphion/vpu_malone.h
+++ b/drivers/media/platform/amphion/vpu_malone.h
@@ -40,5 +40,6 @@ int vpu_malone_pre_cmd(struct vpu_shared_addr *shared, u32 instance);
 int vpu_malone_post_cmd(struct vpu_shared_addr *shared, u32 instance);
 int vpu_malone_init_instance(struct vpu_shared_addr *shared, u32 instance);
 u32 vpu_malone_get_max_instance_count(struct vpu_shared_addr *shared);
+bool vpu_malone_check_fmt(enum vpu_core_type type, u32 pixelfmt);
 
 #endif
diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/amphion/vpu_rpc.c
index 18a164766409..676f7da041bd 100644
--- a/drivers/media/platform/amphion/vpu_rpc.c
+++ b/drivers/media/platform/amphion/vpu_rpc.c
@@ -195,7 +195,7 @@ static struct vpu_iface_ops imx8q_rpc_ops[] = {
 	},
 	[VPU_CORE_TYPE_DEC] = {
 		.check_codec = vpu_imx8q_check_codec,
-		.check_fmt = vpu_imx8q_check_fmt,
+		.check_fmt = vpu_malone_check_fmt,
 		.boot_core = vpu_imx8q_boot_core,
 		.get_power_state = vpu_imx8q_get_power_state,
 		.on_firmware_loaded = vpu_imx8q_on_firmware_loaded,
-- 
2.36.1

