Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4C448D4D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 10:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbiAMJLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 04:11:34 -0500
Received: from foss.arm.com ([217.140.110.172]:41500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233887AbiAMJLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 04:11:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62C26113E;
        Thu, 13 Jan 2022 01:11:25 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.35.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD13D3F766;
        Thu, 13 Jan 2022 01:11:22 -0800 (PST)
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
Subject: [PATCH v2 6/6] Documentation: coresight: Expand branch broadcast documentation
Date:   Thu, 13 Jan 2022 09:10:55 +0000
Message-Id: <20220113091056.1297982-7-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220113091056.1297982-1-james.clark@arm.com>
References: <20220113091056.1297982-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a way of enabling branch broadcast via perf, mention
the possible use cases and known limitations.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../trace/coresight/coresight-etm4x-reference.rst      | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index 0439b4006227..ec336575919c 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -656,7 +656,15 @@ Bit assignments shown below:-
     ETM_MODE_BB
 
 **description:**
-    Set to enable branch broadcast if supported in hardware [IDR0].
+    Set to enable branch broadcast if supported in hardware [IDR0]. The primary use for this feature
+    is when code is patched dynamically at run time and the full program flow may not be able to be
+    reconstructed using only conditional branches.
+
+    Choosing this option will result in a significant increase in the amount of trace generated -
+    possible danger of overflows, or fewer instructions covered. Note, that this option also
+    overrides any setting of :ref:`ETM_MODE_RETURNSTACK <coresight-return-stack>`, so where a branch
+    broadcast range overlaps a return stack range, return stacks will not be available for that
+    range.
 
 .. _coresight-cycle-accurate:
 
-- 
2.28.0

