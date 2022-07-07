Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B1956A303
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiGGM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiGGM44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:56:56 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CE732EF3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 05:56:31 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t24so30994131lfr.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=454tFgA3S0AdDHLCz9NCzDKFnu7jUDGP8ZhaUxLFAwM=;
        b=ZBZNaeAww+Dou3ANR4Eicb8fz7bLlNgPQ80A7xVXd4cLFP/jtPon2GknTZ+8EtMU/y
         D1d4W/S1z5kLi6xXr2EoGQRtv6DNFXc4fPxmiGCFMVzpRHOfV8WOSAorS53sV77apMMb
         COE/hG8m0zyyAMG1MEMtnRpfLsLImDEkvBaTFLhPmDpvLdpAw096gSb0Xj/l50nw4c2F
         8vvnqvNFKk18zK8GlZHC2r59j/j8KpS3CB1OOAedY2LGKNDLuIRTq0rVJZhPmUVIHibc
         t24NdRzWzXTxXEjdFfXqQKrBM7msLM29t79+xi9GG5qIh9qGgeVLwvA7AMSHkf5lEwb1
         wGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=454tFgA3S0AdDHLCz9NCzDKFnu7jUDGP8ZhaUxLFAwM=;
        b=z+CM4RzW4mKtuHN8JD+Nr4VlD+0a6XLdgo+dorkvAjc39sMOZdV3RhNlhOdeE9/pPc
         gcQatat9f8bVHMYsFaashDwn7/tp5CX/3E6o0bn7jk+q3w34CYfYlyuOaCSh6CckRf5a
         HeUcezFXRAqtdoFT4DRh1UEdhdDRtzMVsVqNbFjZLOZUm3QLuruu4SsZFpGhpglHKpuC
         tkv15tk6XpXQ9VNNGg0fC7LRDAIZKXxOtpY9pILfTPjt+SwRPAVc7zPV8yLpP1r10XnL
         RACgU1AF0sajIxdsbEaseS6wRvZvCEDRse78J65+3QA3pPknvR/LuoR8dHGaAq/2e1Um
         LRPA==
X-Gm-Message-State: AJIora9mNOVJGzfA/+84SIi9D0ndLE59Ip8hp9EGm76M3Mk70+E6r8qE
        T48iHfw/8Rt7cRKFFgxJQZRymfg4Jv9/eQ==
X-Google-Smtp-Source: AGRyM1tUIF+2YDWl6srviD3jNZnzTpeDIWSQK6Nxo7YmHYsOrhaaVVcT0yZfLbFNHGMKVZdRHQ/fIg==
X-Received: by 2002:a05:6512:260b:b0:47f:b04e:3116 with SMTP id bt11-20020a056512260b00b0047fb04e3116mr31189424lfb.474.1657198589088;
        Thu, 07 Jul 2022 05:56:29 -0700 (PDT)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id d7-20020a05651221c700b0047255d2111csm6810361lft.75.2022.07.07.05.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:56:28 -0700 (PDT)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org
Cc:     jaz@semihalf.com, dmy@semihalf.com, mario.limonciello@amd.com,
        seanjc@google.com, dbehr@google.com, upstream@semihalf.com,
        zide.chen@intel.corp-partner.google.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sachi King <nakato@nakato.io>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        platform-driver-x86@vger.kernel.org (open list:X86 PLATFORM DRIVERS),
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM)
Subject: [RFC PATCH 2/2] platform/x86: Add virtual PMC driver used for S2Idle
Date:   Thu,  7 Jul 2022 12:53:24 +0000
Message-Id: <20220707125329.378277-3-jaz@semihalf.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220707125329.378277-1-jaz@semihalf.com>
References: <20220707125329.378277-1-jaz@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtual PMC driver is meant for the guest VMs for the S2Idle
notification. Its purpose is to register S2Idle dev ops notify handler,
which will evaluate ACPI _DSM as a very last command before the guest
enters S2Idle power state.

This allows to trap on MMIO access done as a consequence of _DSM
evaluation and therefore notify the VMM about the guest entering S2Idle
state.

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 drivers/platform/x86/Kconfig    |  7 ++++
 drivers/platform/x86/Makefile   |  1 +
 drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index bc4013e950ed..dee974321b01 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -479,6 +479,13 @@ config WIRELESS_HOTKEY
 	 To compile this driver as a module, choose M here: the module will
 	 be called wireless-hotkey.
 
+config VIRT_PMC
+	tristate "Virt PMC"
+	depends on ACPI && SUSPEND
+	help
+	  The Virtual PMC driver is meant for the guest VMs and it's main
+	  purpose is to notify about guest entering s2idle state.
+
 config HP_WMI
 	tristate "HP WMI extras"
 	depends on ACPI_WMI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 4a59f47a46e2..3c3e440f11bb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -116,6 +116,7 @@ obj-$(CONFIG_MLX_PLATFORM)		+= mlx-platform.o
 obj-$(CONFIG_TOUCHSCREEN_DMI)		+= touchscreen_dmi.o
 obj-$(CONFIG_WIRELESS_HOTKEY)		+= wireless-hotkey.o
 obj-$(CONFIG_X86_ANDROID_TABLETS)	+= x86-android-tablets.o
+obj-$(CONFIG_VIRT_PMC)			+= virt_pmc.o
 
 # Intel uncore drivers
 obj-$(CONFIG_INTEL_IPS)				+= intel_ips.o
diff --git a/drivers/platform/x86/virt_pmc.c b/drivers/platform/x86/virt_pmc.c
new file mode 100644
index 000000000000..d0607db6cd22
--- /dev/null
+++ b/drivers/platform/x86/virt_pmc.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Virtual Power Management Controller Driver
+ *
+ * Author: Grzegorz Jaszczyk <jaz@semihalf.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#define ACPI_VIRT_PMC_DSM_UUID	"9ea49ba3-434a-49a6-be30-37cc55c4d397"
+#define ACPI_VIRT_PMC_NOTIFY 1
+
+static acpi_handle virt_pmc_handle;
+
+static void virt_pmc_s2idle_notify(void)
+{
+	union acpi_object *out_obj;
+	static guid_t dsm_guid;
+
+	guid_parse(ACPI_VIRT_PMC_DSM_UUID, &dsm_guid);
+
+	out_obj = acpi_evaluate_dsm(virt_pmc_handle, &dsm_guid,
+					0, ACPI_VIRT_PMC_NOTIFY, NULL);
+
+	acpi_handle_debug(virt_pmc_handle, "_DSM function %u evaluation %s\n",
+			  ACPI_VIRT_PMC_NOTIFY, out_obj ? "successful" : "failed");
+
+	ACPI_FREE(out_obj);
+}
+
+static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
+	.notify = virt_pmc_s2idle_notify,
+};
+
+static int virt_pmc_probe(struct platform_device *pdev)
+{
+	int err = 0;
+
+	virt_pmc_handle = ACPI_HANDLE(&pdev->dev);
+
+	err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
+	if (err)
+		dev_warn(&pdev->dev, "failed to register LPS0 sleep handler\n");
+
+	return err;
+}
+
+static int virt_pmc_remove(struct platform_device *pdev)
+{
+	acpi_unregister_lps0_dev(&amd_pmc_s2idle_dev_ops);
+
+	return 0;
+}
+
+static const struct acpi_device_id virt_pmc_acpi_ids[] = {
+	{"HYPE0001", 0}, /* _HID for XXX Power Engine, _CID PNP0D80*/
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, virt_pmc_acpi_ids);
+
+static struct platform_driver virt_pmc_driver = {
+	.driver = {
+		.name = "virtual_pmc",
+		.acpi_match_table = ACPI_PTR(virt_pmc_acpi_ids),
+	},
+	.probe = virt_pmc_probe,
+	.remove = virt_pmc_remove,
+};
+
+module_platform_driver(virt_pmc_driver);
+
+MODULE_DESCRIPTION("Virtual PMC Driver");
-- 
2.37.0.rc0.161.g10f37bed90-goog

