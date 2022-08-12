Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F285913FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbiHLQiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiHLQiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:38:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893F9C20D;
        Fri, 12 Aug 2022 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660322279; x=1691858279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=HvI6boGRdVfrzeJXmAydZnr5c6dZ+E7yhgQL2sf4XGE=;
  b=LuQ2uDIzlGD1IYd0PCvC4xQQ1Q6ZqybeUK9ndR2lP6rwfM7uOsrHQmC4
   bVAF3qTi/G8XdLsf7hyDbjXO5RYkDTIZvT6gRj+9ueXcPjEjrK7lo3Fav
   z12w2Uhhbgt2wIs/ki126YruZrgcwVTAtVqFt57NUrsBVoMkSDOpEcDrP
   wzgCBPAbBs6bYi5sGQcpV5K0XljmKm0E4Rdt2n+EOHWIzdIHaRH3AABuY
   Gp46fgw58QS7LtN+mlUsqIraSIw+Uams6P3xKxERBxx1vVqMdPZs1m9CB
   ltJz3mF0a23+hOW4JeTjTG61wKCZIZLhMVD30qeWr+kcgWEbJjCzWdYKF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="377921568"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="377921568"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:37:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="782012274"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by orsmga005.jf.intel.com with ESMTP; 12 Aug 2022 09:37:56 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH 1/7] x86/topology: Fix multiple packages shown on a single-package system
Date:   Sat, 13 Aug 2022 00:41:38 +0800
Message-Id: <20220812164144.30829-2-rui.zhang@intel.com>
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

CPUID.1F/B does not emumerate Package level explicitly, instead, all the
APICID bits above the enumerated levels are assumed to be package id bits.

Current code gets package id by shifting out all the APICID bits that
Linux supports, rather than shifting out all the APICID bits that CPUID.1F
enumerates. This introduces problems when CPUID.1F enumerates a level that
Linux does not support.

For example, on an AlderLake-N platform, there are 2 Ecore Modules, which
has 4 atom cores in each module, in a single package.
Linux does not support Module level and interprets the Module id bits as
package id and erroneously reports a multi module system as a multi-package
system.

Fix this by using APICID bits above all the CPUID.1F enumerated levels as
package id.

Suggested-and-reviewed-by: Len Brown <len.brown@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 arch/x86/kernel/cpu/topology.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 132a2de44d2f..f7592814e5d5 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -96,6 +96,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	unsigned int ht_mask_width, core_plus_mask_width, die_plus_mask_width;
 	unsigned int core_select_mask, core_level_siblings;
 	unsigned int die_select_mask, die_level_siblings;
+	unsigned int pkg_mask_width;
 	bool die_level_present = false;
 	int leaf;
 
@@ -111,10 +112,10 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	core_level_siblings = smp_num_siblings = LEVEL_MAX_SIBLINGS(ebx);
 	core_plus_mask_width = ht_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 	die_level_siblings = LEVEL_MAX_SIBLINGS(ebx);
-	die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+	pkg_mask_width = die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 
 	sub_index = 1;
-	do {
+	while (true) {
 		cpuid_count(leaf, sub_index, &eax, &ebx, &ecx, &edx);
 
 		/*
@@ -132,8 +133,13 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 			die_plus_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
 		}
 
+		if (LEAFB_SUBTYPE(ecx) != INVALID_TYPE)
+			pkg_mask_width = BITS_SHIFT_NEXT_LEVEL(eax);
+		else
+			break;
+
 		sub_index++;
-	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
+	}
 
 	core_select_mask = (~(-1 << core_plus_mask_width)) >> ht_mask_width;
 	die_select_mask = (~(-1 << die_plus_mask_width)) >>
@@ -148,7 +154,7 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 	}
 
 	c->phys_proc_id = apic->phys_pkg_id(c->initial_apicid,
-				die_plus_mask_width);
+				pkg_mask_width);
 	/*
 	 * Reinit the apicid, now that we have extended initial_apicid.
 	 */
-- 
2.34.1

