Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07FE5A9E36
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiIARiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 13:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiIARg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:36:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6059A6A6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:36:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-32a115757b6so236813287b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=r+vF5Lo2i1OjVhetiEIJ/9q6C9lfd71c3zrmx7NgTrs=;
        b=H4jFJ8Dt7ZH5cKrXQpN0z8PEygipTnxhDURDwP2r/L6ST1buj0wC6b62XAFXTWTuHE
         TRectVq93AO6tGT7OX1/aI7LFkcRGjFnJwRUud+1aazBY2txe7GqBy/qCAKx7DzAzI1F
         08tbsOZGFue1vB/xCd7zDPTLBCjfhCGGnp6kgmw7nw7+o4krMVIGwx+wiyWeS1/K9dS3
         MY2rAdmwbAo0HfcpKpUrJZgpdcga0Ob80OnRbMBFu5K9+oe2e9P/nHO4ZkzgpYkHj1ef
         kx644FtyUEEJInyDO+nYaup+HokzUzXjSdh7on7VQkqKFKRY8gzUfUlLXLq38fi2PNgi
         LbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=r+vF5Lo2i1OjVhetiEIJ/9q6C9lfd71c3zrmx7NgTrs=;
        b=pvAcO6IJSWyqATnD0FMkAjJcaM93KZdvAKJIfL6uU/mykkEBb3sMMyHQReZVrl+HcZ
         ebj+lRJBcqYPjelN+zkuxqJiMxKlLz1mbkBYyPvS5iNBcWreB2o608526q8bvmuxR1oF
         3LI481O4z6WIjEyW7tVOdXLRA8Nsmh97jdM8Eo7wCHh2caLfIiO9u+TocDxWvpgQZQvg
         tkkcfC2NaDdY8ZvOd1cWIfQBGD62ShjEF1rXeYJ8h69aqn3AfZAN06AJzbZe1jKB4of8
         +B/N1Azrn7pGxzms9it44vEmqxhm2GkJQGUbGjwdvER2vcBae41sF8QehRGDesbTKeYM
         bSUQ==
X-Gm-Message-State: ACgBeo2OaH0H6fuTvU7/1+fKTROKG41eEcvjH3aGiyt8C7klICIiXMwy
        rHfHUHBUC/gFeHYjJqPa9XHNFhbOtSk=
X-Google-Smtp-Source: AA6agR4BDUj9pfWqCFb+xsqUI8F9TUy99Q1kXWNSZ/lAe4Y/IzT7ZfeAPxwUhMVzFJvC8KeIfmdI79dhOFA=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:1bfc:e7ee:6530:4449])
 (user=surenb job=sendgmr) by 2002:a25:8d05:0:b0:68e:c838:c24a with SMTP id
 n5-20020a258d05000000b0068ec838c24amr19294531ybl.45.1662053773853; Thu, 01
 Sep 2022 10:36:13 -0700 (PDT)
Date:   Thu,  1 Sep 2022 10:35:08 -0700
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
Mime-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173516.702122-21-surenb@google.com>
Subject: [RFC PATCH RESEND 20/28] mm: introduce per-VMA lock statistics
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mgorman@suse.de,
        dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com,
        peterz@infradead.org, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, paulmck@kernel.org, luto@kernel.org,
        songliubraving@fb.com, peterx@redhat.com, david@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        surenb@google.com, kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
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
2.37.2.789.g6183377224-goog

