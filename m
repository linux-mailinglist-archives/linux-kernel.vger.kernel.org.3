Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FD537A12
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbiE3Llk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235912AbiE3LlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:41:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE438813FE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso1875534pjf.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JrXAt/7y4IjdEwppejNHx3DEKqS4BuTyzSkWmghpXw=;
        b=lLt96XydFqnWfbHbv9KeyAjoe9Lh/rSzdLf8JaaQr385uQpufB8Aod0hEGHc+ylmqR
         REvh0VU31b+jCWSg+gKpRH84CchGxPI09Z1Yh17O9Nsx5+JtVF/MEZdGEt7WABHPXrp9
         QCI6HaioP31rvuR1cCrC055lrhbA7uqCPD3e2kOyXqwfN8wPadYvogOEGIpbhiTCLntA
         4iA7v39VzZWptX7DPmdVqQ7787iEnIeGidXIFHBQ8XgGKlRjeMJlHpXD77eYcVkK3Toh
         HYdu2PtJzmN9HbGsVCK7w/ovfQTSGqjhmbsKO9Gv7c8+3CF2d3exX73r8Baqxb/fskSW
         beyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JrXAt/7y4IjdEwppejNHx3DEKqS4BuTyzSkWmghpXw=;
        b=1xaswIfVuYo4Ov3aJE+VTIxK3hXQ74tOrkJYyv1gqZGdNcTknvBzteZM1Tkp2zXFRW
         x8SgJjf9Ji+AM+ll1p4n8SraTDO52H5RfIiQQ/4I8kqV0msrRObPKRHnI0dUiaUhS0cS
         BzrP9AzduqiLksyzzFtrgQfSmNXroZDUAlkObnzqceisZvi/40w6X0LbtkHlcXLV4LgZ
         z3r8q80tBayRXSqOjd1uwKn1nmfbRUXu2XUw1O7dh9A2sOaexEl0BVrCXGe6Vaon6zsI
         L7zZBeJRuK3WbSqRdlmwKeyXbR0l3lHZeiqFihu1BQ8CCfMF7oEMQFgDigknjXrk5JDp
         4k/A==
X-Gm-Message-State: AOAM533hud28KhNzxw+hzd+NuPluLeLwlwleK1tMUGiSFJwAxng4n7Ca
        Dc5vaxZf23M6OKce7KjV8zhTNw==
X-Google-Smtp-Source: ABdhPJxMTp9pZOnkFkLR8QB0BluHGLLkJcug50W9O2qSuPLwOqLq1e5dX7Ym1kbx/IIFOfqLz7vOjw==
X-Received: by 2002:a17:902:e80a:b0:163:c2a4:4c9a with SMTP id u10-20020a170902e80a00b00163c2a44c9amr8825992plg.161.1653910879172;
        Mon, 30 May 2022 04:41:19 -0700 (PDT)
Received: from leo-build-box.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902724700b00161a9df4de8sm8846194pll.145.2022.05.30.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 04:41:18 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Alyssa Ross <hi@alyssa.is>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Joe Mario <jmario@redhat.com>,
        Adam Li <adam.li@amperecomputing.com>,
        German Gomez <german.gomez@arm.com>,
        James Clark <james.clark@arm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 04/12] perf c2c: Add dimensions of peer metrics for cache line view
Date:   Mon, 30 May 2022 19:40:28 +0800
Message-Id: <20220530114036.3225544-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220530114036.3225544-1-leo.yan@linaro.org>
References: <20220530114036.3225544-1-leo.yan@linaro.org>
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

This patch adds dimensions of peer ops, which will be used for Shared
cache line distribution pareto.

It adds the percentage dimensions for local and remote peer operations,
and the dimensions for accounting operation numbers which is used for
stdio mode.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2d7991d372a6..85768c526f9d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -902,6 +902,8 @@ static double percent_ ## __f(struct c2c_hist_entry *c2c_he)			\
 
 PERCENT_FN(rmt_hitm)
 PERCENT_FN(lcl_hitm)
+PERCENT_FN(rmt_peer)
+PERCENT_FN(lcl_peer)
 PERCENT_FN(st_l1hit)
 PERCENT_FN(st_l1miss)
 PERCENT_FN(st_na)
@@ -968,6 +970,68 @@ percent_lcl_hitm_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
 	return per_left - per_right;
 }
 
+static int
+percent_lcl_peer_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, lcl_peer);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_lcl_peer_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_lcl_peer);
+}
+
+static int64_t
+percent_lcl_peer_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, lcl_peer);
+	per_right = PERCENT(right, lcl_peer);
+
+	return per_left - per_right;
+}
+
+static int
+percent_rmt_peer_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	int width = c2c_width(fmt, hpp, he->hists);
+	double per = PERCENT(he, rmt_peer);
+	char buf[10];
+
+	return scnprintf(hpp->buf, hpp->size, "%*s", width, PERC_STR(buf, per));
+}
+
+static int
+percent_rmt_peer_color(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
+		       struct hist_entry *he)
+{
+	return percent_color(fmt, hpp, he, percent_rmt_peer);
+}
+
+static int64_t
+percent_rmt_peer_cmp(struct perf_hpp_fmt *fmt __maybe_unused,
+		     struct hist_entry *left, struct hist_entry *right)
+{
+	double per_left;
+	double per_right;
+
+	per_left  = PERCENT(left, rmt_peer);
+	per_right = PERCENT(right, rmt_peer);
+
+	return per_left - per_right;
+}
+
 static int
 percent_stores_l1hit_entry(struct perf_hpp_fmt *fmt, struct perf_hpp *hpp,
 			   struct hist_entry *he)
@@ -1403,6 +1467,22 @@ static struct c2c_dimension dim_cl_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_cl_rmt_peer = {
+	.header		= HEADER_SPAN("----- Peer -----", "Rmt", 1),
+	.name		= "cl_rmt_peer",
+	.cmp		= rmt_peer_cmp,
+	.entry		= rmt_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_cl_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Lcl"),
+	.name		= "cl_lcl_peer",
+	.cmp		= lcl_peer_cmp,
+	.entry		= lcl_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_tot_stores = {
 	.header		= HEADER_BOTH("Total", "Stores"),
 	.name		= "tot_stores",
@@ -1547,6 +1627,24 @@ static struct c2c_dimension dim_percent_lcl_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_percent_rmt_peer = {
+	.header		= HEADER_SPAN("-- Peer Snoop --", "Rmt", 1),
+	.name		= "percent_rmt_peer",
+	.cmp		= percent_rmt_peer_cmp,
+	.entry		= percent_rmt_peer_entry,
+	.color		= percent_rmt_peer_color,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_percent_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Lcl"),
+	.name		= "percent_lcl_peer",
+	.cmp		= percent_lcl_peer_cmp,
+	.entry		= percent_lcl_peer_entry,
+	.color		= percent_lcl_peer_color,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_percent_stores_l1hit = {
 	.header		= HEADER_SPAN("------- Store Refs ------", "L1 Hit", 2),
 	.name		= "percent_stores_l1hit",
@@ -1704,6 +1802,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_rmt_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
+	&dim_cl_lcl_peer,
+	&dim_cl_rmt_peer,
 	&dim_tot_stores,
 	&dim_stores_l1hit,
 	&dim_stores_l1miss,
@@ -1721,6 +1821,8 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_percent_hitm,
 	&dim_percent_rmt_hitm,
 	&dim_percent_lcl_hitm,
+	&dim_percent_rmt_peer,
+	&dim_percent_lcl_peer,
 	&dim_percent_stores_l1hit,
 	&dim_percent_stores_l1miss,
 	&dim_percent_stores_na,
-- 
2.25.1

