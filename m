Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC252360E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245038AbiEKOqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245001AbiEKOqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B20841C4;
        Wed, 11 May 2022 07:46:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82BDE106F;
        Wed, 11 May 2022 07:46:14 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.2.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CBA573F66F;
        Wed, 11 May 2022 07:46:12 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     leo.yan@linaro.com, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] Documentation: coresight: Link config options to existing documentation
Date:   Wed, 11 May 2022 15:46:00 +0100
Message-Id: <20220511144601.2257870-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220511144601.2257870-1-james.clark@arm.com>
References: <20220511144601.2257870-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to document the newly added branch_broadcast option, create a
table that links all of the config option formats to any existing docs.
That way when the branch broadcast docs are expanded they are accessible
from both places.

Signed-off-by: James Clark <james.clark@arm.com>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
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

