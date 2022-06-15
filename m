Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAE54BFF3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbiFODE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiFODEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:04:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618284B42B;
        Tue, 14 Jun 2022 20:04:53 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 3-20020a17090a174300b001e426a02ac5so831351pjm.2;
        Tue, 14 Jun 2022 20:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRRJLF09b5o55+8bgHUG6DnFQ2KPU/1dKTKvWjViuj8=;
        b=q7skwbnXsp6PJAHCfNs6sQ0zffGbireMhEVsGunFMu69eOaTjVGvXbqUpAv51ptlmP
         SY3DmQC/10f+FYr6FZAefExkUSlcVaWWpwgHI40nVmHit9xmtgZQgw1k4wTpXoqEXSWT
         dIqpiow+8dQvLqdDpmXm+a6O4CsHBfFgGhyEVILN9Vza4gUqKNatJaTg08cEse+R7EFj
         x3em7QeX8cdfnA5jLA1mRfqK3KkjuOWOYZljwuk0XXHaJS80GjkIcyqzstMiyJAuxkb6
         rpbDjVjxdJS5dQlgD16whj86wmY4MRtxIih4Vh6f+GaS4zOGTUank0fL2fm/54tBGFIT
         jdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRRJLF09b5o55+8bgHUG6DnFQ2KPU/1dKTKvWjViuj8=;
        b=codJBbEjGQuj0UiVBDSJdkbyhQAVRXiCeHT4phCIKwKhP1Xuiby6+xFVBqAKsAMohR
         SoMjB1TmztDz9cSdYMhgCX+IaVnNqvHuPLcBsnn0oT9JoduKHX0qWecVKwdPMI9rYeGZ
         Yh9btdelWecD+8kEYQAWQ62aZBVSEFfS1u/ctGIcsDTXSdlfHAlAl8zSGu2RsWRW5t/N
         g5FGvl7V1XOwZbq47kS4pb6Hr8RzRRkno/bhjgNMJ7zbfb1gW2qRAqP4XDTN5nym6OYP
         DW6ZbYPttFwAh0Y/0Sov5dCxsODa+aZsbe8qSq4/2s2Ne2lOvv1xWUoQVUyw+1BmJUhn
         ycfA==
X-Gm-Message-State: AJIora/w+jQERyZtnmq8ZSBQco40kLVTCteCi3xafNQ/IPtz+X+cjcyB
        0naFNl6D12E5YPcf2iOt53fAU7n0B13/Pg==
X-Google-Smtp-Source: AGRyM1uvojs6fEmXA1i2Pqm44WS3ctwl2nJOQMJduc22XkO5cUCoUbQmgEAAOTG21oePTLK3RDagAQ==
X-Received: by 2002:a17:90b:188:b0:1e3:1feb:edb2 with SMTP id t8-20020a17090b018800b001e31febedb2mr7829147pjs.195.1655262292752;
        Tue, 14 Jun 2022 20:04:52 -0700 (PDT)
Received: from rpi400.lan (c-73-70-190-118.hsd1.ca.comcast.net. [73.70.190.118])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b001645730e71bsm7996567pln.59.2022.06.14.20.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 20:04:50 -0700 (PDT)
From:   Ian Rogers <rogers.email@gmail.com>
X-Google-Original-From: Ian Rogers <irogers@google.com>
Received: by rpi400.lan (Postfix, from userid 1001)
        id C1FB52FC698; Tue, 14 Jun 2022 20:04:48 -0700 (PDT)
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
Subject: [PATCH v4 1/4] perf python: Prefer python3
Date:   Tue, 14 Jun 2022 20:04:35 -0700
Message-Id: <20220615030438.51477-2-irogers@google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220615030438.51477-1-irogers@google.com>
References: <20220615030438.51477-1-irogers@google.com>
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
2.34.1

