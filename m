Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4594D3A83
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbiCITod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237984AbiCITob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:44:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F5BE1216A9;
        Wed,  9 Mar 2022 11:43:32 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E26E11692;
        Wed,  9 Mar 2022 11:43:31 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 694133FA27;
        Wed,  9 Mar 2022 11:43:30 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org
Cc:     James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] perf tools: Use Python devtools for version autodetection rather than runtime
Date:   Wed,  9 Mar 2022 19:43:13 +0000
Message-Id: <20220309194313.3350126-2-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220309194313.3350126-1-james.clark@arm.com>
References: <20220309194313.3350126-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the issue where the build will fail if only the Python2
runtime is installed but the Python3 devtools are installed. Currently
the workaround is 'make PYTHON=python3'.

Fix it by autodetecting Python based on whether python[x]-config exists
rather than just python[x] because both are needed for the build. Then
-config is stripped to find the Python runtime.

Testing
=======

 * Auto detect links with Python3 when the v3 devtools are installed
   and only Python 2 runtime is installed
 * Auto detect links with Python2 when both devtools are installed
 * Sensible warning is printed if no Python devtools are installed
 * 'make PYTHON=x' still automatically sets PYTHON_CONFIG=x-config
 * 'make PYTHON=x' fails if x-config doesn't exist
 * 'make PYTHON=python3' overrides Python2 devtools
 * 'make PYTHON=python2' overrides Python3 devtools
 * 'make PYTHON_CONFIG=x-config' works
 * 'make PYTHON=x PYTHON_CONFIG=x' works
 * 'make PYTHON=missing' reports an error
 * 'make PYTHON_CONFIG=missing' reports an error

Fixes: 79373082fa9d ("perf python: Autodetect python3 binary")
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.config | 39 ++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 96ad944ca6a8..b3fbb746e7f0 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -239,18 +239,33 @@ ifdef PARSER_DEBUG
 endif
 
 # Try different combinations to accommodate systems that only have
-# python[2][-config] in weird combinations but always preferring
-# python2 and python2-config as per pep-0394. If python2 or python
-# aren't found, then python3 is used.
-PYTHON_AUTO := python
-PYTHON_AUTO := $(if $(call get-executable,python3),python3,$(PYTHON_AUTO))
-PYTHON_AUTO := $(if $(call get-executable,python),python,$(PYTHON_AUTO))
-PYTHON_AUTO := $(if $(call get-executable,python2),python2,$(PYTHON_AUTO))
-override PYTHON := $(call get-executable-or-default,PYTHON,$(PYTHON_AUTO))
-PYTHON_AUTO_CONFIG := \
-  $(if $(call get-executable,$(PYTHON)-config),$(PYTHON)-config,python-config)
-override PYTHON_CONFIG := \
-  $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO_CONFIG))
+# python[2][3]-config in weird combinations in the following order of
+# priority from lowest to highest:
+#   * python3-config
+#   * python-config
+#   * python2-config as per pep-0394.
+#   * $(PYTHON)-config (If PYTHON is user supplied but PYTHON_CONFIG isn't)
+#
+PYTHON_AUTO := python-config
+PYTHON_AUTO := $(if $(call get-executable,python3-config),python3-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python-config),python-config,$(PYTHON_AUTO))
+PYTHON_AUTO := $(if $(call get-executable,python2-config),python2-config,$(PYTHON_AUTO))
+
+# If PYTHON is defined but PYTHON_CONFIG isn't, then take $(PYTHON)-config as if it was the user
+# supplied value for PYTHON_CONFIG. Because it's "user supplied", error out if it doesn't exist.
+ifdef PYTHON
+  ifndef PYTHON_CONFIG
+    PYTHON_CONFIG_AUTO := $(call get-executable,$(PYTHON)-config)
+    PYTHON_CONFIG := $(if $(PYTHON_CONFIG_AUTO),$(PYTHON_CONFIG_AUTO),\
+                          $(call $(error $(PYTHON)-config not found)))
+  endif
+endif
+
+# Select either auto detected python and python-config or use user supplied values if they are
+# defined. get-executable-or-default fails with an error if the first argument is supplied but
+# doesn't exist.
+override PYTHON_CONFIG := $(call get-executable-or-default,PYTHON_CONFIG,$(PYTHON_AUTO))
+override PYTHON := $(call get-executable-or-default,PYTHON,$(subst -config,,$(PYTHON_AUTO)))
 
 grep-libs  = $(filter -l%,$(1))
 strip-libs  = $(filter-out -l%,$(1))
-- 
2.28.0

