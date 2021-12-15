Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BBC47663B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhLOWzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:55:21 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:37526 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhLOWzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:55:20 -0500
Received: by mail-ot1-f44.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so26728182otg.4;
        Wed, 15 Dec 2021 14:55:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3zrbQKjDzYylCqTo9oCZVRtxf26IqrQ0mWzvm+HCL2k=;
        b=Zr2SDY/63Un3KUl8UD6gxsNF5uLrvW+ezgdizjyzpCAj0GEhawEvftEJtH4FqSRlph
         Ef0pmwYWswZxmhN00jmXSjzDuIPhp081puSmES7OwrKiyPIW9ukScRIYvHclS/pTqXu0
         vc5/1KtV2DzVJJep/99gTjb8TiBFob50B0TtHc/oDZpIQSe5/UhlxFBPoMVU5Qgpit9d
         KXhbEAgcicShEWOgrTmr9yPLsGN+SHjYcNo/xKG0LLBITjm089WYtt7irjrUQpc2/qVR
         qIOTzIRKqZaecCM254csqFFzaxeutvEw7AKWHMvaL/2gmoK6zsLpJLZ3l3J7B9hRBVyV
         +gEA==
X-Gm-Message-State: AOAM532aeD6S1i0ZaJZIbu6GKsc82k/8iQc52Zyx6Kurtej67in1gT1J
        1WAZPTLjm2Bo3JbcFBWVsw==
X-Google-Smtp-Source: ABdhPJzhzNtE/cffFwhVnJUH+s+CDFtcddzd6P94a3O1rThPeYzdYWj+X7WwN40t6N9gPxfRptz+wA==
X-Received: by 2002:a9d:6ac7:: with SMTP id m7mr10742613otq.306.1639608919799;
        Wed, 15 Dec 2021 14:55:19 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id m2sm756880oop.12.2021.12.15.14.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:55:19 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ohci-spear: Remove direct access to platform_device resource list
Date:   Wed, 15 Dec 2021 16:55:09 -0600
Message-Id: <20211215225509.1995417-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory resource is already retrieved with platform_get_resource(), so
let's use it instead of assuming it is the first resource in the array.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index b4cd9e6c72fd..9b81f420656d 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -76,7 +76,7 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
 		goto err_put_hcd;
 	}
 
-	hcd->rsrc_start = pdev->resource[0].start;
+	hcd->rsrc_start = res->start;
 	hcd->rsrc_len = resource_size(res);
 
 	sohci_p = to_spear_ohci(hcd);
-- 
2.32.0

