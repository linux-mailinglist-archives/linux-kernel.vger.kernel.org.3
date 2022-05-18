Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D952B213
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiERF6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiERF6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 01:58:39 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9017FC03AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:37 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id i8so795511plr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 22:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SWvOVMom7eH8OxIEa5j/UzCXep6BepIu9+Sif8dUOs=;
        b=JqcJt6uIoGSIGoO1syYH8keD5bz6dUyxA8kyc0WiuF4JA0MqIT4+Cbg9tR7PQPUiCZ
         dpN/HenEBY2Ii1GOg1gBN5kxBqu29xz90NEA1W8lh+cZOSTgsC4JcNG59ObBxco/28qh
         oSLNze77Z0vBtSgGoPRYeNlwJlGGnWOh91H5d4UjIGpYeZnQf2FqjzuW3rJ4LsZnyhSz
         5UJSo/b9/JjQZtTUo7+IFSJImj98/2PNaGeEk5JM6TUm8nWP5xWeooZNOu2XSa5zetfJ
         8OYToR6vrreKvb4zWfhDctjECDX2NL4YQjCEOPWPeNE/BCfW7uhsZZ0Z06GgNE0dMMGS
         Yl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SWvOVMom7eH8OxIEa5j/UzCXep6BepIu9+Sif8dUOs=;
        b=uU5E7Vzpxi3QdQcfBFWbO/BYDRuT0DIC2evReVahYgwDmqU5QDgEu/Fej2kRV1nKNk
         pQCBgZHBTIPqgYoit7EYPpw+cap7BeCuOAb4HXyfW8wsAg1X4dMpc2HtSTACIreDXUrS
         fyDINKCvKWA5D3AaVraPwwrV7CGqv5xDXzwqgj+BSmPbn8TiPxqywYThlYLv8z23PYpc
         oeJ/mzqpt2rUNMJlfLHQaWyF5Xae3yNNAV5obWlMMWOVOwSr9rnlRj5E5In1R3h3F+lN
         a4juLiderbEFiJ78uW+3cLVzpKzvqkMTgtHpcNsSxqCeeXKsgJ5Vo2X/1N+Wuz9hIgze
         s+Mg==
X-Gm-Message-State: AOAM531dcpPa7fWM7xIwMeYzmaFro/1oc4JTHlX5Z2mF+LlnJfMpjLnp
        GQLApO9dA2u+Q0ITeQnfhsbSzQ==
X-Google-Smtp-Source: ABdhPJzHjbGfUbQ2W9SW30P+OO67WGBSZyKgknK2Dr3MxlJpsx//hJaD/732Fw7cpIF7Rh6ibp5lXw==
X-Received: by 2002:a17:90b:4acc:b0:1df:ac4c:d6d with SMTP id mh12-20020a17090b4acc00b001dfac4c0d6dmr2403094pjb.5.1652853516713;
        Tue, 17 May 2022 22:58:36 -0700 (PDT)
Received: from localhost.localdomain (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb2c2sm627127plb.268.2022.05.17.22.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 22:58:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adam Li <adamli@amperemail.onmicrosoft.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 09/11] perf c2c: Sort on peer snooping for load operations
Date:   Wed, 18 May 2022 13:57:27 +0800
Message-Id: <20220518055729.1869566-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220518055729.1869566-1-leo.yan@linaro.org>
References: <20220518055729.1869566-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Except the existed three display options 'tot', 'rmt', 'lcl', this patch
adds a new option 'peer' so can sort on the cache hit for peer snooping.

For displaying with option 'peer', the "Shared Data Cache Line Table" and
"Shared Cache Line Distribution Pareto" both sort with the metrics
"ld_peer".  As result, we can get the 'peer' display as below:

  # perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio

  [...]

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------    Snoop  ------- Load Hitm -------    Snoop    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt     Peer    Total  LclHitm  RmtHitm     Peer  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0xaaaac17d6000   N/A       0  100.00%        0        0        0       99    18851    18851        0        0        0        0        0    18752        0         0        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        ----- HITM -----    Snoop  ------- Store Refs ------  --------- Data address ---------                                                  --------------- cycles ---------------    Total       cpu                                    Shared
  #   Num  RmtHitm  LclHitm     Peer   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt      Pid                Tid        Code address  rmt hitm  lcl hitm      load      peer  records       cnt                  Symbol            Object      Source:Line  Node{cpus %peers %stores}
  # .....  .......  .......  .......  .......  .......  .......  ..................  ....  ......  .......  .................  ..................  ........  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
  #
    -------------------------------------------------------------------------------
        0        0        0       99        0        0        0      0xaaaac17d6000
    -------------------------------------------------------------------------------
             0.00%    0.00%    3.03%    0.00%    0.00%    0.00%                0x20   N/A       0     3603     3603:memstress      0xaaaac17c25ac         0         0        41       376     9314         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 2 100.0%    n/a}
             0.00%    0.00%    3.03%    0.00%    0.00%    0.00%                0x20   N/A       0     3603     3606:memstress      0xaaaac17c25ac         0         0        44       375     9155         1  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 1 100.0%    n/a}
             0.00%    0.00%   45.45%    0.00%    0.00%    0.00%                0x29   N/A       0     3603     3603:memstress      0xaaaac17c3e88         0         0       175       180       70         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 2 100.0%    n/a}
             0.00%    0.00%   48.48%    0.00%    0.00%    0.00%                0x29   N/A       0     3603     3606:memstress      0xaaaac17c3e88         0         0       170       180       65         1  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 1 100.0%    n/a}

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 63 +++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 757a79442a52..3bd422c5e8ae 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -117,13 +117,15 @@ enum {
 	DISPLAY_LCL_HITM,
 	DISPLAY_RMT_HITM,
 	DISPLAY_TOT_HITM,
+	DISPLAY_SNP_PEER,
 	DISPLAY_MAX,
 };
 
 static const char *display_str[DISPLAY_MAX] = {
-	[DISPLAY_LCL_HITM] = "Local",
-	[DISPLAY_RMT_HITM] = "Remote",
-	[DISPLAY_TOT_HITM] = "Total",
+	[DISPLAY_LCL_HITM] = "Local HITMs",
+	[DISPLAY_RMT_HITM] = "Remote HITMs",
+	[DISPLAY_TOT_HITM] = "Total HITMs",
+	[DISPLAY_SNP_PEER] = "Snoop Peers",
 };
 
 static const struct option c2c_options[] = {
@@ -816,6 +818,11 @@ static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 	case DISPLAY_TOT_HITM:
 		st  = stats->tot_hitm;
 		tot = total->tot_hitm;
+		break;
+	case DISPLAY_SNP_PEER:
+		st  = stats->ld_peer;
+		tot = total->ld_peer;
+		break;
 	default:
 		break;
 	}
@@ -1191,6 +1198,10 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 				ret = display_metrics(hpp, stats->tot_hitm,
 						      c2c_he->stats.tot_hitm);
 				break;
+			case DISPLAY_SNP_PEER:
+				ret = display_metrics(hpp, stats->ld_peer,
+						      c2c_he->stats.ld_peer);
+				break;
 			default:
 				break;
 			}
@@ -1546,6 +1557,7 @@ static struct c2c_header percent_costly_snoop_header[] = {
 	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_SNP_PEER] = HEADER_BOTH("Snoop", "Peer"),
 };
 
 static struct c2c_dimension dim_percent_costly_snoop = {
@@ -2022,6 +2034,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		he->filtered = filter_display(c2c_he->stats.tot_hitm,
 					      stats->tot_hitm);
 		break;
+	case DISPLAY_SNP_PEER:
+		he->filtered = filter_display(c2c_he->stats.ld_peer,
+					      stats->ld_peer);
+		break;
 	default:
 		break;
 	}
@@ -2050,6 +2066,8 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	case DISPLAY_TOT_HITM:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
+	case DISPLAY_SNP_PEER:
+		has_record = !!c2c_he->stats.ld_peer;
 	default:
 		break;
 	}
@@ -2139,7 +2157,10 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 }
 
 static struct c2c_header header_node_0 = HEADER_LOW("Node");
-static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_hitms_stores =
+		HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_peers_stores =
+		HEADER_LOW("Node{cpus %peers %stores}");
 static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
 
 static void setup_nodes_header(void)
@@ -2149,7 +2170,10 @@ static void setup_nodes_header(void)
 		dim_node.header = header_node_0;
 		break;
 	case 1:
-		dim_node.header = header_node_1;
+		if (c2c.display == DISPLAY_SNP_PEER)
+			dim_node.header = header_node_1_peers_stores;
+		else
+			dim_node.header = header_node_1_hitms_stores;
 		break;
 	case 2:
 		dim_node.header = header_node_2;
@@ -2223,13 +2247,15 @@ static int setup_nodes(struct perf_session *session)
 }
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
+#define HAS_PEER(__h) ((__h)->stats.ld_peer)
 
 static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	if (HAS_HITMS(c2c_he)) {
+	if ((c2c.display != DISPLAY_SNP_PEER && HAS_HITMS(c2c_he)) ||
+	    (c2c.display == DISPLAY_SNP_PEER && HAS_PEER(c2c_he))) {
 		c2c.shared_clines++;
 		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
 	}
@@ -2404,7 +2430,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2561,7 +2587,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
@@ -2767,6 +2793,8 @@ static int setup_display(const char *str)
 		c2c.display = DISPLAY_RMT_HITM;
 	else if (!strcmp(display, "lcl"))
 		c2c.display = DISPLAY_LCL_HITM;
+	else if (!strcmp(display, "peer"))
+		c2c.display = DISPLAY_SNP_PEER;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2848,6 +2876,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 static int setup_coalesce(const char *coalesce, bool no_source)
 {
 	const char *c = coalesce ?: coalesce_default;
+	const char *sort_str = NULL;
 
 	if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
 		return -ENOMEM;
@@ -2855,12 +2884,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
 	if (build_cl_output(c2c.cl_sort, no_source))
 		return -1;
 
-	if (asprintf(&c2c.cl_resort, "offset,%s",
-		     c2c.display == DISPLAY_TOT_HITM ?
-		     "tot_hitm" :
-		     c2c.display == DISPLAY_RMT_HITM ?
-		     "rmt_hitm,lcl_hitm" :
-		     "lcl_hitm,rmt_hitm") < 0)
+	if (c2c.display == DISPLAY_TOT_HITM)
+		sort_str = "tot_hitm";
+	else if (c2c.display == DISPLAY_RMT_HITM)
+		sort_str = "rmt_hitm,lcl_hitm";
+	else if (c2c.display == DISPLAY_LCL_HITM)
+		sort_str = "lcl_hitm,rmt_hitm";
+	else if (c2c.display == DISPLAY_SNP_PEER)
+		sort_str = "ld_peer";
+
+	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
 		return -ENOMEM;
 
 	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
@@ -3021,6 +3054,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		sort_str = "rmt_hitm";
 	else if (c2c.display == DISPLAY_LCL_HITM)
 		sort_str = "lcl_hitm";
+	else if (c2c.display == DISPLAY_SNP_PEER)
+		sort_str = "ld_peer";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
-- 
2.25.1

