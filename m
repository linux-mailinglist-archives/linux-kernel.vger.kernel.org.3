Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9364EE448
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbiCaWmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242462AbiCaWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:42:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA731C406A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:40:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p15so2216981ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAF79ixH7XO8/kHbUATTBHFnSkL/nkVXYK4Bx07Es9M=;
        b=UIHknE8/0aEaHT5OU1wimWGQYJ5o31cxftZWanbrU5Brir065xFzKQOI5vADS0tzO8
         h//1/dAWPEaeRdGL9/XpgnqDgcWVczQ4vD0W57XPVFF3Hkilqx5w4A8XOpBs9ZMVFAIU
         kOoHD+Wjf66cMpSUXEd21tMYlwQvBjyJ+k4MxREj+OfWpL6rndZLIE2EGLbLSvx+ssqy
         KkiGMhQ4T0lCmKOnc/2J5woXOFNfMAWx9f5mU4EJYamjULdZNMONj68J8okbFkhUfhhA
         go48snyAgXnLinYYkYYsmJVUMVuh4u/EbbXtu3l2nUbYHsqmhUuC+/B8Ew6eEQvDHJqq
         B8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAF79ixH7XO8/kHbUATTBHFnSkL/nkVXYK4Bx07Es9M=;
        b=JaysUJsnLVq3EE2oMRsoo7dq40oKg1vvCCATE3ER8QLQy8rcydlDgcjNEUSojaipqb
         2UH43eNRiKGvCO8dMOvO1i98sDoXmWT0Sz/ZsBXBLSGbRuNIDiPsuwgaruFCtO7xnBkd
         +VANCwYMH16Sgi43dOfFxH7ZS2C6tVo3S9Rr04HAWT/00AOC8e1aSc44ql0BrtOhhXCy
         YbzPV/0DJ76XTBZCwrj6ErbzL4gv81cBsumkeLCLmCLuQJ35wR4exRvmsVWxFCnYCPIw
         suDgDQaTrgJZNRjGogduiI7YnrXeW32BtfXB13i4loExGO4CtXwkjURFePZr3bQW+vnK
         gCzA==
X-Gm-Message-State: AOAM533u9b20CdH6w4UzVoFrD9SUHU8rOUXkqkB89rFLOt+mY2xy2wkj
        rUeUFlwE1GBVGPWoaol/ct4=
X-Google-Smtp-Source: ABdhPJwRUYP4bzLKrhGs345u5NZhGKemPeZq835ij8gf8hKkMzb4rrnRyuAUb3KfXn8Zw9FS/8Ri+g==
X-Received: by 2002:a17:907:3e16:b0:6df:b4f0:5cc2 with SMTP id hp22-20020a1709073e1600b006dfb4f05cc2mr6849525ejc.285.1648766427340;
        Thu, 31 Mar 2022 15:40:27 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id j21-20020a170906255500b006e08c4862ccsm278505ejb.96.2022.03.31.15.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:40:27 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH 1/2] gfs2: remove usage of list iterator variable for list_for_each_entry_continue()
Date:   Fri,  1 Apr 2022 00:38:56 +0200
Message-Id: <20220331223857.902911-1-jakobkoschel@gmail.com>
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

In preparation to limiting the scope of a list iterator to the list
traversal loop, use a dedicated pointer to iterate through the list [1].

Since that variable should not be used past the loop iteration, a
separate variable is used to 'remember the current location within the
loop'.

To either continue iterating from that position or start a new
iteration (if the previous iteration was complete) list_prepare_entry()
is used.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 fs/gfs2/lops.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 6ba51cbb94cf..74e6d05cee2c 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -653,7 +653,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 				bool is_databuf)
 {
 	struct gfs2_log_descriptor *ld;
-	struct gfs2_bufdata *bd1 = NULL, *bd2;
+	struct gfs2_bufdata *bd1 = NULL, *bd2, *tmp1, *tmp2;
 	struct page *page;
 	unsigned int num;
 	unsigned n;
@@ -661,7 +661,7 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 
 	gfs2_log_lock(sdp);
 	list_sort(NULL, blist, blocknr_cmp);
-	bd1 = bd2 = list_prepare_entry(bd1, blist, bd_list);
+	tmp1 = tmp2 = list_prepare_entry(bd1, blist, bd_list);
 	while(total) {
 		num = total;
 		if (total > limit)
@@ -675,14 +675,18 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 		ptr = (__be64 *)(ld + 1);
 
 		n = 0;
+		bd1 = list_prepare_entry(tmp1, blist, bd_list);
+		tmp1 = NULL;
 		list_for_each_entry_continue(bd1, blist, bd_list) {
 			*ptr++ = cpu_to_be64(bd1->bd_bh->b_blocknr);
 			if (is_databuf) {
 				gfs2_check_magic(bd1->bd_bh);
 				*ptr++ = cpu_to_be64(buffer_escaped(bd1->bd_bh) ? 1 : 0);
 			}
-			if (++n >= num)
+			if (++n >= num) {
+				tmp1 = bd1;
 				break;
+			}
 		}
 
 		gfs2_log_unlock(sdp);
@@ -690,6 +694,8 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 		gfs2_log_lock(sdp);
 
 		n = 0;
+		bd2 = list_prepare_entry(tmp2, blist, bd_list);
+		tmp2 = NULL;
 		list_for_each_entry_continue(bd2, blist, bd_list) {
 			get_bh(bd2->bd_bh);
 			gfs2_log_unlock(sdp);
@@ -712,8 +718,10 @@ static void gfs2_before_commit(struct gfs2_sbd *sdp, unsigned int limit,
 				gfs2_log_write_bh(sdp, bd2->bd_bh);
 			}
 			gfs2_log_lock(sdp);
-			if (++n >= num)
+			if (++n >= num) {
+				tmp2 = bd2;
 				break;
+			}
 		}
 
 		BUG_ON(total < num);

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

