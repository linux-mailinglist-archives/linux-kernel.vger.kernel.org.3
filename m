Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF2590C72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiHLHWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237014AbiHLHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:22:40 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20081.outbound.protection.outlook.com [40.107.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5BA50E7;
        Fri, 12 Aug 2022 00:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfGi2MlP44I6rD+HAcA1N9kWKSoA5s9nDr5xjLKX3j9cYSGyhSMuRDLHYgvTt+r5YJGx4kkVqsN5WZOmvroKE9+dDm7yWS6jyxTTk6QXz1drs+9QVtMD2dG58ZQu6dleCu5dpAhoLDWrrPVAU3TDamw4K71xQyLt0ZJMGwamEJxz0b0xijDypnG88XywmA3NNbOdbwhAJw4KZPwhItLDA5p7cG3/rczbwvjfMyPkT8p5k1klLGkzy7pWrZ4nGrUwqI6u3rFZzhfG0yzuqVLMUx9UDpCMcQXGX+OX3IACWdsjo9dfKbNo2qTb/Lib1AuuYP3IHKyGpRwydxQhKgL8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dsm0D97616swXsZPJi/h6Lsai2deQxRhmHaywZsekco=;
 b=CHr0ldzwD55tNJxR9ks7dSEQGy/4fPjW+hTMCwaGmngHms/R0pxZG8v85gzVcwTYmZlPFr8nCx8fouAYHOlY5IcMVJ+n8zxo72xqWfn6fezarB6WaHdSiJr5g3OTuWhPGYVK/VsY/1F2TdKmM7PzjWt2OFi+wNtyNuYVX6JW4Dk4E3Lv09BDZ0fKQ37MdBqDCTT4Omr0rrm8aLhINHkZhQ79HUUwu0G454VIRpoJxEt4pwZWUb0PRNRMLYcr9cvwWPsmY/44GRsJqYLGR/Tu1vHZTecEpg9B0o0h9PVYp487xayLgRG7UQeEpOkljDsWXd119a3wQVhYoieGpIFBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dsm0D97616swXsZPJi/h6Lsai2deQxRhmHaywZsekco=;
 b=o52ZXH/yo+4dMtXHNWy3TYkB6lOThFJ30HFZiIEMi08RYHXDAx++Fd3Ji+fZmoKQINgqZPvu3Va+/N4GTBXETJcwb89F7zwaTssMHAPMo2zDbsvjWgadLeYN4pPWJTxftbQr4zYtodX4KyqCwZCgDR2LAGWu8XAyT9bpPg+gLDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by VE1PR04MB6719.eurprd04.prod.outlook.com (2603:10a6:803:128::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 07:22:37 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::5db6:3f08:2e04:33c%4]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 07:22:36 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, mirela.rabulea@oss.nxp.com,
        hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, xiahong.bao@nxp.com, linux-imx@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] media: imx-jpeg: Lock on ioctl encoder/decoder stop cmd
Date:   Fri, 12 Aug 2022 15:22:09 +0800
Message-Id: <20220812072209.13420-1-ming.qian@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0318ea4b-25e8-429e-5634-08da7c336e7b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6719:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndJgn4mMoXC3rukwYU3q0rvBNntrDR8tVXmNqH2jmH3/UnI7t3EWQoQYydCk2ctzkk81z1wYsvTE/kCvIqs9Eu0n7h4s1OcG5dArNbYhwDjyYD1u7af+7Z1x40c1F4TOl3ep2DcV8lz/i6kTelV5cavfkyIxlhy22zKWmVXP6VNN9rFqJbpyvkJ55HW0+LrmFImyPpnKf0NkGxegmzfDhVqoyYldkpP+vaWwLDDD6fQcfGHwxJIO4xaHxvc3MXEXwTrijNOzIiDxRg8/o2Oy5e8CT1SW3LiYKy2h88gdVGjbk/V5sV1G5D5lEvwUTnsK50EulrrCxWwBzltkCJpsBM0xXFaaMmH4zIZqJGDc+y6fEXgTETEyFkqxMKyJ7lsGJi+zhJexfENK+fU369cUSbB2vVPpFijGwKSN+LxfTdC4gfk8l/HRGPDDhz9zzU8Lliu/BZDIknaa6dAo28fhCdkkVJDmZPm6ymB10BsOQ5u5nr+Ud5dx1kbptMVVE733NiIX5rZyjduj6LGT8Vp1CLGwQksMNDVRbP79hv6NWIgJV923euBSWU1JL259Kco2DRvvZNS5Q5oqHHcegcx8hx21bJX2cuo7iJm+NfKHafVmFAiwoO5Tgq5+xv+MTuh5V/hskc34CYtHtZTIsvAKvM5mdwko7I96iDR7vfh9/X436Zd6L3hVOXE3U6ecr1EbRpeosEqxwF+p15Rv7XgdsbrcZNtajmG+tKsguA8I0GvnM4hn0TXM/3jz9DbDQjY+wI9pBxV1qgcOXdQxE/KP3qKmNn8CcLHjWkla5ZY7+ILFDCDJ60x0YsA5OELUs+h6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(366004)(36756003)(6512007)(478600001)(6666004)(41300700001)(26005)(86362001)(2616005)(186003)(1076003)(6506007)(83380400001)(6486002)(52116002)(4326008)(5660300002)(66476007)(66946007)(66556008)(316002)(8676002)(38350700002)(38100700002)(7416002)(2906002)(8936002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ob6B4UphhJc4vk2Scp4lpigDjX4lczhbg1MPw3TCgUI4FPm8leGTlEC1pczF?=
 =?us-ascii?Q?2gfhasnF7303Kwtw7gunWvpSBCS2HZGdcxh7wYMZf4ncHZXafE7UbAko9XJq?=
 =?us-ascii?Q?vl0tkvTS7OorwWQUtDboxoXO8zv6Px5NjFyq20X2Y4qCNGHBaJhDG8a5OfpL?=
 =?us-ascii?Q?qRjsam+h+363bUwjsOSQo3XeNoXsPXG7/FV65WrZvYFAjOMOEVC9/yyHjmPE?=
 =?us-ascii?Q?mzRVy+rBqnvHukeloz/QI+GhBmsI1EQT1rjV2V+0FswUWe6UJM/+8j2hQtW5?=
 =?us-ascii?Q?n19rqd+VFk0EuotHSnNUdKNYQtTo3aPmUJ/6Q1C3+2WioyWn6FNFS2jllIEx?=
 =?us-ascii?Q?ZgrYB62ZfNo+eWDJnrL0ybdYf/MkGtVOf5cp/UlLxzVuw0GzLBQ4qou39VpN?=
 =?us-ascii?Q?RmcJNzO6tWxlsOvg0lqRS0oPQlr8cSXKNfLRkSWZEIvzBwVmCzDV24asmuEc?=
 =?us-ascii?Q?dxpDDM2m+5/AgMDyhgNhLQ+uZAfNdbrjj/6el9fi0vn8jWV/YlF8sNY/M9Hl?=
 =?us-ascii?Q?TSfNmMWhVxcQDsvAHQFB1Okod4buSTYo3oOVGMr6+QaZmRd+O5l8opNUIdFJ?=
 =?us-ascii?Q?9h18kuild3T4rBRrUmg3JJh1F8agC6rVfbbjSRU1wVF/kpHmh5svI63A3Bwi?=
 =?us-ascii?Q?Kq3qvUUMcRrWUa/LBETjwGKoJ6z4VghRVDwnMHuhXiPFIz6cofefsmXmfa7h?=
 =?us-ascii?Q?l5LQCmiGB0KAJ1t8dYmadbi20etwYwa0C0HNGcBVCxGmmXf6wDmPr8hA7wgO?=
 =?us-ascii?Q?VGjZQuJzzvnT+CJxGahdEdXVFCnevrr15clSSJZfeP8zHglrpw9ae4XDHjyK?=
 =?us-ascii?Q?BR9vbn5S3qcDTBauJDGh+LGRnNffJiyYRfz8XFGrUGuKlBt0CKWscN0gSbql?=
 =?us-ascii?Q?DvSR4yLhjU6GTVb1pqIqJKQ2AezXE6Qbrk3FTP6JOJ6SnBFtZ4vaH79iA++f?=
 =?us-ascii?Q?sVshS9WX2FMcVTF43dS2MXKs8lTcj6s5LUGrsUwq8D4c+oAJVxW4r1FCBuI8?=
 =?us-ascii?Q?CgxS/2nNYfrPZgFqFc5bkYFU0IBGqGOgtjqcZ1gz8YlWloL6eh23zuQARN1x?=
 =?us-ascii?Q?lbMFKvAaiLdTc1K92b4/EPrf+nuEgE4ugbJTnz8f9q+vz4lV45vOmTEKvcuu?=
 =?us-ascii?Q?umYV3dPYsha7tLoRLDI8xgKg7RiGAIZWN2jGbKzCBTZPyhQf+VdllEaOXeWC?=
 =?us-ascii?Q?SfXa7uTnSXMkgk5AbN1VRnpELJ+6nyrKAd8wUGEiqJ4uslXJv1jp+mvAXh+n?=
 =?us-ascii?Q?QhBR/qeLxDHaW1wRMW6Ia9YYQlJ9s7E8wcpIcXRasWRxvVRLf4GxbNMBpB0U?=
 =?us-ascii?Q?MXQFCIw6RslyAZQtrBVEaZacF6i2QTMbBbc2/JDNuSYnsWEeW/XNLeApDB3e?=
 =?us-ascii?Q?tIyzVT0npdoQUXBCN1pbVOlex1ICuevbpbuFMIncvSSccQ597ba5BCnDVnsu?=
 =?us-ascii?Q?t4A1nVKi/8laQ+Jz6fal6pIw9mQsytUK4kqrAwNCdiRJKVDYMtqcTq5OGe+b?=
 =?us-ascii?Q?+WYjli3dooumlD8Tw2qBigqvBkgIAI2x6L8rSTjlruO3/zEZCsZVjqFikQHu?=
 =?us-ascii?Q?ajIN7EQjCXN2m3agKh0J4Co5l3iUBW16L+xUA6hF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318ea4b-25e8-429e-5634-08da7c336e7b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:22:36.7443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8Vt4Su1AIhHUO+jcpOD59cKMMc4g1GPCtPd+fU+rOAtz8PpafVKeMnj+P5gDwVMi2FWgbbEDz/icEQAUZW+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6719
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the ioctl encoder/decoder cmd is under queue lock,
and buf_done is in the irq, it can't be locked with the mutex,
they are not synchronized.
when v4l2_update_last_buf_state is called to
handle the encoder/decoder stop cmd,
the last src buffer may be done at the same time.

so it's possible that last_src_buf is set,
but the output rdy_queue is empty,
then driver won't mark it stopped,
as v4l2_m2m_is_last_draining_src_buf() will always return false and
v4l2_m2m_dst_buf_is_last() return false too.

In this case, the drain will be blocked.

add the hw lock around the ioctl encoder/decoder cmd,
to synchronize with the buf_done.

Fixes: 4911c5acf935 ("media: imx-jpeg: Implement drain using v4l2-mem2mem helpers")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
index 975e11f9821a..ab122ecaf7c6 100644
--- a/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
+++ b/drivers/media/platform/nxp/imx-jpeg/mxc-jpeg.c
@@ -1225,6 +1225,7 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 {
 	struct v4l2_fh *fh = file->private_data;
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	unsigned long flags;
 	int ret;
 
 	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
@@ -1234,7 +1235,9 @@ static int mxc_jpeg_decoder_cmd(struct file *file, void *priv,
 	if (!vb2_is_streaming(v4l2_m2m_get_src_vq(fh->m2m_ctx)))
 		return 0;
 
+	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
 	ret = v4l2_m2m_ioctl_decoder_cmd(file, priv, cmd);
+	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 	if (ret < 0)
 		return ret;
 
@@ -1255,6 +1258,7 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 {
 	struct v4l2_fh *fh = file->private_data;
 	struct mxc_jpeg_ctx *ctx = mxc_jpeg_fh_to_ctx(fh);
+	unsigned long flags;
 	int ret;
 
 	ret = v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
@@ -1265,7 +1269,9 @@ static int mxc_jpeg_encoder_cmd(struct file *file, void *priv,
 	    !vb2_is_streaming(v4l2_m2m_get_dst_vq(fh->m2m_ctx)))
 		return 0;
 
+	spin_lock_irqsave(&ctx->mxc_jpeg->hw_lock, flags);
 	ret = v4l2_m2m_ioctl_encoder_cmd(file, fh, cmd);
+	spin_unlock_irqrestore(&ctx->mxc_jpeg->hw_lock, flags);
 	if (ret < 0)
 		return 0;
 
-- 
2.37.1

