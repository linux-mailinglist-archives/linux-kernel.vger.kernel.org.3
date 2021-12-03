Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B964B467519
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380028AbhLCKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:34:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32329 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380059AbhLCKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJTzC5R0pf7HcncaFZoRWN5xPIE/ssJpEzpvBuVw8EE=;
        b=UDqPoI9Z5sPyhmb7n6WUovlEuARzx5oxmn2fhtb5oHwgRONBCEAtvnveYDKzpzyJUDy2qY
        /cFONZ80TiHnnn+B5NK9bko1M3ufCkK3Xm4s23drnGcH5eefsRULcekv0U+SRWftwdX/U5
        MO4qCyo6gEFrNEsx+w8QsVn3T2NZkJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-XKxi5nrOOpiVz9HIIzLV1w-1; Fri, 03 Dec 2021 05:30:54 -0500
X-MC-Unique: XKxi5nrOOpiVz9HIIzLV1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C61CE81CCB4;
        Fri,  3 Dec 2021 10:30:51 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13A1F5BAE2;
        Fri,  3 Dec 2021 10:30:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 12/14] media: ipu3-cio2: Defer probing until the PMIC is fully setup
Date:   Fri,  3 Dec 2021 11:28:55 +0100
Message-Id: <20211203102857.44539-13-hdegoede@redhat.com>
In-Reply-To: <20211203102857.44539-1-hdegoede@redhat.com>
References: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On devices where things are not fully describe in devicetree (1)
and where the code thus falls back to calling cio2_bridge_init(),
the i2c-clients for any VCMs also need to be instantiated manually.

The VCM can be probed by its driver as soon as the code instantiates
the i2c-client and this probing must not happen before the PMIC is
fully setup.

Make cio2_bridge_init() return -EPROBE_DEFER when the PMIC is not
fully-setup, deferring the probe of the ipu3-cio2 driver.

This is a preparation patch for adding VCM enumeration support to
the ipu3-cio2-bridge code.

1) Through embedding of devicetree info in the ACPI tables

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v7:
- Make the new cio2_bridge_sensors_are_ready() function static

Changes in v6:
- New patch in v6 of this patch series
---
 drivers/media/pci/intel/ipu3/cio2-bridge.c | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/media/pci/intel/ipu3/cio2-bridge.c b/drivers/media/pci/intel/ipu3/cio2-bridge.c
index 1cbbcbf4e157..c805916d0909 100644
--- a/drivers/media/pci/intel/ipu3/cio2-bridge.c
+++ b/drivers/media/pci/intel/ipu3/cio2-bridge.c
@@ -308,6 +308,40 @@ static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
 	return ret;
 }
 
+/*
+ * The VCM cannot be probed until the PMIC is completely setup. We cannot rely
+ * on -EPROBE_DEFER for this, since the consumer<->supplier relations between
+ * the VCM and regulators/clks are not described in ACPI, instead they are
+ * passed as board-data to the PMIC drivers. Since -PROBE_DEFER does not work
+ * for the clks/regulators the VCM i2c-clients must not be instantiated until
+ * the PMIC is fully setup.
+ *
+ * The sensor/VCM ACPI device has an ACPI _DEP on the PMIC, check this using the
+ * acpi_dev_ready_for_enumeration() helper, like the i2c-core-acpi code does
+ * for the sensors.
+ */
+static int cio2_bridge_sensors_are_ready(void)
+{
+	struct acpi_device *adev;
+	bool ready = true;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
+		const struct cio2_sensor_config *cfg =
+			&cio2_supported_sensors[i];
+
+		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
+			if (!adev->status.enabled)
+				continue;
+
+			if (!acpi_dev_ready_for_enumeration(adev))
+				ready = false;
+		}
+	}
+
+	return ready;
+}
+
 int cio2_bridge_init(struct pci_dev *cio2)
 {
 	struct device *dev = &cio2->dev;
@@ -316,6 +350,9 @@ int cio2_bridge_init(struct pci_dev *cio2)
 	unsigned int i;
 	int ret;
 
+	if (!cio2_bridge_sensors_are_ready())
+		return -EPROBE_DEFER;
+
 	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
 	if (!bridge)
 		return -ENOMEM;
-- 
2.33.1

