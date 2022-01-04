Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C443448446F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiADPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:19:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:63278 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbiADPTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641309574; x=1672845574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3VPnlsuCUvPLaUETzLQLxoEOT+xx0yEw/SG76Pt1U58=;
  b=NvVbEHhaCDNEf0rjXePHctAg7lwYCvfpz7wcAhUKZpVRdlLR4syvykOP
   xprLcxeo+u2/CWRMuNiF2V4SkphJYQBRqcG0N4s534fGem8fM+AarpZwE
   P3ohSV0y8rJsRHFvMz433jNMFn/3MEpNUWEYhRJu3szpQT/cJ8dHUOIap
   xhlmO5HNVvJf1TILghOljBTcZMCpzgbUpp/yodJyEUkeETSa3pmq1RerC
   vZjhpzfxr9Lh1PCcU86exF9/01YSs7fS8cfH/20efIM+sZsjCrRFj5oZ1
   h9OmwAlgwqlhrqs0GsLRoTVEyCXFastZn/SiHzaHU6wxv56pUZ4T+BRTC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="242447014"
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="242447014"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 07:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,261,1635231600"; 
   d="scan'208";a="526081114"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 04 Jan 2022 07:19:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 84D64120; Tue,  4 Jan 2022 17:19:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] KVM: arm64: vgic: Replace kernel.h with the necessary inclusions
Date:   Tue,  4 Jan 2022 17:19:40 +0200
Message-Id: <20220104151940.55399-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_vgic.h does not require all the stuff the kernel.h provides.
Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: updated commit message by dropping unrelated paragraph (Marc)
 include/kvm/arm_vgic.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index e602d848fc1a..bb30a6803d9f 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -5,9 +5,11 @@
 #ifndef __KVM_ARM_VGIC_H
 #define __KVM_ARM_VGIC_H
 
-#include <linux/kernel.h>
+#include <linux/bits.h>
 #include <linux/kvm.h>
 #include <linux/irqreturn.h>
+#include <linux/kref.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/static_key.h>
 #include <linux/types.h>
-- 
2.34.1

