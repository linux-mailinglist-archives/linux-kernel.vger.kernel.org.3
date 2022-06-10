Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713E545EB3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbiFJIV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbiFJISX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:18:23 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9964D244142;
        Fri, 10 Jun 2022 01:18:21 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 857C316AB;
        Fri, 10 Jun 2022 11:19:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 857C316AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654849143;
        bh=BfDL2499VHFzGQhkO0OyO5IsQDeHm0cdb0M5NbXP5Nk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JioxRJW7z7ZIAb/2CC4rxdxcuWayey525W9b1elJ+lsSB5iYpEwg5fOLY+dg8iC0L
         aF4zfHcjNvu6M3p32vpGtqS6cJhYD1PjyMlIQm2XUvO09GTEQgbJY/AkWreZVHKJSD
         WAaYTcO/mV+yIGHbNqV5x6oLrJAFphjIb4daS9/Q=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:18:11 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 10/23] ata: libahci_platform: Introduce reset assertion/deassertion methods
Date:   Fri, 10 Jun 2022 11:17:48 +0300
Message-ID: <20220610081801.11854-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
References: <20220610081801.11854-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ACHI-platform library supports only the assert and deassert
reset signals and ignores the platforms with self-deasserting reset lines.
That prone to having the platforms with self-deasserting reset method
misbehaviour when it comes to resuming from sleep state after the clocks
have been fully disabled. For such cases the controller needs to be fully
reset all over after the reference clocks are enabled and stable,
otherwise the controller state machine might be in an undetermined state.

The best solution would be to auto-detect which reset method is supported
by the particular platform and use it implicitly in the framework of the
ahci_platform_enable_resources()/ahci_platform_disable_resources()
methods. Alas it can't be implemented due to the AHCI-platform library
already supporting the shared reset control lines. As [1] says in such
case we have to use only one of the next methods:
+ reset_control_assert()/reset_control_deassert();
+ reset_control_reset()/reset_control_rearm().
If the driver had an exclusive control over the reset lines we could have
been able to manipulate the lines with no much limitation and just used
the combination of the methods above to cover all the possible
reset-control cases. Since the shared reset control has already been
advertised and couldn't be changed with no risk to breaking the platforms
relying on it, we have no choice but to make the platform drivers to
determine which reset methods the platform reset system supports.

In order to implement both types of reset control support we suggest to
introduce the new AHCI-platform flag: AHCI_PLATFORM_RST_TRIGGER, which
when passed to the ahci_platform_get_resources() method together with the
AHCI_PLATFORM_GET_RESETS flag will indicate that the reset lines are
self-deasserting thus the reset_control_reset()/reset_control_rearm() will
be used to control the reset state. Otherwise the
reset_control_deassert()/reset_control_assert() methods will be utilized.

[1] Documentation/driver-api/reset.rst

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---

Changelog v2:
- Convert the ahci_platform_assert_rsts() method to returning int status
  (@Damien).
- Fix some grammar mistakes in the ahci_platform_deassert_rsts() doc
  (@Damien).
---
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci_platform.c | 50 ++++++++++++++++++++++++++++++----
 include/linux/ahci_platform.h  |  5 +++-
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index c3770a19781b..7d834deefeb9 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -340,6 +340,7 @@ struct ahci_host_priv {
 	bool			got_runtime_pm; /* Did we do pm_runtime_get? */
 	unsigned int		n_clks;
 	struct clk_bulk_data	*clks;		/* Optional */
+	unsigned int		f_rsts;
 	struct reset_control	*rsts;		/* Optional */
 	struct regulator	**target_pwrs;	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 1a7060646009..fcf00ffc7d12 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -123,6 +123,44 @@ void ahci_platform_disable_clks(struct ahci_host_priv *hpriv)
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_clks);
 
+/**
+ * ahci_platform_deassert_rsts - Deassert/trigger platform resets
+ * @hpriv: host private area to store config values
+ *
+ * This function deasserts or triggers all the reset lines found for
+ * the AHCI device.
+ *
+ * RETURNS:
+ * 0 on success otherwise a negative error code
+ */
+int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv)
+{
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		return reset_control_reset(hpriv->rsts);
+
+	return reset_control_deassert(hpriv->rsts);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_deassert_rsts);
+
+/**
+ * ahci_platform_assert_rsts - Assert/rearm platform resets
+ * @hpriv: host private area to store config values
+ *
+ * This function asserts or rearms (for self-deasserting resets) all
+ * the reset controls found for the AHCI device.
+ *
+ * RETURNS:
+ * 0 on success otherwise a negative error code
+ */
+int ahci_platform_assert_rsts(struct ahci_host_priv *hpriv)
+{
+	if (hpriv->f_rsts & AHCI_PLATFORM_RST_TRIGGER)
+		return reset_control_rearm(hpriv->rsts);
+
+	return reset_control_assert(hpriv->rsts);
+}
+EXPORT_SYMBOL_GPL(ahci_platform_assert_rsts);
+
 /**
  * ahci_platform_enable_regulators - Enable regulators
  * @hpriv: host private area to store config values
@@ -220,18 +258,18 @@ int ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_regulator;
 
-	rc = reset_control_deassert(hpriv->rsts);
+	rc = ahci_platform_deassert_rsts(hpriv);
 	if (rc)
 		goto disable_clks;
 
 	rc = ahci_platform_enable_phys(hpriv);
 	if (rc)
-		goto disable_resets;
+		goto disable_rsts;
 
 	return 0;
 
-disable_resets:
-	reset_control_assert(hpriv->rsts);
+disable_rsts:
+	ahci_platform_assert_rsts(hpriv);
 
 disable_clks:
 	ahci_platform_disable_clks(hpriv);
@@ -258,7 +296,7 @@ void ahci_platform_disable_resources(struct ahci_host_priv *hpriv)
 {
 	ahci_platform_disable_phys(hpriv);
 
-	reset_control_assert(hpriv->rsts);
+	ahci_platform_assert_rsts(hpriv);
 
 	ahci_platform_disable_clks(hpriv);
 
@@ -449,6 +487,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 			rc = PTR_ERR(hpriv->rsts);
 			goto err_out;
 		}
+
+		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
 	}
 
 	/*
diff --git a/include/linux/ahci_platform.h b/include/linux/ahci_platform.h
index 49e5383d4222..6d7dd472d370 100644
--- a/include/linux/ahci_platform.h
+++ b/include/linux/ahci_platform.h
@@ -23,6 +23,8 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_phys(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_clks(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_clks(struct ahci_host_priv *hpriv);
+int ahci_platform_deassert_rsts(struct ahci_host_priv *hpriv);
+int ahci_platform_assert_rsts(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv);
 void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv);
 int ahci_platform_enable_resources(struct ahci_host_priv *hpriv);
@@ -41,6 +43,7 @@ int ahci_platform_resume_host(struct device *dev);
 int ahci_platform_suspend(struct device *dev);
 int ahci_platform_resume(struct device *dev);
 
-#define AHCI_PLATFORM_GET_RESETS	0x01
+#define AHCI_PLATFORM_GET_RESETS	BIT(0)
+#define AHCI_PLATFORM_RST_TRIGGER	BIT(1)
 
 #endif /* _AHCI_PLATFORM_H */
-- 
2.35.1

