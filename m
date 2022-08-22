Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDA59B8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiHVFxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiHVFx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:53:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED8B86B
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:27 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 73so8483378pgb.9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc;
        bh=O/M4gOzUrS+M1rmwcv2FdRwcaAkd5vB4biny3T6F6f4=;
        b=pNCUfvV+iKyU66Tmc1O3WHyKIWWwat/XYwIpOtl6bavoGIBn1SVzgRaalxmVXonCVa
         qaI/96P8I9/QgLqRp5MZ8bV5ZekprrUkpyKFqY/sltIlr+9ZSq+fx6groR0cOllX6o4L
         cDY2oEn4oKnsWBGfzbJeWnbgqYIlWRkqkaud1dm13ZvlQRsXqTVk0HVmIoSBAfnZFRtu
         VrCHpomQLv57X3DnTo/qErpzUSCITvsDMF0vxX7J8J3RCabeerbzFhbUM4S5EcjA5sdG
         C5BbC1MqQjy99z4b79txqQu/QxRwcHjOzYmxMUybjOqu1lUuocUmT/HYKEPIUkimz0lD
         mR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=O/M4gOzUrS+M1rmwcv2FdRwcaAkd5vB4biny3T6F6f4=;
        b=tZ30o1f0MhBMQAAG1TKGxf4jHt2FvzGbQqpaxowvKWP8NwIcumBmhxi8i4QPDoJnSR
         eW0lu/jYYa+awKEPpmdjpJPm51c9TQU7en9V8EnZPVcUhYV7xe8+z2ban+s4+563npSD
         3qNyqMyPBSbaRnqCwOK81diJR5D/83tcgumEK6YMDalXZVLplOB7rdsUyr/9UmLTjx5l
         7ITpqjlT51dbdYBpfd19dhtQimVb7SuWtDrsNvP2PzOeO3wK8DyOVz7HYcbhkWN2eSzc
         J4bxI1IEZRzxDny4XsH53O/z7WF7dcGdv9BHVVKSJCBHzw+EjC4imNMpyYydfotyreh6
         5IBA==
X-Gm-Message-State: ACgBeo2CIxJyo0h/6eZ9sXcdEX2s8NWXz5bYKo8FpQTxLgBbiFSB7bpr
        9O1BxzySlg+NpLaRJqjBd12SynBEYRg=
X-Google-Smtp-Source: AA6agR6uey2bQTOUFCW+XJ2KWuVJB6sj2RiunNYq6PyFdwCzeEFUMCOEgEzAn+7NvdRLAx1uTJ7ISQ==
X-Received: by 2002:a63:2cc6:0:b0:41c:5f9c:e15c with SMTP id s189-20020a632cc6000000b0041c5f9ce15cmr15384463pgs.241.1661147606740;
        Sun, 21 Aug 2022 22:53:26 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm7078817pjb.46.2022.08.21.22.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:53:26 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH 1/2] erofs: support on-disk offset for shifted decompression
Date:   Mon, 22 Aug 2022 13:53:00 +0800
Message-Id: <d424334dc32483e93baf0a215dab88c90d14e5c2.1661146058.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
In-Reply-To: <cover.1661146058.git.huyue2@coolpad.com>
References: <cover.1661146058.git.huyue2@coolpad.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Currently, there is no start offset when writing uncompressed data to
disk blocks for compressed files. However, we are using in-place I/O
which will decrease the number of memory copies a lot if we write it
just from an offset of 'pageofs_out'. So, let's support it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..dc02d95b52d7 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -326,6 +326,7 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 					     PAGE_SIZE - rq->pageofs_out);
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	unsigned char *src, *dst;
+	unsigned int headofs_in;
 
 	if (nrpages_out > 2) {
 		DBG_BUGON(1);
@@ -337,21 +338,25 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 		return 0;
 	}
 
+	/* set it to pageofs_out if fragments feature is used */
+	headofs_in = 0;
+
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + headofs_in, righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
-		} else {
+		if (rq->out[1] != *rq->in) {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
+			memcpy(dst, src + (headofs_in ? 0 : righthalf),
+			       lefthalf);
 			kunmap_atomic(dst);
+		} else if (!headofs_in) {
+			memmove(src, src + righthalf, lefthalf);
 		}
 	}
 	kunmap_atomic(src);
-- 
2.17.1

