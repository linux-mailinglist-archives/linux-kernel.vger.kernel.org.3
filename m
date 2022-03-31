Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F3B4ED68E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbiCaJOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCaJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:14:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A811EF5C7;
        Thu, 31 Mar 2022 02:12:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so46723255ejb.4;
        Thu, 31 Mar 2022 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8DhswHVHWMQXA2DKu3W62u6CvgqIB7utFtneyXpsAQ=;
        b=FoqbrXkjNAB74Srin4hbjn7hR5o8ixvtBDJQAB85Tb0b/Sjh1LQNgijQX7BJfP/4Jz
         3dJNyVpiP22eUd++EYB+t4MBUJrunojgJcDjs/+xpwcr0JGhik44ACwPttIJwXE9+PK2
         xJ5AMWkxxE6hMK0yjefBjlnZ/tDac+GTZnyD+Hp1bu9N2GtM8qUBQi9ulfPj6BKNZ7t2
         E/dfw+g8DyXRCbqJyRUF4dHCQMfrhNNrqYxAsmQ7eiOBqC7+f+JNSyqOiBcPX6Ynt2BP
         1p1vviKAGEM+jsidE4gGWKgC3XRTqGDTIiCN38eKi27Zp5vTILPSdFSIEJODCCHtfuPU
         8l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z8DhswHVHWMQXA2DKu3W62u6CvgqIB7utFtneyXpsAQ=;
        b=iEDtCyZlKcWIATVGk0oxqeloii9zEJLiWdGxL6UQiySv9OuhNWgZ72SShUPTkPoTCX
         EI/ILSdBDeNGY/gUeeh7Bh25rDC7dq4lzOSd6Ay5gZveCyB1YXTxiq2NwkwcJqON7ijN
         HOvmIipcXlHBXJRVg8w41+amkI+48s0K5Nwme0kH75ksem0KJHFM6R/TzxyRrDTpODJ0
         V+aYwf7JJoAVjeWuIDo4u2PZlVFJW760DD23XlEv7GHSMYtoaxLJq4ciE3QNhJRSL0Oj
         u2C1HBqejib5SjHWeKGcmnAQzXibA+0+380ByaMNUJuBpCNgvG6kxPAilnxNELias+5G
         B2Hg==
X-Gm-Message-State: AOAM532Zhv61RWk3C5jcP8JyN3XUY9DJzmrvacYb8iLex2yZ7rf78s5t
        Zkk+kDj6IBoQtPYVqb5ohEQ=
X-Google-Smtp-Source: ABdhPJzWXfIJWccW24TeVjH7UYtWK3IovnsoiIMLma0irEufD6srkG9QJuaI1NKpfEGjeO3RcJi46g==
X-Received: by 2002:a17:907:a40d:b0:6e1:4055:2c91 with SMTP id sg13-20020a170907a40d00b006e140552c91mr4086826ejc.404.1648717950450;
        Thu, 31 Mar 2022 02:12:30 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id bn14-20020a170906c0ce00b006c5ef0494besm9196387ejb.86.2022.03.31.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:12:29 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH v2] block: use dedicated list iterator variable
Date:   Thu, 31 Mar 2022 11:12:18 +0200
Message-Id: <20220331091218.641532-1-jakobkoschel@gmail.com>
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

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---

v1->v2:
- introduce blk_lookup_qe_pair() for more readable code (Bart Van Assche)

 block/blk-mq.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e6f24fa4a4c2..f7f950cce452 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4462,21 +4462,27 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	return true;
 }

-static void blk_mq_elv_switch_back(struct list_head *head,
-		struct request_queue *q)
+static struct blk_mq_qe_pair *blk_lookup_qe_pair(struct list_head *head,
+						struct request_queue *q)
 {
 	struct blk_mq_qe_pair *qe;
-	struct elevator_type *t = NULL;

 	list_for_each_entry(qe, head, node)
-		if (qe->q == q) {
-			t = qe->type;
-			break;
-		}
+		if (qe->q == q)
+			return qe;

-	if (!t)
-		return;
+	return NULL;
+}
+
+static void blk_mq_elv_switch_back(struct list_head *head,
+				  struct request_queue *q)
+{
+	struct blk_mq_qe_pair *qe = blk_lookup_qe_pair(head, q);
+	struct elevator_type *t;

+	if (!qe)
+		return;
+	t = qe->type;
 	list_del(&qe->node);
 	kfree(qe);


base-commit: d888c83fcec75194a8a48ccd283953bdba7b2550
--
2.25.1

