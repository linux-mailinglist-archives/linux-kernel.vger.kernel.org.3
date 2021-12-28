Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81E480BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhL1RB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 12:01:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38785 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229617AbhL1RBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:01:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640710915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WLxYNcSmXT/x97Tu8DcS8MkU/gaJDHMu1gETCY//v8Q=;
        b=RXi7Y2JMjVV6t7g/npJNsIzKrwJtgnmDLxB+LHOn/Ja1vWhNmGwCDH/Q+lS+h95eI+9IDU
        UmxF7sLXX1sjZcbPbscW7Egh679aO32fQuFQ0TjpHUSYmu+NgPZ7OL5ZR5gSNJVv5PtjUB
        99pUEkd7qxWU7JWFPEjicvGuIBrri2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-373-79jfBvBoNvu_tcb33GY31w-1; Tue, 28 Dec 2021 12:01:52 -0500
X-MC-Unique: 79jfBvBoNvu_tcb33GY31w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6448A1006AA3;
        Tue, 28 Dec 2021 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DAE67ED8F;
        Tue, 28 Dec 2021 17:01:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] extcon: int3496: Request non-exclusive access to the ID GPIO
Date:   Tue, 28 Dec 2021 18:01:39 +0100
Message-Id: <20211228170141.520902-2-hdegoede@redhat.com>
In-Reply-To: <20211228170141.520902-1-hdegoede@redhat.com>
References: <20211228170141.520902-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some DSDTs are buggy and do a read from the ID pin during the ACPI
initialization, causing the pin to be marked as owned by:
"ACPI:OpRegion" and causing gpiod_get() to fail with -EBUSY.

Pass the GPIOD_FLAGS_BIT_NONEXCLUSIVE flag to the gpiod_get() call
to work around this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/extcon/extcon-intel-int3496.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
index df6ab4ef46f5..20605574020c 100644
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -106,7 +106,8 @@ static int int3496_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	data->gpio_usb_id = devm_gpiod_get(dev, "id", GPIOD_IN);
+	data->gpio_usb_id =
+		devm_gpiod_get(dev, "id", GPIOD_IN | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
 	if (IS_ERR(data->gpio_usb_id)) {
 		ret = PTR_ERR(data->gpio_usb_id);
 		dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
-- 
2.33.1

