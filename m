Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A55691BD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiGFS2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234391AbiGFS1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:49 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D021706C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:42 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id j6so16002450vsi.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a46G/5Kp8bkaeYYmOpRfozUG4SaHDyNgsSP9Rr+h6QE=;
        b=g0SLq0LnuE9jAGE7P2zsWXYZ9YETu++Y61y6oUR2yC7BEEp/PdsmGRziTsBeBDaxC6
         9FzbHO7dv2IO47fouu86nQllnNbe9tEOAZnteVMWvpPh5/aYXD/Db4Xde+j8eBVwwwui
         PRhrpX34FlKXStOwMYGKecxTGBawU1RHOx25vMMHP+RVrU6mFY5uRzbxdQYBlzakz2Cb
         To+RAmYL22jrqYohsVXjN4KR5H+cXBoUhP5rZ/g3Y/sqMtXbQzTO53ZFzxk3Ik7i3vT4
         0xcjNSrA2RUVKOXkNBjxtY6lqCRJkRuAVoG+36Hn1ytGPiaMnM3YOE5jevKrUsxYPAus
         J6+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a46G/5Kp8bkaeYYmOpRfozUG4SaHDyNgsSP9Rr+h6QE=;
        b=H/6P1WioEqX8wapLAsw1+8SyQBzr5iSLRvbtUtOuvhoVGKnyTXuqPP+8ISpfGJrx41
         aKmiJw0LgGP2S0K+SFhgw8Eivwu3Vp/56vZ5MLfQAZvpIRx6AQmmsfRSok3+2DoflQlZ
         JlyhW9+SmIsKGC3QaiqoGGAJUhsFCqeDUYI8WzWf/O5m3Nw0a4bXtsSnPu2UZP/CJR6v
         VD4OkiSppNzPhI1C7tNNUhONFYuyAawUOLP4HbBXLXwNGMeQvM/Yd2/SOIO7yptRY1gF
         VM9aOSBht1Tq4/e7TrFNFzyGj2Haq8pW/aBnKEbQvR42NwKmvesW2MtOi8Cz2qE0QnBC
         OAOQ==
X-Gm-Message-State: AJIora+rzjpq7xfmpgA51grI0P5YqMqeuz6WAsuhNARJTftJ4OEVH7g3
        rQjjomAT4tXQuAkcvG6WYUXLjg==
X-Google-Smtp-Source: AGRyM1uSdkj6qPOlusiT7/0GDbe5C66rPoAbPf5ElEfgtvV7wAFLaBx/s4AsuvBVjFUVEDA8xWCZAg==
X-Received: by 2002:a67:b805:0:b0:354:4207:2fc6 with SMTP id i5-20020a67b805000000b0035442072fc6mr22080725vsf.64.1657132062185;
        Wed, 06 Jul 2022 11:27:42 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:41 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 8/8] videobuf2: Remove vb2_find_timestamp()
Date:   Wed,  6 Jul 2022 15:26:57 -0300
Message-Id: <20220706182657.210650-9-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've transitioned all users to vb2_find_buffer API,
remove the unused vb2_find_timestamp().

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 .../media/common/videobuf2/videobuf2-v4l2.c   | 12 ++++-----
 include/media/videobuf2-v4l2.h                | 26 +------------------
 2 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 075d24ebf44c..a9696442dfba 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -625,18 +625,18 @@ static const struct vb2_buf_ops v4l2_buf_ops = {
 	.copy_timestamp		= __copy_timestamp,
 };
 
-int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
-		       unsigned int start_idx)
+struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
 {
 	unsigned int i;
 
-	for (i = start_idx; i < q->num_buffers; i++)
+	for (i = 0; i < q->num_buffers; i++)
 		if (q->bufs[i]->copied_timestamp &&
 		    q->bufs[i]->timestamp == timestamp)
-			return i;
-	return -1;
+			return vb2_get_buffer(q, i);
+
+	return NULL;
 }
-EXPORT_SYMBOL_GPL(vb2_find_timestamp);
+EXPORT_SYMBOL_GPL(vb2_find_buffer);
 
 /*
  * vb2_querybuf() - query video buffer information
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index 7f9ae5b39b78..5a845887850b 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -62,22 +62,6 @@ struct vb2_v4l2_buffer {
 #define to_vb2_v4l2_buffer(vb) \
 	container_of(vb, struct vb2_v4l2_buffer, vb2_buf)
 
-/**
- * vb2_find_timestamp() - Find buffer with given timestamp in the queue
- *
- * @q:		pointer to &struct vb2_queue with videobuf2 queue.
- * @timestamp:	the timestamp to find.
- * @start_idx:	the start index (usually 0) in the buffer array to start
- *		searching from. Note that there may be multiple buffers
- *		with the same timestamp value, so you can restart the search
- *		by setting @start_idx to the previously found index + 1.
- *
- * Returns the buffer index of the buffer with the given @timestamp, or
- * -1 if no buffer with @timestamp was found.
- */
-int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
-		       unsigned int start_idx);
-
 /**
  * vb2_find_buffer() - Find a buffer with given timestamp
  *
@@ -86,15 +70,7 @@ int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
  *
  * Returns the buffer with the given @timestamp, or NULL if not found.
  */
-static inline struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q,
-						 u64 timestamp)
-{
-	int index = vb2_find_timestamp(q, timestamp, 0);
-
-	if (index < 0)
-		return NULL;
-	return vb2_get_buffer(q, index);
-}
+struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp);
 
 int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b);
 
-- 
2.34.3

