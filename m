Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E94E333A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiCUWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiCUWzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:55:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F16E37C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:33:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h16-20020a056902009000b00628a70584b2so13057692ybs.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SpMsyAVY3Ou4ayr2UUYCx6xfElQ9mcgAD2W4Le+nlxs=;
        b=bxKFolBykFNwtGqa9A5Zv5QZ9Ai6Ja84JYVRKGk+yEJYFUgtKde7nioaqACjn8FG2G
         tmv5I6Pm13yFLyrQhOoEW3XVEtflPeAjcShYbuWGFHRmh0cfao9cXbvNHclX4vYI5twx
         JNzzvLk10AayW8KECkv/Nq2PgPL4870qnyxtnlxhOAGeW8oZhgXJHZK4g982LoK11iHx
         X4ag52xx5xMBjQhkfIlRF+mmtK0/NJLrfi5/I1YLTtw0utBqzqj4m4vE2By+1YjcfGsu
         wHOf7xkEHJHLEWXwGc1QwKTloyWocN5HuVM5SHn45E5vg/BRoO1BO1nwXnB0XdtGf2Bk
         tSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SpMsyAVY3Ou4ayr2UUYCx6xfElQ9mcgAD2W4Le+nlxs=;
        b=WI/M7OGDfKzJi9eAXDljnWAog+h5olfF4Y59+Cj8cvj4rWpBh3D/nAINt2FY2uTaZ4
         V84vdR5cJyTDj8f9T4rfDHQFp0iu7ef9SOSAFtIB8jn60SXWzaAlxyrfeTx7XbxYb9Y3
         XZadE1Laebdf8ZMXII7WbguNjrzo3Z371TwgNJeiRvOsPlIcgU/2gZ/5/pk0tSLtu7ck
         gIWRsz5M6PinOUeCn5KueJrXQrHCiHBqaEmH/ac7TYIkceBsTxjY55KvzQmU0C8hU4n6
         uBpvDiVp6x2RcFtqhV60pHFiLuepePeoNuG0yCEcaWI9FIce3I1U8OZ7XkZ7noVwUr3V
         eeTg==
X-Gm-Message-State: AOAM530qBuqy/Xzdopyq7eYZlmmwWrDdRXrOWZRfq7+Ah5eGu7svZGt6
        6qi12VrUJ085ludQ84k4l+uHdyoCFYFC
X-Google-Smtp-Source: ABdhPJwNEOs7GijFSfW6DVg3FBLi7BK61nctdq2vDBs8q3qZjbfN2iuMK2ufFC13SQ9m3MWAcUhaH2beDQqF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1626:404f:eb8e:caae])
 (user=irogers job=sendgmr) by 2002:a81:1e95:0:b0:2e5:ad0d:b7fc with SMTP id
 e143-20020a811e95000000b002e5ad0db7fcmr26767986ywe.328.1647902028157; Mon, 21
 Mar 2022 15:33:48 -0700 (PDT)
Date:   Mon, 21 Mar 2022 15:33:44 -0700
Message-Id: <20220321223344.1034479-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH] perf parse-events: Move slots only with topdown
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
        Ian Rogers <irogers@google.com>
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

If slots isn't with a topdown event then moving it is unnecessary. For
example {instructions, slots} is re-ordered:

$ perf stat -e '{instructions,slots}' -a sleep 1

 Performance counter stats for 'system wide':

       936,600,825      slots
       144,440,968      instructions

       1.006061423 seconds time elapsed

Which can break tools expecting the command line order to match the
printed order. It is necessary to move the slots event first when it
appears with topdown events. Add extra checking so that the slots event
is only moved in the case of there being a topdown event like:

$ perf stat -e '{instructions,slots,topdown-fe-bound}' -a sleep 1

 Performance counter stats for 'system wide':

        2427568570      slots
         300927614      instructions
         551021649      topdown-fe-bound

       1.001771803 seconds time elapsed

Fixes: 94dbfd6781a0 ("perf parse-events: Architecture specific leader override")
Reported-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index 8d9b55959256..cfc208d71f00 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -20,17 +20,27 @@ int arch_evlist__add_default_attrs(struct evlist *evlist)
 
 struct evsel *arch_evlist__leader(struct list_head *list)
 {
-	struct evsel *evsel, *first;
+	struct evsel *evsel, *first, *slots = NULL;
+	bool has_topdown = false;
 
 	first = list_first_entry(list, struct evsel, core.node);
 
 	if (!pmu_have_event("cpu", "slots"))
 		return first;
 
+	/* If there is a slots event and a topdown event then the slots event comes first. */
 	__evlist__for_each_entry(list, evsel) {
-		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") &&
-			evsel->name && strcasestr(evsel->name, "slots"))
-			return evsel;
+		if (evsel->pmu_name && !strcmp(evsel->pmu_name, "cpu") && evsel->name) {
+			if (strcasestr(evsel->name, "slots")) {
+				slots = evsel;
+				if (slots == first)
+					return first;
+			}
+			if (!strncasecmp(evsel->name, "topdown", 7))
+				has_topdown = true;
+			if (slots && has_topdown)
+				return slots;
+		}
 	}
 	return first;
 }
-- 
2.35.1.894.gb6a874cedc-goog

