Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1196480BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbhL1RB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:01:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235865AbhL1RB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640710916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KABhYwtH+lyAX68DKnLwuDf8NcWSShFD3e2X/2OWYS4=;
        b=cUpesx0LjrXlCNTYYbjY5UB2laiLcu4/8wUuxqA9rHfvu/fVKiSMAk81dfRzDktWHh0Zpd
        fdga0TkE1WlhEj3NpMhLu6zBlQRJvu2Fl0dpdG51pFro8WC3GkM18tWM5XbTSkAqs7+emy
        BaIzj8drXEUYSI8i+DsVIDh9o4q4mFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-422-vTg64UgfO8KOAMGSzBNwQQ-1; Tue, 28 Dec 2021 12:01:53 -0500
X-MC-Unique: vTg64UgfO8KOAMGSzBNwQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25C81800D50;
        Tue, 28 Dec 2021 17:01:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABEC57ED9D;
        Tue, 28 Dec 2021 17:01:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] extcon: int3496: Add support for binding to plain platform devices
Date:   Tue, 28 Dec 2021 18:01:40 +0100
Message-Id: <20211228170141.520902-3-hdegoede@redhat.com>
In-Reply-To: <20211228170141.520902-1-hdegoede@redhat.com>
References: <20211228170141.520902-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some X86 Android tablets the DSTD lack the INT3496 ACPI device,
while also not handling micro USB port ID pin events inside the DSDT
(instead the forked factory image kernel has things hardcoded).

The new drivers/platform/x86/x86-android-tablets.c module manually
instantiates an intel-int3496 device for these tablets.

Add support to the extcon-intel-int3496 driver to bind to devices
without an ACPI companion and export a normal platform_device
modalias for automatic module loading.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-int3496.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index 20605574020c..0830076d8c05 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -91,10 +91,12 @@ static int int3496_probe(struct platform_device *pdev)
 	struct int3496_data *data;
 	int ret;
 
-	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_int3496_default_gpios);
-	if (ret) {
-		dev_err(dev, "can't add GPIO ACPI mapping\n");
-		return ret;
+	if (has_acpi_companion(dev)) {
+		ret = devm_acpi_dev_add_driver_gpios(dev, acpi_int3496_default_gpios);
+		if (ret) {
+			dev_err(dev, "can't add GPIO ACPI mapping\n");
+			return ret;
+		}
 	}
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -165,12 +167,19 @@ static const struct acpi_device_id int3496_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, int3496_acpi_match);
 
+static const struct platform_device_id int3496_ids[] = {
+	{ .name = "intel-int3496" },
+	{},
+};
+MODULE_DEVICE_TABLE(platform, int3496_ids);
+
 static struct platform_driver int3496_driver = {
 	.driver = {
 		.name = "intel-int3496",
 		.acpi_match_table = int3496_acpi_match,
 	},
 	.probe = int3496_probe,
+	.id_table = int3496_ids,
 };
 
 module_platform_driver(int3496_driver);
-- 
2.33.1

