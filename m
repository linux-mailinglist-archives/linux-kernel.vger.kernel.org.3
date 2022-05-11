Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4110A52360F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbiEKOql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245016AbiEKOqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:46:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A27E5FE6;
        Wed, 11 May 2022 07:46:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7E4223A;
        Wed, 11 May 2022 07:46:16 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.2.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3D0103F66F;
        Wed, 11 May 2022 07:46:15 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, mike.leach@linaro.org
Cc:     leo.yan@linaro.com, James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] Documentation: coresight: Expand branch broadcast documentation
Date:   Wed, 11 May 2022 15:46:01 +0100
Message-Id: <20220511144601.2257870-5-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220511144601.2257870-1-james.clark@arm.com>
References: <20220511144601.2257870-1-james.clark@arm.com>
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

Now that there is a way of enabling branch broadcast via perf, mention
the possible use cases and known limitations.

Signed-off-by: James Clark <james.clark@arm.com>
---
 .../trace/coresight/coresight-etm4x-reference.rst   | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index 0439b4006227..fb7578fd9372 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -656,7 +656,18 @@ Bit assignments shown below:-
     ETM_MODE_BB
 
 **description:**
-    Set to enable branch broadcast if supported in hardware [IDR0].
+    Set to enable branch broadcast if supported in hardware [IDR0]. The primary use for this feature
+    is when code is patched dynamically at run time and the full program flow may not be able to be
+    reconstructed using only conditional branches.
+
+    There is currently no support in Perf for supplying modified binaries to the decoder, so this
+    feature is only inteded to be used for debugging purposes or with a 3rd party tool.
+
+    Choosing this option will result in a significant increase in the amount of trace generated -
+    possible danger of overflows, or fewer instructions covered. Note, that this option also
+    overrides any setting of :ref:`ETM_MODE_RETURNSTACK <coresight-return-stack>`, so where a branch
+    broadcast range overlaps a return stack range, return stacks will not be available for that
+    range.
 
 .. _coresight-cycle-accurate:
 
-- 
2.28.0

