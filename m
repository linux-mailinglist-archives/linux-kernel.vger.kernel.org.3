Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8402959140E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbiHLQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238771AbiHLQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1EB0291;
        Fri, 12 Aug 2022 09:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322322; x=1691858322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jsbnr8NWVw7uTCz6Xky1YALZ+oPpAzM2h50U5eFhHsw=;
  b=QB3D5zMkyJK0E+2aXtOVgc7GBUbT3un2iaIE2shWIl1u+YuYniqNBhFF
   0+QA7ywxQtKA5YPdGyiSwzyRvBxlLBdAAH6I5Em37KAVAXWf3LUhL110c
   XafcysWH9wCEwnFcPmibwCz98beNZFabY8MtZtdWSeVXkxxfvEsJ3FJ2l
   zyzmHHjVcnj5TdYli6z2nN4nm2yzPwh670SmFHHnFXnVQmpEhd9f6HZDh
   V0pdgAKayJ1oku44bDbucOrhGZGnUQxI3hnFd0d4HGsh5SeXdrFhKQDcU
   nd01ke62csCn7rOcKIy7rdx9z4tyIdDCDi410UujjFEpJAiI8lqRiTuWz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921655"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921655"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:38:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012345"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:38:17 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 7/7] perf/x86/intel/P4: Fix smp_num_siblings usage
Date:   Sat, 13 Aug 2022 00:41:44 +0800
Message-Id: <20220812164144.30829-8-rui.zhang@intel.com>
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

smp_num_siblings can be larger than 2.

Any value larger than 1 suggests HT is supported.

Reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/include/asm/perf_event_p4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/perf_event_p4.h b/arch/x86/include/asm/perf_event_p4.h
index 94de1a05aeba..b14e9a20a7c0 100644
--- a/arch/x86/include/asm/perf_event_p4.h
+++ b/arch/x86/include/asm/perf_event_p4.h
@@ -189,7 +189,7 @@ static inline int p4_ht_active(void)
 static inline int p4_ht_thread(int cpu)
 {
 #ifdef CONFIG_SMP
-	if (smp_num_siblings == 2)
+	if (smp_num_siblings > 1)
 		return cpu != cpumask_first(this_cpu_cpumask_var_ptr(cpu_sibling_map));
 #endif
 	return 0;
-- 
2.34.1

