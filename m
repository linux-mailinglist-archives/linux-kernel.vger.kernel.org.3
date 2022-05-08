Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673051EC77
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbiEHJaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 05:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbiEHJ36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:29:58 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857AE0E5
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:25:44 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l11so4102904pgt.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SwFqL++LGuGx8rttWDytxUfoqa9BjW9BvDNKxYMsDB0=;
        b=hBKzaXL4nqoSRx9aqLZiF4x+ohv47BuayuWIuItMRiat/1r5d1I4zvMNsmGqy8kzTV
         XyQe13Tf8/p1TTDdBpsNLh9G2safLAhwQUxxOx1b/kBilcFYLKBtwmrAdKvU9flXeDMU
         Xc/II+mBoErQXrQPdS5Z5BgjKyXHgna3eSxs2UGrwGEl1zqO9jWl4aHjcUyPZVWSmoz7
         QXdhWJmrNUTFSMSnKlbcY8Go55wfPk3ja6UiTAP9gm4PLXhkArUEyUD6IDl1uEkgVv9F
         LU2CuwUiRulx0yZz4UNTH4cSg31BPaYB9tUHN4U97IKf6VCn37VuHnDidEtwReRJpxNh
         hIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SwFqL++LGuGx8rttWDytxUfoqa9BjW9BvDNKxYMsDB0=;
        b=ivh2/Z+eRcpAMqhfkcQF231tBEXACkDmhft7mI9C6J+E3+0/ADid5GAG+McR39muvR
         48MGBTIM/CWZn70q1xF79uoXMIhm8WVJQQomgLWKP2uot4MJVtjvkXm3IaaCO/ykE8Xn
         bEIGtWlUX3x9xm1QSuF9jGhrzEWSeWcjDfhLgMEaIrYrJi7xf5J2R4g3vZVuH/2bf/ZG
         XsSJEyKqsusxRuu1W4wzBNz9HV1sv6/MudtRC71YsKGej2UEwVS2XYvpPefBKmPDIHgY
         yLifLzVoJrAh2M8vkTbLMPOavkBGWHPn4lPLi44AT7Lm5QYc4tWfMIA5lMRSMDAzy2aq
         TGyg==
X-Gm-Message-State: AOAM5308F7IR0TLHw3VnXOakvi2K8JelunrxWesGsc/YgF90WhbenwKG
        LSPqiu3rKnHJikwBT4rOQIGiow==
X-Google-Smtp-Source: ABdhPJymZiS6mKIa8q2f/7DdoH7tPEFEodI8JyLw6ZHFYO2lK1pbw6Si5Zd0BcMs6FLYHkxiRm3Czw==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr11027599pfu.6.1652001943746;
        Sun, 08 May 2022 02:25:43 -0700 (PDT)
Received: from localhost.localdomain (104-237-153-19.ip.linodeusercontent.com. [104.237.153.19])
        by smtp.gmail.com with ESMTPSA id t63-20020a638142000000b003c14af505f7sm6155088pgd.15.2022.05.08.02.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 02:25:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Like Xu <likexu@tencent.com>, Ian Rogers <irogers@google.com>,
        Alyssa Ross <hi@alyssa.is>, Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 09/11] perf c2c: Sort on peer snooping for load operations
Date:   Sun,  8 May 2022 17:23:44 +0800
Message-Id: <20220508092346.255826-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508092346.255826-1-leo.yan@linaro.org>
References: <20220508092346.255826-1-leo.yan@linaro.org>
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
index 04f33dc8ca0f..9b6d2a9553e1 100644
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
@@ -818,6 +820,11 @@ static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
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
@@ -1193,6 +1200,10 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
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
@@ -1548,6 +1559,7 @@ static struct c2c_header percent_costly_snoop_header[] = {
 	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_SNP_PEER] = HEADER_BOTH("Snoop", "Peer"),
 };
 
 static struct c2c_dimension dim_percent_costly_snoop = {
@@ -2024,6 +2036,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
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
@@ -2052,6 +2068,8 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	case DISPLAY_TOT_HITM:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
+	case DISPLAY_SNP_PEER:
+		has_record = !!c2c_he->stats.ld_peer;
 	default:
 		break;
 	}
@@ -2141,7 +2159,10 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 }
 
 static struct c2c_header header_node_0 = HEADER_LOW("Node");
-static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_hitms_stores =
+		HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_peers_stores =
+		HEADER_LOW("Node{cpus %peers %stores}");
 static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
 
 static void setup_nodes_header(void)
@@ -2151,7 +2172,10 @@ static void setup_nodes_header(void)
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
@@ -2225,13 +2249,15 @@ static int setup_nodes(struct perf_session *session)
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
@@ -2406,7 +2432,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
-	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
+	fprintf(out, "  Cachelines sort on                : %s\n",
 		display_str[c2c.display]);
 	fprintf(out, "  Cacheline data grouping           : %s\n", c2c.cl_sort);
 }
@@ -2563,7 +2589,7 @@ static int perf_c2c_browser__title(struct hist_browser *browser,
 {
 	scnprintf(bf, size,
 		  "Shared Data Cache Line Table     "
-		  "(%lu entries, sorted on %s HITMs)",
+		  "(%lu entries, sorted on %s)",
 		  browser->nr_non_filtered_entries,
 		  display_str[c2c.display]);
 	return 0;
@@ -2769,6 +2795,8 @@ static int setup_display(const char *str)
 		c2c.display = DISPLAY_RMT_HITM;
 	else if (!strcmp(display, "lcl"))
 		c2c.display = DISPLAY_LCL_HITM;
+	else if (!strcmp(display, "peer"))
+		c2c.display = DISPLAY_SNP_PEER;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2850,6 +2878,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 static int setup_coalesce(const char *coalesce, bool no_source)
 {
 	const char *c = coalesce ?: coalesce_default;
+	const char *sort_str = NULL;
 
 	if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
 		return -ENOMEM;
@@ -2857,12 +2886,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
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
@@ -3023,6 +3056,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		sort_str = "rmt_hitm";
 	else if (c2c.display == DISPLAY_LCL_HITM)
 		sort_str = "lcl_hitm";
+	else if (c2c.display == DISPLAY_SNP_PEER)
+		sort_str = "ld_peer";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
-- 
2.25.1

