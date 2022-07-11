Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A5570C75
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiGKVL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiGKVLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:11:52 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E7341D16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:51 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bf634bc50so8208068fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LyzUozuJU4BdsAIYqhi4n317kUN4El07MnlD4WMek9A=;
        b=GiUsAiGhNhkqEvptw+JKaLtTm4VODxNLVRyC8XKIxO8El5hyrgsjyq0rcgPvDS9ivs
         cCrLuIMpEKojgIHNfyVXej4Xu+UmuaTbo6qfPZD16zijup63334FxpBWWglPJzgzdl5t
         RcKUgya+Opa4EwY9ni2K7YxVP5hLiIR8lLsvPAgfR5PXj11keW17MoWiobcU4I8idpPf
         KbdD0TWw702UWVaEjp0Q/MLN6mPXZXlT1vGvz26UjFPbbVXZmUuv+39E3e8FX8jZlxV8
         t8UwVF0wAYLiQvkq5qT2/WpHmH32QriPsMc5wUAj7zlc9Pab/jdld/XZHALml0loT3KU
         V1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LyzUozuJU4BdsAIYqhi4n317kUN4El07MnlD4WMek9A=;
        b=xu6dD8m925qaBBT4/CuV5g2mkbXWmV84LDWKsqlJo1J3xEsQiLeSIKD0D2FV3dqWRc
         ITyERqHVO/7rTgfoF6/zDqXO3xt9XKrHbxKkzzLZp0CZWnJ7kTtaNg5ayooLNHakkpNt
         RjOWh9w6g3heYNvb1kjEC2sTXuKGfP3HdyBtAzQfvLG7ndvMIVYOMqO11OqqBaytcylo
         CR3ZpPXyn8kXvRnqUw7dEn4vqxdtoEgVMPtbaM3lnZAPW3AJ7WUCkZmKETg+N428ZwzE
         edVjMweCmC7hUgoVJ7tZMUy+A7RUfb57pCEv+/BKsV1S7xeLEglCevJ4b0q1RJPlGQW3
         8g+Q==
X-Gm-Message-State: AJIora8aB5Lm8zV7s2mHeCSs+9ibx09zez9tdnYBhOmRiNrYVX+CIABX
        4GT7tiNobZbt6r9ogsFZlaJWxg==
X-Google-Smtp-Source: AGRyM1vu3pSG3WIGRVXNNIZR77WzqoZE4bXt7ev5n7SYrsj7fTJ/whAiwWHnR22EqT18JI5TR1/69A==
X-Received: by 2002:a05:6870:1490:b0:10c:3362:23c3 with SMTP id k16-20020a056870149000b0010c336223c3mr168171oab.73.1657573910976;
        Mon, 11 Jul 2022 14:11:50 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:11:50 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 1/8] videobuf2: Introduce vb2_find_buffer()
Date:   Mon, 11 Jul 2022 18:11:34 -0300
Message-Id: <20220711211141.349902-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
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

From: Ezequiel Garcia <ezequiel@collabora.com>

All users of vb2_find_timestamp() combine it with vb2_get_buffer()
to retrieve a videobuf2 buffer, given a u64 timestamp.

Introduce an API for this use-case. Users will be converted to the new
API as follow-up commits.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Acked-by: Tomasz Figa <tfiga@chromium.org>
---
 drivers/media/common/videobuf2/videobuf2-v4l2.c | 12 ++++++++++++
 include/media/videobuf2-v4l2.h                  | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/media/common/videobuf2/videobuf2-v4l2.c b/drivers/media/common/videobuf2/videobuf2-v4l2.c
index 075d24ebf44c..f26cb8586bd4 100644
--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -638,6 +638,18 @@ int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
 }
 EXPORT_SYMBOL_GPL(vb2_find_timestamp);
 
+struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp)
+{
+	unsigned int i;
+
+	for (i = 0; i < q->num_buffers; i++)
+		if (q->bufs[i]->copied_timestamp &&
+		    q->bufs[i]->timestamp == timestamp)
+			return vb2_get_buffer(q, i);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(vb2_find_buffer);
+
 /*
  * vb2_querybuf() - query video buffer information
  * @q:		videobuf queue
diff --git a/include/media/videobuf2-v4l2.h b/include/media/videobuf2-v4l2.h
index d818d9707695..76e405c0b003 100644
--- a/include/media/videobuf2-v4l2.h
+++ b/include/media/videobuf2-v4l2.h
@@ -78,6 +78,16 @@ struct vb2_v4l2_buffer {
 int vb2_find_timestamp(const struct vb2_queue *q, u64 timestamp,
 		       unsigned int start_idx);
 
+/**
+ * vb2_find_buffer() - Find a buffer with given timestamp
+ *
+ * @q:		pointer to &struct vb2_queue with videobuf2 queue.
+ * @timestamp:	the timestamp to find.
+ *
+ * Returns the buffer with the given @timestamp, or NULL if not found.
+ */
+struct vb2_buffer *vb2_find_buffer(struct vb2_queue *q, u64 timestamp);
+
 int vb2_querybuf(struct vb2_queue *q, struct v4l2_buffer *b);
 
 /**
-- 
2.34.3

