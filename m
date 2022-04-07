Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A3B4F8369
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344948AbiDGPcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344801AbiDGPb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:31:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E57BA0;
        Thu,  7 Apr 2022 08:29:56 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4da4:8da5:b6b4:93c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1DD9B1F467B8;
        Thu,  7 Apr 2022 16:29:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649345394;
        bh=ymIiMAJbaeF9cGl/T5jWAuzOy/P/JnwVS/fgtmDvjeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2OS0AMnSoMqI/8QttgTCW8ZtQd4K3EJ+C3wUUTpli/vzpapVa+C80UOMbBfzlG36
         m69DxCsjLJ8QhYgvozImUsZW1zJcas/ezQLufzkNlboL2Y094wfGAzEgBZXM5GjszD
         +qU9Wgi6RXx2vUXM8dCPh9ldRV034ncx/B4cMx4i0jQxUzZKmLpO307qpHWlm1BCPA
         y1pusJKsJwnmF5tsFPQ08eEgbh2moWJH4Z2eFyeSwwAEFLt3OC1VxIkPu+c07peTjV
         Fo9KMXUhZ5hUy5EjUG4WwfFgCmHPde3geKYRnsXFUOXs+hIbfpzWu2n+1mwMOPyaFO
         wFjQ9GBkYG5wg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        sebastian.fricke@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v5 09/17] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Thu,  7 Apr 2022 17:29:32 +0200
Message-Id: <20220407152940.738159-10-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
a dynamic array control type.
Some drivers may be able to receive multiple slices in one control
to improve decoding performance.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
 include/media/hevc-ctrls.h                                | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 7fcc6c2bac4c..1aaf3b84b584 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2964,6 +2964,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     These bitstream parameters are defined according to :ref:`hevc`.
     They are described in section 7.4.7 "General slice segment header
     semantics" of the specification.
+    This control is a dynamically sized 1-dimensional array,
+    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
 
 .. c:type:: v4l2_ctrl_hevc_slice_params
 
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
index 96a9b71d1def..28049e1a8a07 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -314,6 +314,9 @@ struct v4l2_hevc_pred_weight_table {
 /**
  * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
  *
+ * This control is a dynamically sized 1-dimensional array,
+ * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
+ *
  * @bit_size: size (in bits) of the current slice data
  * @data_bit_offset: offset (in bits) to the video data in the current slice data
  * @nal_unit_type: specifies the coding type of the slice (B, P or I)
-- 
2.32.0

