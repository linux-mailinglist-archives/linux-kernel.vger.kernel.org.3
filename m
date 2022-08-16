Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AC59544D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiHPH6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiHPH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427ACF47E4;
        Mon, 15 Aug 2022 22:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626790; x=1692162790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=u+ZvcOj9M2zkdP1mQyjcoYw0fYKI0r1gp+/88xhN1yA=;
  b=Srm1zOzumwswv84gJwzNYsGXTvNptIFlqkj+tpZjD2fbTALrwfk6/HVj
   iUWEIMZXDesgcj//0wG2Fq1HDWzE6CeuitPyMtWSHMsZZycBrz5rM09ay
   u/iG/J7CFHV0Rj6t4WrZLdlxS0mXXQOSkZWX4N75dwVxFRAeNlGpqr9gS
   tBjGjaoTUZ5LIFsbO3zT/3vAupUl8FCtJHdl2xtKXqK71c6y3it3/u8F/
   l/rqZivoIJVM6ede+PdvNQMVZro7xz3DxFW2RZm2llOB9WKuU2nqNUfHu
   hL9XiKtKLNYreLDbgfIARFD9gbvZ4cKb9cP4626mx3LZfUpTKpxxPSX0u
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130180"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130180"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:13:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953525"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:13:07 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 7/8] Documentation: x86: Update smp_num_siblings/x86_max_cores description
Date:   Tue, 16 Aug 2022 13:16:32 +0800
Message-Id: <20220816051633.17775-8-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816051633.17775-1-rui.zhang@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smp_num_siblings/cpuinfo_x86.x86_max_cores are retrieved via CPUID EAX
bit_shift value, and they represent the maximum possible number of threads
in a core, and the maximum possible number of cores in a package.

Update the smp_num_siblings/cpuinfo_x86.x86_max_cores description in the
documentation.

Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 Documentation/x86/topology.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/x86/topology.rst b/Documentation/x86/topology.rst
index 7f58010ea86a..c5eb5bc42380 100644
--- a/Documentation/x86/topology.rst
+++ b/Documentation/x86/topology.rst
@@ -49,7 +49,8 @@ AMD nomenclature for package is 'Node'.
 
   - cpuinfo_x86.x86_max_cores:
 
-    The number of cores in a package. This information is retrieved via CPUID.
+    The maximum possible number of cores in a package. This information is
+    retrieved via CPUID.
 
   - cpuinfo_x86.x86_max_dies:
 
@@ -102,10 +103,10 @@ AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
 
   - smp_num_siblings:
 
-    The number of threads in a core. The number of threads in a package can be
-    calculated by::
+    The maximum possible number of threads in a core. The maximum possible
+    number of threads in a package can be calculated by::
 
-	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
+	maximum_threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
 
 
 Threads
-- 
2.25.1

