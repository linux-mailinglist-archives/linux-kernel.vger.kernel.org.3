Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CA7584CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 09:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiG2Hpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 03:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiG2Ho6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 03:44:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B9F820FE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:45 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31f4450c963so36270677b3.19
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=vsVx0RXggVgT0Vzeq33Ge2ECpCDo8PPDDZprUlFUzbU=;
        b=d7tM7m3wSx+Nl3LsHF3Qkp1URtOSaRrhcRzOpGhMvuDIzsJ6ORKxe9qw5CIL7pLEi+
         DV986YF3a/OamH6P50M+iW7ja+NNZIQ7c65kuRHpi7trc7GXOzI0a+4GqbPXR20O63Wp
         gM5mSRJsf0xkjfsmmhaW0JsdpFPTMIzAi5arSo5Gqmkw4E6NtXmjicsj89vV5RPOzdCs
         SwnikVqD2c4lL0LQLpfcwfNdvi18dCIFcH/XWMAL9HoYlW1NfWScpIXCpZMC5nROT1Qm
         rbwloGq+SwztiHqkJfpMc3X2e+GdNcLApSmmAU4H7gRB/zrPyPU5j/YUGapUwZWBlTuA
         pmTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=vsVx0RXggVgT0Vzeq33Ge2ECpCDo8PPDDZprUlFUzbU=;
        b=Z61PQPAoObmuBr+IAP3QvOpRFauJF0gq8FybMzQ5v2aJeBhebjIcwgU+M9WsBQZPGG
         2gHNSxYw61tIJ0ewl0JhDDDtmzj2YwL5xn/E9gRmZhbZIJO3WHj/sARL3S/qudmJddqs
         biLq/OZqJriNlfdGbWdFQTgj01bG5xFbNC585+q7GUClEl2GK5pqcVl8IgtNfSQSpZ9Z
         DVMP+d1RZmRnUqf50GVlc2SVzA2LiPm+Y32ld1BEuL1sNGBCpt5T5RHD9QBA+tPLVhop
         ZqmNe1OefM40GgthjQd4p7dkg4d5BWojeBzvy48iOcXYpm8QIBnnki3nTO9K9gd4yS3p
         rgPQ==
X-Gm-Message-State: ACgBeo3EIxGINLMvs0P2cz3U2zYVH/VntoIeiF0YU0/bR6S1q//0fGtM
        5nesVM8INrwoaBPIm1V8+ShvAWzkw4vu
X-Google-Smtp-Source: AA6agR4Gdae2DAr0F8eHUkZlTJOf6KliV4pgoBZPuV2HWpQnhPdzjdAaC/qIhk5RnUThfkaBsRPBs6u1CKjy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:524b:47b4:2aeb:1b49])
 (user=irogers job=sendgmr) by 2002:a5b:585:0:b0:671:2b80:9d42 with SMTP id
 l5-20020a5b0585000000b006712b809d42mr1689021ybp.154.1659080685054; Fri, 29
 Jul 2022 00:44:45 -0700 (PDT)
Date:   Fri, 29 Jul 2022 00:43:51 -0700
In-Reply-To: <20220729074351.138260-1-irogers@google.com>
Message-Id: <20220729074351.138260-18-irogers@google.com>
Mime-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH v3 17/17] perf jevents: Fold strings optimization
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
index a5e162558994..e5545758c92d 100755
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

