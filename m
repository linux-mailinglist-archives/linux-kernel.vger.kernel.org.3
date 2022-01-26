Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6247949C82F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbiAZLAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:00:01 -0500
Received: from foss.arm.com ([217.140.110.172]:59794 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240388AbiAZLAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:00:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1447C113E;
        Wed, 26 Jan 2022 03:00:00 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.88.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DE67D3F766;
        Wed, 26 Jan 2022 02:59:57 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     German Gomez <german.gomez@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf tools: apply correct label to user/kernel symbols in branch mode
Date:   Wed, 26 Jan 2022 10:59:26 +0000
Message-Id: <20220126105927.3411216-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In branch mode, the branch symbols were being displayed with incorrect
cpumode labels. So fix this.

For example, before:
  # perf record -b -a -- sleep 1
  # perf report -b

  Overhead  Command  Source Shared Object  Source Symbol               Target Symbol
     0.08%  swapper  [kernel.kallsyms]     [k] rcu_idle_enter          [k] cpuidle_enter_state
 ==> 0.08%  cmd0     [kernel.kallsyms]     [.] psi_group_change        [.] psi_group_change
     0.08%  cmd1     [kernel.kallsyms]     [k] psi_group_change        [k] psi_group_change

After:
  # perf report -b

  Overhead  Command  Source Shared Object  Source Symbol               Target Symbol
     0.08%  swapper  [kernel.kallsyms]     [k] rcu_idle_enter          [k] cpuidle_enter_state
     0.08%  cmd0     [kernel.kallsyms]     [k] psi_group_change        [k] pei_group_change
     0.08%  cmd1     [kernel.kallsyms]     [k] psi_group_change        [k] psi_group_change

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/machine.c    | 2 ++
 tools/perf/util/map_symbol.h | 1 +
 tools/perf/util/sort.c       | 4 ++--
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 3901440ae..ef564a5cf 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2072,6 +2072,7 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
+	ams->al_level = al.level;
 	ams->ms.maps = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
@@ -2091,6 +2092,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
+	ams->al_level = al.level;
 	ams->ms.maps = al.maps;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index 7d22ade08..e08817b0c 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -18,6 +18,7 @@ struct addr_map_symbol {
 	struct map_symbol ms;
 	u64	      addr;
 	u64	      al_addr;
+	char	      al_level;
 	u64	      phys_addr;
 	u64	      data_page_size;
 };
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index cfba8c337..2da081ef5 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -915,7 +915,7 @@ static int hist_entry__sym_from_snprintf(struct hist_entry *he, char *bf,
 		struct addr_map_symbol *from = &he->branch_info->from;
 
 		return _hist_entry__sym_snprintf(&from->ms, from->al_addr,
-						 he->level, bf, size, width);
+						 from->al_level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
@@ -928,7 +928,7 @@ static int hist_entry__sym_to_snprintf(struct hist_entry *he, char *bf,
 		struct addr_map_symbol *to = &he->branch_info->to;
 
 		return _hist_entry__sym_snprintf(&to->ms, to->al_addr,
-						 he->level, bf, size, width);
+						 to->al_level, bf, size, width);
 	}
 
 	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
-- 
2.25.1

