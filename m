Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8175691D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbiGFS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234400AbiGFS3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B9DA5;
        Wed,  6 Jul 2022 11:29:19 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id a5so8530707wrx.12;
        Wed, 06 Jul 2022 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBjdN5NUGMSrTfcSwRSnviKC0jDxf73NH1c09YBH+ks=;
        b=klI9lAEds8ntHb3bSSotoDSlhZMq2joJLVCnocYqYFGSS7LZmvwrfnitTKi1K6X/b9
         pvJgM59bEy0ouuAf+lNwyppcYvw8lBzDlzA6BI+FcfLqD6N7rS++8g8lNiPcA8NWaD9B
         XmURxrAAIG01cIj4P3/Wy3UccHZfiD7otxMF08UVoPm/WsqNorgmp9r9NZfI3LXJoMsQ
         wgs6GYjr+2nc9PEINOCpgW2hUZ5XSDv2vOMBubI/2jc23JBJ4pv+9iBkfPsM7WYT5BEL
         mgqS7jKsNeL6Vl4KxMi5x5l0/ANyplO1b1q6JgW6u816RjrkvctCuR/nNTkb/0MvJ3Ad
         /VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBjdN5NUGMSrTfcSwRSnviKC0jDxf73NH1c09YBH+ks=;
        b=gBptGLt93mYTRLAuxZ+dlCELvd40hUznr71iB9tI2p1BNBBKPn0B6a+GDm3+UMLDLF
         T9mNlGsMOu1KG1gSjIUm1uqxHLqWZc36OZ8iSx91tYgDtprK8ObheAAzzf/68+WuVxxH
         86WbDPdzIQyJQvTpshy7tfBC+vClTc1I6UlYcTQstG0gslMaY+XHCAyQ0d+QchfxcG2D
         SGVhI/RjRICEdjZnO8xHmeULezb/d5wcoxNzbLl5TqineM+CwwyVc90zLCmaBdzKTsmm
         KIe+gwRMRBnBi9F2p64JFWhsf2hNji4nP+ZcRBEdIUEwd7TOTw3mLqYQ6SB/hcVNuzZC
         SElA==
X-Gm-Message-State: AJIora9DjHhIgGgxHb2Qrv6FWr0A8Rf/UPs+Cl88LtIIu+51miSLTk5L
        7lT3PboK+uIvPhZvEMax5xw=
X-Google-Smtp-Source: AGRyM1vmHpcNssTFlNOXB27/03qd4J3xPuu63Y2Bl+wCdVyppCVWa3L2700thlJ4oAbh6D/NAoWZZg==
X-Received: by 2002:a5d:5f05:0:b0:21b:8ca0:6d3d with SMTP id cl5-20020a5d5f05000000b0021b8ca06d3dmr38801018wrb.382.1657132158045;
        Wed, 06 Jul 2022 11:29:18 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:17 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 5/7] media: hantro: postproc: Properly calculate chroma offset
Date:   Wed,  6 Jul 2022 20:28:59 +0200
Message-Id: <20220706182901.78949-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706182901.78949-1-jernej.skrabec@gmail.com>
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently chroma offset calculation assumes only 1 byte per luma, with
no consideration for stride.

Take necessary information from destination pixel format which makes
calculation completely universal.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro_postproc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index 8933b4af73ed..a0928c508434 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -113,12 +113,14 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *dst_buf;
-	size_t chroma_offset = ctx->dst_fmt.width * ctx->dst_fmt.height;
 	int down_scale = down_scale_factor(ctx);
+	size_t chroma_offset;
 	dma_addr_t dst_dma;
 
 	dst_buf = hantro_get_dst_buf(ctx);
 	dst_dma = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
+	chroma_offset = ctx->dst_fmt.plane_fmt[0].bytesperline *
+			ctx->dst_fmt.height;
 
 	if (down_scale) {
 		hantro_reg_write(vpu, &g2_down_scale_e, 1);
-- 
2.37.0

