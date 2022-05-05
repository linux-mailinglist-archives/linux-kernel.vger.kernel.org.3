Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE051B737
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242883AbiEEEme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiEEEm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:42:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269213D1FB
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:38:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f16f3a7c34so29267267b3.17
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=wBm1JmwECRLkttHm3yQPoOND9agzdTmi7HWgk8fL1rE=;
        b=Em3pXDRHyuKOT67qBeS4z4yl19hn72MZcOgf9wy0MLxs74n98uBwlzVuAhWIJqpHA+
         InVXOUH07Mv4SqfG3J4ozlVHGyz8oRZXKwMVb+29iVhw1fPJPuTYxVjk/f53GRznf+p9
         fMgzQy8/wl4jeT0zEyJO7VGmE795tW/xhLBgbdnz4192vO97lcX1YY0GpQubXe89s7Nc
         o0Y+Cs60mAu3fvQVzLI0BmKqZZ/jISv/IOSuOCtgxyzQj9rRQ8VubVC1mN4YBogGG3B9
         keFgW75jPOOmCoaYKAslqN1G0vhuRAvZYKbvy6O04B8JkqJFmAWKhKgWYBQcEok350TK
         0t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=wBm1JmwECRLkttHm3yQPoOND9agzdTmi7HWgk8fL1rE=;
        b=xaralz4F8LH2VWJw87T2B7BUKI4iZJgIahMXapntjUOMgWPw/XipbwFN/9yHHcR1OD
         N5Ervlw3CQj5vOaUdmJZ/tZ4+AE/EdOOA9Hc8M3UBmhxlRsyOptcINnMAXXIONzQJaXO
         E1VKFZQReUDrOrzahNT89dQShd9L1SrQ9z2NMBjm/XtoxhWiYRHyql3iiMoITN2tja9U
         jRDP18ZI2+rUphHhhXH/xcK5waVJPl9WkuxyOMjukUzBXgUG3KOtk7CEjCjBgVacWMN/
         nSXePHh9lZ6YMX7iZXlYHOpfHueBjIbsXsNlzzhOoGCyslGe9ns2THRZ7wTG06gwPp1z
         j2mA==
X-Gm-Message-State: AOAM532/oM60/HVVentxlo+JwgGnsUoRncygDX0cliPr8WS8ztZB+SFX
        US1+I1uEJu8fFFFSG47AgZmD1umf32f8
X-Google-Smtp-Source: ABdhPJxf6XOHnQuHDJ4fc5+oz6nK1iFGZ5sAbYXKY3snVXvCezpYJNPAXtJLEAMSTh9vAcdZHikZEw9C6C7x
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:385b:60bc:5434:2897])
 (user=irogers job=sendgmr) by 2002:a81:dc4:0:b0:2f7:d7a0:a491 with SMTP id
 187-20020a810dc4000000b002f7d7a0a491mr21203452ywn.466.1651725529998; Wed, 04
 May 2022 21:38:49 -0700 (PDT)
Date:   Wed,  4 May 2022 21:38:45 -0700
Message-Id: <20220505043846.3165303-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 1/2] perf evlist: Keep topdown counters in weak group
From:   Ian Rogers <irogers@google.com>
To:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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
index ac2899a25b7a..40b171de2086 100644
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
+		 !strncasecmp(evsel->name, "topdown", 7));
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
index d38722560e80..b7c0c9775673 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3082,3 +3082,13 @@ int evsel__source_count(const struct evsel *evsel)
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
index 45d674812239..0ed2850b7ebb 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -488,6 +488,9 @@ bool evsel__has_leader(struct evsel *evsel, struct evse=
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
2.36.0.464.gb9c8b46e94-goog

