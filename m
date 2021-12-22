Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443947D580
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344116AbhLVQzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 11:55:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:14709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344065AbhLVQzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640192150; x=1671728150;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zn+R305IguXUmjbxhooWhM4nYIBAkbNRb9VmYzm7JcQ=;
  b=jOE1ZsCBEluMmqOkmsizTQKap5FlcFVup5Qc42valZ2K5mKNU4q5dGyN
   puaY+AZWOC3AwPFOeW0snQPr3xHMMATw+awMknMQo6lU65v7L4zqy4wpd
   iT0SHTSwzGzUrTfgR6kgvuo2UCUs7jjAig3dJLP8+SpEo9yYFojI3SuRe
   6P+QX/eIdnezHPhy9AlWrOikrHV/m3Jw9+xWD6QwwnXSKypKMsnVWaqmL
   AzJMGJjT99n7mRAKdV0glfRVFe5lhq0tfW0s2khFBLHgXE8+VDuWp1fnG
   63WziyxJ6JcSzI/fHyExB5spsd9pMhgiF0ljqY+S6fRjWrDwFRPm7DHkK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="240465211"
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="240465211"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 08:55:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,227,1635231600"; 
   d="scan'208";a="685081716"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Dec 2021 08:55:48 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7DAC2FE; Wed, 22 Dec 2021 18:55:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] KVM: arm64: vgic: Replace kernel.h with the necessary inclusions
Date:   Wed, 22 Dec 2021 18:55:52 +0200
Message-Id: <20211222165552.69288-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel.h is used in the headers it adds a lot into dependency hell,
especially when there are circular dependencies are involved.

Replace kernel.h inclusion with the list of what is really being used.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

