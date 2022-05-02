Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E31516A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 06:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383272AbiEBEy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 00:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbiEBEy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 00:54:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548713DC6
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 21:51:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i1so5490239plg.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tvM/1t2XqsQv5qtt2IQD9gIkDfu8eB+KlKnKPZPDEc=;
        b=dJbkZMqcwDS95Bfzh5MBlN+4eMMjdo2Iw6nHzJL8yE8QGzSbGsVgX+d5A5aH0PcnTp
         SXFMPe/GM+mq9/RX6jACraGOz6wSVyhscqR+uo0jGa8K646WGvytO0vY+w7fw9XsWt+w
         PwVX163mh5IsZvaO9a25hdKovJdFmvSJ+/ax8aqH5TyYIBLbt0VIYWxy2ylsKJs1XXC6
         lVQlmiU9ZvjZlJth+oRgNsIXhfdmrhNo1supc3PFJFuWCQG7xR0eBjeTkIzGoAtlmFpL
         DIlx+rQXuIDM6qaxML0/uXZ5FagGwvOLljbZ6RSwNxkSlsxG951HZphHGpDhxkUCkVQO
         vzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2tvM/1t2XqsQv5qtt2IQD9gIkDfu8eB+KlKnKPZPDEc=;
        b=TMS5fVbxbLOOaRcsQ8FEB8oh57DtPB4+Cnjf7DV/tY31Z/sEWrDthIa91iABwivsFV
         14pJmWsmkmXOnFbk4WFBkNiJvZetgYIM3cc4oSXRAqkAvdlBywxXyrY1ra/8CXAewre/
         DHxa3FhNAirKhUPgWRXo/50PgXgD4Sx+bmpd6Q86j9n6AmCCrVoJlhvcogPQjW1xc+dD
         bf10Dkqz/pMf9v9OAI2/Tow/Hpqy6LUethzhs/JBiqlhupxk+SEIIOyvVE0qFIXRqqs3
         ok/298MbyDQaRtvvFYfvhk6RDJo4+OCxFab5XQsaSkS7JY95O/jwyEw2gKF48B8BGlSN
         fw8w==
X-Gm-Message-State: AOAM533yG77Eh+C9wE+sT7FZCgcCp5+3u2mzd9GQoQvRPSlqglJrzaTa
        PNefq+bE8id7yNM5LGpcxtM=
X-Google-Smtp-Source: ABdhPJywG0PfuTkOuyhpd8EQideyvT73rVZnVt88Bs7aJseLJ6MKXTMD+Ub81AsROmDTN2J8zNghdg==
X-Received: by 2002:a17:902:d4c2:b0:15e:aec8:6a6e with SMTP id o2-20020a170902d4c200b0015eaec86a6emr131302plg.57.1651467088366;
        Sun, 01 May 2022 21:51:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:e60:9053:cb2b:2141:650c:835f:37fb])
        by smtp.gmail.com with ESMTPSA id n14-20020a17090ac68e00b001d9e3b0e10fsm16521950pjt.16.2022.05.01.21.51.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 May 2022 21:51:28 -0700 (PDT)
From:   Levi Yun <ppbuk5246@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, rostedt@goodmis.org,
        yun.wang@linux.alibaba.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [PATCH] kprobe: sync issue's on ftraced-kprobe.
Date:   Mon,  2 May 2022 13:51:02 +0900
Message-Id: <20220502045102.40005-1-ppbuk5246@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kprobe_ftrace_handler, it accesses get kporbe without kprobe_mutex
held.

This makes some of synchronizing issue when we use kprobe API in
kernel-module.

Below is what i experienced:

CPU 0									CPU 1
<...>									<In module code>
kprobe_ftrace_handler
    get_kprobe
        __this_cpu_write
									unregister_kprobe
									unload_module
						<			kprobe memory gone>
	p->pre_handler <access invalid memory>
	page_fault
		kprobe_fault_handler
			(In here, kprobe memory gone,
			 double page fault is happening inifinie).

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
---
 arch/x86/kernel/kprobes/ftrace.c | 3 +++
 include/linux/kprobes.h          | 2 ++
 kernel/kprobes.c                 | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index dd2ec14adb77..76147ff6ed88 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -25,6 +25,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (bit < 0)
 		return;
 
+	mutex_lock(&kprobe_mutex);
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
 		goto out;
@@ -57,7 +58,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		 */
 		__this_cpu_write(current_kprobe, NULL);
 	}
+
 out:
+	mutex_unlock(&kprobe_mutex);
 	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 157168769fc2..4a18147ff6d6 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -191,6 +191,8 @@ struct kprobe_blacklist_entry {
 DECLARE_PER_CPU(struct kprobe *, current_kprobe);
 DECLARE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
 
+extern struct mutex kprobe_mutex;
+
 extern void kprobe_busy_begin(void);
 extern void kprobe_busy_end(void);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dd58c0be9ce2..b65f055b6fa2 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -64,7 +64,7 @@ static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
 static bool kprobes_all_disarmed;
 
 /* This protects 'kprobe_table' and 'optimizing_list' */
-static DEFINE_MUTEX(kprobe_mutex);
+DEFINE_MUTEX(kprobe_mutex);
 static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
 
 kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
-- 
2.35.1

