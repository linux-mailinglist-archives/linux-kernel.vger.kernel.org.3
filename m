Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBE74C27BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 10:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiBXJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 04:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbiBXJJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:09:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8571A12B9;
        Thu, 24 Feb 2022 01:08:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m22so1481892pja.0;
        Thu, 24 Feb 2022 01:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pzQXvbfFL7dPzEr5ZOm4Q64kxcQtnZEvdiaZ7+tJ8ec=;
        b=Mn9liH/ZVdqXmUvXSP/ACWUY8hIIjhlf3+QrTVNAfYWtfdOXvMevFq6rZgpe//EIm0
         ic6v3nLgBh7km/UHTNz7BwMZ/jY62XfL0wcZm5tEhcqlQLgbtdcHPOFzLUC6JZN0WhGu
         9Hv05jH9aM5V+5pZgJCRVfLxx5dVReZDKfbqhWfnbvABFqmA0T11LJJKIqfBp+gR4RUV
         LzH4h9Ga8hYBxvUXwRvX3kxxnk2+GHnXipl7fMVd0v66CEkfbWCZU8nItK3O36bd8/I4
         oOllakomcY2Z2d3qZeHSbBb2ThbT6VMHoPZrVlBS27QVpfgVoQ8cwRAMBwX18fXh4wSl
         DXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pzQXvbfFL7dPzEr5ZOm4Q64kxcQtnZEvdiaZ7+tJ8ec=;
        b=1eZDHuZGFPqr5p4K0rMdW5QKS/1/r6dxU6njxABcFMP0OukdkcVv9QGwoG1sQaFEnJ
         GHGJb2JgKeqwNYs24/s0Gx5mUBInaw25WKNx15MqKCg0vBKiNcnWrDP6azjkfKAh9brS
         FkB2GTYuA+h1AythN5B26em6nsRcBLfQMTZdFJCizH0TR+sPTKckRF3zZZ2dKm/Lu+BL
         brL+geRdthYdLn+EmKtxg+GHGNmF6Uumw2iNQQ8I+xMCjMdnnhD84xC+36Oddd4nSygO
         U/7oYaOrtthSVA62UFoEIUBoCmICfOfWAixbx1WWKV2ccL3Vb1MahvBIRIIBFG0vMzX2
         wRgA==
X-Gm-Message-State: AOAM530O7vyuDcSUtB/YJdOnmHYSipqRHZkI8GDlJtl+A9ELBnEJjHIP
        KwsYtmsjJrIVWV+N4P9Zx5iP3CH51ALxmg==
X-Google-Smtp-Source: ABdhPJxFxz7XSxjsfqBQvxvGQ05DxwfhH16OKljzey8Xcmjvsy6YbvLehwBhjb97e+SnQH3nqlXfDw==
X-Received: by 2002:a17:903:2311:b0:14e:eb4f:4559 with SMTP id d17-20020a170903231100b0014eeb4f4559mr1900727plh.138.1645693728573;
        Thu, 24 Feb 2022 01:08:48 -0800 (PST)
Received: from localhost.localdomain ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id nn14sm2023999pjb.45.2022.02.24.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:08:48 -0800 (PST)
From:   "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>, Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC V5 11/16] blk/rq-qos: get rid of debugfs register in blk_mq_debugfs_register
Date:   Thu, 24 Feb 2022 17:06:49 +0800
Message-Id: <20220224090654.54671-12-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220224090654.54671-1-jianchao.wan9@gmail.com>
References: <20220224090654.54671-1-jianchao.wan9@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is not any enabled rqos policy when queue is initialized,
get rid of the coding for registering debugfs.

Signed-off-by: Wang Jianchao (Kuaishou) <jianchao.wan9@gmail.com>
---
 block/blk-mq-debugfs.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 7e3c3cc1b1a9..4c9dafd16a08 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -726,18 +726,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 		if (q->elevator && !hctx->sched_debugfs_dir)
 			blk_mq_debugfs_register_sched_hctx(q, hctx);
 	}
-
-	if (q->rq_qos) {
-		struct rq_qos *rqos = q->rq_qos;
-		/*
-		 * Queue has not been registered right now, it is safe to
-		 * iterate the rqos w/o lock
-		 */
-		while (rqos) {
-			blk_mq_debugfs_register_rqos(rqos);
-			rqos = rqos->next;
-		}
-	}
 }
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
-- 
2.17.1

