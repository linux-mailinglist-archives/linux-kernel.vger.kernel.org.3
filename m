Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8244E8A4D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiC0Vtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 17:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0Vtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 17:49:39 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6A43878A;
        Sun, 27 Mar 2022 14:48:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r23so14957124edb.0;
        Sun, 27 Mar 2022 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10DwZiGdLo3hJFyknuuSJ9NrQcIJAd3mzxuhl7Xh74I=;
        b=SXfIFxn/OMeLD4DgcunldrrQ4thZDEEsQN7KIK35VxVxm4sPKjA0uKjl7q12AYwimT
         9ISN8zfP48Q9thC4BH6ePKjVFf3whf5ewXPwLg7UaThQYNqN6MaCW0jo7WLZfWz7Xd3E
         xZyjAIX2msykGln2x6RgZQzS3GsYZU6Q1B0s8Biby8gzJpRx8V0teaolYc9GEZIobdf6
         9kngYbQ8ZczCrI3DsODrPoeiBrjybS9+N6m/hhQBm2yrKP38iJF+zE9NVb1DFOgRCWez
         cJnrq9M/fD1hEl0PrTcaibE3K0wxjScfW/5Ip/JZo0le1gxWhjIJWpEdsQQkJIkRxToO
         n9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10DwZiGdLo3hJFyknuuSJ9NrQcIJAd3mzxuhl7Xh74I=;
        b=EPpk3w8AevjRjUfNuYk+MSWD8VblnqFezsGMav9VF5nuD8EDT3a5vVsRDNiAyTBJLb
         3nPvT1SWS6Rt+U8PpufHcFGSdnMBrsR4rvg0aZrRtBa/8zQqyYxqHs3xqgqWwe0U+OUi
         Rr56xviWRhQqgjrM0uLrezU8qcfk5wg9c7R75TbZsHoyssd0jaOOMaVRacRboszFoOk8
         GhBri9prW+pjeX2i75LeuIv7Ota7hCZaMeWz4FGqhsrDqOAgJ5k7w11cIg4aCMozT+yi
         jASSjPETLeS4HFmYdHDNNdds0ebDkCIDU3s3wvmVQuDDTHkesUs+bbZE/k6feiS9qDnS
         77GA==
X-Gm-Message-State: AOAM5323I3x4hFHwZPqNn5nvN2XHC+aNUtZaBnp6RplLbn8wcqbJR457
        W6Uq+C2daznVIXgadDa1MkM=
X-Google-Smtp-Source: ABdhPJy4sUrGVMDcw69uwGlOgKI+xgZMdkTvhFRQOKehyNJdf/1YjMNl0G+viaikQsNSObKW/rfajg==
X-Received: by 2002:a05:6402:5210:b0:419:d802:626e with SMTP id s16-20020a056402521000b00419d802626emr4631547edd.11.1648417679059;
        Sun, 27 Mar 2022 14:47:59 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm5089236eje.147.2022.03.27.14.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 14:47:58 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] block: use dedicated list iterator variable
Date:   Sun, 27 Mar 2022 23:47:04 +0200
Message-Id: <20220327214704.2188742-1-jakobkoschel@gmail.com>
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 block/blk-mq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e659dc5fcf3..455fdd488f3c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4466,12 +4466,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 static void blk_mq_elv_switch_back(struct list_head *head,
 		struct request_queue *q)
 {
-	struct blk_mq_qe_pair *qe;
+	struct blk_mq_qe_pair *qe = NULL;
+	struct blk_mq_qe_pair *iter;
 	struct elevator_type *t = NULL;
 
-	list_for_each_entry(qe, head, node)
-		if (qe->q == q) {
-			t = qe->type;
+	list_for_each_entry(iter, head, node)
+		if (iter->q == q) {
+			t = iter->type;
+			qe = iter;
 			break;
 		}
 

base-commit: b47d5a4f6b8d42f8a8fbe891b36215e4fddc53be
-- 
2.25.1

