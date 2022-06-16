Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D854D976
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 06:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357797AbiFPEsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 00:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350349AbiFPEsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 00:48:22 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DDD1A381
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:48:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m11-20020a25710b000000b0065d4a4abca1so140179ybc.18
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aNvZPcZ6zsNSg6KtWndLDA+9lA/85jhiUeKYeiO2xYM=;
        b=DKTgrtAQmHIxOtJdvwlZ15/gTsavr6bwhVeccAenhBaxHngqGezpOa+Arc8Enjk6tf
         9efTR1Jm15DQvjyfyOvGcbRGH25DVQxXqIWuqbEk5SOipxnHIKdAbafINYIp6Z5OvgGG
         rJrHrCPM0OugTUkTLlxEjtQMBby25NS4Gp/Zv6zRXJmvRE9CWv7oiqAh6XDlC947A2uD
         91zn7qDt3mEoX8q3wDUzdb3sjQIf9TDDSH2SMYdMb72HLzPPl5FzQvSqPNklQRPg5nlm
         pfMMXZI9u7M8UgHI88VAs30pEtY+VRMbE3FUG8IKrd8m0S+GfDOI3OG9wDcoVdohxhDL
         as6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aNvZPcZ6zsNSg6KtWndLDA+9lA/85jhiUeKYeiO2xYM=;
        b=LrgJC7kxXeoyDYTeXPNK97ceVLakAB8JZ8hq5w5sjVRJaTDtD8NnZr9IwTAv4WQtA7
         1ZMB+Bpe1zdxmCAhVnV/b4zKTpjG+1qFWp1u2pA6myTtw363ygqzeL1RX+93swJQvLFa
         p+1/+de3bNR6zX20PsmQXLucCKg0/TPp8Wq5DYcGLYWIV3jZNOK1OLvhJvILV/Imu7Pk
         4qxpeaAlLibs/QHAjMfoh5O5M/Kju1ScIO/KofRX40ByMvdfNPVNbu3AK0+lsxHo56tH
         vrJcyx5XMLZTzsdXJpdMWmANdyyWlIB6dY5UnuK0Kpgr16b7rr69UzGz3G2E/QePQvX/
         egtg==
X-Gm-Message-State: AJIora/7E1/pKs7nda2ICEjpU7BvUxU4rPm6MU47D0iKVmM352teXMzp
        z0zgUK+LTMgPCPVykEqjOoolxUMj40qn
X-Google-Smtp-Source: AGRyM1sG9gJkT/zMUadD9j2INLWefD6MH/d4lDxZ9D4QOqogGaLkM7kTzzSnqre/ayzOIzVWWjd1ignQd/g/
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8a8e:cef:df61:163d])
 (user=irogers job=sendgmr) by 2002:a25:358b:0:b0:668:a642:ccb3 with SMTP id
 c133-20020a25358b000000b00668a642ccb3mr117088yba.563.1655354900567; Wed, 15
 Jun 2022 21:48:20 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:48:03 -0700
In-Reply-To: <20220616044806.47770-1-irogers@google.com>
Message-Id: <20220616044806.47770-2-irogers@google.com>
Mime-Version: 1.0
References: <20220616044806.47770-1-irogers@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v5 1/4] perf python: Prefer python3
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PYTHON_AUTO code orders the preference for the PYTHON command to
be python3, python and then python2. python3 makes a more logical
preference as python2 is no longer supported:
https://www.python.org/doc/sunset-python-2/

Reorder the priority of the PYTHON command to be python2, python and
then python3.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 73e0762092fe..16c1a87444b8 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -241,15 +241,15 @@ endif
 # Try different combinations to accommodate systems that only have
 # python[2][3]-config in weird combinations in the following order of
 # priority from lowest to highest:
-#   * python3-config
-#   * python-config
 #   * python2-config as per pep-0394.
+#   * python-config
+#   * python3-config
 #   * $(PYTHON)-config (If PYTHON is user supplied but PYTHON_CONFIG isn't)
 #
 PYTHON_AUTO := python-config
-PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
-PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
 PYTHON_AUTO := $(if $(call get-executable,python2-config),python2-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
 
 # If PYTHON is defined but PYTHON_CONFIG isn't, then take $(PYTHON)-config as if it was the user
 # supplied value for PYTHON_CONFIG. Because it's "user supplied", error out if it doesn't exist.
-- 
2.36.1.476.g0c4daa206d-goog

