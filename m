Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30147F31F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbhLYLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231540AbhLYLzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:55:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640433323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7wriX1tby6tYi8trHEMgRyyL5Fk6JfqftJOTRFi9AT4=;
        b=NNDR5ibWlacf37iiPenI//gedh8/p3oqeRORq8ziNt4RarIDXu1uQX8lJbZj4qqSPPcP8u
        sxEBdHU+4tD23Ma+I0bx88FoLx2q5znjXXOzBNgm78bu4w6G4tgrPF87AsaBOWh2yUztsa
        pdb6oOHQjvn4l832wO7D7uqL8I7HzWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-Nx6VF0SnOhijALFSm6jAlg-1; Sat, 25 Dec 2021 06:55:18 -0500
X-MC-Unique: Nx6VF0SnOhijALFSm6jAlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED29C102CB29;
        Sat, 25 Dec 2021 11:55:16 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 852EA7C77E;
        Sat, 25 Dec 2021 11:55:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mfd: intel_soc_pmic_crc: Sort cells by IRQ order
Date:   Sat, 25 Dec 2021 12:55:06 +0100
Message-Id: <20211225115509.94891-2-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-1-hdegoede@redhat.com>
References: <20211225115509.94891-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cells for the Crystal Cove PMIC are already mostly sorted by
function / IRQ order. Move the ADC cell so that they are fully sorted.

Also move some of the resource definitions so that their order matches
the (new) order of the cells.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 38acb20e2d60..574cb8f9c70d 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -28,18 +28,10 @@
 #define CRYSTAL_COVE_IRQ_GPIO		5
 #define CRYSTAL_COVE_IRQ_VHDMIOCP	6
 
-static const struct resource gpio_resources[] = {
-	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
-};
-
 static const struct resource pwrsrc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_PWRSRC, "PWRSRC"),
 };
 
-static const struct resource adc_resources[] = {
-	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
-};
-
 static const struct resource thermal_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_THRM, "THERMAL"),
 };
@@ -48,17 +40,20 @@ static const struct resource bcu_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_BCU, "BCU"),
 };
 
+static const struct resource adc_resources[] = {
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
+};
+
+static const struct resource gpio_resources[] = {
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
+};
+
 static struct mfd_cell crystal_cove_byt_dev[] = {
 	{
 		.name = "crystal_cove_pwrsrc",
 		.num_resources = ARRAY_SIZE(pwrsrc_resources),
 		.resources = pwrsrc_resources,
 	},
-	{
-		.name = "crystal_cove_adc",
-		.num_resources = ARRAY_SIZE(adc_resources),
-		.resources = adc_resources,
-	},
 	{
 		.name = "crystal_cove_thermal",
 		.num_resources = ARRAY_SIZE(thermal_resources),
@@ -69,6 +64,11 @@ static struct mfd_cell crystal_cove_byt_dev[] = {
 		.num_resources = ARRAY_SIZE(bcu_resources),
 		.resources = bcu_resources,
 	},
+	{
+		.name = "crystal_cove_adc",
+		.num_resources = ARRAY_SIZE(adc_resources),
+		.resources = adc_resources,
+	},
 	{
 		.name = "crystal_cove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
-- 
2.33.1

