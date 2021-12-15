Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC32476389
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhLOUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:40:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:19624 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236341AbhLOUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:40:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="238070941"
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="238070941"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 12:40:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,209,1635231600"; 
   d="scan'208";a="464414456"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 12:40:34 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] x86/perf: Avoid warning for Arch LBR without XSAVE
Date:   Wed, 15 Dec 2021 12:40:29 -0800
Message-Id: <20211215204029.150686-1-ak@linux.intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hypervisors support Arch LBR, but without the LBR XSAVE support.
The current Arch LBR init code prints a warning when the xsave size (0) is
unexpected. Avoid printing the warning for the "no LBR XSAVE" case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8043213b75a5..1b8fef8545fb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -1726,6 +1726,8 @@ static bool is_arch_lbr_xsave_available(void)
 	 * Check the LBR state with the corresponding software structure.
 	 * Disable LBR XSAVES support if the size doesn't match.
 	 */
+	if (xfeature_size(XFEATURE_LBR) == 0)
+		return false;
 	if (WARN_ON(xfeature_size(XFEATURE_LBR) != get_lbr_state_size()))
 		return false;
 
-- 
2.33.1

