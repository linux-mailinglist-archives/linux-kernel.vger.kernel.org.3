Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E50F4943F7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbiATAER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344602AbiATAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:04:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687FEC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v70-20020a25c549000000b006130de5790aso8207860ybe.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=Iyr+MG88n+iHRt04O0HAxgK5CL4awNioywRv0cYQLtlwJ7Cp2SF2E+wRqKyckrKrSy
         hmfqoFYVLlfPXiyjZU06fsJiaM/B8aeEaNl3VbXQGhaWdYv6ndFzA8ejdebFsaE4eeIH
         kEvmt22o01TDRtXrlTgL3RIJthagpYwzNqQ089bNvHagB0KLUVE+3Qebav6fE5W+MVK6
         0aES0QD7R8qT9H/ciOd7arS2npXxDYv2+lDyzoviHA4D/0fKmtDzFqx3ZZuExjD1dTVD
         6mRh2ScSTKfbsEbGwT5BFTnd5Hj5sxoVitLpDVQeh5FObEJFXH+HRD6SHTvrHlLmyzbR
         fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=Vhe8De35opc4KT6heD2TXbkG+L1xVHNCSAOi2uZ7bAklG6Ltly0jtI49wsoJkeNlNi
         jG02Si3MDwEVJ7m6vq+LRNKqwovRawzj3kM1q2qDf1KMf3vBXsN5iYnqlWlUm1YMnbTW
         vLkueFIuV2AK5VFV3p7Pib+6nzTll6Vq6otc4GMmcmTayA06aIeCqAWxUW1hG2fZ/gP1
         P3I9dZ7ZsW8rJqxmuSry7TWPQIn00RlvPyBYLwh69Zj9Ha2BO0drEtArZ6a8vZwZfTxU
         tz+5zMh/y21j7GSEzjhNPhSzLFZzBKrZxRB4tJWkdb3ZtIrDhvT/Om/NCtiyTQKBJOlh
         636g==
X-Gm-Message-State: AOAM5331RcrYljoO9bW5xc2VZU25nYWIJnIlicjRxY+auFJPQj6WlGTd
        DLVkxcQH30nNf8t9tWRiozzcGfXRh1TR
X-Google-Smtp-Source: ABdhPJxHY8jtaOES8j1o7rDLaIqeTvHnKwyZJ56vMd87GW+rxIi4jQUMPrzyY5G6j/GnKeYEUMVs8qiGk8ds
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:4305:5632:a281:7eb0])
 (user=rajatja job=sendgmr) by 2002:a25:7e87:: with SMTP id
 z129mr45619551ybc.719.1642637054515; Wed, 19 Jan 2022 16:04:14 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:04:09 -0800
Message-Id: <20220120000409.2706549-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
From:   Rajat Jain <rajatja@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today the pci_dev->untrusted is set for any devices sitting downstream
an external facing port (determined via "ExternalFacingPort" property).
This however, disallows any internal devices to be marked as untrusted.

There are use-cases though, where a platform would like to treat an
internal device as untrusted (perhaps because it runs untrusted
firmware, or offers an attack surface by handling untrusted network
data etc).

This patch introduces a new "UntrustedDevice" property that can be used
by the firmware to mark any device as untrusted.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..3d9e5fa49451 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_set_untrusted(struct pci_dev *dev)
+{
+	u8 val;
+
+	if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
+		return;
+
+	/* These PCI devices are not trustworthy */
+	if (val)
+		dev->untrusted = 1;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_acpi_set_untrusted(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.34.1.703.g22d0c6ccf7-goog

