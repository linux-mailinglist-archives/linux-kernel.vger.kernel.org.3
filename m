Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584D54BFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiFODFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345884AbiFODE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:04:59 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7FE4B43C;
        Tue, 14 Jun 2022 20:04:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d13so9265006plh.13;
        Tue, 14 Jun 2022 20:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD0NmwuUrX47DPRLrWv40Es+J6Tt15gUljsar+e50t4=;
        b=PxLg80jhvr5wUnjqqPw86c44vOy2aVxVBaEiyWvukUQy2RV4fVhEMl8D8uLi72apSs
         DieyptDB3Y3yv091ajk9ih0UWiY3qpPEHO0D21YGdtvd2tqTa6RKoCBEY5BqQWH5aURl
         FIpvCPU1BFLmkXQjP8MrbgMyEdsShdIhY0mjTxk5zXr8nteFly69J8xjFeKdcd1MFxyv
         3x5ewreMYiUDOCMILJIogLIk02UFjQp4Z8gT1yrYrDmXj8NyH19oE987CHNThdxQJMn5
         g4WtP1id3bYiBhAgyCSzFDLR1dDBU22uARVCPkpz0m+fdz3K9Ul/sggIsBmpz33aCIQ9
         8ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QD0NmwuUrX47DPRLrWv40Es+J6Tt15gUljsar+e50t4=;
        b=mFSmsDfQJEiSBwixXPjstkRraO2DpuzUMwwekcRT7A3aQNM5kjIzqjWMmYISKQqqC/
         B58Z7abs604GU6UgASQ5e5Sf5hGMvlxSqTvAlrFcK06aQyGPFCI7B4+L45ZwKQfNuGBT
         j2t4E3rRmwpQTOdZGKi8oZz41nNb34GiDgbYxD9jzs42tvBoDZ0nMGD4YFkz7APTUlxx
         C9MslWn3IEwrRDig4u5iJhciv4AM+Jqt9t/fdMxyqtRe0WdzJLo2vZNb11vZEGRY5PmV
         c9bjdRtcKRp7DhTroJdMewDJPkH3DtfJpbZv0Wl7jckENfiDlk5+1f3niAOItP2M+dS+
         7oqw==
X-Gm-Message-State: AJIora9chnnE04/5Z6qUsQgeg73gQrfRs7TdcJWxtD9BJjstceDtYzMQ
        7A2+pf/Nt9GH8O7GymDfPPQ=
X-Google-Smtp-Source: ABdhPJxP5PXz9iZOeCBb/215ZreFbAIf7RAywMg8VRicsryS6jSQPwBiAcigPwBxWEyTX/97+ZWXVA==
X-Received: by 2002:a17:902:e54b:b0:166:50b6:a0a0 with SMTP id n11-20020a170902e54b00b0016650b6a0a0mr7337820plf.30.1655262298099;
        Tue, 14 Jun 2022 20:04:58 -0700 (PDT)
Received: from rpi400.lan (c-73-70-190-118.hsd1.ca.comcast.net. [73.70.190.118])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902f7cc00b0015e8d4eb28csm7933132plw.214.2022.06.14.20.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 20:04:51 -0700 (PDT)
From:   Ian Rogers <rogers.email@gmail.com>
X-Google-Original-From: Ian Rogers <irogers@google.com>
Received: by rpi400.lan (Postfix, from userid 1001)
        id AFC862FC697; Tue, 14 Jun 2022 20:04:48 -0700 (PDT)
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
Subject: [PATCH v4 0/4] Rewrite jevents program in python
Date:   Tue, 14 Jun 2022 20:04:34 -0700
Message-Id: <20220615030438.51477-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 tools/perf/pmu-events/jevents.py         |  394 +++++++
 tools/perf/pmu-events/jsmn.h             |   68 --
 tools/perf/pmu-events/json.c             |  162 ---
 tools/perf/pmu-events/json.h             |   39 -
 9 files changed, 450 insertions(+), 1634 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.34.1

