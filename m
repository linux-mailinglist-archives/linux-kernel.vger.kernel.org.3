Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FBB595C83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiHPM51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 08:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiHPM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 08:57:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA838979E3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 05:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660654589; x=1692190589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dmsjCXBkUH6EeoqDGUhnKaCzPvSWsgnyLBDIcgCWsU=;
  b=TAg/SUxNr8WXB7luDmAqP7atoTWoTzewEFD5JGrNIt5QM0H9JSAla5wM
   TYdDMFWg1hHjEC8fHQ3SBE9uTuq+f1xEf8h3LhMISzUoIlPwnimtodOLA
   cwmfp9pRQf826iA4wfAT+MFwjo7IxW/RSO4LNyn694Ef5lZrNWV47pPV8
   Uxaozlh1jDxXvIAk0RTfafZTrz/HyqXJOtSbNr1LI+hz2ijoauyUOkeOO
   uK8zqj6yf22cL5x23L2lXrQznduxcybXcbgE4Wq13m6gGbRe8STnPDyHw
   TBqmIZQzLaJCTFVAHfqTtu5T0A5CpwGAmkPQqztTk4XVTxy1zdaGMIxc/
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="293004107"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="293004107"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 05:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="557686020"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 16 Aug 2022 05:56:27 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, ak@linux.intel.com, namhyung@kernel.org,
        irogers@google.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 2/2] perf docs: Update the documentation for the save_type filter
Date:   Tue, 16 Aug 2022 05:56:12 -0700
Message-Id: <20220816125612.2042397-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816125612.2042397-1-kan.liang@linux.intel.com>
References: <20220816125612.2042397-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Update the documentation to reflect the kernel changes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 099817ef5150..d5c57ac1ee0a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -397,6 +397,9 @@ following filters are defined:
 	- abort_tx: only when the target is a hardware transaction abort
 	- cond: conditional branches
 	- save_type: save branch type during sampling in case binary is not available later
+		     For the platforms with Intel Arch LBR support (12th-Gen+ client or
+		     4th-Gen Xeon+ server), the save branch type is unconditionally enabled
+		     when the taken branch stack sampling is enabled.
 
 +
 The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
-- 
2.35.1

