Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3574DD0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiCQWoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCQWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:44:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F30A55750
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:43:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5db04460cso2628347b3.17
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Quw5pKZWI0gGahzjOjy/Y5sjn3FIERyKvG0tcs0jMps=;
        b=RC4U9MKxbUpik1R32Ww8fll/kQRSlc2R8uVUmQXKT+y9Kms3VodZZpZIlcoE4qN/3s
         vwGwOEQ+wAG4RTNaN++I9Y9ulLYLOI97fUnFnVzAlFhx3FlacUQOnqS/xnDsKR+fXchI
         cVfJvUi8Ln1avhgjpSt+Xrjgp96UuG11Tp/IhwIzIjwqgoIuTFvCYBW31zP5jWb8teHY
         8VOTRjj8Krsr41fqYg2bQPNLd1dFb9exCXZBqjv/xl47wTZgVitYxsHd2Qqdi+wYZfxF
         OhmavQ5dhEVB5eBk+iLf+DlrD44IDCzi2rNoMYRbjLS1hAKm7lmUKnSP7TEcICrRn2HB
         ZrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Quw5pKZWI0gGahzjOjy/Y5sjn3FIERyKvG0tcs0jMps=;
        b=efjmZ4Gv6Ue2c5gBFeSKOIG5t2JlTlLQ2KGgnpZWM8mLA+C44SuOoseUkj5fiu/PPZ
         gJ4GlBr6n/JK4rsZvR2Q29yMCiwlMa8MXHpz4j9VLAsGJ+MtXPrBbZJyrH7PHELahUTL
         ZBlM1z9v37xgdULGx+MzNSKtQVMOJZnNN8UWEyGZ7vfZw4GiXs/RyPUpzy6ATUjEf2F1
         Oj8uZwH5ChiGtyIghZ99+9c3oxA90ywrgRjL1lxuKCAxZ3S219tq7MUxMQvC8Qf68rTX
         IviVepaqKmw+/WnA/zVc230aimam+0bG6QI+xb6BwlL9vu6LPZYTAnHPM+CyUURGttms
         DqeQ==
X-Gm-Message-State: AOAM533AtIGB/P7oL38gOJE4KlTACGQqyvIkvC2RhDXdxBQMYbdDrLj7
        x3y6dCpgPA399Bvh1tYa28lWMFBBDjhn
X-Google-Smtp-Source: ABdhPJxxoHmYNsNLQpHtSnpG/Uy+E0F4Jk4lzTm63hLihwRDkSNrbNkfgc41BZzTlMlkSpgcqUtnj4fvURI0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6811:1685:e3b9:7904])
 (user=irogers job=sendgmr) by 2002:a25:5b57:0:b0:633:6b5c:86ad with SMTP id
 p84-20020a255b57000000b006336b5c86admr7751468ybb.113.1647556993187; Thu, 17
 Mar 2022 15:43:13 -0700 (PDT)
Date:   Thu, 17 Mar 2022 15:43:09 -0700
Message-Id: <20220317224309.543736-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] perf parse-events: Ignore case in topdown.slots check
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Caleb Biggers <caleb.biggers@intel.com>
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

An issue with icelakex metrics:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json?h=perf/core&id=65eab2bc7dab326ee892ec5a4c749470b368b51a#n48
That causes the slots not to be first.

Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
Reported-by: Caleb Biggers <caleb.biggers@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index f924246eff78..8d9b55959256 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -29,7 +29,7 @@ struct evsel *arch_evlist__leader(struct list_head *list)
 
 	__evlist__for_each_entry(list, evsel) {
 		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
-			evsel->name && strstr(evsel->name, "slots"))
+			evsel->name && strcasestr(evsel->name, "slots"))
 			return evsel;
 	}
 	return first;
-- 
2.35.1.894.gb6a874cedc-goog

