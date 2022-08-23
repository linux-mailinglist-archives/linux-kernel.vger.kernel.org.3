Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 528F659EDE1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiHWVCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiHWVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:01:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F47E838
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661288511; x=1692824511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wqzz300j2KV+gbb3JSVLKBX28Fwj6Wd6JIiihPMctuc=;
  b=bfCpwovtj7abwoOo1YWoNePm7JmTtYfp1Kc8CV7dSGygOwFFFwT6npf9
   gYFrW9+m7k6I584Sd+J+dJwoVw+oTXo9yNeZUU+Kw3mGgm/16YLqACs2O
   urfkiQaf2W5CqJfIDdk1AthzyM6VDUvGK4KYvupJ/FZI2vbAM86qFo/so
   0w0XYkgcm7g/d78cux2qS8mh/tseQkxLdsuSGOrAy/c318JnpodgjFoNq
   6r6YDPCgBR2pEvlbYM7bLZQRofXiwRvjc/h4xI1eMkO5LB4Y7sd5fCf3J
   bJWUyLXPivt0UFBp05GmEaESm7XxVrY27Te6b8aLLayhDEsFfMwhgX3fl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="357769303"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="357769303"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 14:01:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="698812591"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2022 14:01:49 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/uncore: Add new Raptor Lake S support
Date:   Tue, 23 Aug 2022 14:01:29 -0700
Message-Id: <20220823210129.979394-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823210129.979394-1-kan.liang@linux.intel.com>
References: <20220823210129.979394-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of the uncore PMU, the new Raptor Lake S is the
same as the other {ALDER,RAPTOP}LAKE.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index db6c31bca809..6f1ccc57a692 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1831,6 +1831,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
-- 
2.35.1

