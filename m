Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FD4D91F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiCOBEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344141AbiCOBEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:04:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE4C205FC;
        Mon, 14 Mar 2022 18:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306175; x=1678842175;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=JFNihO4l29+MrWjhjoI4e3nVb3jT6juj+eYhE7RWgIs=;
  b=FhP3eW6L7SlROa5uaNDak/AIru28vxND2TxNZUPiGErUaZrqVCI5jD6X
   X/1zugtKI1HNk8P+9ZA6hXjc5q9Wg5mXClIh08sh92NqLaQq6ScyMU5NR
   B38TDRi8zwYeTzR4Y0Hmd7tdotUWC6d/l/+qQiC7E68/HbfQH77rV1WJX
   uEkACdwZutmxYy+5GIQOMEk0f2lO08P9hSObS+i8t+OE+wovMUyF/9//k
   8fm5ysmu9eH515lwjr0aoIvxke14An6haKtonpclTfJBcUjQh8IIpUGgG
   HOSzKsMgf81RUg2biGI2lGekAlkabI3osBssdmgkYC1dmF2sPJDJiQU5n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912383"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912383"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669396"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:53 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 10/10] x86/sgx: Call ENCLS[EUPDATESVN] during SGX initialization
Date:   Tue, 15 Mar 2022 09:03:00 +0800
Message-Id: <20220315010300.10199-11-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220315010300.10199-1-cathy.zhang@intel.com>
References: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A snapshot of the processor microcode SVN is taken each boot cycle at
the time when Intel SGX is first used. This results in microcode
updates being loadable at any time, fixing microcode issues. However,
if system boot up through kexec() from error recovery, no hardware
reset happens, any SGX leaf execution during boot up is not assumed
as the first use in such case, and no snapshot of SVN is taken. So,
it's necessary to call ENCLS[EUPDATESVN] to update SVN automatically,
rather than waiting for the admin to do it when he/she is even not
aware of that.

Call ENCLS[EUPDATESVN] after sanitizing pages will increase the chance
of success, for it requires that EPC is empty.

Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>

---
Changes since v1:
 - Update accordingly for update_cpusvn_intel() return *void*.
---
 arch/x86/kernel/cpu/sgx/main.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
index d86745d8cc7d..5c1fe860540c 100644
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -397,8 +397,10 @@ void sgx_direct_reclaim(void)
 		sgx_reclaim_pages();
 }
 
+void update_cpusvn_intel(void);
 static int ksgxd(void *p)
 {
+	int ret;
 	int srcu_idx;
 
 	set_freezable();
@@ -411,7 +413,14 @@ static int ksgxd(void *p)
 	__sgx_sanitize_pages(&sgx_dirty_page_list);
 
 	/* sanity check: */
-	WARN_ON(!list_empty(&sgx_dirty_page_list));
+	if (!WARN_ON(!list_empty(&sgx_dirty_page_list))) {
+		/*
+		 * Do SVN update for kexec(). It should complete without error, for
+		 * all EPC pages are unused at this point.
+		 */
+		if (cpuid_eax(SGX_CPUID) & SGX_CPUID_EUPDATESVN)
+			update_cpusvn_intel();
+	}
 
 	while (!kthread_should_stop()) {
 		if (try_to_freeze())
-- 
2.17.1

