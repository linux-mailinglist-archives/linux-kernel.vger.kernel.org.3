Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2B53D580
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350661AbiFDEbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350605AbiFDEaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:30:18 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3295C37014
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:30:08 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j7so8716127pjn.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tX6DcZqaWhHC2FThTQuomyIQfm0jVlHpS7Xh9jPWIIc=;
        b=AZ3dohV9xoxAZWUaNphnUVdw1qUrXVBD0w/9kay823oTOnbaLokrZShzlzaKodq4iW
         IomG1m1OksgZ+Pztbe8guTVZYDeb39oqZKVDlcI6EABnHro54SPrXDxzWY4i5yWLItRY
         LkCcQazZ+GXrE0120hjEawD7ylFIKWu1blFICZ9hJSwMxZIyzO/Bo5ss5lR4LOOcljzc
         p2/1GIB+TdCVcZB94uVaw6WyfzqDYBMRZlz8bUMOO4zYlyCIMeRmN4cOJok5iB3C9Zl3
         33kJJObLpXSIldfFudp4dZYIiRLGqBeuW3ND0v0jvt1kPA7zrWqxor10iRG37k8a15w2
         SLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tX6DcZqaWhHC2FThTQuomyIQfm0jVlHpS7Xh9jPWIIc=;
        b=tQ+S54rUWLsDq6isSANQXTTC3hBP/BS0i7DXEtYQQixBdlERK/LDxvkSij+1NB6z8O
         9IXv/G9vAtxsg2RWgZ3D488RQP6cKrKuKSmTBU6fcqVa7LkYJMpOtOW4vUKD42RiupeC
         U3dQ0dGt3Rd6QZQC3HSKnSaxRPungpvxFF5aYKD4nt3SobsOYUAITTVRc6fyzaMsJGzD
         HTO5FV78hH11txTUU6IfkWM8y8pIpdkQlHrotUpOwgR1YJJHTefgrOVF8y65zFEXhqCT
         +9m9vruLJ601auYRqyiVAIeDH59ITyBQ7G1DZDW3P5kdxgmaKn1Cl5dd3Mk91ReaALos
         9bZg==
X-Gm-Message-State: AOAM533Ag5TL21nyMftGx42Qd/861UEerKz70Hu17fPF7joNwCsP3y4i
        TzKi6Vr7T7reeWqeUXDFqk7vJg==
X-Google-Smtp-Source: ABdhPJyK9d+eXYs9Ol4VhNnw7xljw2sUTCLRg1Pz+M3+z0i98ArqaSsxgBTO+c96VgNUJlUoBLC0Xw==
X-Received: by 2002:a17:90a:4a03:b0:1df:4583:cb26 with SMTP id e3-20020a17090a4a0300b001df4583cb26mr49131046pjh.173.1654317007870;
        Fri, 03 Jun 2022 21:30:07 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:30:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Ali Saidi <alisaidi@amazon.com>, Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 15/17] perf c2c: Sort on peer snooping for load operations
Date:   Sat,  4 Jun 2022 12:28:18 +0800
Message-Id: <20220604042820.2270916-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new option 'peer' so can sort on the cache hit for
peer snooping.

For displaying with option 'peer', the "Shared Data Cache Line Table"
and "Shared Cache Line Distribution Pareto" both sort with the metrics
"tot_peer".

As result, we can get the 'peer' display:

  # perf c2c report -d peer --coalesce tid,pid,iaddr,dso -N --stdio

  =================================================
             Shared Data Cache Line Table
  =================================================
  #
  #        ----------- Cacheline ----------     Peer  ------- Load Peer -------    Total    Total    Total  --------- Stores --------  ----- Core Load Hit -----  - LLC Load Hit --  - RMT Load Hit --  --- Load Dram ----
  # Index             Address  Node  PA cnt    Snoop    Total    Local   Remote  records    Loads   Stores    L1Hit   L1Miss      N/A       FB       L1       L2    LclHit  LclHitm    RmtHit  RmtHitm       Lcl       Rmt
  # .....  ..................  ....  ......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  .......  ........  .......  ........  .......  ........  ........
  #
        0      0xaaaac17d6000   N/A       0  100.00%       99       99        0    18851    18851        0        0        0        0        0    18752        0        99        0         0        0         0         0

  =================================================
        Shared Cache Line Distribution Pareto
  =================================================
  #
  #        -- Peer Snoop --  ------- Store Refs ------  --------- Data address ---------                                                  ---------- cycles ----------    Total       cpu                                    Shared
  #   Num      Rmt      Lcl   L1 Hit  L1 Miss      N/A              Offset  Node  PA cnt      Pid                Tid        Code address  rmt peer  lcl peer      load  records       cnt                  Symbol            Object      Source:Line  Node{cpus %peers %stores}
  # .....  .......  .......  .......  .......  .......  ..................  ....  ......  .......  .................  ..................  ........  ........  ........  .......  ........  ......................  ................  ...............  ....
  #
    ----------------------------------------------------------------------
        0        0       99        0        0        0      0xaaaac17d6000
    ----------------------------------------------------------------------
             0.00%    3.03%    0.00%    0.00%    0.00%                0x20   N/A       0     3603     3603:memstress      0xaaaac17c25ac         0       376        41     9314         2  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 2 100.0%    n/a}
             0.00%    3.03%    0.00%    0.00%    0.00%                0x20   N/A       0     3603     3606:memstress      0xaaaac17c25ac         0       375        44     9155         1  [.] 0x00000000000025ac  memstress         memstress[25ac]   0{ 1 100.0%    n/a}
             0.00%   48.48%    0.00%    0.00%    0.00%                0x29   N/A       0     3603     3606:memstress      0xaaaac17c3e88         0       180       170       65         1  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 1 100.0%    n/a}
             0.00%   45.45%    0.00%    0.00%    0.00%                0x29   N/A       0     3603     3603:memstress      0xaaaac17c3e88         0       180       175       70         2  [.] 0x0000000000003e88  memstress         memstress[3e88]   0{ 2 100.0%    n/a}

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 135 ++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 8b7c1fd35380..f7a961e55a92 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -118,6 +118,7 @@ enum {
 	DISPLAY_LCL_HITM,
 	DISPLAY_RMT_HITM,
 	DISPLAY_TOT_HITM,
+	DISPLAY_SNP_PEER,
 	DISPLAY_MAX,
 };
 
@@ -125,6 +126,7 @@ static const char *display_str[DISPLAY_MAX] = {
 	[DISPLAY_LCL_HITM] = "Local HITMs",
 	[DISPLAY_RMT_HITM] = "Remote HITMs",
 	[DISPLAY_TOT_HITM] = "Total HITMs",
+	[DISPLAY_SNP_PEER] = "Peer Snoop",
 };
 
 static const struct option c2c_options[] = {
@@ -822,6 +824,11 @@ static double percent_costly_snoop(struct c2c_hist_entry *c2c_he)
 	case DISPLAY_TOT_HITM:
 		st  = stats->tot_hitm;
 		tot = total->tot_hitm;
+		break;
+	case DISPLAY_SNP_PEER:
+		st  = stats->tot_peer;
+		tot = total->tot_peer;
+		break;
 	default:
 		break;
 	}
@@ -1229,6 +1236,10 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 				ret = display_metrics(hpp, stats->tot_hitm,
 						      c2c_he->stats.tot_hitm);
 				break;
+			case DISPLAY_SNP_PEER:
+				ret = display_metrics(hpp, stats->tot_peer,
+						      c2c_he->stats.tot_peer);
+				break;
 			default:
 				break;
 			}
@@ -1609,6 +1620,7 @@ static struct c2c_header percent_costly_snoop_header[] = {
 	[DISPLAY_LCL_HITM] = HEADER_BOTH("Lcl", "Hitm"),
 	[DISPLAY_RMT_HITM] = HEADER_BOTH("Rmt", "Hitm"),
 	[DISPLAY_TOT_HITM] = HEADER_BOTH("Tot", "Hitm"),
+	[DISPLAY_SNP_PEER] = HEADER_BOTH("Peer", "Snoop"),
 };
 
 static struct c2c_dimension dim_percent_costly_snoop = {
@@ -2107,6 +2119,10 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 		he->filtered = filter_display(c2c_he->stats.tot_hitm,
 					      stats->tot_hitm);
 		break;
+	case DISPLAY_SNP_PEER:
+		he->filtered = filter_display(c2c_he->stats.tot_peer,
+					      stats->tot_peer);
+		break;
 	default:
 		break;
 	}
@@ -2135,6 +2151,8 @@ static inline bool is_valid_hist_entry(struct hist_entry *he)
 	case DISPLAY_TOT_HITM:
 		has_record = !!c2c_he->stats.tot_hitm;
 		break;
+	case DISPLAY_SNP_PEER:
+		has_record = !!c2c_he->stats.tot_peer;
 	default:
 		break;
 	}
@@ -2224,7 +2242,10 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 }
 
 static struct c2c_header header_node_0 = HEADER_LOW("Node");
-static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_hitms_stores =
+		HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_1_peers_stores =
+		HEADER_LOW("Node{cpus %peers %stores}");
 static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
 
 static void setup_nodes_header(void)
@@ -2234,7 +2255,10 @@ static void setup_nodes_header(void)
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
@@ -2308,13 +2332,14 @@ static int setup_nodes(struct perf_session *session)
 }
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
+#define HAS_PEER(__h) ((__h)->stats.lcl_peer || (__h)->stats.rmt_peer)
 
 static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-	if (HAS_HITMS(c2c_he)) {
+	if (HAS_HITMS(c2c_he) || HAS_PEER(c2c_he)) {
 		c2c.shared_clines++;
 		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
 	}
@@ -2447,13 +2472,22 @@ static void print_pareto(FILE *out)
 	int ret;
 	const char *cl_output;
 
-	cl_output = "cl_num,"
-		    "cl_rmt_hitm,"
-		    "cl_lcl_hitm,"
-		    "cl_stores_l1hit,"
-		    "cl_stores_l1miss,"
-		    "cl_stores_na,"
-		    "dcacheline";
+	if (c2c.display != DISPLAY_SNP_PEER)
+		cl_output = "cl_num,"
+			    "cl_rmt_hitm,"
+			    "cl_lcl_hitm,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "cl_stores_na,"
+			    "dcacheline";
+	else
+		cl_output = "cl_num,"
+			    "cl_rmt_peer,"
+			    "cl_lcl_peer,"
+			    "cl_stores_l1hit,"
+			    "cl_stores_l1miss,"
+			    "cl_stores_na,"
+			    "dcacheline";
 
 	perf_hpp_list__init(&hpp_list);
 	ret = hpp_list__parse(&hpp_list, cl_output, NULL);
@@ -2852,6 +2886,8 @@ static int setup_display(const char *str)
 		c2c.display = DISPLAY_RMT_HITM;
 	else if (!strcmp(display, "lcl"))
 		c2c.display = DISPLAY_LCL_HITM;
+	else if (!strcmp(display, "peer"))
+		c2c.display = DISPLAY_SNP_PEER;
 	else {
 		pr_err("failed: unknown display type: %s\n", str);
 		return -1;
@@ -2898,10 +2934,12 @@ static int build_cl_output(char *cl_sort, bool no_source)
 	}
 
 	if (asprintf(&c2c.cl_output,
-		"%s%s%s%s%s%s%s%s%s%s",
+		"%s%s%s%s%s%s%s%s%s%s%s%s",
 		c2c.use_stdio ? "cl_num_empty," : "",
-		"percent_rmt_hitm,"
-		"percent_lcl_hitm,"
+		c2c.display == DISPLAY_SNP_PEER ? "percent_rmt_peer,"
+						  "percent_lcl_peer," :
+						  "percent_rmt_hitm,"
+						  "percent_lcl_hitm,",
 		"percent_stores_l1hit,"
 		"percent_stores_l1miss,"
 		"percent_stores_na,"
@@ -2909,8 +2947,10 @@ static int build_cl_output(char *cl_sort, bool no_source)
 		add_pid   ? "pid," : "",
 		add_tid   ? "tid," : "",
 		add_iaddr ? "iaddr," : "",
-		"mean_rmt,"
-		"mean_lcl,"
+		c2c.display == DISPLAY_SNP_PEER ? "mean_rmt_peer,"
+						  "mean_lcl_peer," :
+						  "mean_rmt,"
+						  "mean_lcl,",
 		"mean_load,"
 		"tot_recs,"
 		"cpucnt,",
@@ -2931,6 +2971,7 @@ static int build_cl_output(char *cl_sort, bool no_source)
 static int setup_coalesce(const char *coalesce, bool no_source)
 {
 	const char *c = coalesce ?: coalesce_default;
+	const char *sort_str = NULL;
 
 	if (asprintf(&c2c.cl_sort, "offset,%s", c) < 0)
 		return -ENOMEM;
@@ -2938,12 +2979,16 @@ static int setup_coalesce(const char *coalesce, bool no_source)
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
+		sort_str = "tot_peer";
+
+	if (asprintf(&c2c.cl_resort, "offset,%s", sort_str) < 0)
 		return -ENOMEM;
 
 	pr_debug("coalesce sort   fields: %s\n", c2c.cl_sort);
@@ -2989,7 +3034,7 @@ static int perf_c2c__report(int argc, const char **argv)
 			     "print_type,threshold[,print_limit],order,sort_key[,branch],value",
 			     callchain_help, &parse_callchain_opt,
 			     callchain_default_opt),
-	OPT_STRING('d', "display", &display, "Switch HITM output type", "lcl,rmt"),
+	OPT_STRING('d', "display", &display, "Switch HITM output type", "tot,lcl,rmt,peer"),
 	OPT_STRING('c', "coalesce", &coalesce, "coalesce fields",
 		   "coalesce fields: pid,tid,iaddr,dso"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
@@ -3084,20 +3129,36 @@ static int perf_c2c__report(int argc, const char **argv)
 		goto out_mem2node;
 	}
 
-	output_str = "cl_idx,"
-		     "dcacheline,"
-		     "dcacheline_node,"
-		     "dcacheline_count,"
-		     "percent_costly_snoop,"
-		     "tot_hitm,lcl_hitm,rmt_hitm,"
-		     "tot_recs,"
-		     "tot_loads,"
-		     "tot_stores,"
-		     "stores_l1hit,stores_l1miss,stores_na,"
-		     "ld_fbhit,ld_l1hit,ld_l2hit,"
-		     "ld_lclhit,lcl_hitm,"
-		     "ld_rmthit,rmt_hitm,"
-		     "dram_lcl,dram_rmt";
+	if (c2c.display != DISPLAY_SNP_PEER)
+		output_str = "cl_idx,"
+			     "dcacheline,"
+			     "dcacheline_node,"
+			     "dcacheline_count,"
+			     "percent_costly_snoop,"
+			     "tot_hitm,lcl_hitm,rmt_hitm,"
+			     "tot_recs,"
+			     "tot_loads,"
+			     "tot_stores,"
+			     "stores_l1hit,stores_l1miss,stores_na,"
+			     "ld_fbhit,ld_l1hit,ld_l2hit,"
+			     "ld_lclhit,lcl_hitm,"
+			     "ld_rmthit,rmt_hitm,"
+			     "dram_lcl,dram_rmt";
+	else
+		output_str = "cl_idx,"
+			     "dcacheline,"
+			     "dcacheline_node,"
+			     "dcacheline_count,"
+			     "percent_costly_snoop,"
+			     "tot_peer,lcl_peer,rmt_peer,"
+			     "tot_recs,"
+			     "tot_loads,"
+			     "tot_stores,"
+			     "stores_l1hit,stores_l1miss,stores_na,"
+			     "ld_fbhit,ld_l1hit,ld_l2hit,"
+			     "ld_lclhit,lcl_hitm,"
+			     "ld_rmthit,rmt_hitm,"
+			     "dram_lcl,dram_rmt";
 
 	if (c2c.display == DISPLAY_TOT_HITM)
 		sort_str = "tot_hitm";
@@ -3105,6 +3166,8 @@ static int perf_c2c__report(int argc, const char **argv)
 		sort_str = "rmt_hitm";
 	else if (c2c.display == DISPLAY_LCL_HITM)
 		sort_str = "lcl_hitm";
+	else if (c2c.display == DISPLAY_SNP_PEER)
+		sort_str = "tot_peer";
 
 	c2c_hists__reinit(&c2c.hists, output_str, sort_str);
 
-- 
2.25.1

