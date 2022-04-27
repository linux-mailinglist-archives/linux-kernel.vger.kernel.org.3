Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BC251159A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiD0Kwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiD0Kwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:52:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C681A49409D;
        Wed, 27 Apr 2022 03:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651055048; x=1682591048;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oOBwk0JvX4Hq4ln24agEjKLp6VWg/8zMYq4wKqzU1aE=;
  b=RmfaLN90jWuAtwy5HMxFVCEGzWohdVcZG/REmdHYLKzgLU6HeSNFfrxR
   X/NcSrcVYPX61qEUBMPpCm9JxFWE5ESAZKRQNx/DLLNcT5om96znkFzdI
   XLxCy0wc2IuR83aihkav2FyVE5qbQ/MOZToGzBQhJghDyu4qJ/jCqUp/e
   rE6KVUY2gW5spY3A4xBPiRT8b4XmP1bChY9QfS+q2FtVXGWfsiFmmvJzM
   mB6VsEUOOcyyJO/2Vhj7UsO1NUx9fSpg0V9rACEphrSDmj4FZEPse6KOb
   Wpuq+ZTaxnt0xz4QxugDBNwO56+oGkV2kFUMijkqo1ZRiqe4OIozrilsk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265406485"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265406485"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 03:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="596211348"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2022 03:04:25 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH v2] platform/x86: intel-uncore-freq: Prevent driver loading in guests
Date:   Wed, 27 Apr 2022 03:03:04 -0700
Message-Id: <20220427100304.2562990-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loading this driver in guests results in unchecked MSR access error for
MSR 0x620.

There is no use of reading and modifying package/die scope uncore MSRs
in guests. So check for CPU feature X86_FEATURE_HYPERVISOR to prevent
loading of this driver in guests.

Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and enumeration part")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215870
Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
	Add Fixes tag

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

