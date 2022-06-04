Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293C853D57D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 06:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350583AbiFDEab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 00:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350630AbiFDE36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 00:29:58 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9E532FC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:29:57 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gd1so8739178pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 21:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV9mkt3ephXax7MfRdfbDUHOxPn/hdg1p0gu+rxdm78=;
        b=mpC6M22S4cCbV9GmX77b2LQbSdCx/zcpKaW7wiDssAalFX9zJBZoA+9jNH2ItcXZLH
         O8n7I/V4WCDdqeb+mitSx+tcrJJvvp+GDY/BKGJY6jNjw+He4dylN5bIkrGFivQ6AJBI
         urJCfR7+Q4FQ70GKZzpYoCT/znCkOLo4eG0yEFuO+a4mkXf77uvHQv7OB0cCHnK1aIw0
         IcXOTldIqROjpI85dYhELub59uC/H2HW2PifEmPpgAFHKSz1CLtS5oB/8vk7VEWhCz9+
         Bws5Fh3vhujk21hUcsf4BPkGsa9tdjEBjk9yvjUB2Gh2dvcX5Q/OpA5JYEwjds8U8J6t
         9ifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV9mkt3ephXax7MfRdfbDUHOxPn/hdg1p0gu+rxdm78=;
        b=eMj5dB2edH2JCRrAY0mgxTCxnSTw0AP2/tjbL4+Ryoa3nf8cV6QeeB0EqetnRtACWe
         yHYArlgmY1gFC1cr55zn3WKskPg8RfyopCGROUgxNDQWVGaAS5rHRSsLtW37DqXtDdIH
         OznwwOi2oOJrCihDfwAKMyiutRI/Psmw+2cVBEcXrOXEfo+LOLr7/UVVIvxpZaYl6Bp9
         iGTw021I2e06ybKCMc6bRZhkZNqeI59zWsO9w00H3JKORXOJ/fhxZ8yvLmzxpDbNrmXr
         TJd1VqBXDp1B2vA3rPqjnwWUD6gHwVWdeEolxXLvDe2mqZ8fbu/fJTOTvLf/giUk4pJC
         9o7g==
X-Gm-Message-State: AOAM5330VxpYsy0Qg9kxnnNKXIaYdgbe7tO6KVZZn3oHjw7pE4yiGIcL
        tk9BnBzS74RLm3ifjffEp/UPrg==
X-Google-Smtp-Source: ABdhPJz7MX++cHHfvMO8C7OgRtYjYk3Z7+QMbdY6e4mCdy91xbbx0ckbiponNUlRYL7n/3Rd/VZgEg==
X-Received: by 2002:a17:902:e5c4:b0:166:44af:3c35 with SMTP id u4-20020a170902e5c400b0016644af3c35mr10493586plf.101.1654316996607;
        Fri, 03 Jun 2022 21:29:56 -0700 (PDT)
Received: from leo-build-box.lan (ec2-54-67-95-58.us-west-1.compute.amazonaws.com. [54.67.95.58])
        by smtp.gmail.com with ESMTPSA id w24-20020a1709027b9800b00163d4c3ffabsm6152916pll.304.2022.06.03.21.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 21:29:56 -0700 (PDT)
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
Subject: [PATCH v5 13/17] perf c2c: Refactor node header
Date:   Sat,  4 Jun 2022 12:28:16 +0800
Message-Id: <20220604042820.2270916-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220604042820.2270916-1-leo.yan@linaro.org>
References: <20220604042820.2270916-1-leo.yan@linaro.org>
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

The node header array contains 3 items, each item is used for one of
the 3 flavors for node accessing info.  To extend sorting on other
snooping type and not always stick to HITMs, the second header string
"Node{cpus %hitms %stores}" should be adjusted (e.g. it's changed as
"Node{cpus %peer %stores}").

For this reason, this patch changes the node header array to three
flat variables and uses switch-case in function setup_nodes_header(),
thus it is easier for altering the header string.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Ian Rogers <irogers@google.com>
Tested-by: Ali Saidi <alisaidi@amazon.com>
Reviewed-by: Ali Saidi <alisaidi@amazon.com>
---
 tools/perf/builtin-c2c.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 66ff834516a2..49a9b8480b41 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1723,12 +1723,6 @@ static struct c2c_dimension dim_dso = {
 	.se		= &sort_dso,
 };
 
-static struct c2c_header header_node[3] = {
-	HEADER_LOW("Node"),
-	HEADER_LOW("Node{cpus %hitms %stores}"),
-	HEADER_LOW("Node{cpu list}"),
-};
-
 static struct c2c_dimension dim_node = {
 	.name		= "node",
 	.cmp		= empty_cmp,
@@ -2229,9 +2223,27 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 	return 0;
 }
 
+static struct c2c_header header_node_0 = HEADER_LOW("Node");
+static struct c2c_header header_node_1 = HEADER_LOW("Node{cpus %hitms %stores}");
+static struct c2c_header header_node_2 = HEADER_LOW("Node{cpu list}");
+
 static void setup_nodes_header(void)
 {
-	dim_node.header = header_node[c2c.node_info];
+	switch (c2c.node_info) {
+	case 0:
+		dim_node.header = header_node_0;
+		break;
+	case 1:
+		dim_node.header = header_node_1;
+		break;
+	case 2:
+		dim_node.header = header_node_2;
+		break;
+	default:
+		break;
+	}
+
+	return;
 }
 
 static int setup_nodes(struct perf_session *session)
-- 
2.25.1

