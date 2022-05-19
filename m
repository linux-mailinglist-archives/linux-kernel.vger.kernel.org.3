Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0A52DCCE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiESSaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiESSaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:30:13 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB9BED73F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:11 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r71so5834188pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBcruspzlRSUkj1U/ztmfktnidm/dp1cZWRRvf7+pnI=;
        b=QsQqdtLwZc0eErpW+lp8P5RtGtErHFCKbEYB+utK3i4Dk+nEWoNs0zGNOCrdNS5tks
         W+VXbeWrAeOf9ogl8Actgzl2iaul9VDKLfM8opBiXTVR5cZZBB4tT2T5txkr49i8clTY
         XbC0KH7+Cj64LFCjy5BkGSMaJGyAbraOwWrttPhJdaL2QIzYxAQqJKaqqV9cx/V1qzKf
         gtr26jaZz/hWK/Pk6eT1jyIq/xvT/oDREMpFQNt/C8B8eIkzH1drfql4ckWNvyvdhSOi
         N+kPGeboi8SFwHrsKQX40KifLiRqH62bvq7ejKCf7HltCBOWTKAvJkMwJPrlPUgneNKE
         aK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBcruspzlRSUkj1U/ztmfktnidm/dp1cZWRRvf7+pnI=;
        b=MAFREv0PNChNiQxiWLmBAowMrAEFuV1mJheXwK99ckghIxIbcj0Y8OselY+a5s6PQF
         wqKsrhFXdIflbrIp1wjrBTf4wVZcQsAt+qe5BY9aeGea6CKU8N9pTSiowIRB80xdmDOW
         wuM0MgdP5Q3qjrI0ba8G9nP3qnUb6FKCGeTUuoP2e59c5W12kb7hY2xeKOSWj19qSJvw
         LZrS6KezsbdSx6fJdbour7PUQSbFnW4YUWHb5Wyc+tYwPSVp6WFvDbMayqCCEmKjHgq1
         AvkhT5MOfv2F+mg4Xqe+o43iBiXBDXmwbYMtCv9Klad77mKLkXxaTx3A8Qjz9GC7ZKLX
         vd+Q==
X-Gm-Message-State: AOAM532ouiPJGo9ex53Efv49bcMEIMMoN9EOlifZMA7vsiwwcR/7rIZ6
        dBHlID7AjHJdtpEDucoM37w=
X-Google-Smtp-Source: ABdhPJwjZtwEwrpyhy+etq/VjPlWGxVwe2qV4NvoJ4SLLfXvXkWATt7s2S7siucglap/0xqXp1MQUw==
X-Received: by 2002:a63:6705:0:b0:3c1:976d:bd68 with SMTP id b5-20020a636705000000b003c1976dbd68mr5049666pgc.133.1652985011160;
        Thu, 19 May 2022 11:30:11 -0700 (PDT)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.googlemail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm3884674pgh.14.2022.05.19.11.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:30:10 -0700 (PDT)
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
Subject: [RFC PATCH 1/6] mm: Add a new mm flag for Copy-On-Write PTE table
Date:   Fri, 20 May 2022 02:31:22 +0800
Message-Id: <20220519183127.3909598-2-shiyn.lin@gmail.com>
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

Add MMF_COW_PGTABLE flag to prepare the subsequent implementation of
copy-on-write for the page table.

Signed-off-by: Chih-En Lin <shiyn.lin@gmail.com>
---
 include/linux/sched/coredump.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 4d9e3a656875..19e9f2b71398 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -83,7 +83,10 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_HAS_PINNED		28	/* FOLL_PIN has run, never cleared */
 #define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
 
+#define MMF_COW_PGTABLE		29
+#define MMF_COW_PGTABLE_MASK	(1 << MMF_COW_PGTABLE)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_COW_PGTABLE_MASK)
 
 #endif /* _LINUX_SCHED_COREDUMP_H */
-- 
2.36.1

