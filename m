Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2606146E92E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbhLINfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:35:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:20047 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhLINft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:35:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="225362523"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="225362523"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 05:32:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="462131671"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 09 Dec 2021 05:32:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id D42A9329; Thu,  9 Dec 2021 15:32:17 +0200 (EET)
Date:   Thu, 9 Dec 2021 16:32:17 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 2/4] ACPI: PM: Remove redundant cache flushing
Message-ID: <20211209133217.omm3mzchsfippwjc@black.fi.intel.com>
References: <CAJZ5v0gLwSvPfWzYwiZXee8SiPiQQoxjfKfVn4jx6wK_9VVEeg@mail.gmail.com>
 <20211206122952.74139-1-kirill.shutemov@linux.intel.com>
 <20211206122952.74139-3-kirill.shutemov@linux.intel.com>
 <CAJZ5v0hGnvX2a1bsoUSqV4Vf0LE6P6wTjk4ZPT7JTLvSAL7z_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hGnvX2a1bsoUSqV4Vf0LE6P6wTjk4ZPT7JTLvSAL7z_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:35:38PM +0100, Rafael J. Wysocki wrote:
> I don't think this is needed for S2, because the function doesn't do
> anything low-level in that case and simply returns (IOW, S2 isn't
> really supported).

Updated patch is below. Does it look good?

From 5eb4ec7d8dd463ba186b779dcef2a802d999c59c Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Thu, 9 Dec 2021 16:08:02 +0300
Subject: [PATCH 1/2] ACPI: PM: Remove redundant cache flushing

ACPICA code takes care about cache flushing on S1/S2/S3 in
acpi_hw_extended_sleep() and acpi_hw_legacy_sleep().

acpi_suspend_enter() calls into ACPICA code via acpi_enter_sleep_state()
for S1 or x86_acpi_suspend_lowlevel() for S3.

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
 drivers/acpi/sleep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index eaa47753b758..5ca6c223ba3d 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -73,7 +73,6 @@ static int acpi_sleep_prepare(u32 acpi_state)
 		acpi_set_waking_vector(acpi_wakeup_address);
 
 	}
-	ACPI_FLUSH_CPU_CACHE();
 #endif
 	pr_info("Preparing to enter system sleep state S%d\n", acpi_state);
 	acpi_enable_wakeup_devices(acpi_state);
@@ -566,8 +565,6 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	u32 acpi_state = acpi_target_sleep_state;
 	int error;
 
-	ACPI_FLUSH_CPU_CACHE();
-
 	trace_suspend_resume(TPS("acpi_suspend"), acpi_state, true);
 	switch (acpi_state) {
 	case ACPI_STATE_S1:
-- 
 Kirill A. Shutemov
