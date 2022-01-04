Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8917484947
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiADUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiADUXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:23:39 -0500
Received: from mail-io1-xd49.google.com (mail-io1-xd49.google.com [IPv6:2607:f8b0:4864:20::d49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C73C061398
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 12:23:34 -0800 (PST)
Received: by mail-io1-xd49.google.com with SMTP id o11-20020a0566022e0b00b005e95edf792dso20733713iow.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 12:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3mcZXTFAVVKAScTp9T3FYR4LKZEXMUV/Knzjk0tHVBE=;
        b=mCSkJPXwf5wHh/HtH5JZ+zUi3W3uwEIfDgmRUzHvNJepZwEhIS/LNb9n1UjALu6Szd
         LW2tgMSnTS94ajbP0LuotYeROOEjgYIqL1r52Fu2ahDG5lg6pwzoRhy2smYNkegSkyCh
         fxekftRQoLrHbGM7wBD6FLHByCTPJBiPTHg5NzOXkEp8FArYs2b/ajTU7WVFy14ke9FT
         wVCe1XGRcC2oVFeMgkzm4EvQ8o3PjhPioXo3Im20qILTBCqmMzInC/LY06qm4KQ5/lUz
         pqVasfgkpB0nb6Ec57SKzh/tKLoHnlE0A5BzuFT1bUxWh1TICakRWiay0NjrwCrWvetR
         mEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3mcZXTFAVVKAScTp9T3FYR4LKZEXMUV/Knzjk0tHVBE=;
        b=3hTRZviSySlqiVx9WdcQL/+kj6PUUS7JrbpSUHCJm9vwOUxHpEE6EDvU2KRbSZffSG
         Y1qdqr0L1e8SWnHUtDzLLdw/3RL4N7EhHIAPQ5i+4JDbQSHfJux2dd+wlUPyC+L73Xt/
         hkzBztkry02dmBSUeoAl2+bcDhVHS5kEk6Ny+8KKNNK+Tfq/4GCt7AgZnPOqwFaAsEMa
         V/EWurwvG1LEMW0ypuAtFSyfzFz7OpJ5Hca00H40JRwhQA9YndzAV7/uIAHG+7nqm53o
         6PgbO342aDp/6AU9V0owwMO9qKMAIln69b8fohOpYOfBFdlZsI5K+mzZOmMgy7ZPbfSF
         AUWw==
X-Gm-Message-State: AOAM531Fh5oHUJ7GOdQJijACDU4tIRlH55sWvxhyEux7cCO1R4UidS1u
        KpTX+o8UcTws2po6Kgqj24MmG1cYV6g=
X-Google-Smtp-Source: ABdhPJyZPE5V4Ptt+nYa5Cps4VQsza0yacqlO/1013IgaXvoQvd8iavdrzdCI+Jz1MdsuYRS3ehUPNavaKw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:6c8c:5506:7ca2:9dfd])
 (user=yuzhao job=sendgmr) by 2002:a92:d849:: with SMTP id h9mr24622336ilq.181.1641327813743;
 Tue, 04 Jan 2022 12:23:33 -0800 (PST)
Date:   Tue,  4 Jan 2022 13:22:28 -0700
In-Reply-To: <20220104202227.2903605-1-yuzhao@google.com>
Message-Id: <20220104202227.2903605-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20220104202227.2903605-1-yuzhao@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v6 9/9] mm: multigenerational lru: Kconfig
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        page-reclaim@google.com, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add configuration options for the multigenerational lru.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
---
 Documentation/vm/multigen_lru.rst | 18 ++++++++++++
 mm/Kconfig                        | 48 +++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
index 6f9e0181348b..a54c5637c455 100644
--- a/Documentation/vm/multigen_lru.rst
+++ b/Documentation/vm/multigen_lru.rst
@@ -6,6 +6,13 @@ Multigenerational LRU
 
 Quick start
 ===========
+Build configurations
+--------------------
+:Required: Set ``CONFIG_LRU_GEN=y``.
+
+:Optional: Set ``CONFIG_LRU_GEN_ENABLED=y`` to enable this feature by
+ default.
+
 Runtime configurations
 ----------------------
 :Required: Write ``1`` to ``/sys/kernel/mm/lru_gen/enable`` if the
@@ -25,6 +32,17 @@ Personal computers
 
 Data centers
 ------------
+:Optional: Change ``CONFIG_NR_LRU_GENS`` to a larger value to support
+ more generations for ``Working set estimation`` and
+ ``Proactive reclaim``.
+
+:Optional: Change ``CONFIG_TIERS_PER_GEN`` to a larger value to
+ support more tiers, which generally provide better protection for
+ page cache when under heavy buffered I/O workloads.
+
+:Optional: Set ``CONFIG_LRU_GEN_STATS=y`` to enable full stats for
+ debugging. See ``Debugfs interface``.
+
 :Debugfs interface: ``/sys/kernel/debug/lru_gen`` has the following
  format:
  ::
diff --git a/mm/Kconfig b/mm/Kconfig
index 356f4f2c779e..8a33605917f5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -900,6 +900,54 @@ config IO_MAPPING
 config SECRETMEM
 	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
 
+# multigenerational lru {
+config LRU_GEN
+	bool "Multigenerational LRU"
+	depends on MMU
+	# the following options can use up the spare bits in page flags
+	depends on !MAXSMP && (64BIT || !SPARSEMEM || SPARSEMEM_VMEMMAP)
+	help
+	  A high performance LRU implementation for memory overcommit. See
+	  Documentation/vm/multigen_lru.rst for details.
+
+config LRU_GEN_ENABLED
+	bool "Enable by default"
+	depends on LRU_GEN
+	help
+	  This option enables the multigenerational lru by default.
+
+config NR_LRU_GENS
+	int "Max number of generations"
+	depends on LRU_GEN
+	range 4 31
+	default 4
+	help
+	  This option uses order_base_2(N+1) bits in page flags.
+
+	  Do not configure more generations than you plan to use. They have a
+	  per-memcg and per-node memory overhead.
+
+config TIERS_PER_GEN
+	int "Number of tiers per generation"
+	depends on LRU_GEN
+	range 2 5
+	default 4
+	help
+	  This option uses N-2 bits in page flags.
+
+	  Larger values generally provide better protection for page cache when
+	  under heavy buffered I/O workloads.
+
+config LRU_GEN_STATS
+	bool "Full stats for debugging"
+	depends on LRU_GEN
+	help
+	  This option keeps historical stats for evicted generations.
+
+	  Do not enable full stats unless you plan to look at them. They have a
+	  per-memcg and per-node memory overhead.
+# }
+
 source "mm/damon/Kconfig"
 
 endmenu
-- 
2.34.1.448.ga2b2bfdf31-goog

