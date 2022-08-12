Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF0F591403
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbiHLQiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0DBAE9E1;
        Fri, 12 Aug 2022 09:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322283; x=1691858283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xVfLDJHbNxdB43zszcy1iXYlCNPm2m2mul/ubrZges4=;
  b=Z5vJtLNh+f3kPBi62HFtyDLCowWzl252ueTqPLRCKehMUiASRk21oD9q
   nrcx6cQdcnbpGPkoccLlMou+LFVnhFDLxVjP73eJ95Qi8KzqkV8vmCY0a
   6m2ln07Tt2vOIe8Mv3Z/hzaaAAatU5d6JBiIUc+/Utp4Gj0cn0Ir3LcLt
   eBzfZpztdHfZgPEi/rBg6vou5Tl9+Q/kUQkpwj2q0+G7CmNodVPCmuaCy
   m6+Y1/h8AhAkBBaIWGWsJm2CoYHwgbkeX6rdbFVa6ur133sqb7eP8vP8I
   0349E7Sw7kz3wMfV9eig+vvwM4Bo56JauFEMRO6VfoWpGb6Ji6opCyzly
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921582"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921582"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012287"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:37:59 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 2/7] x86/topology: Fix duplicated core_id within a package
Date:   Sat, 13 Aug 2022 00:41:39 +0800
Message-Id: <20220812164144.30829-3-rui.zhang@intel.com>
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

Today, core_id is assumed to be unique within each package.

But an AlderLake-N platform adds a Module level between core and package,
Linux excludes the unknown modules bits from the core_id, resulting in
duplicate core_id's.

To keep core_id unique within a package, Linux must include all APIC-id
bits for known or un-known levels above the core and below the package
in the core_id.

It is important to understand that core_id's have always come directly
from the APIC-id encoding, which comes from the BIOS. Thus there is no
guarantee that they start at 0, or that they are contiguous.
As such, using them for array indexes can be problematic.

Suggested-and-reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index f7592814e5d5..5e868b62a7c4 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -141,7 +141,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 		sub_index++;
 	}
 
-	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
+	core_select_mask = (~(-1 << pkg_mask_width)) >> ht_mask_width;
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
 				core_plus_mask_width;
 
-- 
2.34.1

