Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D4052456D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350173AbiELGNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350153AbiELGNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:13:15 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0571D91
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:14 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v64-20020a25abc6000000b0064a22f2a1e7so3765773ybi.17
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=wvaSTyts92zHFtGbhyMWnRUCXMwR0gcXi1gpU3AolYI=;
        b=UZqMCHQufjoY6D4eYGfalSxnSZIBI5kmgxpM9whXo+Nb4KwKYuL4m+4wFKFWi42vGE
         jScSbTYlPV2ZxqHHuFZS7mSy93IPyMkAxOl0iHMencHMjO52XgzhHMkoFyY/fwCOfTq+
         yB9OPTxwfifNkpZ0tLZjn90KCCIYwpiPv74TFjCdVPbXqv61f7WDkR3Qfz4gkpW29yGw
         HD9gMhNhM59yydIdkNWQVXhx6O7R3DSJ/snlleGIF4ctoruBG6ksTPLI2HR4DVOSjjUT
         h0hgarJnpG4h/m//DPE0GlaFsm5qmhZxL/dH0RTH5Lv1dPPkfjh3D9JLJyiEjSbiwu4h
         6Niw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=wvaSTyts92zHFtGbhyMWnRUCXMwR0gcXi1gpU3AolYI=;
        b=Ukuj5jWMVTv9XgE7yihaawndYgIiWB/aUZShe2kOl7/XtCiLYP54NkM5HXX0nNa17/
         WPcDrI8o75uYghCAGTskYjuewHfZY475qddxVKt+a5jJx5QoNRGzRWr8rzRFSqwWapPo
         lIUsm0+UHroOxxMaplCDmnEjTLAqUN9YScIWlKdZsoMsYk3YXaUDBXAdz39feq3I87Jf
         PcoIN9B8RZQdfeb5IJRaYQEkD/wchxOHkHtMSns1Cl5Np+75yFq/rs7V0kfZaCFbVE6g
         OhFLGQqmaifFecNEfmIOisE3S2hCenwVhr3kOMj75cOCH629Bhw0sDsVCm7Mn/+n32Wf
         MjMA==
X-Gm-Message-State: AOAM530pd8QEa6wavQDnI01u3oCvoc1Anx9FkeQIpkUCheQF3bSZ/IS0
        WrfFvvjEkMCZQQa/e6He5sKO2m5AzaaO
X-Google-Smtp-Source: ABdhPJxF2PuuIm8e2NuuQmI1ebomlrij4mr2kucV5yjGl3vVay3LbMRb+eH30ecwVedtCfsUCz7SiUbQgRZZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a81:1e86:0:b0:2eb:66b9:3a93 with SMTP id
 e128-20020a811e86000000b002eb66b93a93mr28318920ywe.411.1652335993709; Wed, 11
 May 2022 23:13:13 -0700 (PDT)
Date:   Wed, 11 May 2022 23:13:07 -0700
In-Reply-To: <20220512061308.1152233-1-irogers@google.com>
Message-Id: <20220512061308.1152233-2-irogers@google.com>
Mime-Version: 1.0
References: <20220512061308.1152233-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 1/2] perf evlist: Keep topdown counters in weak group
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Icelake, topdown events must always be grouped with a slots
event as leader. When a metric is parsed a weak group is formed and
retried if perf_event_open fails. The retried events aren't grouped
breaking the slots leader requirement. This change modifies the weak
group "reset" behavior so that topdown events aren't broken from the
group for the retry.

$ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,t=
opdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,c=
ache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,bac=
lears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1

 Performance counter stats for 'system wide':

    47,867,188,483      slots                                              =
           (92.27%)
   <not supported>      topdown-bad-spec
   <not supported>      topdown-be-bound
   <not supported>      topdown-fe-bound
   <not supported>      topdown-retiring
     2,173,346,937      branch-instructions                                =
           (92.27%)
        10,540,253      branch-misses             #    0.48% of all branche=
s          (92.29%)
        96,291,140      bus-cycles                                         =
           (92.29%)
         6,214,202      cache-misses              #   20.120 % of all cache=
 refs      (92.29%)
        30,886,082      cache-references                                   =
           (76.91%)
    11,773,726,641      cpu-cycles                                         =
           (84.62%)
    11,807,585,307      instructions              #    1.00  insn per cycle=
           (92.31%)
                 0      mem-loads                                          =
           (92.32%)
     2,212,928,573      mem-stores                                         =
           (84.69%)
    10,024,403,118      ref-cycles                                         =
           (92.35%)
        16,232,978      baclears.any                                       =
           (92.35%)
        23,832,633      ARITH.DIVIDER_ACTIVE                               =
           (84.59%)

       0.981070734 seconds time elapsed

After:

$ perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound,t=
opdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-misses,c=
ache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,bac=
lears.any,ARITH.DIVIDER_ACTIVE}:W' -a sleep 1

 Performance counter stats for 'system wide':

       31040189283      slots                                              =
           (92.27%)
        8997514811      topdown-bad-spec          #     28.2% bad speculati=
on         (92.27%)
       10997536028      topdown-be-bound          #     34.5% backend bound=
           (92.27%)
        4778060526      topdown-fe-bound          #     15.0% frontend boun=
d          (92.27%)
        7086628768      topdown-retiring          #     22.2% retiring     =
           (92.27%)
        1417611942      branch-instructions                                =
           (92.26%)
           5285529      branch-misses             #    0.37% of all branche=
s          (92.28%)
          62922469      bus-cycles                                         =
           (92.29%)
           1440708      cache-misses              #    8.292 % of all cache=
 refs      (92.30%)
          17374098      cache-references                                   =
           (76.94%)
        8040889520      cpu-cycles                                         =
           (84.63%)
        7709992319      instructions              #    0.96  insn per cycle=
           (92.32%)
                 0      mem-loads                                          =
           (92.32%)
        1515669558      mem-stores                                         =
           (84.68%)
        6542411177      ref-cycles                                         =
           (92.35%)
           4154149      baclears.any                                       =
           (92.35%)
          20556152      ARITH.DIVIDER_ACTIVE                               =
           (84.59%)

       1.010799593 seconds time elapsed

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evsel.c | 12 ++++++++++++
 tools/perf/util/evlist.c         | 16 ++++++++++++++--
 tools/perf/util/evsel.c          | 10 ++++++++++
 tools/perf/util/evsel.h          |  3 +++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/ev=
sel.c
index ac2899a25b7a..00cb4466b4ca 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -3,6 +3,7 @@
 #include <stdlib.h>
 #include "util/evsel.h"
 #include "util/env.h"
+#include "util/pmu.h"
 #include "linux/string.h"
=20
 void arch_evsel__set_sample_weight(struct evsel *evsel)
@@ -29,3 +30,14 @@ void arch_evsel__fixup_new_cycles(struct perf_event_attr=
 *attr)
=20
 	free(env.cpuid);
 }
+
+bool arch_evsel__must_be_in_group(const struct evsel *evsel)
+{
+	if ((evsel->pmu_name && strcmp(evsel->pmu_name, "cpu")) ||
+	    !pmu_have_event("cpu", "slots"))
+		return false;
+
+	return evsel->name &&
+		(!strcasecmp(evsel->name, "slots") ||
+		 strcasestr(evsel->name, "topdown"));
+}
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 52ea004ba01e..dfa65a383502 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1790,8 +1790,17 @@ struct evsel *evlist__reset_weak_group(struct evlist=
 *evsel_list, struct evsel *
 		if (evsel__has_leader(c2, leader)) {
 			if (is_open && close)
 				perf_evsel__close(&c2->core);
-			evsel__set_leader(c2, c2);
-			c2->core.nr_members =3D 0;
+			/*
+			 * We want to close all members of the group and reopen
+			 * them. Some events, like Intel topdown, require being
+			 * in a group and so keep these in the group.
+			 */
+			if (!evsel__must_be_in_group(c2) && c2 !=3D leader) {
+				evsel__set_leader(c2, c2);
+				c2->core.nr_members =3D 0;
+				leader->core.nr_members--;
+			}
+
 			/*
 			 * Set this for all former members of the group
 			 * to indicate they get reopened.
@@ -1799,6 +1808,9 @@ struct evsel *evlist__reset_weak_group(struct evlist =
*evsel_list, struct evsel *
 			c2->reset_group =3D true;
 		}
 	}
+	/* Reset the leader count if all entries were removed. */
+	if (leader->core.nr_members)
+		leader->core.nr_members =3D 0;
 	return leader;
 }
=20
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5fd7924f8eb3..1cf967d689aa 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3103,3 +3103,13 @@ int evsel__source_count(const struct evsel *evsel)
 	}
 	return count;
 }
+
+bool __weak arch_evsel__must_be_in_group(const struct evsel *evsel __maybe=
_unused)
+{
+	return false;
+}
+
+bool evsel__must_be_in_group(const struct evsel *evsel)
+{
+	return arch_evsel__must_be_in_group(evsel);
+}
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d4b04537ce6d..3e41b1712b86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -498,6 +498,9 @@ bool evsel__has_leader(struct evsel *evsel, struct evse=
l *leader);
 bool evsel__is_leader(struct evsel *evsel);
 void evsel__set_leader(struct evsel *evsel, struct evsel *leader);
 int evsel__source_count(const struct evsel *evsel);
+bool evsel__must_be_in_group(const struct evsel *evsel);
+
+bool arch_evsel__must_be_in_group(const struct evsel *evsel);
=20
 /*
  * Macro to swap the bit-field postition and size.
--=20
2.36.0.512.ge40c2bad7a-goog

