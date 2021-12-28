Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6707F480BB7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhL1RCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:02:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235947AbhL1RB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:01:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640710917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GbibL7+qsgGTEzZAH5K++4G+8dOnAJHF6kFCngyzC10=;
        b=EMEvimJKiPudQ5a3CSPyenALkpLO7OsqVicgE0DPStuVx7sol4UwkRLyAFG/FCUDAGimHM
        gaS0KfFIQPDMix0t3ore/JWsp443HDcm0HTO5BlMEEmgcd1qU3QSGx6U96i3QKrTVWBlws
        HGLec/8TztRMfzh2BaupfJpyGXifcLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-fPwmQBvLNYGEs-2xqD-4JQ-1; Tue, 28 Dec 2021 12:01:54 -0500
X-MC-Unique: fPwmQBvLNYGEs-2xqD-4JQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F4B9102CB76;
        Tue, 28 Dec 2021 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 156D37ED9D;
        Tue, 28 Dec 2021 17:01:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] extcon: int3496: Add support for controlling Vbus through a regulator
Date:   Tue, 28 Dec 2021 18:01:41 +0100
Message-Id: <20211228170141.520902-4-hdegoede@redhat.com>
In-Reply-To: <20211228170141.520902-1-hdegoede@redhat.com>
References: <20211228170141.520902-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards the 5V vboost-regulator for powering devices connected to
the micro USB connector is not controlled through a GPIO. This happens
for example when the 5V vboost-regulator is integrated into the charger IC
and controlled over I2C.

Add support for controlling the 5V vboost-regulator through the regulator
framework for such boards.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-int3496.c | 30 ++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index 0830076d8c05..ded1a85a5549 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -17,6 +17,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 
 #define INT3496_GPIO_USB_ID	0
 #define INT3496_GPIO_VBUS_EN	1
@@ -30,7 +31,9 @@ struct int3496_data {
 	struct gpio_desc *gpio_usb_id;
 	struct gpio_desc *gpio_vbus_en;
 	struct gpio_desc *gpio_usb_mux;
+	struct regulator *vbus_boost;
 	int usb_id_irq;
+	bool vbus_boost_enabled;
 };
 
 static const unsigned int int3496_cable[] = {
@@ -53,6 +56,27 @@ static const struct acpi_gpio_mapping acpi_int3496_default_gpios[] = {
 	{ },
 };
 
+static void int3496_set_vbus_boost(struct int3496_data *data, bool enable)
+{
+	int ret;
+
+	if (IS_ERR_OR_NULL(data->vbus_boost))
+		return;
+
+	if (data->vbus_boost_enabled == enable)
+		return;
+
+	if (enable)
+		ret = regulator_enable(data->vbus_boost);
+	else
+		ret = regulator_disable(data->vbus_boost);
+
+	if (ret == 0)
+		data->vbus_boost_enabled = enable;
+	else
+		dev_err(data->dev, "Error updating Vbus boost regulator: %d\n", ret);
+}
+
 static void int3496_do_usb_id(struct work_struct *work)
 {
 	struct int3496_data *data =
@@ -71,6 +95,8 @@ static void int3496_do_usb_id(struct work_struct *work)
 
 	if (!IS_ERR(data->gpio_vbus_en))
 		gpiod_direction_output(data->gpio_vbus_en, !id);
+	else
+		int3496_set_vbus_boost(data, !id);
 
 	extcon_set_state_sync(data->edev, EXTCON_USB_HOST, !id);
 }
@@ -123,8 +149,10 @@ static int int3496_probe(struct platform_device *pdev)
 	}
 
 	data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", GPIOD_ASIS);
-	if (IS_ERR(data->gpio_vbus_en))
+	if (IS_ERR(data->gpio_vbus_en)) {
 		dev_dbg(dev, "can't request VBUS EN GPIO\n");
+		data->vbus_boost = devm_regulator_get_optional(dev, "vbus");
+	}
 
 	data->gpio_usb_mux = devm_gpiod_get(dev, "mux", GPIOD_ASIS);
 	if (IS_ERR(data->gpio_usb_mux))
-- 
2.33.1

