Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B55584848
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiG1Wab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbiG1W3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:29:50 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A3C7B1C1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:29:21 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s6-20020a170902a50600b0016d2e77252eso1879418plq.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 15:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=HomNzY0vohqpUh0WW0YjSOj5dnamYzXcJXTx/P5QSJY=;
        b=fugd2W/0FjFmERrZHRJ9Oge/AIsnKYu3XZGvHxf3pm+xuy8aTUBYfcc57eE3YRtOTL
         P+xx5Ox6IBSsqS8rgGVLo61QqxBSTq4SbiiVEJNr2KG5WgbyNKLsAtVlHA/5yS0M/kQG
         KzQrjQM+4EYVQ9XV6Xs2zwjFVax8gm0QrGgAonUw3mFiOoNyByq3iKKyWUTHpRGlSP61
         Uu3NGhTd+d14uzyYxb7mYrrOxlhlT3f+z0UB3yYuDaoPc4daKB4VR2eeMOophaas8Wks
         RDWA0dWyFLyXGltBy0qtbnv1I1KlKP5EzUeGIv5jatpDB+3wGwwiWK75H+0lijxbFZKj
         kiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=HomNzY0vohqpUh0WW0YjSOj5dnamYzXcJXTx/P5QSJY=;
        b=y3VrJC2QQbir5sPyGHsjOFnV460RgbpbYm6fXBNMZvGaSE4I6wYDfzJpClFsBeIOzp
         VjQkUx8qQSlHcdQF4yJ+ZOii7v1CeTUQ9pAqPYW0xX4YNBJ1rOW6Wxw5/750vwXmHes+
         RyYQnF/YBvKALL1ag0HaUDIXyiOoSTCQjHvahBWBlAN+V1gVL9HYJvqOHz4Aw1Xr6RdL
         +eQQipIW3kRHVjtnc6rOhisNcZPMXcmVgwwHeD8oBNnnm8rK0TN6WB/VmHgRFWSN6XBC
         GSX+3DAMDqd2UxMQxe47uT+mWzZc23YVoZ0ncbWOJ58vHTNhO1IiKx7baigwJDEzb48z
         sNPg==
X-Gm-Message-State: ACgBeo1BCWexzBxkE0SW1/+BcAi0uDdhB74Qt6ht32BoIOUwQMwiw3UP
        d6ytc/q5+RkvIrxozm/+sbPtLpN5hFZi
X-Google-Smtp-Source: AA6agR6+1QKKxTjuVaAPBjV66yElg9YxhvqlisXjAfM/4vKw5/WJYArP6PhxtmBbr8Hwlms499G2kXCu/Zzg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fd09:96c3:28af:b08f])
 (user=irogers job=sendgmr) by 2002:a17:902:6bc5:b0:16c:ea31:5934 with SMTP id
 m5-20020a1709026bc500b0016cea315934mr903077plt.172.1659047360858; Thu, 28 Jul
 2022 15:29:20 -0700 (PDT)
Date:   Thu, 28 Jul 2022 15:28:35 -0700
In-Reply-To: <20220728222835.3254224-1-irogers@google.com>
Message-Id: <20220728222835.3254224-17-irogers@google.com>
Mime-Version: 1.0
References: <20220728222835.3254224-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v2 16/16] perf jevents: Fold strings optimization
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a shorter string ends a longer string then the shorter string may
reuse the longer string at an offset. For example, on x86 the event
arith.cycles_div_busy and cycles_div_busy can be folded, even though
they have difference names the strings are identical after 6
characters. cycles_div_busy can reuse the arith.cycles_div_busy string
at an offset of 6.

In pmu-events.c this looks like the following where the 'also:' lists
folded strings:
/* offset=3D177541 */ "arith.cycles_div_busy\000\000pipeline\000Cycles the =
divider is busy\000\000\000event=3D0x14,period=3D2000000,umask=3D0x1\000\00=
0\000\000\000\000\000\000\000" /* also: cycles_div_busy\000\000pipeline\000=
Cycles the divider is busy\000\000\000event=3D0x14,period=3D2000000,umask=
=3D0x1\000\000\000\000\000\000\000\000\000 */

As jevents.py combines multiple strings for an event into a larger
string, the amount of folding is minimal as all parts of the event must
align. Other organizations can benefit more from folding, but lose space
by say recording more offsets.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/jevents.py | 55 ++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 7 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jeven=
ts.py
index f6f0459a261d..e446b8d9a3b2 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -80,7 +80,9 @@ class BigCString:
   are all the other C strings (to avoid memory issues the string
   itself is held as a list of strings). The offsets within the big
   string are recorded and when stored to disk these don't need
-  relocation.
+  relocation. To reduce the size of the string further, identical
+  strings are merged. If a longer string ends-with the same value as a
+  shorter string, these entries are also merged.
   """
   strings: Set[str]
   big_string: Sequence[str]
@@ -96,6 +98,33 @@ class BigCString:
   def compute(self) -> None:
     """Called once all strings are added to compute the string and offsets=
."""
=20
+    folded_strings =3D {}
+    # Determine if two strings can be folded, ie. let 1 string use the
+    # end of another. First reverse all strings and sort them.
+    sorted_reversed_strings =3D sorted([x[::-1] for x in self.strings])
+
+    # Strings 'xyz' and 'yz' will now be [ 'zy', 'zyx' ]. Scan forward
+    # for each string to see if there is a better candidate to fold it
+    # into, in the example rather than using 'yz' we can use'xyz' at
+    # an offset of 1. We record which string can be folded into which
+    # in folded_strings, we don't need to record the offset as it is
+    # trivially computed from the string lengths.
+    for pos,s in enumerate(sorted_reversed_strings):
+      best_pos =3D pos
+      for check_pos in range(pos + 1, len(sorted_reversed_strings)):
+        if sorted_reversed_strings[check_pos].startswith(s):
+          best_pos =3D check_pos
+        else:
+          break
+      if pos !=3D best_pos:
+        folded_strings[s[::-1]] =3D sorted_reversed_strings[best_pos][::-1=
]
+
+    # Compute reverse mappings for debugging.
+    fold_into_strings =3D collections.defaultdict(set)
+    for key, val in folded_strings.items():
+      if key !=3D val:
+        fold_into_strings[val].add(key)
+
     # big_string_offset is the current location within the C string
     # being appended to - comments, etc. don't count. big_string is
     # the string contents represented as a list. Strings are immutable
@@ -104,13 +133,25 @@ class BigCString:
     big_string_offset =3D 0
     self.big_string =3D []
     self.offsets =3D {}
-    # Emit all strings in a sorted manner.
+
+    # Emit all strings that aren't folded in a sorted manner.
     for s in sorted(self.strings):
-      self.offsets[s] =3D big_string_offset
-      self.big_string.append(f'/* offset=3D{big_string_offset} */ "')
-      self.big_string.append(s)
-      self.big_string.append('"\n')
-      big_string_offset +=3D c_len(s)
+      if s not in folded_strings:
+        self.offsets[s] =3D big_string_offset
+        self.big_string.append(f'/* offset=3D{big_string_offset} */ "')
+        self.big_string.append(s)
+        self.big_string.append('"')
+        if s in fold_into_strings:
+          self.big_string.append(' /* also: ' + ', '.join(fold_into_string=
s[s]) + ' */')
+        self.big_string.append('\n')
+        big_string_offset +=3D c_len(s)
+        continue
+
+    # Compute the offsets of the folded strings.
+    for s in folded_strings.keys():
+      assert s not in self.offsets
+      folded_s =3D folded_strings[s]
+      self.offsets[s] =3D self.offsets[folded_s] + c_len(folded_s) - c_len=
(s)
=20
 _bcs =3D BigCString()
=20
--=20
2.37.1.455.g008518b4e5-goog

