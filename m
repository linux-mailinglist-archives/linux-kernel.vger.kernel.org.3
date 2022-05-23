Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229E25317E7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbiEWSMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242218AbiEWRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:37:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4823150;
        Mon, 23 May 2022 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653327070; x=1684863070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yEKxJVGCY27SHm5dP9lIMOmKkOGFlFMyVfaXYrGEgOA=;
  b=RKG5vLCn4NHSN0ULoje8CgbeSIYdoL1KJoT0CBSMYytoRuxF0YmwR+H6
   D1bVmLCifpdthshBIGNMT2ohbycx+63KftIKeBdDeJ8pWcsb2kli88Ogc
   JV90jFUf2cYNhTxBq1LBq/BQOYj3e9K3mhExiGNtzphmkRdmubewzLtQ/
   5UdiilF60BqYdryKmob08gamuGFkxsx8/Km1NtJ1ibSa6gLWuoacUUwWf
   BWcPeZ2Z95xG6edF4JgctdxfGM1ZpyjbKASUjmOpZGTpyWarbYVFe52lt
   yfYpjrr/BYfY1OH13Llew0OMr5z2FiR3HAVocaEjX24ltLnE4mXr59rxG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273290493"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="273290493"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 10:28:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="577510072"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2022 10:28:23 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, corbet@lwn.net, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Documentation: admin-guide: pm: Add Out of Band mode
Date:   Mon, 23 May 2022 10:27:57 -0700
Message-Id: <20220523172757.2351052-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for using the tool to support performance level
change via OOB (Out of Band) interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../admin-guide/pm/intel-speed-select.rst     | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
index 0a1fbdb54bfe..4146a2da35ea 100644
--- a/Documentation/admin-guide/pm/intel-speed-select.rst
+++ b/Documentation/admin-guide/pm/intel-speed-select.rst
@@ -262,6 +262,25 @@ Which shows that the base frequency now increased from 2600 MHz at performance
 level 0 to 2800 MHz at performance level 4. As a result, any workload, which can
 use fewer CPUs, can see a boost of 200 MHz compared to performance level 0.
 
+Changing performance level via BMC Interface
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is possible to change SST-PP level using out of band (OOB) agent (Via some
+remote management console, through BMC "Baseboard Management Controller"
+interface). This mode is supported from the Sapphire Rapids processor
+generation. The kernel and tool change to support this mode is added to Linux
+kernel version 5.18. To enable this feature, kernel config
+"CONFIG_INTEL_HFI_THERMAL" is required. The minimum version of the tool
+is "v1.12" to support this feature, which is part of Linux kernel version 5.18.
+
+To support such configuration, this tool can be used as a daemon. Add
+a command line option --oob::
+
+# intel-speed-select --oob
+
+In this mode the tool will online/offline CPUs based on the new performance
+level.
+
 Check presence of other Intel(R) SST features
 ---------------------------------------------
 
-- 
2.35.1

