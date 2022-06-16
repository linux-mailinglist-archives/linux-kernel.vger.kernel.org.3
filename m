Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0756454EB0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378618AbiFPUZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378552AbiFPUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:26 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CB5B89B;
        Thu, 16 Jun 2022 13:25:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x5so3696029edi.2;
        Thu, 16 Jun 2022 13:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3J94croFMFgt0EIDJ5nBaYvM7f2XLJQTjqgj/3/ZjU=;
        b=OjI41978muhCWJpsmE5/OwT4NeZE6oN7hB1HJMp+1zL5tIB2+dDizaiyju2FcUW9qX
         HIT9QQh11RNhiIn6kAMoJlJ0V1HcIwjQ0byUUh6vDi+Cgz473YAWz60fsAqksaBeOlfo
         wM6zf5PwHxslOSTrTzTA2LEYc1LmySjTyVOZl+H8czBl3PtiWqTCeNe/xE8Sw9rcDXoD
         Iowbhe4w+W0cfFkDnWAiYdrkDU0J8lnv8aZ4dgWrEwgnnQ75Sdx22inr6Td2NzeCf1Le
         kg0V6sUw4MclDdS2J5e7nU/G0cTj+f+OQRZs17+zHUJ5UxwRGgx7r88R08oeK8LFHMPR
         cvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3J94croFMFgt0EIDJ5nBaYvM7f2XLJQTjqgj/3/ZjU=;
        b=VrUonxT75aVYJuRf6oqRxjAp6aV7xfvb4eHaimL+Qk6WxAqIc1Xet08TG2JxFX5Rq1
         AyNm5YtU25C+dcZv1j3N80Ekv9SwejgDYWoO+1YGgtK+v1n/rWoQ4ppt6KdsAw8sRxb/
         3mtsuieXwfAMa7nplgZoVccksXN4KdjDBg+LtmGn/jr6j0yd+C/ilt8HO28zvzgDrW6M
         Z1B42mncQ+Xlq0Yxf8kjUFfSSqHmkKSLghxCb3KZA50E2T75K0GsF8Ggaz69raIO4vko
         J+kSWTBx7ii9UOfeq2z/HA1gN1PjX1lviCAKKIYwMFk6nIkJkLxLZehLB6sPn0SVWcuq
         mNjA==
X-Gm-Message-State: AJIora9++XAerLk+OxT0iZ7KeTHcYgogip75gn1gsFdrEeUbtIgLDgqK
        hmj16ndNEP/Zq6iUHNdL7kk=
X-Google-Smtp-Source: AGRyM1v1iQnrIcKC/5Ullqm08UvUYs8tXFYALDcMtA4733HLWtfij5akuBYqnFfWLR2YvuEHSDo7UA==
X-Received: by 2002:a05:6402:2788:b0:431:3f86:1d4e with SMTP id b8-20020a056402278800b004313f861d4emr8890198ede.238.1655411124688;
        Thu, 16 Jun 2022 13:25:24 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:24 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 5/7] media: hantro: postproc: Properly calculate chroma offset
Date:   Thu, 16 Jun 2022 22:25:11 +0200
Message-Id: <20220616202513.351039-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
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
2.36.1

