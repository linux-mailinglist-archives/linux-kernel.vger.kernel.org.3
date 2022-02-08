Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFFD4AE41C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387795AbiBHW0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386890AbiBHVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:26 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5787CC0612BC
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 2-20020a251302000000b006118f867dadso324967ybt.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AfnR3Nm7yc5ok/MjiQ3WXGdZyImD71++/kH8RUzdzEo=;
        b=iGiHWkFBaBN5bvqSrIpm9CvlBfMgTkuuVA6EthbtpSWjMnmORtCnFFKEJ/EOCl0OUb
         tQQgi/sCdNelt5HSNHz3jJuediSGaFROqcHQs4qMfU6KIGnae3LaZL805GJhUeowx9eH
         c/shKP4YQqL95KEdx3uYl4Er+lR0fVRv/ZvedjYQtLUj+26q0ZWVFkXWSNJyOoOlU76J
         4UzH/XErzqOQ/YWKTnkyFaYSIflQMoHK78qvthYhr2jiOoV8X6iQ4pKK4zV0VhJ6gt4T
         9l6OjznvCKouvsD9qCaob3Pa/n2Za2bW673iX/L+JWg3cG/gggiJysDrCHtcyQiBIswk
         yLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AfnR3Nm7yc5ok/MjiQ3WXGdZyImD71++/kH8RUzdzEo=;
        b=x0fbLW+GMVfXzmFThHBldfWXvRbN3DrbBQTWhjP7RBBAk8IyKPk+667CaLcsX2W2fj
         59hGrkBu4BaR0aJTA6YqWmcVm/q+JT+Va2ZpIqvY3KWw3fj3Xe5VE1inFu2i3zoNhKRB
         9ui80VnRZ5JtTa0YDJxOnArdnLj79NBt4MN9LAk8JqrlkK5iqJHCStyJluct/HkBz/AC
         hW8dGV/amC1SvZBK2GO4XGKqUMEX5whwrFqnNz3ZiXI9J/YGwQIA21fVUchzkwbxzMc1
         pHRBKGA1chCRdgaEggO/dVIARzf8rHH2ctMUAkb5GWp6ximfzWJWBw0EhXXYA8Doh0Dd
         EXjw==
X-Gm-Message-State: AOAM532+aisc7LweC3FWMEcu03OInp+5gM0TuALhQJ3aXLXSIesDwtCT
        A4cm8mWiaJD5s1ji7v+RF11SBa8iijnCgb9RtYJCWUXJh6ssNRk62VqLtRjJmrwRDT5JGlMwSXb
        +65PRwsGLOdN1olXS5FJdqxZT1+kGF1ZsIwIzc2Rsovznsvz+kIhUZ07NzHHI3FRpbSfis1wN
X-Google-Smtp-Source: ABdhPJxsi9V32l7wcvyjIOPe9zUkfV3MbtC27mX+fQ98jrFwTM1ryS5Noz2QhHdTWMjuLjoRcr7A1Z8UtjFv
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:bcd0:: with SMTP id
 l16mr5459204ybm.59.1644355044562; Tue, 08 Feb 2022 13:17:24 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:37 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-13-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 12/12] perf report: add addr_from/addr_to sort dimensions
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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

With the existing symbol_from/symbol_to, branches captured in the same
function would be collapsed into a single function if the latencies associated
with the each branch (cycles) were all the same.  That is the case on Intel
Broadwell, for instance. Since Intel Skylake, the latency is captured by
hardware and therefore is used to disambiguate branches.

Add addr_from/addr_to sort dimensions to sort branches based on their
addresses and not the function there are in. The output is still the function
name but the offset within the function is provided to uniquely identify each
branch.  These new sort dimensions also help with annotate because they create
different entries in the histogram which, in turn, generates proper branch
annotations.

Here is an example using AMD's branch sampling:

$ perf record -a -b -c 1000037 -e cpu/branch-brs/ test_prg

$ perf report
Samples: 6M of event 'cpu/branch-brs/', Event count (approx.): 6901276
Overhead  Command          Source Shared Object  Source Symbol                                   Target Symbol                                   Basic Block Cycle
  99.65%  test_prg	   test_prg              [.] test_thread                                 [.] test_thread                                 -
   0.02%  test_prg         [kernel.vmlinux]      [k] asm_sysvec_apic_timer_interrupt             [k] error_entry                                 -

$ perf report -F overhead,comm,dso,addr_from,addr_to
Samples: 6M of event 'cpu/branch-brs/', Event count (approx.): 6901276
Overhead  Command          Shared Object     Source Address          Target Address
   4.22%  test_prg         test_prg          [.] test_thread+0x3c    [.] test_thread+0x4
   4.13%  test_prg         test_prg          [.] test_thread+0x4     [.] test_thread+0x3a
   4.09%  test_prg         test_prg          [.] test_thread+0x3a    [.] test_thread+0x6
   4.08%  test_prg         test_prg          [.] test_thread+0x2     [.] test_thread+0x3c
   4.06%  test_prg         test_prg          [.] test_thread+0x3e    [.] test_thread+0x2
   3.87%  test_prg         test_prg          [.] test_thread+0x6     [.] test_thread+0x38
   3.84%  test_prg         test_prg          [.] test_thread         [.] test_thread+0x3e
   3.76%  test_prg         test_prg          [.] test_thread+0x1e    [.] test_thread
   3.76%  test_prg         test_prg          [.] test_thread+0x38    [.] test_thread+0x8
   3.56%  test_prg         test_prg          [.] test_thread+0x22    [.] test_thread+0x1e
   3.54%  test_prg         test_prg          [.] test_thread+0x8     [.] test_thread+0x36
   3.47%  test_prg         test_prg          [.] test_thread+0x1c    [.] test_thread+0x22
   3.45%  test_prg         test_prg          [.] test_thread+0x36    [.] test_thread+0xa
   3.28%  test_prg         test_prg          [.] test_thread+0x24    [.] test_thread+0x1c
   3.25%  test_prg         test_prg          [.] test_thread+0xa     [.] test_thread+0x34
   3.24%  test_prg         test_prg          [.] test_thread+0x1a    [.] test_thread+0x24
   3.20%  test_prg         test_prg          [.] test_thread+0x34    [.] test_thread+0xc
   3.04%  test_prg         test_prg          [.] test_thread+0x26    [.] test_thread+0x1a
   3.01%  test_prg         test_prg          [.] test_thread+0xc     [.] test_thread+0x32
   2.98%  test_prg         test_prg          [.] test_thread+0x18    [.] test_thread+0x26
   2.94%  test_prg         test_prg          [.] test_thread+0x32    [.] test_thread+0xe
   2.76%  test_prg         test_prg          [.] test_thread+0x28    [.] test_thread+0x18
   2.73%  test_prg         test_prg          [.] test_thread+0xe     [.] test_thread+0x30
   2.67%  test_prg         test_prg          [.] test_thread+0x30    [.] test_thread+0x10
   2.67%  test_prg         test_prg          [.] test_thread+0x16    [.] test_thread+0x28
   2.46%  test_prg         test_prg          [.] test_thread+0x10    [.] test_thread+0x2e
   2.44%  test_prg         test_prg          [.] test_thread+0x2a    [.] test_thread+0x16
   2.38%  test_prg         test_prg          [.] test_thread+0x14    [.] test_thread+0x2a
   2.32%  test_prg         test_prg          [.] test_thread+0x2e    [.] test_thread+0x12
   2.28%  test_prg         test_prg          [.] test_thread+0x12    [.] test_thread+0x2c
   2.16%  test_prg         test_prg          [.] test_thread+0x2c    [.] test_thread+0x14
   0.02%  test_prg         [kernel.vmlinux]  [k] asm_sysvec_apic_ti+0x5  [k] error_entry

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 tools/perf/util/hist.c |   2 +
 tools/perf/util/hist.h |   2 +
 tools/perf/util/sort.c | 128 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/sort.h |   2 +
 4 files changed, 134 insertions(+)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0a8033b09e28..1c085ab56534 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -124,6 +124,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
 			hists__new_col_len(hists, HISTC_SYMBOL_FROM, symlen);
+			hists__new_col_len(hists, HISTC_ADDR_FROM, symlen);
 			hists__set_unres_dso_col_len(hists, HISTC_DSO_FROM);
 		}
 
@@ -138,6 +139,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 		} else {
 			symlen = unresolved_col_width + 4 + 2;
 			hists__new_col_len(hists, HISTC_SYMBOL_TO, symlen);
+			hists__new_col_len(hists, HISTC_ADDR_TO, symlen);
 			hists__set_unres_dso_col_len(hists, HISTC_DSO_TO);
 		}
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 2a15e22fb89c..7ed4648d2fc2 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -77,6 +77,8 @@ enum hist_column {
 	HISTC_GLOBAL_INS_LAT,
 	HISTC_LOCAL_P_STAGE_CYC,
 	HISTC_GLOBAL_P_STAGE_CYC,
+	HISTC_ADDR_FROM,
+	HISTC_ADDR_TO,
 	HISTC_NR_COLS, /* Last entry */
 };
 
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 2da081ef532b..6d5588e80935 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -990,6 +990,128 @@ struct sort_entry sort_sym_to = {
 	.se_width_idx	= HISTC_SYMBOL_TO,
 };
 
+static int _hist_entry__addr_snprintf(struct map_symbol *ms,
+				     u64 ip, char level, char *bf, size_t size,
+				     unsigned int width)
+{
+	struct symbol *sym = ms->sym;
+	struct map *map = ms->map;
+	size_t ret = 0, offs;
+
+	ret += repsep_snprintf(bf + ret, size - ret, "[%c] ", level);
+	if (sym && map) {
+		if (sym->type == STT_OBJECT) {
+			ret += repsep_snprintf(bf + ret, size - ret, "%s", sym->name);
+			ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx",
+					ip - map->unmap_ip(map, sym->start));
+		} else {
+			ret += repsep_snprintf(bf + ret, size - ret, "%.*s",
+					       width - ret,
+					       sym->name);
+			offs = ip - sym->start;
+			if (offs)
+				ret += repsep_snprintf(bf + ret, size - ret, "+0x%llx", offs);
+		}
+	} else {
+		size_t len = BITS_PER_LONG / 4;
+		ret += repsep_snprintf(bf + ret, size - ret, "%-#.*llx",
+				       len, ip);
+	}
+
+	return ret;
+}
+
+static int hist_entry__addr_from_snprintf(struct hist_entry *he, char *bf,
+					 size_t size, unsigned int width)
+{
+	if (he->branch_info) {
+		struct addr_map_symbol *from = &he->branch_info->from;
+
+		return _hist_entry__addr_snprintf(&from->ms, from->al_addr,
+						 he->level, bf, size, width);
+	}
+
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
+}
+
+static int hist_entry__addr_to_snprintf(struct hist_entry *he, char *bf,
+				       size_t size, unsigned int width)
+{
+	if (he->branch_info) {
+		struct addr_map_symbol *to = &he->branch_info->to;
+
+		return _hist_entry__addr_snprintf(&to->ms, to->al_addr,
+						 he->level, bf, size, width);
+	}
+
+	return repsep_snprintf(bf, size, "%-*.*s", width, width, "N/A");
+}
+
+static int64_t
+sort__addr_from_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	struct addr_map_symbol *from_l;
+	struct addr_map_symbol *from_r;
+	int64_t ret;
+
+	if (!left->branch_info || !right->branch_info)
+		return cmp_null(left->branch_info, right->branch_info);
+
+	from_l = &left->branch_info->from;
+	from_r = &right->branch_info->from;
+
+	/*
+	 * comparing symbol address alone is not enough since it's a
+	 * relative address within a dso.
+	 */
+	ret = _sort__dso_cmp(from_l->ms.map, from_r->ms.map);
+	if (ret != 0)
+		return ret;
+
+	return _sort__addr_cmp(from_l->addr, from_r->addr);
+}
+
+static int64_t
+sort__addr_to_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	struct addr_map_symbol *to_l;
+	struct addr_map_symbol *to_r;
+	int64_t ret;
+
+	if (!left->branch_info || !right->branch_info)
+		return cmp_null(left->branch_info, right->branch_info);
+
+	to_l = &left->branch_info->to;
+	to_r = &right->branch_info->to;
+
+	/*
+	 * comparing symbol address alone is not enough since it's a
+	 * relative address within a dso.
+	 */
+	ret = _sort__dso_cmp(to_l->ms.map, to_r->ms.map);
+	if (ret != 0)
+		return ret;
+
+	return _sort__addr_cmp(to_l->addr, to_r->addr);
+}
+
+struct sort_entry sort_addr_from = {
+	.se_header	= "Source Address",
+	.se_cmp		= sort__addr_from_cmp,
+	.se_snprintf	= hist_entry__addr_from_snprintf,
+	.se_filter	= hist_entry__sym_from_filter, /* shared with sym_from */
+	.se_width_idx	= HISTC_ADDR_FROM,
+};
+
+struct sort_entry sort_addr_to = {
+	.se_header	= "Target Address",
+	.se_cmp		= sort__addr_to_cmp,
+	.se_snprintf	= hist_entry__addr_to_snprintf,
+	.se_filter	= hist_entry__sym_to_filter, /* shared with sym_to */
+	.se_width_idx	= HISTC_ADDR_TO,
+};
+
+
 static int64_t
 sort__mispredict_cmp(struct hist_entry *left, struct hist_entry *right)
 {
@@ -1893,6 +2015,8 @@ static struct sort_dimension bstack_sort_dimensions[] = {
 	DIM(SORT_SRCLINE_FROM, "srcline_from", sort_srcline_from),
 	DIM(SORT_SRCLINE_TO, "srcline_to", sort_srcline_to),
 	DIM(SORT_SYM_IPC, "ipc_lbr", sort_sym_ipc),
+	DIM(SORT_ADDR_FROM, "addr_from", sort_addr_from),
+	DIM(SORT_ADDR_TO, "addr_to", sort_addr_to),
 };
 
 #undef DIM
@@ -3126,6 +3250,10 @@ static bool get_elide(int idx, FILE *output)
 		return __get_elide(symbol_conf.dso_from_list, "dso_from", output);
 	case HISTC_DSO_TO:
 		return __get_elide(symbol_conf.dso_to_list, "dso_to", output);
+	case HISTC_ADDR_FROM:
+		return __get_elide(symbol_conf.sym_from_list, "addr_from", output);
+	case HISTC_ADDR_TO:
+		return __get_elide(symbol_conf.sym_to_list, "addr_to", output);
 	default:
 		break;
 	}
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index f994261888e1..2ddc00d1c464 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -251,6 +251,8 @@ enum sort_type {
 	SORT_SRCLINE_FROM,
 	SORT_SRCLINE_TO,
 	SORT_SYM_IPC,
+	SORT_ADDR_FROM,
+	SORT_ADDR_TO,
 
 	/* memory mode specific sort keys */
 	__SORT_MEMORY_MODE,
-- 
2.35.0.263.gb82422642f-goog

