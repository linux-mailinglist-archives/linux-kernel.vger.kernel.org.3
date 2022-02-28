Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659FD4C6EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiB1OJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiB1OJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:09:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B852B16;
        Mon, 28 Feb 2022 06:08:49 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:82d4:230a:70ff:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8020B1F43A62;
        Mon, 28 Feb 2022 14:08:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646057328;
        bh=bowMSxciKZ4e4jd3aI13NZ259r8hIcdS0hJZN8hF4F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cF22N2PmAn74Wyq878r5eKfIQKuM0GUOn2hhxdaVw3A0V0KCyFfH8FdQWkFS82A4T
         Nv0mz5FF7fzz56np3/GE/DNW+Bzyax1rOlgVrScN+yc69wGPsAj/iqw3USrXxSqZ6u
         4iwmaKHteLUphgGYi3su1PIGy0HYjI23bBKrm0DxjMLkfogGODtqlQJvZT3hckTqcD
         mk9h3XgnZXwywqABmdEkSdTnnPmVSKMMU+0A6kIN0/snbkKYHQH/TmGhJzYE9+9xiV
         mPvMqzCI1oNPOMwCToGv0JPMY9/B6wkdULZQObPe0RyILItJ9+SAqfNo1D47i1C/eU
         E0uTA5P26Wwfw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH v4 03/15] vivid: add dynamic array test control
Date:   Mon, 28 Feb 2022 15:08:26 +0100
Message-Id: <20220228140838.622021-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
References: <20220228140838.622021-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Add a dynamic array test control to help test support for this
feature.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/media/test-drivers/vivid/vivid-ctrls.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index e7516dc1227b..7267892dc18a 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -34,6 +34,7 @@
 #define VIVID_CID_U8_4D_ARRAY		(VIVID_CID_CUSTOM_BASE + 10)
 #define VIVID_CID_AREA			(VIVID_CID_CUSTOM_BASE + 11)
 #define VIVID_CID_RO_INTEGER		(VIVID_CID_CUSTOM_BASE + 12)
+#define VIVID_CID_U32_DYN_ARRAY		(VIVID_CID_CUSTOM_BASE + 13)
 
 #define VIVID_CID_VIVID_BASE		(0x00f00000 | 0xf000)
 #define VIVID_CID_VIVID_CLASS		(0x00f00000 | 1)
@@ -189,6 +190,19 @@ static const struct v4l2_ctrl_config vivid_ctrl_u32_array = {
 	.dims = { 1 },
 };
 
+static const struct v4l2_ctrl_config vivid_ctrl_u32_dyn_array = {
+	.ops = &vivid_user_gen_ctrl_ops,
+	.id = VIVID_CID_U32_DYN_ARRAY,
+	.name = "U32 Dynamic Array",
+	.type = V4L2_CTRL_TYPE_U32,
+	.flags = V4L2_CTRL_FLAG_DYNAMIC_ARRAY,
+	.def = 50,
+	.min = 10,
+	.max = 90,
+	.step = 1,
+	.dims = { 100 },
+};
+
 static const struct v4l2_ctrl_config vivid_ctrl_u16_matrix = {
 	.ops = &vivid_user_gen_ctrl_ops,
 	.id = VIVID_CID_U16_MATRIX,
@@ -1612,6 +1626,7 @@ int vivid_create_controls(struct vivid_dev *dev, bool show_ccs_cap,
 	dev->ro_int32 = v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_ro_int32, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_area, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_array, NULL);
+	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u32_dyn_array, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u16_matrix, NULL);
 	v4l2_ctrl_new_custom(hdl_user_gen, &vivid_ctrl_u8_4d_array, NULL);
 
-- 
2.32.0

