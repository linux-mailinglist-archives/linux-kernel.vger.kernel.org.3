Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6468C476634
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhLOWwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:52:18 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38784 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbhLOWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:52:17 -0500
Received: by mail-oi1-f179.google.com with SMTP id r26so33758552oiw.5;
        Wed, 15 Dec 2021 14:52:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BTAdvg6ZCWLy3pwv52Rr2UXsoSNfM+gDylz9/qM85kQ=;
        b=0lZlB06B9LAGYN44GRZDc0m5/LVvZJ4jRi4UIh1xrJQ7aeL5Om7evvAoPgj8yTkQB0
         2i8XFkLMSOKzVHI7ehz9gJ0srY8mEjPhyVc/bXioXnTinwSBtdymDDVDPRrLsWTEI47M
         20MbshheQEEqWG6dLZJLYl4MhdAyK5uSVGLsFoXdOzZA4NWFZviGfrVYOMNUy9moGDaV
         jYvnHSdV0ZDkGXz8meSb8X29p90q0CXmWGk8qufX9UfRrExyMPBIuTlmi5bdJoF+TTLk
         VnXH9Gwthn+Yvr/xnWjsSMhJSpKoudDNuws1iqrlLZrqrY3e4OTy/26kywcQElJ9Cobe
         jcUA==
X-Gm-Message-State: AOAM530epXYVm7CIezCbqUiQadtat0z52ZUy9KzaPk4/nXhWqehDx5Q2
        3Ufw+I+G6SgSgbNHkTLUtVWc0B/hdg==
X-Google-Smtp-Source: ABdhPJzjW+/VnakDTGGNVbf3wwocFZdqSTXDGieMzyqzLtirEI39Yr8cGa7eiwqdxYhdv10H+ad5CA==
X-Received: by 2002:a05:6808:697:: with SMTP id k23mr1998953oig.18.1639608736558;
        Wed, 15 Dec 2021 14:52:16 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id i16sm599759oig.15.2021.12.15.14.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:52:15 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: uhci: Use platform_get_irq() to get the interrupt
Date:   Wed, 15 Dec 2021 16:52:03 -0600
Message-Id: <20211215225203.1991003-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing platform device resources directly has long been deprecated for
DT as IRQ resources may not be available at device creation time. Drivers
continuing to use static IRQ resources is blocking removing the static setup
from the DT core code.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/host/uhci-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/uhci-platform.c b/drivers/usb/host/uhci-platform.c
index 70dbd95c3f06..b854699e9e4e 100644
--- a/drivers/usb/host/uhci-platform.c
+++ b/drivers/usb/host/uhci-platform.c
@@ -132,7 +132,11 @@ static int uhci_hcd_platform_probe(struct platform_device *pdev)
 		goto err_rmr;
 	}
 
-	ret = usb_add_hcd(hcd, pdev->resource[1].start, IRQF_SHARED);
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		goto err_clk;
+
+	ret = usb_add_hcd(hcd, ret, IRQF_SHARED);
 	if (ret)
 		goto err_clk;
 
-- 
2.32.0

