Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E8252C9BC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 04:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiESCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 22:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiESCSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 22:18:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DACC03BA;
        Wed, 18 May 2022 19:18:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so7424166pjb.2;
        Wed, 18 May 2022 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeX8w/tHzQMRh97u9HLg+afFKVHsNgRdUyS/TL/tFmA=;
        b=KVBvFQ9YS19mLDlSZBGgTG8QmY88NWqRL+Zdt+9e++VxhDUOavYgmvT5U6xOaRaj5e
         c/HGDwqd2zxj8bkYiZ036YdHVShZZgTfyNIovn927R00DucYUHUufFEW0Ca+HRsCOj7E
         /p4NhbInAdFA8OyuuBTr9bnV/NDhRExU3dgO7ISPkdk9I+LO2GdkhvtqOGC7EJ7n4eYE
         7ratehvr7WapPNnIGwiLazuKv27m+Nm8WBD1pUqQmDA3566KD3eEglonI+5znVlcMkCM
         NnrLCChO0yokU1Cii1hQxB8jb2mdNLMKUR4Kk5vISlXutokQWD9ayvJU/oaKZuAN0mmm
         8Ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KeX8w/tHzQMRh97u9HLg+afFKVHsNgRdUyS/TL/tFmA=;
        b=6V8PbRnBxxKL+DR0BRaNNnWb9RdbvyfuXhn7Tmkb9Pgf0E+PC39FW+PweJ/kMyU5Rh
         CGX7gt2TkjZhIaAJSu0sZ4jhP4kEg5fYdOm70nEcos0xVCB+4232Ryxnp8JS4SnUBTOS
         XlxbMej8dy9/dhsux527uFVPv1ofmimL8aFhB/oDiN2NaxH3xmjKDVXamSw2ktmOaY4E
         cr3UaOj23DXY3CAmTCV3IJO1AiblbCLabKb3fSKMQ6Km89XnbURc5o3NazJklRI8w7d/
         4PTF1y73OvcgRb0T7lSDsUnQA479Jbk3DBWoHNaHd9tvMYZ9uoc33m2qNoLxbqfET5LH
         d/JQ==
X-Gm-Message-State: AOAM530VF4GEHjRvRlJN5EriooViUeVE5kJdq0I6N90dEScAeKTufmqw
        bRV6PZZHGIJRFu4w5uEvUoo=
X-Google-Smtp-Source: ABdhPJza5NJsX50MgITiY21AXbqRp+aNg3kqzni2ni98Vxr5gRd5WexpY9rrSjpDP9Q2v6nVea/xDw==
X-Received: by 2002:a17:902:dad1:b0:161:9abb:fb75 with SMTP id q17-20020a170902dad100b001619abbfb75mr2469103plx.135.1652926719221;
        Wed, 18 May 2022 19:18:39 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id 63-20020a621842000000b00512d13016d0sm2548596pfy.159.2022.05.18.19.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 19:18:38 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     mchehab@kernel.org, senozhatsky@chromium.org,
        cai.huoqing@linux.dev, hverkuil-cisco@xs4all.nl,
        sw0312.kim@samsung.com, satendra.t@samsung.com,
        jh1009.sung@samsung.com, nenggun.kim@samsung.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] media: dvb_vb2: fix possible out of bound access
Date:   Thu, 19 May 2022 10:17:43 +0800
Message-Id: <20220519021743.8295-1-hbh25y@gmail.com>
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

Fixes: 57868acc369a ("media: videobuf2: Add new uAPI for DVB streaming I/O")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---

v2: 
1. fix inappropriate use of dprintk.
2. add "fixes" tag

 drivers/media/dvb-core/dvb_vb2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/media/dvb-core/dvb_vb2.c b/drivers/media/dvb-core/dvb_vb2.c
index a1bd6d9c9223..909df82fed33 100644
--- a/drivers/media/dvb-core/dvb_vb2.c
+++ b/drivers/media/dvb-core/dvb_vb2.c
@@ -354,6 +354,12 @@ int dvb_vb2_reqbufs(struct dvb_vb2_ctx *ctx, struct dmx_requestbuffers *req)
 
 int dvb_vb2_querybuf(struct dvb_vb2_ctx *ctx, struct dmx_buffer *b)
 {
+	struct vb2_queue *q = &ctx->vb_q;
+
+	if (b->index >= q->num_buffers) {
+		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
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
+		dprintk(1, "[%s] buffer index out of range\n", ctx->name);
+		return -EINVAL;
+	}
 	ret = vb2_core_qbuf(&ctx->vb_q, b->index, b, NULL);
 	if (ret) {
 		dprintk(1, "[%s] index=%d errno=%d\n", ctx->name,
-- 
2.25.1

