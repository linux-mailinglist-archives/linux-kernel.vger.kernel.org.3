Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2857461A9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243757AbhK2PHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhK2PFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:05:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22855C08E801
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5810614F4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F10C004E1;
        Mon, 29 Nov 2021 13:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638192241;
        bh=PbFwApqPoOQ84o5p+n61F3jjtY3GYZqJTshMm6xkbYk=;
        h=From:To:Cc:Subject:Date:From;
        b=Tejp1w8h8ABSFefxbrtWIKUc0rLUgY2473+vdkQr6E4KepZijXxp7xEC/ac4JE/fv
         qw9f5mMEMDRyJAKOuXF6NQnFHn3GGbbQUucJCyzFW5eb4zJLxnckQVCsEkAVauU8iD
         8xU/0Xptsw7Xyjc/S6dvWJGhURT7zLNqmlwZ15zljv4ECW+hgyyAbR+wDhjSc7Go8f
         YQvxkWLLeFwapi8YI4uWMnDAamLDrz8hnRxQq9PqgmuM9gvtm3U1woC9vg2paA925t
         w4HdnAaqsrsfLIduQN4AcPe1jOMFYx3YqyXbIbRBfkYo4WOy6BAjXJEr4JccpJgkHD
         Vp15emPMI28sw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mrgdS-000V7V-Tf; Mon, 29 Nov 2021 14:23:58 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] mfd: Kconfig: change INTEL_SOC_PMIC_CHTDC_TI to bool
Date:   Mon, 29 Nov 2021 14:23:56 +0100
Message-Id: <86f546b3233fd799b0c39b83afc521440ebfe004.1638192232.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The INTEL_SOC_PMIC_CHTDC_TI should be initialized early, before
loading the fbcon driver, as otherwise the i915 driver will
fail to configure pwm:

[   13.674287] fb0: switching to inteldrmfb from EFI VGA
[   13.682380] Console: switching to colour dummy device 80x25
[   13.682468] i915 0000:00:02.0: vgaarb: deactivate vga console
[   13.682686] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.685773] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[   13.686219] i915 0000:00:02.0: [drm] *ERROR* Failed to configure the pwm chip
[   13.699572] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
[   13.739044] fbcon: i915drmfb (fb0) is primary device
[   14.037792] intel_soc_pmic_exec_mipi_pmic_seq_element: No PMIC registered
...
[   24.621403] intel_pmic_install_opregion_handler: Ask to register OpRegion for bus ID=PMI2, HID=INT33F5
[   24.630540] intel_pmic_install_opregion_handler: OpRegion registered

(some extra debug printk's were added to the above)

As suggested by Hans, this patch also addresses an issue with
the dependencies, as, for this driver to be a bool, it also
need the I2C core and the I2C_DESIGNWARE driver to be builtin.

Suggested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3fb480818599..b756860ae551 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -634,7 +634,7 @@ config INTEL_SOC_PMIC_CHTWC
 config INTEL_SOC_PMIC_CHTDC_TI
 	tristate "Support for Intel Cherry Trail Dollar Cove TI PMIC"
 	depends on GPIOLIB
-	depends on I2C
+	depends on I2C=y && I2C_DESIGNWARE_PLATFORM=y
 	depends on ACPI
 	depends on X86
 	select MFD_CORE
@@ -644,6 +644,10 @@ config INTEL_SOC_PMIC_CHTDC_TI
 	  Select this option for supporting Dollar Cove (TI version) PMIC
 	  device that is found on some Intel Cherry Trail systems.
 
+	  This option is a bool as it provides an ACPI OpRegion which must be
+	  available before any devices using it are probed. This option also
+	  needs the designware-i2c driver to be builtin for the same reason.
+
 config INTEL_SOC_PMIC_MRFLD
 	tristate "Support for Intel Merrifield Basin Cove PMIC"
 	depends on GPIOLIB
-- 
2.33.1

