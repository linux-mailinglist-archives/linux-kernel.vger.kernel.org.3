Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0308E59EA77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233399AbiHWSDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiHWSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:01:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12250DCFE8;
        Tue, 23 Aug 2022 09:07:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 876A21424;
        Tue, 23 Aug 2022 09:07:16 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.14.228])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B00BE3F718;
        Tue, 23 Aug 2022 09:07:10 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     suzuki.poulose@arm.com, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, german.gomez@arm.com,
        James Clark <james.clark@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: [PATCH v3 2/2] coresight: etm4x: docs: Add documentation for 'ts_source' sysfs interface
Date:   Tue, 23 Aug 2022 17:06:50 +0100
Message-Id: <20220823160650.455823-3-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20220823160650.455823-1-james.clark@arm.com>
References: <20220823160650.455823-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: German Gomez <german.gomez@arm.com>

Sync sysfs documentation pages to include the new ts_source (timestamp
source) interface.

Signed-off-by: German Gomez <german.gomez@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  8 ++++++++
 .../trace/coresight/coresight-etm4x-reference.rst  | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 8e53a32f8150..08b1964f27d3 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -516,3 +516,11 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(Read) Returns the number of special conditional P1 right-hand keys
 		that the trace unit can use (0x194).  The value is taken
 		directly from the HW.
+
+What:		/sys/bus/coresight/devices/etm<N>/ts_source
+Date:		October 2022
+KernelVersion:	6.1
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org> or Suzuki K Poulose <suzuki.poulose@arm.com>
+Description:	(Read) When FEAT_TRF is implemented, value of TRFCR_ELx.TS used for
+		trace session. Otherwise -1 indicates an unknown time source. Check
+		trcidr0.tssize to see if a global timestamp is available.
diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index fb7578fd9372..70e34b8c81c1 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -71,6 +71,20 @@
 
 ----
 
+:File:            ``ts_source`` (ro)
+:Trace Registers: None.
+:Notes:
+    When FEAT_TRF is implemented, value of TRFCR_ELx.TS used for trace session. Otherwise -1
+    indicates an unknown time source. Check trcidr0.tssize to see if a global timestamp is
+    available.
+
+:Example:
+    ``$> cat ts_source``
+
+    ``$> 1``
+
+----
+
 :File:            ``addr_idx`` (rw)
 :Trace Registers: None.
 :Notes:
-- 
2.28.0

