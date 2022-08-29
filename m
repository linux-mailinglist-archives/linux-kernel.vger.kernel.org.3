Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7315A5625
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiH2V1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiH2V0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:26:46 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E634D985A4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:16 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id m34-20020a634c62000000b0042aff6dff12so4547542pgl.14
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=bUksEMWzQ2sQtj6CAseSDP7Wnd3Y9YWuXlHuoAiHS/w=;
        b=R4f3AmhYQvfrJmCukv/e3Nij13PuVUa8k8O646df0PoObwBnO/xDcemk6+SqKXvVGr
         hJkm2649shhdYcclI4xYPbiKHXEe7XEvjq6ebwkp6YZFsZtQX3MH5xTV757BPS7Zeyib
         IALyiqYSG4f0kCJDHQ3+fMXa5F0OzkQKlh2EgahzIDAp6HMSPtfd8qN17COdyNthUkyK
         vH/w1n6XgnYHxRHIzAjyfQH31twkRddq+jpJViGP9dMWFd2ba2cwGPVTVH8mdAvdjCY4
         84OD9xZ4r8HlzIfM65gveSjGxaILhsxn9vJXDz/VODVoOMzJt9RI4cwlcbKnFfX3PjSN
         BY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=bUksEMWzQ2sQtj6CAseSDP7Wnd3Y9YWuXlHuoAiHS/w=;
        b=l/Y0aMF0B+iVY2xu5dVlCbcxy2dr5pCTArjwe9X0x3iaUN47Mi05RvDrVKwoN+9TcE
         pbJ0QoWJgbtvg13goGjeunHxUIXGY5Ai04qsYX8CCBh2l/Jx5FrFdpin4pkkNkfNBAcX
         ctKOiDhLjKWm22m+zkv9gIwS4WwFlXk9CjNDk5lxv3PbBnrZPEYhQjFqjX+IKW0wkaOw
         4iVj16gulpQ1ygTGZpg0r+LsSFDIrJ3r68jzf6XLJMXcpz4AByGWcOxYulT3JV9kp9tZ
         Qibs6W6LiXClY2LFNscbCVsSo6T2WgB57UtR09eKFlWTWqWjh8MYaA2ltwKKenad2QX6
         cuTA==
X-Gm-Message-State: ACgBeo32bGo42XvCuDgrDzWFKlpuiuEtVQ1NuXP2YxmYVuu+ij1VMZ4E
        uDEItCgs1RNsru8zRn74UWN09dTwY58=
X-Google-Smtp-Source: AA6agR4CSgZfYughTw1oP2TGtJ/Gx4qpWPKVumSGbjZh4UG9V5skHPeijnTVviS5CargVPsvloUs2cN/SRk=
X-Received: from surenb-spec.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e30])
 (user=surenb job=sendgmr) by 2002:a17:90b:2c11:b0:1fd:e56c:79de with SMTP id
 rv17-20020a17090b2c1100b001fde56c79demr4481996pjb.201.1661808371494; Mon, 29
 Aug 2022 14:26:11 -0700 (PDT)
Date:   Mon, 29 Aug 2022 21:25:23 +0000
In-Reply-To: <20220829212531.3184856-1-surenb@google.com>
Mime-Version: 1.0
References: <20220829212531.3184856-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829212531.3184856-21-surenb@google.com>
Subject: [RFC PATCH 20/28] mm: introduce per-VMA lock statistics
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@techsingularity.net,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, riel@surriel.com,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        rientjes@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, surenb@google.com, kernel-team@android.com,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new CONFIG_PER_VMA_LOCK_STATS config option to dump extra
statistics about handling page fault under VMA lock.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/vm_event_item.h | 6 ++++++
 include/linux/vmstat.h        | 6 ++++++
 mm/Kconfig.debug              | 8 ++++++++
 mm/vmstat.c                   | 6 ++++++
 4 files changed, 26 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f3fc36cd2276..a325783ed05d 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -150,6 +150,12 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
 		DIRECT_MAP_LEVEL3_SPLIT,
+#endif
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+		VMA_LOCK_SUCCESS,
+		VMA_LOCK_ABORT,
+		VMA_LOCK_RETRY,
+		VMA_LOCK_MISS,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..0c2611899cfc 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -131,6 +131,12 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_vmacache_event(x) do {} while (0)
 #endif
 
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+#define count_vm_vma_lock_event(x) count_vm_event(x)
+#else
+#define count_vm_vma_lock_event(x) do {} while (0)
+#endif
+
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
 
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index ce8dded36de9..075642763a03 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -207,3 +207,11 @@ config PTDUMP_DEBUGFS
 	  kernel.
 
 	  If in doubt, say N.
+
+
+config PER_VMA_LOCK_STATS
+	bool "Statistics for per-vma locks"
+	depends on PER_VMA_LOCK
+	help
+	  Statistics for per-vma locks.
+	  If in doubt, say N.
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 90af9a8572f5..3f3804c846a6 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1411,6 +1411,12 @@ const char * const vmstat_text[] = {
 	"direct_map_level2_splits",
 	"direct_map_level3_splits",
 #endif
+#ifdef CONFIG_PER_VMA_LOCK_STATS
+	"vma_lock_success",
+	"vma_lock_abort",
+	"vma_lock_retry",
+	"vma_lock_miss",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
-- 
2.37.2.672.g94769d06f0-goog

