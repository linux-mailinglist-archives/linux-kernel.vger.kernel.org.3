Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2A550113
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 02:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiFRAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbiFRAJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 20:09:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23653A71
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:09:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e6-20020a259246000000b00668cc122ca7so1088467ybo.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 17:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=QFsYOhmyOgr6cVDRGDPbLmjTaZjVZrI8k2YnAiU6fW4=;
        b=igOzC5ue4ApqpDZ1/UITk3c/oocfijmjnc7hWCT+lpq95np3iqhzMlHQ7Bh+dLE6NL
         hZOyM0B5VLqtfZfetAvXs8GyrjCq2ylAKHtNCTkNeHeDXsVmET/CJdP7suVxXIEiXRvn
         IsQzlOypPFB0KgRh8w5ekPC5i2IjNUUJxqj2KaBLpoVuEPka+//d2R5vFRZUmThsRwmE
         aKdzJ6kqLHv+p7+4GO2mfc6xtgZKsSxksr/1h0l+ixngrU2Yb7hlZbBjvO8IzmucD/mB
         xk9R7tlp63YmWt7mCzXr5DFPlpaBfaLk1nNkpkOk3hgX+L+QDabGAgMKF3N5aLyGpLyt
         i+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=QFsYOhmyOgr6cVDRGDPbLmjTaZjVZrI8k2YnAiU6fW4=;
        b=WJI82+7kaMmTvw/Ph/V/8+TY+kOk68YgfzgRFpLAEI4jyXizKZCbFBKq6N7Lm6gJns
         bEdXNZvocLN4QNdhQfRa5nDgLUOj+NQQkjJaPHGeDxtK+0vsluEcUfiRB+vjA2zmn0Pe
         qMod6pBW1vFeCc5f70iNvtKcJTPI5ce8oJN+aHQv+gdyYeRT7Ek8FQGOsma16cQ++KGW
         R1NcoNaYQ33bLaxTpf7le5D/Vb2pfO6hbhnHjbJqmOXB3VG7xtbxcW7f6/yeC04QoaBE
         s1CvMc9uewvZJe7Ac1pgI5ZPa2PiQRdDmd7mLoNfisv6vyhrVvBKXcigBpsEJNHaZqjg
         wdxQ==
X-Gm-Message-State: AJIora/WV/vohlXjKDz0HHgupZfxGLYih9GttPm038lopm53R6jfBGB2
        suNlxflZtRdhpnq8fpGdHWZNocXJXHj9
X-Google-Smtp-Source: AGRyM1t9t6dU4V13Ua3Lk7SpisZJrH6t4FMFpTvD9gkcmLJmSb08Up9HBXX7ro2oVNvBU5yrKPUogq1eYXjt
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c89f:8969:c05d:79b6])
 (user=irogers job=sendgmr) by 2002:a25:cb43:0:b0:668:a932:a351 with SMTP id
 b64-20020a25cb43000000b00668a932a351mr10155095ybg.50.1655510962799; Fri, 17
 Jun 2022 17:09:22 -0700 (PDT)
Date:   Fri, 17 Jun 2022 17:09:03 -0700
Message-Id: <20220618000907.433350-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v6 0/4] Rewrite jevents program in python
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
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

New architectures bring new complexity, such as Intel's hybrid
models. jevents provides an alternative to specifying events in the
kernel and exposing them through sysfs, however, it is difficult to
work with. For example, an error in the json input would yield an
error message but no json file or location. It is also a challenge to
update jsmn.c given its forked nature.

The changes here switch from jevents.c to a rewrite in python called
jevents.py. This means there is a build time dependency on python, but
such a dependency already exists for asciidoc (used to generate perf's
man pages). If the build detects that python isn't present or is older
than version 3.6 (released Dec. 2016) then an empty file is
substituted for the generated one.

A challenge with this code is in avoiding regressions. For this reason
the jevents.py produces identical output to jevents.c, validated with a
test script and build target.

v6. Fixes an annotation and use of removesuffix that aren't present in
    Python 3.6. Linter issues are also fixed.The code was tested on
    Python 3.6 and 3.8 with docker.
v5. Adds a 2>/dev/null as suggested by David Laight
    <David.Laight@aculab.com>.
v4. Fixes the build for systems with python2 installed by adding a
    patch that makes python3 the preferred python (Reported-by: John
    Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
    jevents-test.sh and fixes the handling of an empty string for a
    metric BriefDescription as one was added for sapphirerapids in the
    metric Execute.
v3. Updates the patches for merged changes (on
    acme/tmp.perf/core). Re-runs all comparisons to make sure the
    generated pmu-events.c isn't altered at all by this change. Adds
    the jevents.c ExtSel fix in:
    https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
    Bumps the python version from 3.5 to 3.6, as f-strings weren't
    introduced until 3.6.

v2. Fixes the build for architectures that don't have pmu-events json
    (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
    build for python not being present or too old (Suggested-by: Peter
    Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).

Ian Rogers (4):
  perf python: Prefer python3
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.config               |   27 +-
 tools/perf/Makefile.perf                 |   16 +-
 tools/perf/pmu-events/Build              |   15 +-
 tools/perf/pmu-events/empty-pmu-events.c |   21 +
 tools/perf/pmu-events/jevents.c          | 1342 ----------------------
 tools/perf/pmu-events/jevents.py         |  409 +++++++
 tools/perf/pmu-events/jsmn.h             |   68 --
 tools/perf/pmu-events/json.c             |  162 ---
 tools/perf/pmu-events/json.h             |   39 -
 9 files changed, 465 insertions(+), 1634 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.36.1.476.g0c4daa206d-goog

