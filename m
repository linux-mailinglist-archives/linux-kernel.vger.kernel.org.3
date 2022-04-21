Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FB250A849
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391494AbiDUSpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391466AbiDUSpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:45:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9EF4BFE2;
        Thu, 21 Apr 2022 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650566530; x=1682102530;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+IQDrRPGugZW8RUWPewakie2NlU9QDgn7R5/ljfg3dI=;
  b=IHNFiVlbgyvTb3em1ZM5Qt9d1sQ6Nj/MjyTelzKVj6Shv6my9qo5HJps
   lQBKRw4Mjd+DwWfHLX27TWTWNQ2TqgnPvmTGcYuziHKEJqVrd6opWW0Z1
   uI2SKjobWSkxCgv2DGmaFmVHRdgU4o6m6pmCIdl5XwJGLWwG9eOq905Ra
   Um+QX9qw1b3ydDcwXl2qgHVY7sn/vsok3o9kylHWr+MZSwXFBeS8/jEBp
   DYLdSxIjxOUOmPGdSaWfyUqB06WlrWBJJwj12X6eCK1kbs1HwLg8VEC4f
   48K3SIix+VgNRLgB5d7P4Dq2uRo4p6XTxDttFPnr5KqiNZ0gqmQyYgS6b
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246346435"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="246346435"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="555932861"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga007.jf.intel.com with ESMTP; 21 Apr 2022 11:42:09 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH] platform/x86: intel-uncore-freq: Prevent driver loading in guests
Date:   Thu, 21 Apr 2022 11:41:54 -0700
Message-Id: <20220421184154.747721-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading this driver in guests results in unchecked MSR access error for
MSR 0x620.

There is no use of reading and modifying package/die scoped uncore MSRs
in guests. So check for CPU feature X86_FEATURE_HYPERVISOR to prevent
loading of this driver in guests.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215870
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index c61f804dd44e..8f9c571d7257 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -212,6 +212,9 @@ static int __init intel_uncore_init(void)
 	const struct x86_cpu_id *id;
 	int ret;
 
+	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
+		return -ENODEV;
+
 	id = x86_match_cpu(intel_uncore_cpu_ids);
 	if (!id)
 		return -ENODEV;
-- 
2.31.1

