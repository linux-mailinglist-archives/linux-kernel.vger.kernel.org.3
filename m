Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAD47F31E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhLYLz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39704 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231536AbhLYLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640433323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=di4ERPaBNjWDt7Z9CBd64dRLjk5xvsZryNSyB+k/1Ds=;
        b=UPSUUrUPuWAN1eADn6WMNxTXNNH1po0+yPY4nnsGXVM6DBla7k/7PYczPwElmtZXRohnCw
        AptQb78ITbu9WOW3G7sc0CASXPkgz1v89dUguP7QDOka6T5D4+M7GUm4lK6KK0sTaA7SuO
        3rGU5oycPBCzEmafCYrZ5s2qJqIuJ6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-ot29v0kCMF2CQZGV8LXpng-1; Sat, 25 Dec 2021 06:55:19 -0500
X-MC-Unique: ot29v0kCMF2CQZGV8LXpng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A171A102CB2A;
        Sat, 25 Dec 2021 11:55:18 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B8A07ADB4;
        Sat, 25 Dec 2021 11:55:17 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell to BYT cells
Date:   Sat, 25 Dec 2021 12:55:07 +0100
Message-Id: <20211225115509.94891-3-hdegoede@redhat.com>
In-Reply-To: <20211225115509.94891-1-hdegoede@redhat.com>
References: <20211225115509.94891-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Crystal Cove PMIC has a pin which can be used to connect the IRQ of
an external charger IC. On some boards this is used and we need to have
a cell for this, with a driver which creates its own irqchip with
a single IRQ for the charger driver to consume.

The charger driver cannot directly consume the IRQ from the MFD level
irqchip because the PMIC has 2 levels of interrupts and the second
level interrupt status register, which is handled by the cell drivers,
needs to have the IRQ acked to avoid an IRQ storm.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 574cb8f9c70d..5bb0367bd974 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -44,6 +44,10 @@ static const struct resource adc_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
 };
 
+static const struct resource charger_resources[] = {
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_CHGR, "CHGR"),
+};
+
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
 };
@@ -69,6 +73,11 @@ static struct mfd_cell crystal_cove_byt_dev[] = {
 		.num_resources = ARRAY_SIZE(adc_resources),
 		.resources = adc_resources,
 	},
+	{
+		.name = "crystal_cove_charger",
+		.num_resources = ARRAY_SIZE(charger_resources),
+		.resources = charger_resources,
+	},
 	{
 		.name = "crystal_cove_gpio",
 		.num_resources = ARRAY_SIZE(gpio_resources),
-- 
2.33.1

