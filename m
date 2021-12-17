Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C6F478828
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhLQJyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:54:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:21043 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234577AbhLQJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639734855; x=1671270855;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wO2KKCXxlXStgs3eWnLuIPaVW795Idp5jp+RuEzWNIA=;
  b=hWaiTf/4Z0WyqOZpVspLSwtGnALr0MXbgCc1+fRpBrg/qV+TKVr5iAnX
   al9zV1IhD85rchRNZGDnjPsw8KdUoUhlMx8tGBS8nkAPTDmBxb1vYeQSp
   JJytTa7QzwRUCIMYmBdb/wZLv0XcIiEBxqEhHiVvMl0EDF7iRGMXPDfLo
   K3WK3zR37Fflq4ECAW4Wd6LkzRfBqpj9zl1PH4rQfTDnplHvP7tbssD87
   glB8tAG1J7419Tgrg1ib5VsydrV7/4A0v9/evJ8e5Gq4TcoblcCxOIdly
   dtNkmZ3CzgXP5+h9qvLpB80L8NVV1OhX+vfApB0HHhrhrAPzSlwuXbo+m
   Q==;
IronPort-SDR: /0TJOSSrtQL1XBs7Bi2sytRzWGwr9kW/PhQgCzTh20cizMmDuT92N2+w/KdB+wvtO+jZnrKpWd
 fxXs36bGEgYmaXlfco7JVDbNq/fTIa98OgZLJB5EAZCvBuXYedvbaWBQaMr1RfQQ8i6rEq4W9N
 OkQT990X8k4TFV+hVz4uDq7wlGoMJ80JcSsvFSqZB7WIdBg15bbLm77FYKzFzTe9U79wwWND4W
 ou1kyaxQQb0uBUIo06EK44U2az/eqzLEgbXI/ma/P7/dQ+7Uziaj71SogL8abRfPmq6l6/uEmy
 Eno+PY6x92meSW+s48EeDlCh
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="155858690"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 02:54:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 02:54:15 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 02:54:11 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH] dt-bindings: iio: adc: atmel,sama5d2-adc: make atmel,trigger-edge-type non-mandatory
Date:   Fri, 17 Dec 2021 11:54:01 +0200
Message-ID: <20211217095401.583821-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The atmel,trigger-edge-type was never imposed by the driver.
Make things right and remove this property from the mandatory list.
This will not break existing nodes because according to the binding they
should have this property.
However, the driver does not impose it and it works without it, the property
selects the trigger type, and without it, the driver will have no trigger
available, which is the case on some boards which do not have access
to the trigger pin.
This will avoid generating this warning for example:

*/arch/arm/boot/dts/at91-sama7g5ek.dt.yaml: adc@e1000000: 'atmel,trigger-edge-type' is a required property
From schema: */Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
index efed361215b4b..482d80dd43b5f 100644
--- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
@@ -72,7 +72,6 @@ required:
   - atmel,min-sample-rate-hz
   - atmel,max-sample-rate-hz
   - atmel,startup-time-ms
-  - atmel,trigger-edge-type
 
 examples:
   - |
-- 
2.25.1

