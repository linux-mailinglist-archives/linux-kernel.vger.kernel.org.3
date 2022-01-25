Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B7849BD8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiAYVAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:00:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:39742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbiAYVAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643144409; x=1674680409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=SSGZlYNLi7MfgMezAMjOb0VUK6t6eVKZpen2DopXUd8=;
  b=cseniD4cG1Y+vxN9J/S//WZ0DIcb/kyI3iYZh0pAasT1xQU5B1x+skHd
   zRwZ+xC0FUmIFF9KkqxmZ8695HFaUeMfK+XAIWTWvEIq29fekCJGwh1vo
   9/PRG2XGdk+oB3eTNoGEUYfrIWqT7cFDYJdpO2vTqOtnKtBQsLfctzi9y
   Lc9+7929ad3FiEzQaQ+RAzgFaYEh9rIQ6ycQm6+ZeoVoXbVsh7N8Bg00k
   gomrDdPfCKVYX3f0mkMMneAdXMuk+bvrEP2GiwN/JHIjqfkrwqkE8pzbc
   SD2ijCnbVK/9ClwXyniia5QDnQZD8S7Mp7tYitPNuBEBCsVyZVPdNGlwz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244013726"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="244013726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:00:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520545822"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 13:00:09 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 3/4] perf/x86/msr: Add Raptor Lake CPU support
Date:   Tue, 25 Jan 2022 15:57:50 -0800
Message-Id: <1643155071-98900-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
References: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Raptor Lake is Intel's successor to Alder lake. PPERF and SMI_COUNT MSRs
are also supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 96c775a..6d759f8 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -103,6 +103,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_FAM6_ROCKETLAKE:
 	case INTEL_FAM6_ALDERLAKE:
 	case INTEL_FAM6_ALDERLAKE_L:
+	case INTEL_FAM6_RAPTORLAKE:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
-- 
2.7.4

