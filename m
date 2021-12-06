Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0344695AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhLFMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:33:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:60264 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232833AbhLFMdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:33:33 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10189"; a="323557976"
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="323557976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 04:30:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,291,1631602800"; 
   d="scan'208";a="514838582"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 06 Dec 2021 04:30:01 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6725CB8; Mon,  6 Dec 2021 14:30:07 +0200 (EET)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     rafael@kernel.org
Cc:     ak@linux.intel.com, bp@alien8.de, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, knsathya@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rjw@rjwysocki.net,
        sathyanarayanan.kuppuswamy@linux.intel.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 1/4] ACPICA: Do not flush cache for on entering S4 and S5
Date:   Mon,  6 Dec 2021 15:29:49 +0300
Message-Id: <20211206122952.74139-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the ACPI spec v6.4, section 16.2 the cache flushing is
required on entering to S1, S2, and S3. ACPICA code flushes cache
regardless of the sleep state.

Blind cache flush on entering S5 causes problems for TDX. Flushing
happens with WBINVD that is not supported in the TDX environment.

TDX only supports S5 and adjusting ACPICA code to conform to the spec
fixes the issue.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 drivers/acpi/acpica/hwesleep.c  | 3 ++-
 drivers/acpi/acpica/hwsleep.c   | 3 ++-
 drivers/acpi/acpica/hwxfsleep.c | 2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwesleep.c b/drivers/acpi/acpica/hwesleep.c
index 808fdf54aeeb..ceb5a4292efa 100644
--- a/drivers/acpi/acpica/hwesleep.c
+++ b/drivers/acpi/acpica/hwesleep.c
@@ -104,7 +104,8 @@ acpi_status acpi_hw_extended_sleep(u8 sleep_state)
 
 	/* Flush caches, as per ACPI specification */
 
-	ACPI_FLUSH_CPU_CACHE();
+	if (sleep_state < ACPI_STATE_S4)
+		ACPI_FLUSH_CPU_CACHE();
 
 	status = acpi_os_enter_sleep(sleep_state, sleep_control, 0);
 	if (status == AE_CTRL_TERMINATE) {
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 34a3825f25d3..ee094a3aaaab 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -110,7 +110,8 @@ acpi_status acpi_hw_legacy_sleep(u8 sleep_state)
 
 	/* Flush caches, as per ACPI specification */
 
-	ACPI_FLUSH_CPU_CACHE();
+	if (sleep_state < ACPI_STATE_S4)
+		ACPI_FLUSH_CPU_CACHE();
 
 	status = acpi_os_enter_sleep(sleep_state, pm1a_control, pm1b_control);
 	if (status == AE_CTRL_TERMINATE) {
diff --git a/drivers/acpi/acpica/hwxfsleep.c b/drivers/acpi/acpica/hwxfsleep.c
index e4cde23a2906..ba77598ee43e 100644
--- a/drivers/acpi/acpica/hwxfsleep.c
+++ b/drivers/acpi/acpica/hwxfsleep.c
@@ -162,8 +162,6 @@ acpi_status acpi_enter_sleep_state_s4bios(void)
 		return_ACPI_STATUS(status);
 	}
 
-	ACPI_FLUSH_CPU_CACHE();
-
 	status = acpi_hw_write_port(acpi_gbl_FADT.smi_command,
 				    (u32)acpi_gbl_FADT.s4_bios_request, 8);
 	if (ACPI_FAILURE(status)) {
-- 
2.32.0

