Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567E647D0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244574AbhLVLSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbhLVLS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:18:29 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D77C061574;
        Wed, 22 Dec 2021 03:18:29 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id s15so2082918pfk.6;
        Wed, 22 Dec 2021 03:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=AudhrVtPds+UwnXofwiLV9UBGSO5lD3WwKy0WzfA4bc=;
        b=mhSvBAqM6Jynn5ZcJKLxMiQ1QgWotix5caEqMK4JyhoK0IcicthOWfRfWRzw4mT+3w
         cSEXUBbCOrGpkqVb5vyiT2IDRN7+w5jDkwDy8iw+YwttU3kAFbd09bI+hgqPpyX/tVDP
         Hnlwz+NsbJwxavah970ej3udVZxQJhwkc3Ge3LuLm0iGFjyuONwaAsnhLdjnhyOzd71h
         f1DCOIhEUQzHTyUkkBGp3S1iHGTyTa2AaZLAHKq+XXtJKprqdDJwRw3y6exOhUDAgKZu
         a6xuVG54XpJjnTL2w82WIayhx0NlIZa9CL1tLtksYl8Mx5O2LDpcz/NRdNBikE00nXHb
         9diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AudhrVtPds+UwnXofwiLV9UBGSO5lD3WwKy0WzfA4bc=;
        b=4UYn/FBxA9Vctuan6rTa84SJYpQJ+2liLKV+BLUUSOJjyyvQGtXAZ8OJ9mWkfi9qe3
         o4CDfsJvDtAb6f5tywjQy/1bIW33EzGjcijR34asze0oYqgEwyKLeHwM3JL+m1jCkaO6
         jVjoVipFJxXwwDYx+1jqxfGQ9mEzDJUPOUbYvGog9vLPUAGAlo3o7JlCdRGo6HjGAyB7
         JEYhtRwUHEJlq95py9O/CF8OVMrdBjDrhM7xdvXyHFAOnrxjyIozu4TACpyG9cMAz1Xq
         u/9cq6imGOloFsQn1dlfGTAaMjehasrmCmW2Mac8xyc2/yCKDzJHCx3DmWGWISH7kceQ
         ClzQ==
X-Gm-Message-State: AOAM530dfWqAGTTV55B1E7yXTaZTqgDZoVLwDXuDgP7PYU/L/JANeu/1
        SJa8nOra5ndCiB3wsmemgV4=
X-Google-Smtp-Source: ABdhPJzKe6KBOuJOT/xf2DPVJWCeYaxVc0Zf4vagg6iQwXB/52SH6biT9PdfzCtUDiYR1fMPeVyi8g==
X-Received: by 2002:a62:6042:0:b0:4bb:86a:c05f with SMTP id u63-20020a626042000000b004bb086ac05fmr2432034pfb.64.1640171908910;
        Wed, 22 Dec 2021 03:18:28 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id ng7sm2230478pjb.41.2021.12.22.03.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:18:28 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe
Date:   Wed, 22 Dec 2021 11:18:23 +0000
Message-Id: <20211222111823.22887-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the acpi_create_platform_device() function may return error
pointers, dwc3_qcom_create_urs_usb_platdev() function may return error
pointers too. Using IS_ERR_OR_NULL() to check the return value to fix this.

Fixes: c25c210f590e ("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
Changes in v3:
- use if statement instead of ?: .
- Add space in Fixes info.
---
 drivers/usb/dwc3/dwc3-qcom.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3cb01cdd02c2..b81a9e1c1315 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -769,9 +769,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 		if (qcom->acpi_pdata->is_urs) {
 			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
-			if (!qcom->urs_usb) {
+			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
-				return -ENODEV;
+				if (!qcom->urs_usb)
+					return -ENODEV;
+				else
+					return PTR_ERR(qcom->urs_usb);
 			}
 		}
 	}
-- 
2.17.1

