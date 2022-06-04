Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AE253D57C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350552AbiFDE3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350531AbiFDE3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7993544DE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so2155674pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKXILwkRVdA3Fa6aqPRmJrL7mZPDO3MwqGuWltaS794=;
        b=ZrMrMwxNoNF0zzyxwZDgysg7jGahVeGE+iX35PIPdmiZHQuLQPSCD2dwYqttdPyhjP
         LS8HOl95nRarD3I1q40CBFOGFpyQF1HnOGJUYfmt9tf0/trGGgXRpdAEbdkHtWZ9dK8c
         4ePr9RZeG8RsaZaRSmLPYIqZEbzlcpQGeC43SCEj1f3Ycl645cfIiWeRjfCUMamtjKtr
         9yzd6SXtxBiihWFKC1q5sVx86zgmxhwWGaFtYbL5Nh5yqJIZ7X2wM/twI0j6k8e0pkF7
         SsKJBoYIMJ3/FzLSBV7Um07NWAe/DaJ2yu96eC+Zf5jNjWNzd9J2mtxetOyjDxmVgaEZ
         GNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKXILwkRVdA3Fa6aqPRmJrL7mZPDO3MwqGuWltaS794=;
        b=sbRbhVPqjGHi45j/g5bs+FvNbvgzNtwvMp2ZvwPF5lqs5rcxv90LYhxC93QVy9Md/N
         fzzReOLYi8GEgDAm8rj04vdkMFypR/vF1sQ+YnXX8aDxbkBh/561uLaAf1qJPto707vu
         RzuyRNV8VxdFv9OLWbJMXQSWojkf07aRVWlJudr6n9ZI4qOav2G26UdvY9BOwZAN4J6V
         jYO0V4x7PQ7IM5EDlq5vSIiZmVtPXeBphmmu3TOYgxSuhydJNmkfF+j2IyLpLF1WqoMS
         /38VTEx/yoQX9FOpiOuoyXUlMFTEOhu5BNR6Jg4020ZsPFoCuTXNc0kjMPlIOifi8gz5
         +1ag==
X-Gm-Message-State: AOAM533zH+4ljNP4g/4KxyY054Ed6FTVCjlUlnksR8NtrWQqW7++tnvP
        gWes0qWDuglj1TqWCJ2IG9bxUQ==
X-Google-Smtp-Source: ABdhPJwrfo/O3rcVKswOwm/BY0TFIFuj5/gOCyu21b7yZFXaclT6zOL9KrFQgfNXmNibPS1S5xKBLQ==
X-Received: by 2002:a17:902:ee8d:b0:164:7dd:6cc6 with SMTP id a13-20020a170902ee8d00b0016407dd6cc6mr13858875pld.84.1654316968262;
        Fri, 03 Jun 2022 21:29:28 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:27 -0700 (PDT)
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
Subject: [PATCH v5 08/17] perf c2c: Add dimensions for peer load operations
Date:   Sat,  4 Jun 2022 12:28:11 +0800
Message-Id: <20220604042820.2270916-9-leo.yan@linaro.org>
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

This patch adds three dimensions for peer load operations of 'lcl_peer',
'rmt_peer' and 'tot_peer'.  These three dimensions will be used in the
shared data cache line table.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 37bebeb6c11b..99c0c7307a4a 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -650,6 +650,9 @@ __f ## _cmp(struct perf_hpp_fmt *fmt __maybe_unused,			\
 
 STAT_FN(rmt_hitm)
 STAT_FN(lcl_hitm)
+STAT_FN(rmt_peer)
+STAT_FN(lcl_peer)
+STAT_FN(tot_peer)
 STAT_FN(store)
 STAT_FN(st_l1hit)
 STAT_FN(st_l1miss)
@@ -1360,6 +1363,30 @@ static struct c2c_dimension dim_rmt_hitm = {
 	.width		= 7,
 };
 
+static struct c2c_dimension dim_tot_peer = {
+	.header		= HEADER_SPAN("------- Load Peer -------", "Total", 2),
+	.name		= "tot_peer",
+	.cmp		= tot_peer_cmp,
+	.entry		= tot_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_lcl_peer = {
+	.header		= HEADER_SPAN_LOW("Local"),
+	.name		= "lcl_peer",
+	.cmp		= lcl_peer_cmp,
+	.entry		= lcl_peer_entry,
+	.width		= 7,
+};
+
+static struct c2c_dimension dim_rmt_peer = {
+	.header		= HEADER_SPAN_LOW("Remote"),
+	.name		= "rmt_peer",
+	.cmp		= rmt_peer_cmp,
+	.entry		= rmt_peer_entry,
+	.width		= 7,
+};
+
 static struct c2c_dimension dim_cl_rmt_hitm = {
 	.header		= HEADER_SPAN("----- HITM -----", "Rmt", 1),
 	.name		= "cl_rmt_hitm",
@@ -1672,6 +1699,9 @@ static struct c2c_dimension *dimensions[] = {
 	&dim_tot_hitm,
 	&dim_lcl_hitm,
 	&dim_rmt_hitm,
+	&dim_tot_peer,
+	&dim_lcl_peer,
+	&dim_rmt_peer,
 	&dim_cl_lcl_hitm,
 	&dim_cl_rmt_hitm,
 	&dim_tot_stores,
-- 
2.25.1

