Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3D591406
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239406AbiHLQii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHLQiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:15 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0279DFAB;
        Fri, 12 Aug 2022 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322294; x=1691858294;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Rnn+p5zNuCdgUOlK8NEqTpgcBtst3TdKIhIXK5G2ySY=;
  b=Ij0576mHBPEywaTvgy+OoMFVP8n7G0pzFt7U5aVmugZHD1Fvsr/cznDG
   sAPJ8VqdKv9H1qcYsoX74zMjgijoXK6FcGMijYZuNrue7nMeHfX4H4ru9
   AqWbJmqwDHlbnHPDHxMV8mqxo2KMGSum/mDsiMoywABUyYpR4/7o0KPZp
   yIUKlGERN3FBH8gXQOEMEtkitKYZpVkWltt8+Q7RCuop/+JrYvabZXFJT
   du/qizPGiE0X5WUIh72TwVheTTPXBUXh9SKuUjo7qed2XuErE84G65+9+
   80ikc91usZ/5FMf13CdWGjnfNLrCFbynZHItjtpblQVHpMQCckP/qJLyi
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921624"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921624"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012316"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:38:10 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 5/7] Documentation: x86: Update smp_num_siblings/x86_max_cores description
Date:   Sat, 13 Aug 2022 00:41:42 +0800
Message-Id: <20220812164144.30829-6-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812164144.30829-1-rui.zhang@intel.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
2.34.1

