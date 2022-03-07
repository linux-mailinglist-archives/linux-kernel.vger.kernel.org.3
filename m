Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44E34CFB64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbiCGKhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242126AbiCGKLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:11:15 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51898879E;
        Mon,  7 Mar 2022 01:54:29 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qx21so30577618ejb.13;
        Mon, 07 Mar 2022 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LFdIEDDy0ZaKGYeFQ4O3vTisKLa+lVgmmPHb0pU4IoY=;
        b=qoygGdB9he2opWGHDYY9XoglRQBeKxqr2galGyGL324N6uwz5pYadRvnCC/qmNoth2
         SSfIHRN5tIWzfosn3sS8tPkOytRkjeisdeDpM2k0zRYTe/kAsGdQqIyqANiVzAG6P2LH
         SAdpeHjenJ2OHWABdj13zKU8Psy1bUdE1o5tqvvOETChL5hMz1fNIOWfsXUewp8/wHDB
         1ve8ceRYlWaZyuxoBXLj1LzDNjKUn/oSswux10YTXCHdGobid0FL5GdG3MYQ13HM5Vat
         RJgFmQFHC+D1lnfzCKDRY+bOBt0pYxbEdb+n/OuV599iG3vXRILheS1wnPIMPCbFBhbf
         ObjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LFdIEDDy0ZaKGYeFQ4O3vTisKLa+lVgmmPHb0pU4IoY=;
        b=ZSJ6dqaohmaCwsyTuH+7l5R5WCVFbKN11n4pK83+QxxpMbxpfxvL11DEX/Kmra6X6c
         lhMtQ7zmEErvtU+0Xk6KDe7LjmA2KJg2kn75LnxrSWQPb6ME10HwdkthF9/kDkpLggwf
         Y9x3Rp0mThP0vFxX2b2HIu9lmA4uEJJBcEi97pgMnfsTKoNYZ0zJjuR7TFqvrUJEU2sO
         KyWjsMxWSz8XCGJP4COEe7nJjFNqS9HSKxfF4AiJMrP3ne3QwB+pPMPXoaVWnBdldtut
         uayaGvo7Fs511gIJvKy8pTVB1czTtCYq3Iq4DXFjHd04mllGVUlGaBrn9253McIpgN4k
         nPHQ==
X-Gm-Message-State: AOAM532q1BSIxL/r6IAIyR/38gw4a7c2elZJm/yHAXDfIGwSG/QkR/yE
        Wdb66Dyi60Vkw1Wv9Gzvbzk=
X-Google-Smtp-Source: ABdhPJzn9/vfO4XyyIBeJkoetqe/kypEJfdHkvj7lvP5sVvs0XW3c1b5gVNgK7dQKvtaEsb5zpkcxw==
X-Received: by 2002:a17:907:168f:b0:6da:b548:4f9f with SMTP id hc15-20020a170907168f00b006dab5484f9fmr8375270ejc.666.1646646867157;
        Mon, 07 Mar 2022 01:54:27 -0800 (PST)
Received: from felia.fritz.box (200116b826f87d009c8e984acb545ab7.dip.versatel-1u1.de. [2001:16b8:26f8:7d00:9c8e:984a:cb54:5ab7])
        by smtp.gmail.com with ESMTPSA id n3-20020a1709061d0300b006da94efcc7esm4333310ejh.204.2022.03.07.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 01:54:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH RESEND] block: remove dead queue_dma_alignment branch from bio_map_user_iov()
Date:   Mon,  7 Mar 2022 10:54:11 +0100
Message-Id: <20220307095411.30459-1-lukas.bulwahn@gmail.com>
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

If queue_dma_alignment(rq->q), then blk_rq_map_user_iov() will call
bio_copy_user_iov() and not bio_map_user_iov(). So, bio_map_user_iov() does
not need to handle the queue_dma_alignment(rq->q) case in any special way.

Remove this dead branch from bio_map_user_iov().

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
still applies on next-20220307

added Christoph's Reviewed-by tag from:
  https://lore.kernel.org/all/20220104124724.GA21670@lst.de/

Jens, this patch must have fell through the cracks...
please pick this minor non-urgent clean-up patch.


 block/blk-map.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index c7f71d83eff1..2a1d7c5f791e 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -260,31 +260,26 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 		npages = DIV_ROUND_UP(offs + bytes, PAGE_SIZE);
 
-		if (unlikely(offs & queue_dma_alignment(rq->q))) {
-			ret = -EINVAL;
-			j = 0;
-		} else {
-			for (j = 0; j < npages; j++) {
-				struct page *page = pages[j];
-				unsigned int n = PAGE_SIZE - offs;
-				bool same_page = false;
-
-				if (n > bytes)
-					n = bytes;
-
-				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
-						     max_sectors, &same_page)) {
-					if (same_page)
-						put_page(page);
-					break;
-				}
-
-				added += n;
-				bytes -= n;
-				offs = 0;
+		for (j = 0; j < npages; j++) {
+			struct page *page = pages[j];
+			unsigned int n = PAGE_SIZE - offs;
+			bool same_page = false;
+
+			if (n > bytes)
+				n = bytes;
+
+			if (!bio_add_hw_page(rq->q, bio, page, n, offs,
+					     max_sectors, &same_page)) {
+				if (same_page)
+					put_page(page);
+				break;
 			}
-			iov_iter_advance(iter, added);
+
+			added += n;
+			bytes -= n;
+			offs = 0;
 		}
+		iov_iter_advance(iter, added);
 		/*
 		 * release the pages we didn't map into the bio, if any
 		 */
-- 
2.17.1

