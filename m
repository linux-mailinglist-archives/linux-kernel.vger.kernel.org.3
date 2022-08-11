Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801158F793
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiHKG0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbiHKGZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:25:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED86D9C3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:39 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 202so9559469pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=f67DxDkxHroZMFoZK6mrn4q4D5M0LO9oUzI+oIec9yQ=;
        b=qK3HT8xhLBHFCpfpcVLl/L8H6NnAg4OC//TLPKwHr7xnBDeGvgZTa89cPs899T8Ubs
         UP9EwbnO0UqAuI2X1JXJ7qE9nPXdghVgw3O7ua3SfIj0f0pVASW8j7xR4XcbMe7b9TZs
         OMtCDDIaBljKwDKpgmqVNaj4E/Bm5lS7Hv90gHk4Cnlthib3KZEA0F0HpOcvdtwLLkoq
         eExUZUVlnyOSptqm1PRdegFSJXUZ6QaaLgtBUTftJbxA9GqO5yElbQ/V97n0VraBhpzD
         XJq+VG2+H52CdHYf4pxoW8Hx36Y0lAU2JnASQhJNg4lUyGKt+xV071tEUc3F5w/2tSKl
         +Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=f67DxDkxHroZMFoZK6mrn4q4D5M0LO9oUzI+oIec9yQ=;
        b=MrBSpGMu9O9wQG/QoXPG8sEI4CTkcpWOqR7E6duq1kasjdQPHag3KMSxfbdPeUrn/w
         ku4r37NeKdhkCGbW66V71l1nqTl30Pb0DxBhIQ13bGchVCX5OM6M5Ld+bEwDN9jZtHbi
         Ncs9+GLjVMVx+TPsM95lx+gFOLa4Fy4t02Ena50kkChyKzsCgUMZwq3It/e1SwfFe9eN
         HQyEnZYd0ZO46ITitqLkxx0+AOD3qscbelslgN8fLbln3KOjHv659ifisNB820v8kK9Q
         3ZBNth8JehlSF0A3+b4tMnPH4c0uvfRstz0xk17bjzM5gJQdsKRmXqtioPcFj/XSMmpj
         W7Vg==
X-Gm-Message-State: ACgBeo3oxuvpgulWsPP9d+zPVN/AXsRy7An4vd6zhtGGg4dq76g56AwH
        7Hp3AqrJ7nCmBUk5Ga7EqKpaLA==
X-Google-Smtp-Source: AA6agR5H8e/YFsEUshvz95pOP1ghFED8hJp8f6oiA4F3LawcEpDj00ACfx61/jM76yBJPIJTfmvz4A==
X-Received: by 2002:a63:6587:0:b0:41b:dacc:1826 with SMTP id z129-20020a636587000000b0041bdacc1826mr25165361pgb.142.1660199138517;
        Wed, 10 Aug 2022 23:25:38 -0700 (PDT)
Received: from leoy-yangtze.lan (n058152077182.netvigator.com. [58.152.77.182])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090a55cc00b001f506009036sm2766926pjm.49.2022.08.10.23.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 23:25:38 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ali Saidi <alisaidi@amazon.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ian Rogers <irogers@google.com>, Like Xu <likexu@tencent.com>,
        German Gomez <german.gomez@arm.com>,
        Timothy Hayes <timothy.hayes@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 06/15] perf c2c: Add dimensions for peer load operations
Date:   Thu, 11 Aug 2022 14:24:42 +0800
Message-Id: <20220811062451.435810-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220811062451.435810-1-leo.yan@linaro.org>
References: <20220811062451.435810-1-leo.yan@linaro.org>
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
2.34.1

