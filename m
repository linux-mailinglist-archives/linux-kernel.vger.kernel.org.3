Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8C4E5FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348781AbiCXIDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348765AbiCXIDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:03:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0911799ED5;
        Thu, 24 Mar 2022 01:01:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f3so2138299pfe.2;
        Thu, 24 Mar 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5VkRxphoDlEffob+x1mTjn2V5jLAaYh4z6lIZRAV4w=;
        b=SztdccuZGsYitnp5O37Adv5pazKmREdg7yYTtTI5xjFfB2W40ez4XslXUEH3pu/mYj
         RhRIF2YdKKb3eFfRvGh+Pay83BAw65hM1ekzuqwDufB1/2RO5XcZGMWa7W/kSzjA3kRk
         rSnGlKgFN6wyC+bCk+ESrtaRh1wi6/8UOwT6racfe1nLtcGOqkkCZ4xAnJen+Pf30fwg
         zfqnr1xf53dILmn9XJ/t5tEDUtul0BlM3grhvHrWKerziMlm1YV3yFbH209OEhv5+be+
         FZDXWsrgKubV6CftoDY6yWKLWMj2uzNqAs6aHUkhj1VN0JA585cRLSJzOQjd67OaVZqJ
         Of6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G5VkRxphoDlEffob+x1mTjn2V5jLAaYh4z6lIZRAV4w=;
        b=Y/ODXh4ALtgwMVdKqyBZdgBeD7A6dabe/0ZDsQ5XSammCl/97+Bh+YMcxL22gNJX9g
         cENictvQZn5ElaOTrTcGH9z/abwEhApSLNM180oQLGqwxgUOIqJMv867fzGmBhm+kT70
         NebiAmdWpBMyKjpd5WaNIJ81cuyr+9xgtudbxYB0uuV6X2LoVfBKUQmyDWWkSyeK8juF
         rUdGGVL/alpXDxOfFxxjKyo9rvABpxjPlfzUjfXBq9r/Q1n+QXLQYsdeMbNpYU7UqIBV
         OI3AfQjS7hij1983bmQxJDCU4wRGC25gPmt6XX5lwDfGo91I9E3w2ArKJga27hAYrYsg
         V7Qg==
X-Gm-Message-State: AOAM533M5zromZzUMHNpSkPcRaoFKJiDRkF+jOebsOS6m3riPwR3zBPz
        MTpMbDDqlXG11FdIvp4hHF0=
X-Google-Smtp-Source: ABdhPJzV9flb8+/KRvZtqrfv9/g03HicTQwgBkz1o7UNKYIX5ocNISFZQB5ey9sbPgYSoPVnOHZRYg==
X-Received: by 2002:a63:3e01:0:b0:386:3916:182f with SMTP id l1-20020a633e01000000b003863916182fmr2071130pga.435.1648108895546;
        Thu, 24 Mar 2022 01:01:35 -0700 (PDT)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id j14-20020a056a00174e00b004f776098715sm2443851pfc.68.2022.03.24.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:01:35 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     mchehab@kernel.org, senozhatsky@chromium.org, caihuoqing@baidu.com,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] media: dvb_vb2: fix possible out of bound access
Date:   Thu, 24 Mar 2022 16:01:19 +0800
Message-Id: <20220324080119.40133-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

vb2_core_qbuf and vb2_core_querybuf don't check the range of b->index
controlled by the user.

Fix this by adding range checking code before using them.

Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index a1bd6d9c9223..f410800b92e7 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
 
 int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 {
+	struct vb2_queue *q = &ctx->vb_q;
+
+	if (b->index >= q->num_buffers) {
+		dprintk(q, 1, "buffer index out of range\n");
+		return -EINVAL;
+	}
 	vb2_core_querybuf(&ctx->vb_q, b->index, b);
 	dprintk(3, "[%s] index=%d\n", ctx->name, b->index);
 	return 0;
@@ -378,8 +384,13 @@ int dvb_vb2_expbuf(struct dvb_vb2_ctx *ctx, struct dmx_exportbuffer *exp)
 
 int dvb_vb2_qbuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 {
+	struct vb2_queue *q = &ctx->vb_q;
 	int ret;
 
+	if (b->index >= q->num_buffers) {
+		dprintk(q, 1, "buffer index out of range\n");
+		return -EINVAL;
+	}
 	ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
 	if (ret) {
 		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
-- 
2.25.1

