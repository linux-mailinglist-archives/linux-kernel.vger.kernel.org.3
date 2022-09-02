Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AA65AA80D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 08:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiIBGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiIBGcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 02:32:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527B0B14EA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 23:32:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 199so1003954pfz.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kLnHKzUhQUtEqhe241FKh09xdL2v/zozWI6ZKV+2obU=;
        b=QqoFhQ+UqZRtcqRxsbr1JyRO39dkDQ5TR+O4BcwYGTZIufanaahHtNQyNF6SPx9kdc
         hOUA2Pmmpf5m14QuDz3ZYcreqEeocku4sbuWdIVMWyZ9bbWFNBja10d+YLlr2ApnghVq
         E+KE2EAKlldsSPpA0WNSSR+wYuZZhLVdvkzCO4xjjmXmI0s4eXqtpnA79k38BGPyHvru
         fOZ/9Of3HGoRrw4FaMLS0Z/2nQ/3UWKZgG+7ymoMf0l1XM83bUJ8kozbSei8mZziLUun
         hpKVvO26bgiAAGGmHn5pjqn5N3fd45U8y0A0Buqrc/efd4ibaxovwtLdYiyDC69Trt62
         r5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kLnHKzUhQUtEqhe241FKh09xdL2v/zozWI6ZKV+2obU=;
        b=pujYGmuGi/7L6gc08G+C7NK2roPpjay3JscLK1N/USLzavRAImjarpQQa3GcgsLaXg
         tEmtuGjp+ezuZYlqWLex/q56pf7u2CTX856e1rs9YkUYKC0rM5yMapubROiXnahMRwsJ
         S8lnIyMmXDBIofEI3BK5yb2lhfidSYjE6RVLuBgV5ce8yF8Xqo0bgTbGWcR4uNMI8vIZ
         YgmyAOv0+B1E/j0nPlgqcBO3vBPMNmlvVFHvEr9dqHGNZKfU8bf3oARQKFlkhe6GhWLT
         u5Z+9yc9WVgA4xe5Vo7hmrxstb0CO6MmxgFhy6TnvrH+fUyw06cNXOUdCU6DCR2BS4aG
         OpIQ==
X-Gm-Message-State: ACgBeo16MXhc0yH1MDE9c3/B2cf0Pw21DNL1IHFEHwxxem9fOabaDKZb
        yHZLRpQuYZaOQ6Bec0agTqY=
X-Google-Smtp-Source: AA6agR75raVgus7hK607KKw892NdHOvA5Fn41T8aDP2nbQPifHOsmsJrZNstB8b8rZgF6US1bqFmJw==
X-Received: by 2002:a63:d607:0:b0:427:bc0c:55c8 with SMTP id q7-20020a63d607000000b00427bc0c55c8mr29376102pgg.402.1662100338852;
        Thu, 01 Sep 2022 23:32:18 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c82-20020a621c55000000b005381f50d1e8sm769851pfc.115.2022.09.01.23.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 23:32:18 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [PATCH] erofs: support uncompressed pcluster with more than 1 block
Date:   Fri,  2 Sep 2022 14:31:34 +0800
Message-Id: <20220902063134.7639-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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

The length of uncompressed pcluster may exceed one block in some new
scenarios such as non 4K-sized lcluster (which will be supported later).
So, let's support the decompression for this firstly.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 56 +++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..fe6abb79e560 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,41 +320,55 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct page **pagepool)
 {
+	const unsigned int nrpages_in = rq->inputsize >> PAGE_SHIFT;
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
 					     PAGE_SIZE - rq->pageofs_out);
-	const unsigned int lefthalf = rq->outputsize - righthalf;
+	const unsigned int lefthalf = min_t(unsigned int,
+					    rq->outputsize - righthalf,
+					    PAGE_SIZE - righthalf);
 	unsigned char *src, *dst;
+	unsigned int i;
 
-	if (nrpages_out > 2) {
+	if (nrpages_in == 1 && nrpages_out > 2) {
 		DBG_BUGON(1);
 		return -EIO;
 	}
 
-	if (rq->out[0] == *rq->in) {
-		DBG_BUGON(nrpages_out != 1);
-		return 0;
-	}
+	i = 0;
+	do {
+		src = kmap_atomic(rq->in[i]) + rq->pageofs_in;
+
+		if (rq->out[i]) {
+			if (rq->out[i] == rq->in[i]) {
+				DBG_BUGON(nrpages_in == 1 && nrpages_out != 1);
+			} else {
+				dst = kmap_atomic(rq->out[i]);
+				memcpy(dst + rq->pageofs_out, src, righthalf);
+				kunmap_atomic(dst);
+			}
+		}
 
-	src = kmap_atomic(*rq->in) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
-		kunmap_atomic(dst);
-	}
+		if (i + 1 == nrpages_out) {
+			kunmap_atomic(src);
+			break;
+		}
 
-	if (nrpages_out == 2) {
-		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
+		if (rq->out[i + 1]) {
+			if (rq->out[i + 1] == rq->in[i]) {
+				memmove(src, src + righthalf, lefthalf);
+			} else {
+				dst = kmap_atomic(rq->out[i + 1]);
+				memcpy(dst, src + righthalf, lefthalf);
+				kunmap_atomic(dst);
+			}
 		} else {
-			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
-			kunmap_atomic(dst);
+			DBG_BUGON(nrpages_in == 1 && nrpages_out == 2);
 		}
-	}
-	kunmap_atomic(src);
+		kunmap_atomic(src);
+	} while (++i < nrpages_in);
+
 	return 0;
 }
 
-- 
2.17.1

