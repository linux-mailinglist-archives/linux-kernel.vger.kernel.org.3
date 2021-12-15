Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F208476638
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhLOWyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:54:09 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:43564 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOWyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:54:08 -0500
Received: by mail-oi1-f170.google.com with SMTP id o4so33811481oia.10;
        Wed, 15 Dec 2021 14:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1rTeo0olahvplgpRoUTrL6H+6X7kg0uXokwNI+aGFZ0=;
        b=LGsegQoN7+MXg/NVw8oUZzkMr9eKmICfnd8RCzJX8hBhB9RMVMLDaqV9ei8QrKiQjC
         EvYcPslVyk/sDVYxl/ltaXTr9XqkCDoQdYu0iyq7RIR2T1USaardalNlBB78zS1bj36w
         ce1aRs7UvLtft0t+7vUyxUFaLQiuGewIgFn1tUD/FKPw3ka9mJsP/FlNr7sLj0SlFr6N
         98tI2C0tUeAmHlk+MPBCdRMs2bhnN1C89KujC+d031AhG4Y521fy20ocfAcggZUFIqZx
         9xep4yW2N7QlHCW2SON5iDr6QSo+YK48S5QxDZxli1z/6728OMGnBpa8JmMkYUs5F5Wv
         m7yg==
X-Gm-Message-State: AOAM531Ntpxx10SWIpMJdYVr4BXi9KnLLt6jhz8xlHW75fdefnhaQGKI
        stAshu4wFopOBC/XbSqc0w==
X-Google-Smtp-Source: ABdhPJz1GQKsmbNWfcveEq9z+WBLQtpdPuWRxooywpFwBudd2c3G4Q4K8R/mVbo0j4+jEyU8567M3g==
X-Received: by 2002:a54:480a:: with SMTP id j10mr1945670oij.34.1639608847867;
        Wed, 15 Dec 2021 14:54:07 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bl33sm665930oib.47.2021.12.15.14.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:54:07 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ohci-s3c2410: Use platform_get_irq() to get the interrupt
Date:   Wed, 15 Dec 2021 16:53:57 -0600
Message-Id: <20211215225358.1993774-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing platform device resources directly has long been deprecated for
DT as IRQ resources may not be available at device creation time. Drivers
relying on the static IRQ resources is blocking removing the static setup
from the DT core code.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/host/ohci-s3c2410.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index 1bec9b585e2d..12264c048601 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -356,7 +356,7 @@ static int ohci_hcd_s3c2410_probe(struct platform_device *dev)
 {
 	struct usb_hcd *hcd = NULL;
 	struct s3c2410_hcd_info *info = dev_get_platdata(&dev->dev);
-	int retval;
+	int retval, irq;
 
 	s3c2410_usb_set_power(info, 1, 1);
 	s3c2410_usb_set_power(info, 2, 1);
@@ -388,9 +388,15 @@ static int ohci_hcd_s3c2410_probe(struct platform_device *dev)
 		goto err_put;
 	}
 
+	irq = platform_get_irq(dev, 0);
+	if (irq < 0) {
+		retval = irq;
+		goto err_put;
+	}
+
 	s3c2410_start_hc(dev, hcd);
 
-	retval = usb_add_hcd(hcd, dev->resource[1].start, 0);
+	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval != 0)
 		goto err_ioremap;
 
-- 
2.32.0

