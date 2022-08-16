Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36816595444
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiHPH5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiHPH4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:42 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670E5280E;
        Mon, 15 Aug 2022 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626771; x=1692162771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=FboYUogSe9ihPrbF4l07tSAlrq3YvoBAcJ7puMFHbZ4=;
  b=bAmqzXqcik+rK5YlAyd0LsdTfjCmBZBrkisKsYhvR7xMSztAkkzU77w3
   ryE0LP1RnFhphyzdi6GjP/BcSsMiDn9mAAnOeMgYZEiP/8ydg9DSAJ5P9
   8lQ0ERfOxeB70R0eP50e6rcHJvjKz4Nm7BIbWb4mWDo4kvnyZOWppzx4P
   FIJsiA7m+YYca+oJUlLuVsR8/y9LhsaLvCOCRuXS93jkr1BIWf8UXHpfI
   WalHZ8ecdZZmJF7eQ8m3JzJKf1hP3AK/dyDt6A0TP7tw0Q+cmAaP0eOzm
   0NYy3smc5DEjqUSQSk9xkB/NnM5usuXX+Z8uih13Wq2t1cM+MMpFEzmXK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130129"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130129"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:12:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953450"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:12:48 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 1/8] perf/x86/intel/P4: Fix smp_num_siblings usage
Date:   Tue, 16 Aug 2022 13:16:26 +0800
Message-Id: <20220816051633.17775-2-rui.zhang@intel.com>
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
2.25.1

