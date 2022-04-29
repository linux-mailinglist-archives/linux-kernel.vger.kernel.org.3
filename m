Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18292514965
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359192AbiD2Meq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359295AbiD2Mej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:34:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB0EDC90E7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:31:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DEC91063;
        Fri, 29 Apr 2022 05:31:19 -0700 (PDT)
Received: from e127744.arm.com (unknown [10.57.46.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04ECA3F73B;
        Fri, 29 Apr 2022 05:31:16 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com
Cc:     james.clark@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        German Gomez <german.gomez@arm.com>
Subject: [PATCH 2/2] coresight: etm4x: docs: Add documentation for 'ts_source' sysfs interface
Date:   Fri, 29 Apr 2022 13:31:00 +0100
Message-Id: <20220429123100.268059-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429123100.268059-1-german.gomez@arm.com>
References: <20220429123100.268059-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync sysfs documentation pages to include the new ts_source (timestamp
source) interface.

Signed-off-by: German Gomez <german.gomez@arm.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-etm4x  |  8 ++++++++
 .../trace/coresight/coresight-etm4x-reference.rst  | 14 ++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
index 8e53a32f81505..19ac9d6d2f504 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
@@ -516,3 +516,11 @@ Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(Read) Returns the number of special conditional P1 right-hand keys
 		that the trace unit can use (0x194).  The value is taken
 		directly from the HW.
+
+What:		/sys/bus/coresight/devices/etm<N>/ts_source
+Date:		April 2022
+KernelVersion:	5.18
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(Read) When FEAT_TRF is implemented, value of TRFCR_ELx.TS used for
+		trace session. Otherwise -1 indicates an unknown time source. Check
+		trcidr0.tssize to see if a global timestamp is available.
diff --git a/Documentation/trace/coresight/coresight-etm4x-reference.rst b/Documentation/trace/coresight/coresight-etm4x-reference.rst
index d25dfe86af9bf..f016c7c29429b 100644
--- a/Documentation/trace/coresight/coresight-etm4x-reference.rst
+++ b/Documentation/trace/coresight/coresight-etm4x-reference.rst
@@ -71,6 +71,20 @@ the ‘TRC’ prefix.
 
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
2.25.1

