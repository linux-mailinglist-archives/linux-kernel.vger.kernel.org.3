Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1ED5AB35E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbiIBOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiIBOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:24:09 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E66BCCD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:51:05 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f12so1889827plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zNUF4pLM2gZEdiAVUHg/D43GzpVxrjgPWBN3pmIBL4Q=;
        b=OWTK6Y3PL2yw7UqNBd3BKxNCZm3WWdoiwL1O1myrStMFLYjzS/PshODfkZouf8TdyM
         34cfblzJlfbsqzNTY6EcRcNxJC+uL41ewK3gT6X1TwMuFzMCqa191Inwq/0gtQUyzuNO
         cddhry2HZJMnpVcKm2BU+YBLOvZt/QL7bUiOR4zophKpy1XohzLV0QP4JcY1npbc9+x/
         vnpntCAk0tMhTT0Ghf1CTgl2cxobFno1trWx76Ijdugmfyr5paHVZm2dJ1CWMxpUWtRU
         FfyyJzCZoPRyw/CXk4ycMlyeefC51asE+FfRfTG42UBFQ5JYu76DePVZJ+j8JUeA6X/c
         SD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zNUF4pLM2gZEdiAVUHg/D43GzpVxrjgPWBN3pmIBL4Q=;
        b=Pxb20gsNH1YJAYQqETyPylFEyWF8Wu+AyY7IlG51NGzt7eUMvUKrz1w9jBuGlpj3dU
         nCn1iNx8vOvaaKMJX16KMPMhMya6GlrbByiZlbujJhX47AY+5QXZ3/KZ1/noQU8jQHtf
         oqsFElhlGljPQ9fIb1Dz4v35ZXSheDD/zFc2SF6sgMXzHktcxZ9QXcWXqc5PoTgSPW6f
         ABBoLgdXSm0hsEo/g+A1Kf4SAvKqRn/+uywO028kE6lisCYafEQL9wTM4XV2bFsLf5Ka
         Vo2TlbPJyMP+cAJiWgH2YW6D6TnTMwb3OosDXW32plQq2Ww3sfdN2CBYBeVzq/ZWvgye
         Li/Q==
X-Gm-Message-State: ACgBeo2WcI95LLlDEaOYambuUu0OxQ+T6/4vDkh2PkuwnFrfCaG4FaK5
        uM0mdkREqyWoZoNXKEdZRNj6TYXrMf1lLA==
X-Google-Smtp-Source: AA6agR62SVCb2fOMwXF20SiASjjKCcM0ENGQ/zfWNHw3aYk/dQ1Z0bmkeiGXxhGn8OHTbPIjNQ3wbw==
X-Received: by 2002:a17:902:f64d:b0:172:d004:8b2d with SMTP id m13-20020a170902f64d00b00172d0048b2dmr36077767plg.14.1662126664789;
        Fri, 02 Sep 2022 06:51:04 -0700 (PDT)
Received: from localhost.localdomain ([49.77.180.166])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm1733739pfm.159.2022.09.02.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 06:51:04 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH v2] erofs: support uncompressed pcluster with more than 1 block
Date:   Fri,  2 Sep 2022 21:50:36 +0800
Message-Id: <20220902135036.11595-1-zbestahu@gmail.com>
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
v2: fix tail data length.

 fs/erofs/decompressor.c | 64 ++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..77d2b6cb6eda 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -320,41 +320,59 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 				     struct page **pagepool)
 {
+	const unsigned int nrpages_in = rq->inputsize >> PAGE_SHIFT;
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
-	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
-					     PAGE_SIZE - rq->pageofs_out);
-	const unsigned int lefthalf = rq->outputsize - righthalf;
+	unsigned int righthalf, lefthalf, i;
 	unsigned char *src, *dst;
 
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
+		unsigned int outputsize = rq->outputsize;
+
+		righthalf = min_t(unsigned int, outputsize,
+				  PAGE_SIZE - rq->pageofs_out);
+		lefthalf = min_t(unsigned int, outputsize - righthalf,
+				 PAGE_SIZE - righthalf);
+
+		src = kmap_atomic(rq->in[i]) + rq->pageofs_in;
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
+
+		if (outputsize > PAGE_SIZE)
+			outputsize -= PAGE_SIZE;
+	} while (++i < nrpages_in);
+
 	return 0;
 }
 
-- 
2.17.1

