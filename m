Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA3480BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbhL1RBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhL1RBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640710912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DXxOzHc1iZa7oGJsbF87BKuQf7WqJlWqhVP8T26PBQY=;
        b=aPFEDsdYmuYpQ9bqWNmz7Y/GQu9dE66oXRHY4XVETlY/NfSOTOtXT9DioSDOiygl1mcHjD
        1wF9JPbW/tJB2G6wpm7VAsuNV2pKTQqEhHJ1ITiivu+h5Mc9hcHRGdXg8jM1eD+6GLAze/
        qP0oBTLaz7i395T2jfffLx23vT/8fQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-P4HRWQqlNqOylcsl4-AbjA-1; Tue, 28 Dec 2021 12:01:50 -0500
X-MC-Unique: P4HRWQqlNqOylcsl4-AbjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0680A180FD79;
        Tue, 28 Dec 2021 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 823857ED94;
        Tue, 28 Dec 2021 17:01:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] extcon: int3496: Make the driver a bit less verbose
Date:   Tue, 28 Dec 2021 18:01:38 +0100
Message-Id: <20211228170141.520902-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On all devices which I have with an INT3496 ACPI device,
there is only an ID pin defined.

Change the log-messages about not being able to get GPIOs for
"VBUS EN" and "USB MUX" to use dev_dbg().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-int3496.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index fb527c23639e..df6ab4ef46f5 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -121,11 +121,11 @@ static int int3496_probe(struct platform_device *pdev)
 
 	data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", GPIOD_ASIS);
 	if (IS_ERR(data->gpio_vbus_en))
-		dev_info(dev, "can't request VBUS EN GPIO\n");
+		dev_dbg(dev, "can't request VBUS EN GPIO\n");
 
 	data->gpio_usb_mux = devm_gpiod_get(dev, "mux", GPIOD_ASIS);
 	if (IS_ERR(data->gpio_usb_mux))
-		dev_info(dev, "can't request USB MUX GPIO\n");
+		dev_dbg(dev, "can't request USB MUX GPIO\n");
 
 	/* register extcon device */
 	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
-- 
2.33.1

