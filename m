Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844CD5A58EF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiH3BoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiH3BoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:44:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F157C1C2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:06 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id p8-20020a17090ad30800b001fdfc8c7567so294905pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4G45J5/wbH8CJ9lkE1Iii44KzFmB6q2uZP6UhKMt5F0=;
        b=hme/xCx/PdWfI+daRrW3BOD4RhkV7SbDD/dzQtAIJm3N9y6A0v2eTJXbzhQRklZ33N
         MNb27S+7PWwZ+54cwchHFCS64G6NXu64y3i+aQuZIYPMffL0uSdT1ragDchYw2qk9+DO
         NirXWwVaPO1mu0DWrmpUVGRHbl1dnNKLCxMbJYk7NyiUh0HXBhLP8jw8expuxco0Hroi
         iJriviALZehlN7lEgZa/8X9jTN5vNX3NHJlHKV3d1/iWQMHQIwUTrhmVAtJn1SDZGH7F
         I5Up7tKTClddctA6Ad3bXIRGJJpxlKgKGUMa/1iZxUGxS6bpVNH5d2i+KWAYhMb1u5id
         89zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4G45J5/wbH8CJ9lkE1Iii44KzFmB6q2uZP6UhKMt5F0=;
        b=bt11qfNg4EPJ37/whk+DHrCi0ovOEPeD0q7c1W0Lbj/9h4xcouCyxelUxNRdO/JGVt
         jWtnUXDb3b1v1JECwhXWyTlEXvdkVzv+UVV658OEDS1FzVHtU4aVjNJVnwo+0fQLHGHw
         QVha//E9xcdG0/PityOKr+ujNMnW67S2KgXRe051+QqlQGpQf1QA1I0qeleoq7Btf8xF
         1MhampTduh7Cd97mQ/ObzKU6hNZ+i512HywGWxqgQnw20xQe/jjEaT/Towfsx6Dwv0m4
         16ggwvvzwOZl49hmJ1BkV9DX+Lrk0IgsFAC3+JpB3IkTBUvoKOmylJ99TuIZnNEqXQjh
         YyEw==
X-Gm-Message-State: ACgBeo2u7H2AmKXPkJOygHFBAY3DcXIpxvBxG6uD8N3tl6PbLqqkXuUm
        SpRbtdEeR0oZihx9rVFdC7TxXrJx+Oo=
X-Google-Smtp-Source: AA6agR4GNeZem4U6gjMW7sBQ700KlnJNkMGpLWafUK2syMDcnXqz4HabgHHGrcE9a5qv1yfg4bRBjg==
X-Received: by 2002:a17:902:d708:b0:172:f24e:2e59 with SMTP id w8-20020a170902d70800b00172f24e2e59mr19018781ply.169.1661823845456;
        Mon, 29 Aug 2022 18:44:05 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id v14-20020aa799ce000000b00535faa9d6f2sm7976038pfi.53.2022.08.29.18.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 18:44:04 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/4] seccomp: don't use semaphore and wait_queue together
Date:   Mon, 29 Aug 2022 18:43:53 -0700
Message-Id: <20220830014356.5364-2-avagin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830014356.5364-1-avagin@gmail.com>
References: <20220830014356.5364-1-avagin@gmail.com>
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

Here is no reason to use two different primitives that do similar things.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 kernel/seccomp.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index e9852d1b4a5e..667fd2d89464 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -145,7 +145,7 @@ struct seccomp_kaddfd {
  * @notifications: A list of struct seccomp_knotif elements.
  */
 struct notification {
-	struct semaphore request;
+	atomic_t requests;
 	u64 next_id;
 	struct list_head notifications;
 };
@@ -1116,7 +1116,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	list_add_tail(&n.list, &match->notif->notifications);
 	INIT_LIST_HEAD(&n.addfd);
 
-	up(&match->notif->request);
+	atomic_add(1, &match->notif->requests);
 	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
 
 	/*
@@ -1388,8 +1388,10 @@ static long seccomp_set_mode_strict(void)
 #ifdef CONFIG_SECCOMP_FILTER
 static void seccomp_notify_free(struct seccomp_filter *filter)
 {
-	kfree(filter->notif);
-	filter->notif = NULL;
+	struct notification *notif = filter->notif;
+
+	WRITE_ONCE(filter->notif, NULL);
+	kfree_rcu(notif);
 }
 
 static void seccomp_notify_detach(struct seccomp_filter *filter)
@@ -1450,6 +1452,16 @@ find_notification(struct seccomp_filter *filter, u64 id)
 	return NULL;
 }
 
+static bool notify_wakeup(struct seccomp_filter *filter)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = atomic_add_unless(&filter->notif->requests, -1, 0);
+	rcu_read_unlock();
+
+	return ret;
+}
 
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
@@ -1467,7 +1479,7 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 
 	memset(&unotif, 0, sizeof(unotif));
 
-	ret = down_interruptible(&filter->notif->request);
+	ret = wait_event_interruptible(filter->wqh, notify_wakeup(filter));
 	if (ret < 0)
 		return ret;
 
@@ -1515,7 +1527,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 			if (should_sleep_killable(filter, knotif))
 				complete(&knotif->ready);
 			knotif->state = SECCOMP_NOTIFY_INIT;
-			up(&filter->notif->request);
+			atomic_add(1, &filter->notif->requests);
+			wake_up_poll(&filter->wqh, EPOLLIN | EPOLLRDNORM);
 		}
 		mutex_unlock(&filter->notify_lock);
 	}
@@ -1771,15 +1784,15 @@ static const struct file_operations seccomp_notify_ops = {
 static struct file *init_listener(struct seccomp_filter *filter)
 {
 	struct file *ret;
+	struct notification *notif;
 
 	ret = ERR_PTR(-ENOMEM);
-	filter->notif = kzalloc(sizeof(*(filter->notif)), GFP_KERNEL);
-	if (!filter->notif)
+	notif = kzalloc(sizeof(*notif), GFP_KERNEL);
+	if (!notif)
 		goto out;
 
-	sema_init(&filter->notif->request, 0);
-	filter->notif->next_id = get_random_u64();
-	INIT_LIST_HEAD(&filter->notif->notifications);
+	notif->next_id = get_random_u64();
+	INIT_LIST_HEAD(&notif->notifications);
 
 	ret = anon_inode_getfile("seccomp notify", &seccomp_notify_ops,
 				 filter, O_RDWR);
@@ -1788,10 +1801,11 @@ static struct file *init_listener(struct seccomp_filter *filter)
 
 	/* The file has a reference to it now */
 	__get_seccomp_filter(filter);
+	WRITE_ONCE(filter->notif, notif);
 
 out_notif:
 	if (IS_ERR(ret))
-		seccomp_notify_free(filter);
+		kfree(notif);
 out:
 	return ret;
 }
-- 
2.37.2

