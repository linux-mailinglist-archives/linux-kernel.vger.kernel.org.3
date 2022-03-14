Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7904D8BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbiCNShn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239156AbiCNShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:37:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2067A3EA9F;
        Mon, 14 Mar 2022 11:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647282991; x=1678818991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CGGYoQy8Uh6eqetAPU1rnwgpZHWRk+Ntx869mxlvjLI=;
  b=JfZP8rTHlDzhpuJgQdvQUibRjN/99s1lX5vnO+TuESwo/wGHSmsgRzkn
   CeXEfVVM03eH26Qrj/gLm8MJma/1nLkXnadfgwxkVCL7XPZQHM+HrFDnl
   Znlx2TwTIdovHGnYl+diXvLPZkkersCut0GO9X1NYr+fYnG732BZfET/F
   UR3rfZyNPzNIolzvHOHT3elWs1Xe5Bq+pnFT8Cjy8g2k4l10nefxTzpi+
   gHxjvIcxd5YPRGQaRXquymfpxMqDjutw1l81ury8wISDp0f0iegr+4MAD
   bSYiM29cTyXz370a/urfau+c7qc0SdCTWwPsKj4T/wCJJiFPGga7ik5Jk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255844732"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255844732"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 11:36:30 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="512321592"
Received: from zborja-mobl1.amr.corp.intel.com (HELO ray2.sr71.net) ([10.212.239.199])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 11:36:28 -0700
From:   Dave Hansen <dave.hansen@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] [RFC] Documentation/process: Add testing section to tip handbook
Date:   Mon, 14 Mar 2022 11:35:52 -0700
Message-Id: <20220314183552.1446911-1-dave.hansen@linux.intel.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel has a wide variety of debugging options to help catch
and squash bugs.  However, new debugging is added all the time and
the existing options can be hard to find.

Add a list of debugging options which tip maintainers expect to be
used to test contributions.

This should make it easier for contributors to test their code and
find issues before submission.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-tip.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index c74f4a81588b..75f86b0f1cf0 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -437,6 +437,30 @@ in a private repository which allows interested people to easily pull the
 series for testing. The usual way to offer this is a git URL in the cover
 letter of the patch series.
 
+Testing
+^^^^^^^
+
+Code should be tested before submitting to the tip maintainers.  Anything
+other than minor changes should be built, booted and tested with the
+following set of comprehensive (and heavyweight) set of kernel debugging
+options enabled.
+
+	CONFIG_X86_DEBUG_FPU=y
+	CONFIG_LOCK_STAT=y
+	CONFIG_DEBUG_VM=y
+	CONFIG_DEBUG_VM_VMACACHE=y
+	CONFIG_DEBUG_VM_RB=y
+	CONFIG_DEBUG_SLAB=y
+	CONFIG_DEBUG_KMEMLEAK=y
+	CONFIG_DEBUG_PAGEALLOC=y
+	CONFIG_SLUB_DEBUG_ON=y
+	CONFIG_KMEMCHECK=y
+	CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=y
+	CONFIG_GCOV_KERNEL=y
+	CONFIG_LOCKDEP=y
+	CONFIG_PROVE_LOCKING=y
+	CONFIG_SCHEDSTATS=y
+	CONFIG_VMLINUX_VALIDATION=y
 
 Coding style notes
 ------------------
-- 
2.34.0

