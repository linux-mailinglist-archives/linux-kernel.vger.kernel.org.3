Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D9D5A68BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiH3Qt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiH3Qt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:49:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F1C6B7D
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dce8cae71so183002937b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=FIhE9np411d4p3gN9blVTRPdzI3E6ppyXBOT6UPFbR4=;
        b=OB9LHc8+8o4/iZ0pku4OGrdZbF6yK0SRgaoyCd1QczBcJO/t3tAbU3x/u16rFi6MUs
         movMoeOJ+FEdjpK3a7cvjtczSoz0sUB4UOCyo484agRRkmpcnekDO6t/TyXwtT+kcNt7
         RU6rdtTzp4zAk5j2tjFJ5/MMHobhdviXUreRR8aiFbr4V9mpRA+oUy6gajOepvZ28dYp
         J+s5cZ30KE9zhdJtEVpUat8aZaRIbXLqOazxoQA/ZUTCA90ZBGi+tqXUVgb/Z0Z36n9Q
         STSIFswLJqCToWbeoXSPlSKmGrNnWoC3dIj/bd6RkOkd11uwM1gO1uz52IqrpMjhAiq6
         qz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=FIhE9np411d4p3gN9blVTRPdzI3E6ppyXBOT6UPFbR4=;
        b=3t28ZSUGpA+tOwkhrBSqrKiXhtugUrgGY4Sr8cbq4yBWBnMe1HcpbeeZAbKUoXyEJF
         G3r09hqE0qIs/neqiYuwJfq8iBqJ1srdbqvk3Ho7pl7Yc+/xNuZoUI3oKakqDOS1zs90
         AuhxMMzYHL/3aQmoyQBcXDwPnuKrjJ/BSL5JQKA2aSttWL3LzzVP+GQgoX9oERR5+NA6
         KN9cw7eQo/JFoQZY4R3/vBXCxX3RLdsXJXH0aR1dsVMh95QEempcavGUPO/FJmWJOJvu
         D1UjbT9Qy54gezuxfHsa1eZrmKw9qJfRBuiTvqbBC2I2mPMs1qR/RqOIsKFm//UhjXX+
         Vctw==
X-Gm-Message-State: ACgBeo2ooyFogEtiz01lRuK9+jP2XANnLWJiMNzAtKBdrr88HRo7Khe1
        lWRzqeBvYxuB4i+cPidAU15lFveWKh93
X-Google-Smtp-Source: AA6agR60NLTVro4NGYnyxknnlRFNT4NfEDW+vIPr4CfSzsgb8ynaczdPxrSsjF2yG4pOZQ0thLLj35ZsE/Of
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:902c:b0fa:dec9:8767])
 (user=irogers job=sendgmr) by 2002:a25:1f89:0:b0:696:4d6e:62aa with SMTP id
 f131-20020a251f89000000b006964d6e62aamr12438386ybf.373.1661878149113; Tue, 30
 Aug 2022 09:49:09 -0700 (PDT)
Date:   Tue, 30 Aug 2022 09:48:40 -0700
In-Reply-To: <20220830164846.401143-1-irogers@google.com>
Message-Id: <20220830164846.401143-3-irogers@google.com>
Mime-Version: 1.0
References: <20220830164846.401143-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v1 2/8] perf metric: Return early if no CPU PMU table exists
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous behavior is to segfault if there is no CPU PMU table and a
metric is sought. To reproduce compile with NO_JEVENTS=1 then request
a metric, for example, "perf stat -M IPC true".

Fixes: 00facc760903 ("perf jevents: Switch build to use jevents.py")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ad5cacdecd81..18aae040d61d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1655,6 +1655,9 @@ int metricgroup__parse_groups(const struct option *opt,
 	struct evlist *perf_evlist = *(struct evlist **)opt->value;
 	const struct pmu_events_table *table = pmu_events_table__find();
 
+	if (!table)
+		return -EINVAL;
+
 	return parse_groups(perf_evlist, str, metric_no_group,
 			    metric_no_merge, NULL, metric_events, table);
 }
-- 
2.37.2.672.g94769d06f0-goog

