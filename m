Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CE47B642
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 00:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbhLTXoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 18:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhLTXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 18:44:00 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438ECC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:44:00 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 14so15418532ioe.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 15:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPLa+lTt8vCW4IqiZRoAjFD2+DlmxgEl4wmSi4FTuOw=;
        b=O9l0LEb7TUTSspyh/AxCMkfk93Be4GaRLHafsGgHpnuCZ44FW2+fOwGF33R7FZiIk+
         HaBxmoAoqGeayPqmlu/1yOxD+aemuqviVdRi3nLfpJVTx0VhJJiO1eGIkEzSyTeYJxdC
         VwX0i/zyKbxKb9Obr+VcykFgeAWGZ56+0Gp54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPLa+lTt8vCW4IqiZRoAjFD2+DlmxgEl4wmSi4FTuOw=;
        b=M9iKBKqwjyE+A0kU/ZIjkV/f8os5+ATEsP7yauMX2UANLnNlfolEnJpq898hi1h5Dw
         5oyNGctXNtBOyt520bI3gkeB94reQiaKcET1+BFBw0g7mh3TUgaRIGjyey9KV5nJfLaJ
         ZnDaCgB7zXODqFHypQu+Utnms42jLMN3Dw8QbjGtgOuaVJYPNzsNS6CEi4BkMuuV6MyZ
         nHJPWKdXazqKvwJNLNti191Wn27OXvLELE65EPjIUQtyqwot9wk7EaCNHGFA+PNToFAj
         KIwwMVyd00QpWk9Vfi5jDe76fFMVyhAUyfIGd2X8HmBatoqrzPbZzeFSLt+mHb7uUie1
         +irg==
X-Gm-Message-State: AOAM533UKuZOutYwgXnDVi6D326X7BAPW+iiGFKv9HY5Y1/d8JP6uEvt
        W4WmLGIYKcSSxt/R476mO+iUPgDr3jWtUQ==
X-Google-Smtp-Source: ABdhPJxt7kvyeNHdnIFlVtQ7EkSTD2BNbhkBbLVbnBSYJW9499zBRWaFWT7dSKIXap6NXxEEnSftAg==
X-Received: by 2002:a05:6638:25cd:: with SMTP id u13mr392376jat.8.1640043839566;
        Mon, 20 Dec 2021 15:43:59 -0800 (PST)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id k19sm4077521ilr.34.2021.12.20.15.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 15:43:59 -0800 (PST)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     mario.limonciello@amd.com, linux-input@vger.kernel.org,
        dianders@chromium.org, Raul E Rangel <rrangel@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH 3/3] platform/chrome: cros_ec: Don't enable wake pin if ACPI managed
Date:   Mon, 20 Dec 2021 16:43:46 -0700
Message-Id: <20211220163823.3.I2339b40dd2ed02569ba204734dc335866a1c5b98@changeid>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
In-Reply-To: <20211220234346.2798027-1-rrangel@chromium.org>
References: <20211220234346.2798027-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ACPI managed systems, the `_PRW` method defines the wake source for
the device. This could be a GPE or a GPIO not related to the IRQ. The
way the cros_ec_lpc driver works is that the irq field is optional. The
IRQ defined in the `_CRS` is only used to speed up sensor event
processing. Before this change, the SYNC_IRQ GPIO would have its wake
bit enabled. This means that we now have two wake sources defined for
the EC. This change makes the CrOS EC driver leave wake configuration
alone if the device is ACPI managed.

I tested this on guybrush and no longer see the EC SYNC IRQ enabled as a
wake source when suspending.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/platform/chrome/cros_ec.c           | 8 ++++++--
 include/linux/platform_data/cros_ec_proto.h | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index fc5aa1525d13..81e334157338 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -9,6 +9,7 @@
  * battery charging and regulator control, firmware update.
  */
 
+#include <linux/acpi.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
@@ -336,11 +337,14 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec",
 			ret);
 
-	if (device_may_wakeup(dev))
+	/*
+	 * For non-ACPI subsystems we need to explicitly enable the wake source.
+	 * For ACPI systems, the ACPI subsystem will handle all the details.
+	 */
+	if (device_may_wakeup(dev) && !ACPI_COMPANION(ec_dev->dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 
 	disable_irq(ec_dev->irq);
-	ec_dev->was_wake_device = ec_dev->wake_enabled;
 	ec_dev->suspended = true;
 
 	return 0;
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 992796e40cd6..054d28ddb4c1 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -139,7 +139,6 @@ struct cros_ec_device {
 	/* These are used by other drivers that want to talk to the EC */
 	const char *phys_name;
 	struct device *dev;
-	bool was_wake_device;
 	struct class *cros_class;
 	int (*cmd_readmem)(struct cros_ec_device *ec, unsigned int offset,
 			   unsigned int bytes, void *dest);
-- 
2.34.1.307.g9b7440fafd-goog

