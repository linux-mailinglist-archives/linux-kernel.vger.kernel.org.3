Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4DE4C4B35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243297AbiBYQrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243197AbiBYQqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:46:48 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E7D22D648;
        Fri, 25 Feb 2022 08:46:15 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:947c:7c9e:f96:1bc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2E3C51F4637E;
        Fri, 25 Feb 2022 16:46:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645807574;
        bh=1efQRsTSb/TbonDTR62JGVtaxw0xtZBRD5WqCbjWseg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pj1k7u0abLDHj8d5XPrhXdVJGprxQF3eaExfkjtkF4ClxevhwXqrc+mLtoxwmzYf4
         zamxrXOkP9z/HyKotEYxmia0WuOWKfNfVqvlNPMKeXW9g6ioDhracecmA727kRnlH1
         MM67xCc3YOGGeSmojkQ+yWBCcDtCA2owPsCQuBkEmE6o3rwdy6W7cR4CnK3w8WW4I8
         SefYpK6Kc3KeadSCrYFN+UV533GdzoA4ka11aS0W0p1Af6IjRNg+FoKEVzPOFWXog3
         INApZ+E4vURPS5STj+zz35sy0HX5mmnM3jq9PIurXLOtgQhQeyzM5sQRYnCNQ7hvkW
         AKz/73eHHxLTw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH v3 07/14] media: uapi: HEVC: Define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Date:   Fri, 25 Feb 2022 17:45:53 +0100
Message-Id: <20220225164600.1044663-8-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com>
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
index 18625d18ddf3..44a268a948c0 100644
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
index 1c86566cd7cb..057b5032453b 100644
--- a/include/media/hevc-ctrls.h
+++ b/include/media/hevc-ctrls.h
@@ -300,6 +300,9 @@ struct v4l2_hevc_pred_weight_table {
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

