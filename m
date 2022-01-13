Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DC348D4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiAMJLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:11:32 -0500
Received: from foss.arm.com ([217.140.110.172]:41474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233879AbiAMJLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:11:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13931106F;
        Thu, 13 Jan 2022 01:11:22 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.35.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8CAA93F766;
        Thu, 13 Jan 2022 01:11:19 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.com,
        mike.leach@linaro.org
Cc:     James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH v2 5/6] Documentation: coresight: Link config options to existing documentation
Date:   Thu, 13 Jan 2022 09:10:54 +0000
Message-Id: <20220113091056.1297982-6-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220113091056.1297982-1-james.clark@arm.com>
References: <20220113091056.1297982-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to document the newly added branch_broadcast option, create a
table that links all of the config option formats to any existing docs.
That way when the branch broadcast docs are expanded they are accessible
from both places.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../coresight/coresight-etm4x-reference.rst   |  4 ++
 Documentation/trace/coresight/coresight.rst   | 39 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index d25dfe86af9b..0439b4006227 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -650,6 +650,7 @@ Bit assignments shown below:-
     parameter is set this value is applied to the currently indexed
     address range.
 
+.. _coresight-branch-broadcast:
 
 **bit (4):**
     ETM_MODE_BB
@@ -657,6 +658,7 @@ Bit assignments shown below:-
 **description:**
     Set to enable branch broadcast if supported in hardware [IDR0].
 
+.. _coresight-cycle-accurate:
 
 **bit (5):**
     ETMv4_MODE_CYCACC
@@ -678,6 +680,7 @@ Bit assignments shown below:-
 **description:**
     Set to enable virtual machine ID tracing if supported [IDR2].
 
+.. _coresight-timestamp:
 
 **bit (11):**
     ETMv4_MODE_TIMESTAMP
@@ -685,6 +688,7 @@ Bit assignments shown below:-
 **description:**
     Set to enable timestamp generation if supported [IDR0].
 
+.. _coresight-return-stack:
 
 **bit (12):**
     ETM_MODE_RETURNSTACK
diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index db66ff45ff4c..803a224dbb0e 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -585,6 +585,45 @@ sort example is from the AutoFDO tutorial (https://gcc.gnu.org/wiki/AutoFDO/Tuto
 	Bubble sorting array of 30000 elements
 	5806 ms
 
+Config option formats
+~~~~~~~~~~~~~~~~~~~~~
+
+The following strings can be provided between // on the perf command line to enable various options.
+They are also listed in the folder /sys/bus/event_source/devices/cs_etm/format/
+
+.. list-table::
+   :header-rows: 1
+
+   * - Option
+     - Description
+   * - branch_broadcast
+     - Session local version of the system wide setting:
+       :ref:`ETM_MODE_BB <coresight-branch-broadcast>`
+   * - contextid
+     - See `Tracing PID`_
+   * - contextid1
+     - See `Tracing PID`_
+   * - contextid2
+     - See `Tracing PID`_
+   * - configid
+     - Selection for a custom configuration. This is an implementation detail and not used directly,
+       see :ref:`trace/coresight/coresight-config:Using Configurations in perf`
+   * - preset
+     - Override for parameters in a custom configuration, see
+       :ref:`trace/coresight/coresight-config:Using Configurations in perf`
+   * - sinkid
+     - Hashed version of the string to select a sink, automatically set when using the @ notation.
+       This is an internal implementation detail and is not used directly, see `Using perf
+       framework`_.
+   * - cycacc
+     - Session local version of the system wide setting: :ref:`ETMv4_MODE_CYCACC
+       <coresight-cycle-accurate>`
+   * - retstack
+     - Session local version of the system wide setting: :ref:`ETM_MODE_RETURNSTACK
+       <coresight-return-stack>`
+   * - timestamp
+     - Session local version of the system wide setting: :ref:`ETMv4_MODE_TIMESTAMP
+       <coresight-timestamp>`
 
 How to use the STM module
 -------------------------
-- 
2.28.0

