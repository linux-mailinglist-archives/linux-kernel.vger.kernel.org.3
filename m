Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463744D273B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbiCIBQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiCIBQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:16:49 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFAD16F970
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:05:22 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so5004607b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 17:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=5w1OIfygzSAzOtR1gEmt6DQmNATik/MV9LcnsLZ7twE=;
        b=VmtraZ998i0c3SLIXGsaDapNpLDnNwC90h3F9NhYwhfeLG4kWQ0pxVDK0xFqBdd31/
         O75Uyb1YCFIXEs3jPi1jSsnrhN0sSNoWLADWTG2DDE7svbB5RNZMPBETU0CZMpdwjnRk
         cHhuCTwAjwuj5JW668Ylb4zSDeQyhvV6qavV9prGeugTCy3oekzyNdbW/I584eMcAcqz
         3INfnz7jrWWKKBafzc+djKDRdNPjY/4BrQ/6yNQcHdfYf+VdHaxaPY/B1Rw8HKWzXhzn
         oik6vT19Wq7DIt6GpFUpzrsli17ZFl72q1uqxb1D6dhlst7F0xhjsm3bgnqv+Yqs5hoG
         S51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=5w1OIfygzSAzOtR1gEmt6DQmNATik/MV9LcnsLZ7twE=;
        b=EBRzY91/H30UE6vMQm/jenLm95SSUfp9dHg8I3HjpQS93Oi8n9+OzWRfhsA/JxsTkR
         mG16rGJgn32PfSM/BBpKSeWzA1cnNmFT8Al5LCQnKB911f8bUgcSNmCkKmT9E6svvYTL
         O09T3lAtUbHoqjnFS90m7Aw8Im4cw+P8nOQWmO7N4KmKhtuV6RxJRTW5KytE/hH5Bnby
         9rl8rlCOly732PnsKAoutHWkP+00VvtrooCOss4HKV7hKAM86tXhHeO60LQYZRYtgIRD
         aeq1xb3fPSkHGriUizS0q+Xi4lym2fD552S8xPBIPgOd6NNxnL4x9LAf7PS+5t/d1k2c
         5vmw==
X-Gm-Message-State: AOAM531o4+JQzkKSifLphunrrkp0uamu8KwzdQ1aGpWPXsml6qauHLsk
        7Db80538PrmRXt+sYTi96hpIDPBRPP4=
X-Google-Smtp-Source: ABdhPJzKcl/TP6kH+FmylpiM0aHD/7GierDsHJdkwsZVoIQCtyZIj202X1NnTxJc8Yav7hJXeGgtyQYmv+w=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:57a6:54a6:aad1:c0a8])
 (user=yuzhao job=sendgmr) by 2002:a25:b9ca:0:b0:619:649f:1bf6 with SMTP id
 y10-20020a25b9ca000000b00619649f1bf6mr14098274ybj.196.1646783322500; Tue, 08
 Mar 2022 15:48:42 -0800 (PST)
Date:   Tue,  8 Mar 2022 16:47:23 -0700
In-Reply-To: <20220308234723.3834941-1-yuzhao@google.com>
Message-Id: <20220308234723.3834941-14-yuzhao@google.com>
Mime-Version: 1.0
References: <20220308234723.3834941-1-yuzhao@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v8 13/14] mm: multi-gen LRU: admin guide
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        "=?UTF-8?q?Holger=20Hoffst=C3=A4tte?=" 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an admin guide.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Acked-by: Brian Geffon <bgeffon@google.com>
Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Acked-by: Steven Barrett <steven@liquorix.net>
Acked-by: Suleiman Souhlal <suleiman@google.com>
Tested-by: Daniel Byrne <djbyrne@mtu.edu>
Tested-by: Donald Carr <d@chaos-reins.com>
Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
Tested-by: Sofia Trinh <sofia.trinh@edi.works>
Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 Documentation/admin-guide/mm/index.rst        |   1 +
 Documentation/admin-guide/mm/multigen_lru.rst | 146 ++++++++++++++++++
 mm/Kconfig                                    |   3 +-
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/mm/multigen_lru.rst

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-g=
uide/mm/index.rst
index c21b5823f126..2cf5bae62036 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -32,6 +32,7 @@ the Linux memory management.
    idle_page_tracking
    ksm
    memory-hotplug
+   multigen_lru
    nommu-mmap
    numa_memory_policy
    numaperf
diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/=
admin-guide/mm/multigen_lru.rst
new file mode 100644
index 000000000000..c60dcae5a1a9
--- /dev/null
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -0,0 +1,146 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Multi-Gen LRU
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Quick start
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Build the kernel with the following configurations.
+
+* ``CONFIG_LRU_GEN=3Dy``
+* ``CONFIG_LRU_GEN_ENABLED=3Dy``
+
+All set!
+
+Runtime options
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``/sys/kernel/mm/lru_gen/`` contains stable ABIs described in the
+following subsections.
+
+Kill switch
+-----------
+``enable`` accepts different values to enable or disabled the
+following components. The default value of this file depends on
+``CONFIG_LRU_GEN_ENABLED``. All the components should be enabled
+unless some of them have unforeseen side effects. Writing to
+``enable`` has no effect when a component is not supported by the
+hardware, and valid values will be accepted even when the main switch
+is off.
+
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Values Components
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+0x0001 The main switch for the multi-gen LRU.
+0x0002 Clearing the accessed bit in leaf page table entries in large
+       batches, when MMU sets it (e.g., on x86). This behavior can
+       theoretically worsen lock contention (mmap_lock). If it is
+       disabled, the multi-gen LRU will suffer a minor performance
+       degradation.
+0x0004 Clearing the accessed bit in non-leaf page table entries as
+       well, when MMU sets it (e.g., on x86). This behavior was not
+       verified on x86 varieties other than Intel and AMD. If it is
+       disabled, the multi-gen LRU will suffer a negligible
+       performance degradation.
+[yYnN] Apply to all the components above.
+=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+E.g.,
+::
+
+    echo y >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0007
+    echo 5 >/sys/kernel/mm/lru_gen/enabled
+    cat /sys/kernel/mm/lru_gen/enabled
+    0x0005
+
+Thrashing prevention
+--------------------
+Personal computers are more sensitive to thrashing because it can
+cause janks (lags when rendering UI) and negatively impact user
+experience. The multi-gen LRU offers thrashing prevention to the
+majority of laptop and desktop users who do not have ``oomd``.
+
+Users can write ``N`` to ``min_ttl_ms`` to prevent the working set of
+``N`` milliseconds from getting evicted. The OOM killer is triggered
+if this working set cannot be kept in memory. In other words, this
+option works as an adjustable pressure relief valve, and when open, it
+terminates applications that are hopefully not being used.
+
+Based on the average human detectable lag (~100ms), ``N=3D1000`` usually
+eliminates intolerable janks due to thrashing. Larger values like
+``N=3D3000`` make janks less noticeable at the risk of premature OOM
+kills.
+
+Experimental features
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+``/sys/kernel/debug/lru_gen`` accepts commands described in the
+following subsections. Multiple command lines are supported, so does
+concatenation with delimiters ``,`` and ``;``.
+
+``/sys/kernel/debug/lru_gen_full`` provides additional stats for
+debugging. ``CONFIG_LRU_GEN_STATS=3Dy`` keeps historical stats from
+evicted generations in this file.
+
+Working set estimation
+----------------------
+Working set estimation measures how much memory an application
+requires in a given time interval, and it is usually done with little
+impact on the performance of the application. E.g., data centers want
+to optimize job scheduling (bin packing) to improve memory
+utilizations. When a new job comes in, the job scheduler needs to find
+out whether each server it manages can allocate a certain amount of
+memory for this new job before it can pick a candidate. To do so, this
+job scheduler needs to estimate the working sets of the existing jobs.
+
+When it is read, ``lru_gen`` returns a histogram of numbers of pages
+accessed over different time intervals for each memcg and node.
+``CONFIG_NR_LRU_GENS`` decides the number of bins for each histogram.
+::
+
+    memcg  memcg_id  memcg_path
+       node  node_id
+           min_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
+           ...
+           max_gen_nr  age_in_ms  nr_anon_pages  nr_file_pages
+
+Each generation contains an estimated number of pages that have been
+accessed within ``age_in_ms`` non-cumulatively. E.g., ``min_gen_nr``
+contains the coldest pages and ``max_gen_nr`` contains the hottest
+pages, since ``age_in_ms`` of the former is the largest and that of
+the latter is the smallest.
+
+Users can write ``+ memcg_id node_id max_gen_nr
+[can_swap[full_scan]]`` to ``lru_gen`` to create a new generation
+``max_gen_nr+1``. ``can_swap`` defaults to the swap setting and, if it
+is set to ``1``, it forces the scan of anon pages when swap is off.
+``full_scan`` defaults to ``1`` and, if it is set to ``0``, it reduces
+the overhead as well as the coverage when scanning page tables.
+
+A typical use case is that a job scheduler writes to ``lru_gen`` at a
+certain time interval to create new generations, and it ranks the
+servers it manages based on the sizes of their cold memory defined by
+this time interval.
+
+Proactive reclaim
+-----------------
+Proactive reclaim induces memory reclaim when there is no memory
+pressure and usually targets cold memory only. E.g., when a new job
+comes in, the job scheduler wants to proactively reclaim memory on the
+server it has selected to improve the chance of successfully landing
+this new job.
+
+Users can write ``- memcg_id node_id min_gen_nr [swappiness
+[nr_to_reclaim]]`` to ``lru_gen`` to evict generations less than or
+equal to ``min_gen_nr``. Note that ``min_gen_nr`` should be less than
+``max_gen_nr-1`` as ``max_gen_nr`` and ``max_gen_nr-1`` are not fully
+aged and therefore cannot be evicted. ``swappiness`` overrides the
+default value in ``/proc/sys/vm/swappiness``. ``nr_to_reclaim`` limits
+the number of pages to evict.
+
+A typical use case is that a job scheduler writes to ``lru_gen``
+before it tries to land a new job on a server, and if it fails to
+materialize the cold memory without impacting the existing jobs on
+this server, it retries on the next server according to the ranking
+result obtained from the working set estimation step described
+earlier.
diff --git a/mm/Kconfig b/mm/Kconfig
index e9d5f1d09ac4..414eee6390a6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -899,7 +899,8 @@ config LRU_GEN
 	# the following options can use up the spare bits in page flags
 	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
 	help
-	  A high performance LRU implementation for memory overcommit.
+	  A high performance LRU implementation for memory overcommit. See
+	  Documentation/admin-guide/mm/multigen_lru.rst for details.
=20
 config LRU_GEN_ENABLED
 	bool "Enable by default"
--=20
2.35.1.616.g0bdcbb4464-goog

