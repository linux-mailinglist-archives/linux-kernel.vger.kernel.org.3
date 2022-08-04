Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FA589967
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238992AbiHDIlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbiHDIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B15E301
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:40:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id h28so12403109pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qPFA3XwXyTSeEohLFMsskHgwupaXA0ENjQ4ZfIF3Cr8=;
        b=hJXN3MMDut33BAQgcXLu2y9Mz/rSpCX9vFcTVp67KTJbdjyIy2CJdr8C1xL8GF0pFN
         7vndv5w/DHjEoPt3GhZlINZjFlnf/W4+tctA36dq3U5rb2B/VsKslCjMupHSsAyB1dUV
         54qiuiz32UrXpAQIP9+I0QHPosdUE1DPlVGTtMqFH5zEpMQuDMbKTwt4sPEg0IAcaqSU
         tb5Gf7ZbRi8dhVhlJPHhewlhi5CORNOBx5XOjH5+tlTuAaYpsfDDpUriaai0sMPMzapP
         0llzMQzV7efxSqchv03rZb87P9/YrTM/P8KAMjASuUM4ZHdVNuU8pVofR05W45L9gcw9
         7pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qPFA3XwXyTSeEohLFMsskHgwupaXA0ENjQ4ZfIF3Cr8=;
        b=BQOeE6mnqgieeF55FudCjcvKPhRbPD5ywSqQVti+RXHMnlMner9FQeDJyBKnwMa15i
         /3qv1QxhG9lzPcNcQRMGCQFh5B6lrixKW3nj0CUSinss2VA3wvZ8yCBiZr2FtK1m5sZQ
         qD5DY6yXLcWUGGnmzzi+iRX+iOedjRKqt0+IugIDThmvvWwZRWValJxIAG99yf91kY+Q
         T56bqSrsJjoiYy+eVJlg8dNRO3ofn46iSpm2gssQ6GhI6cu5LIjkUXOXanneUEAT601c
         bGiFmmPQOnsgRQHo0mEHFggDgB6tNdZvXyFV6CTEVpODNbVadUC9IcvefYvHVEnl/Z//
         NlBA==
X-Gm-Message-State: ACgBeo3sAa8yO5BDc06mff9qfRU7PEJHTG1Yfv79l61Gq20dVaoGh4eZ
        Hez7M3L/pOQdaPQQb+VaA3VwF8KP0FE=
X-Google-Smtp-Source: AA6agR6UlT1jWktB4/zR56Vdl9FXyMKUzofgTnilPDLtuq1tyE5lWsnWBdzUpRgiqHkNukRSevNEUw==
X-Received: by 2002:a63:6888:0:b0:3fe:49fc:3be3 with SMTP id d130-20020a636888000000b003fe49fc3be3mr781177pgc.182.1659602453267;
        Thu, 04 Aug 2022 01:40:53 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id a7-20020a1709027e4700b0016cd74e5f87sm242487pln.240.2022.08.04.01.40.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [RFC PATCH 3/8] workqueue: Set PF_NO_SETAFFINITY instead of kthread_bind_mask()
Date:   Thu,  4 Aug 2022 16:41:30 +0800
Message-Id: <20220804084135.92425-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220804084135.92425-1-jiangshanlai@gmail.com>
References: <20220804084135.92425-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

kthread_bind_mask() can't work correctly if spurious wakeup
happens before kthread_bind_mask().

And a spuriously wakeup worker's cpumask can be possibly changed
by a userspace if worker_attach_to_pool() is called earlier than
kthread_bind_mask().

To avoid the problem caused by spurious wokeup, set PF_NO_SETAFFINITY
at the starting of workers where kthread_bind_mask() can't be used
and luckily workqueue code binds cpumask by itself, all it needs is
only PF_NO_SETAFFINITY.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tejun Heo <tj@kernel.org>,
Cc: Petr Mladek <pmladek@suse.com>
Cc: Michal Hocko <mhocko@suse.com>,
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f5b12c6778cc..82937c0fb21f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1958,7 +1958,6 @@ static struct worker *create_worker(struct worker_pool *pool)
 		goto fail;
 
 	set_user_nice(worker->task, pool->attrs->nice);
-	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
 	/* start the newly created worker */
 	wake_up_process(worker->task);
@@ -2380,6 +2379,8 @@ static int worker_thread(void *__worker)
 	struct worker *worker = __worker;
 	struct worker_pool *pool = worker->pool;
 
+	current->flags |= PF_NO_SETAFFINITY;
+
 	/* attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
 
@@ -2494,6 +2495,7 @@ static int rescuer_thread(void *__rescuer)
 	struct list_head *scheduled = &rescuer->scheduled;
 	bool should_stop;
 
+	current->flags |= PF_NO_SETAFFINITY;
 	set_user_nice(current, RESCUER_NICE_LEVEL);
 
 	/*
@@ -4279,7 +4281,6 @@ static int init_rescuer(struct workqueue_struct *wq)
 	}
 
 	wq->rescuer = rescuer;
-	kthread_bind_mask(rescuer->task, cpu_possible_mask);
 	wake_up_process(rescuer->task);
 
 	return 0;
-- 
2.19.1.6.gb485710b

