Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601FA4AA4A7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378451AbiBDXxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378394AbiBDXxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:53:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9C3C06C94C;
        Fri,  4 Feb 2022 15:53:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68964B83978;
        Fri,  4 Feb 2022 23:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F26C340FA;
        Fri,  4 Feb 2022 23:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644018810;
        bh=CD9/OZPPyIm9sd6gKVYb1dK+c+5ezedy+TEEypg9DOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhi5fVmaEB0t3n39LHsGhX2HITZbKmJYYOvVXvJQDIDBr29n0R2JGzluGjVvGC7gN
         QZhJspl+ovlUXUlaijFgxomoYOOifiu5L6czU/c7XbqP79MN96thBiVRhcp/G3ZhvE
         tDrclwYUJvuGzbiV+VbN18GXFAxDL4St3KnsbQ5FoQ6AhnXUrYBKCDrB5hfpaoFxf0
         2D2uBurj1XqXKmXhsXWBwAMy2ZqHeBvQGezVJfFUN5J0ywWeBnZ2nzNyvzTDcqrn+b
         jMckCRGfGlvfYFc/ccVhdtGevfboj6wClYQKHn2suqM6cbiVKUzHylxANnZmn+j8lo
         3WpY9mz8CHWvw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 806E35C0A21; Fri,  4 Feb 2022 15:53:29 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH rcu 7/8] torture: Wake up kthreads after storing task_struct pointer
Date:   Fri,  4 Feb 2022 15:53:26 -0800
Message-Id: <20220204235327.2948-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
References: <20220204235321.GA2511@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, _torture_create_kthread() uses kthread_run() to create
torture-test kthreads, which means that the resulting task_struct
pointer is stored after the newly created kthread has been marked
runnable.  This in turn can cause spurious failure of checks for
code being run by a particular kthread.  This commit therefore changes
_torture_create_kthread() to use kthread_create(), then to do an explicit
wake_up_process() after the task_struct pointer has been stored.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index f55d803f995d4..789aeb0e1159c 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -931,12 +931,14 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
 	int ret = 0;
 
 	VERBOSE_TOROUT_STRING(m);
-	*tp = kthread_run(fn, arg, "%s", s);
+	*tp = kthread_create(fn, arg, "%s", s);
 	if (IS_ERR(*tp)) {
 		ret = PTR_ERR(*tp);
 		TOROUT_ERRSTRING(f);
 		*tp = NULL;
+		return ret;
 	}
+	wake_up_process(*tp);  // Process is sleeping, so ordering provided.
 	torture_shuffle_task_register(*tp);
 	return ret;
 }
-- 
2.31.1.189.g2e36527f23

