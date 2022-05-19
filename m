Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAF52DCD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbiESSaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243939AbiESSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:19 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC676EC303
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:17 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q4so5499936plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3okhAQVmzjH9kpTDWZv9di+1X0JN/hwQHbaAYTPmRKk=;
        b=I+QLZYTCidWLfryGwh4g+iNPPl6KK/+PTmZ5tmus8ew7FcE0+F4I6GR1AeKJ0IgWba
         YoSZ0KTQ021omXkmBeN09uz6+kjyWiwe0P61FuRW57jxuBJoiY3flBF1gfJxlqx/wu8s
         SahdVzfO46wtZo7jwf+jUA7Ste66ESPiqB/P8XhoAnMnx5KQNDZoTGCLYK61sI4/2G8x
         bcepaLLWxq6ImNnKHmOfB9KobRNM6EChRhPzjt2ff2iZKbMECqDLDHkn3l+7k/tpWFsP
         uUeE0dd13WF976vBM0KJCsqZ3XnHUTjRIuXwoywUgfL74ck007qYJ1pFPou57Va32SXL
         d+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3okhAQVmzjH9kpTDWZv9di+1X0JN/hwQHbaAYTPmRKk=;
        b=7VPQXUO/laCdwFocjgNOvKGql/B3ylDqRsZRpJgPO1z+5RhBds2sn/5sLDNXH+7OnA
         xXlJQfShpui0uwMKjnKclf0mU5Wd2kNr3rTP7r2KtbwM3hcuH+dKYkRnQiowHlqpiY7i
         8u4fOTzKW7nt9hn+66dVEBeJDWIcwDClnc4hL2w64ihVqvlMyj5EHZbkSgDPhWNEmXVn
         5BpNXeFdb+jhtHLkpEsCDDju7n+f8u1ey1MdC8ecHqzED6p6uphGLb0asnboMONwn1Tc
         gFFijVsZlYKcwuGrITDQrzmbBXsQpU+hj1pmvK27T5At1/CGHZLMpXzNiEMe+9veE6wx
         Zawg==
X-Gm-Message-State: AOAM531m+DluSrhwUObSpRP75DdKm9OxQCWyhbnmvh+j0tCjqEdasbhx
        voz/aSw5Tk3lZJGwc21a+Lw=
X-Google-Smtp-Source: ABdhPJxwGQw9CuhqHPaJc6onGODQtEQxG6uPknIr9RC26LYZwaGLAi7jy/9FM5GFXFgarv/bsML44w==
X-Received: by 2002:a17:90b:1b44:b0:1dc:315f:4510 with SMTP id nv4-20020a17090b1b4400b001dc315f4510mr7126569pjb.28.1652985017382;
        Thu, 19 May 2022 11:30:17 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:16 -0700 (PDT)
From:   Chih-En Lin <shiyn.lin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Chih-En Lin <shiyn.lin@gmail.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: [RFC PATCH 2/6] mm: clone3: Add CLONE_COW_PGTABLE flag
Date:   Fri, 20 May 2022 02:31:23 +0800
Message-Id: <20220519183127.3909598-3-shiyn.lin@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519183127.3909598-1-shiyn.lin@gmail.com>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
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

Add CLONE_COW_PGTABLE flag to support clone3() system call to enable the
Copy-On-Write (COW) mechanism on the page table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/uapi/linux/sched.h | 1 +
 kernel/fork.c              | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..3b92ff589e0f 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_COW_PGTABLE 0x400000000ULL /* Copy-On-Write for page table */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
diff --git a/kernel/fork.c b/kernel/fork.c
index 35a3beff140b..08cf95201333 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2636,6 +2636,9 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace = 0;
 	}
 
+	if (clone_flags & CLONE_COW_PGTABLE)
+		set_bit(MMF_COW_PGTABLE, &current->mm->flags);
+
 	p = copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
 
@@ -2860,7 +2863,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP |
+		    CLONE_COW_PGTABLE))
 		return false;
 
 	/*
-- 
2.36.1

