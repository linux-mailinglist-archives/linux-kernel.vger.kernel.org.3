Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5773589960
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 10:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiHDIk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 04:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiHDIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 04:40:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A016A25C72
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 01:40:46 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso4566032pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GWE4Fsz2e2PmZ/o8Txibq+ksrvgnJCJQRSWGkgTYSfc=;
        b=jRQtZTZHdvZ1yokGaY/qgydPXnr+tpDIgguOusl+c7o6l95fYptk60YNC5t5kffWBN
         0ra0lZxDxOzwD+sSWe0VSbTylxL+KC276B+J9OOsUxKjHEMUSm5q5jp/Rp9IIy6QUPqb
         OIrlJ9EI7W4in7kUk0cSqW8H24Kl6W+H3A+SN6c0K7JXvCT/+vyXQZIL7uTmGG2/vadY
         ilkNEJ3LNwjJPzCFI+qt2OlDqPBiP95+2vEFgqNBd9+TWNVMUlsk2g4OOPUCZTc85g5k
         XXB5dlyC2Y6zrp6E6zXiij1ropgl2q8HnWut3PaPpt9w+8jAapY1d51WAMip8bGr0Qn4
         W0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GWE4Fsz2e2PmZ/o8Txibq+ksrvgnJCJQRSWGkgTYSfc=;
        b=c9EOBmcGGjS9USBglBo20pn19QwyHtvn+MpH3tWrvKhUQot4djxOStK14vYuUiTcnP
         Co4/Zera1+pJn5kP/wQLIwrpJRxb/oepeggECkIMYxDBIgFAW8W7pPyUzZMgTxb2Ve2w
         IJN2hHq5gq8xs2D0ln7MldrDdtDyY/tDDcPv5hJ7njZgp6MrkHkLXxuR+qiEHt+U0GlO
         +xgyqqX86Hw9E1r3R8czb0dYiCEl4ORiP7cH8zTC4bv4tSe0L2MB5DqQMEy90FEbrmZt
         d8SU3+WQU7Nb5uhXudI3zTDVsRPodRWJhasGeXH2vvuh8bgI2h9sqtWH5jCPFK3XD/b+
         nAqg==
X-Gm-Message-State: ACgBeo3Xem/bZUMrB5Y/g4hdB8QwAM0P4dYU6SsU9ppbscZvQdrhuDFb
        KBIcYe9zohma2yApzgQ3BZDVcS5yDXs=
X-Google-Smtp-Source: AA6agR582QSlqLWTdGHZ+HcgtOlZaPGNAw8Z0fIzfT0l0JmeESTdTeQ8i8g1DsAs+Nd6YILAZ6b0TQ==
X-Received: by 2002:a17:90b:3944:b0:1f5:4cc8:d46 with SMTP id oe4-20020a17090b394400b001f54cc80d46mr914418pjb.95.1659602445865;
        Thu, 04 Aug 2022 01:40:45 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id c78-20020a624e51000000b0052ce1737ee1sm377492pfb.37.2022.08.04.01.40.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2022 01:40:45 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [RFC PATCH 1/8] workqueue: Unconditionally set cpumask in worker_attach_to_pool()
Date:   Thu,  4 Aug 2022 16:41:28 +0800
Message-Id: <20220804084135.92425-2-jiangshanlai@gmail.com>
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

If a worker is spuriously woken up after kthread_bind_mask() but before
worker_attach_to_pool(), and there are some cpu-hot-[un]plug happening
during the same interval, the worker task might be pushed away from its
bound CPU with its affinity changed by the scheduler and worker_attach_to_pool()
doesn't rebind it properly.

Do unconditionally affinity binding in worker_attach_to_pool() to fix
the problem.

Prepare for moving worker_attach_to_pool() from create_worker() to the
starting of worker_thread() which will really cause the said interval
even without spurious wakeup.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Tejun Heo <tj@kernel.org>,
Cc: Petr Mladek <pmladek@suse.com>
Cc: Michal Hocko <mhocko@suse.com>,
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Wedson Almeida Filho <wedsonaf@google.com>
Fixes: 640f17c82460 ("workqueue: Restrict affinity change to rescuer")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1ea50f6be843..928aad7d6123 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1872,8 +1872,11 @@ static void worker_attach_to_pool(struct worker *worker,
 	else
 		kthread_set_per_cpu(worker->task, pool->cpu);
 
-	if (worker->rescue_wq)
-		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+	/*
+	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
+	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
+	 */
+	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
-- 
2.19.1.6.gb485710b

