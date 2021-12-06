Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E50E4695B6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243195AbhLFMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:33:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:5275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243180AbhLFMdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:33:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="298101829"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="298101829"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 04:30:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="562759884"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2021 04:30:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6F2D7199; Mon,  6 Dec 2021 14:30:07 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     rafael@kernel.org
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 2/4] ACPI: PM: Remove redundant cache flushing
Date:   Mon,  6 Dec 2021 15:29:50 +0300
Message-Id: <20211206122952.74139-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPICA code takes care about cache flushing on S1/S2/S3 in
acpi_hw_extended_sleep() and acpi_hw_legacy_sleep().

acpi_suspend_enter() calls into ACPICA code via acpi_enter_sleep_state()
for S1 or x86_acpi_suspend_lowlevel() for S3. It only need to flush
cache for S2 (not sure if this call path is ever used for S2).

acpi_sleep_prepare() call tree:
  __acpi_pm_prepare()
    acpi_pm_prepare()
      acpi_suspend_ops::prepare_late()
      acpi_hibernation_ops::pre_snapshot()
      acpi_hibernation_ops::prepare()
    acpi_suspend_begin_old()
      acpi_suspend_begin_old::begin()
  acpi_hibernation_begin_old()
    acpi_hibernation_ops_old::acpi_hibernation_begin_old()
  acpi_power_off_prepare()
    pm_power_off_prepare()

Hibernation (S4) and Power Off (S5) don't require cache flushing. So,
the only interesting callsites are acpi_suspend_ops::prepare_late() and
acpi_suspend_begin_old::begin(). Both of them have cache flush on
->enter() operation in acpi_suspend_enter().

Remove redundant ACPI_FLUSH_CPU_CACHE() in acpi_sleep_prepare() and
acpi_suspend_enter().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/sleep.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eaa47753b758..14e8df0ac762 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -73,7 +73,6 @@ static int acpi_sleep_prepare(u32 acpi_state)
 		acpi_set_waking_vector(acpi_wakeup_address);
 
 	}
-	ACPI_FLUSH_CPU_CACHE();
 #endif
 	pr_info("Preparing to enter system sleep state S%d\n", acpi_state);
 	acpi_enable_wakeup_devices(acpi_state);
@@ -566,15 +565,15 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	u32 acpi_state = acpi_target_sleep_state;
 	int error;
 
-	ACPI_FLUSH_CPU_CACHE();
-
 	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
 		barrier();
 		status = acpi_enter_sleep_state(acpi_state);
 		break;
-
+	case ACPI_STATE_S2:
+		ACPI_FLUSH_CPU_CACHE();
+		break;
 	case ACPI_STATE_S3:
 		if (!acpi_suspend_lowlevel)
 			return -ENOSYS;
-- 
2.32.0

