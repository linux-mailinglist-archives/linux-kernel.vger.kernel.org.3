Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76606560905
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiF2SZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiF2SZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:25:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC12654D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:25:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d132-20020a251d8a000000b0066c8dfb35f4so10888610ybd.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=61y9ZbhNM9aUa2DE015x/wXVvTB/o4yjLiEf1BV500Q=;
        b=baBCA/KhIRIKWbiWArtjOZMGeBZ9usu3nyVsCsSEi2tBwChryTPc6wxkxEBbf7sFdA
         tLTycH/nJxV3GMcVs/3gbn8tXTxSjk+UysCDnEBMCoqjWv9zdj9A/ZHB4IlvQsk1hp93
         ZJaQvDLRU1hClGiTWCZ+JZCt3USJLdkVLI/UgkJDTdePct5USqWQUASkCjZKFIygeNwR
         z2T+MnN9QSCbbNk+spFX3YrxZrdy+X6nBjtf/iyLIMuj4FG1NTQVWORNKtduaKmzwoD7
         Vy+atG6nUAeQ4pw+rX1VJ2nvDX2tBEjv3nQSKedp0TV5blNZ/b57zLpXZfEEdGRmQ2Bs
         UK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=61y9ZbhNM9aUa2DE015x/wXVvTB/o4yjLiEf1BV500Q=;
        b=jKCtoKjdZR4RQlyCh2JxL+yPHGzPynWQCsvQn7N2+EQGzUJg45jduPQTWN1bCzZO+e
         zTeyJErwnMPYzMb/0dI4WgZlESb86KA2B8wTFakS6YeW1rI4AfMEGh9jaXGGQ5r2M/A5
         pYw8RaVxQOKrdIxhkEBxgolu9UNLB80tzUKI5SY3BavAoW2VQV/vrRy8i835mB2M/rkN
         9VW7F6+mnTw08BIvhL2FsPzEimeZM4Ide7SyOK7o/lfDQLwpCrF4NMYJu2XFPtq9Sk3X
         /Jgwk3efROmAUY/4zMefwxV8mNnQAPmZ9RtKQCPIzbKD2blVIEWmS6ibOaYgmPrQZsVD
         5bxg==
X-Gm-Message-State: AJIora98vubMPGZQcBU3DYeGW5GJ/O8sS2uYX8WfU+Jw21IlMKFrl5gE
        2ytbxzOn5AuUr4ZGknq4woPwc9G29qzT
X-Google-Smtp-Source: AGRyM1sMndKMm44rfmDv3hwTaujKL2Kn2c493wD28xDQB+xXXXO4cmtQBUgqGchDWkmDzV9wBzZsuryjd6pr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a25:50c7:0:b0:66c:95d2:c7e5 with SMTP id
 e190-20020a2550c7000000b0066c95d2c7e5mr4976142ybb.156.1656527140474; Wed, 29
 Jun 2022 11:25:40 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:25:02 -0700
In-Reply-To: <20220629182505.406269-1-irogers@google.com>
Message-Id: <20220629182505.406269-2-irogers@google.com>
Mime-Version: 1.0
References: <20220629182505.406269-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v7 1/4] perf python: Prefer python3
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
        Ian Rogers <rogers.email@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>
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

From: Ian Rogers <rogers.email@gmail.com>

The PYTHON_AUTO code orders the preference for the PYTHON command to
be python3, python and then python2. python3 makes a more logical
preference as python2 is no longer supported:
https://www.python.org/doc/sunset-python-2/

Reorder the priority of the PYTHON command to be python2, python and
then python3.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: John Garry <john.garry@huawei.com>
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
2.37.0.rc0.161.g10f37bed90-goog

