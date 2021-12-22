Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4970A47CEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243810AbhLVJOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbhLVJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:14:51 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D6FC061574;
        Wed, 22 Dec 2021 01:14:50 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o63-20020a17090a0a4500b001b1c2db8145so5198667pjo.5;
        Wed, 22 Dec 2021 01:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OSssIMDDFqUl1GaxKIZoLI2sUJGkDJOGUapWzIMb5/8=;
        b=Cvr73gx342I4ibMWljPtMFTugqY8eShifSiun7fCw+d657o27NPMycuHCQDePGeYOA
         jmbL/qL6VhH5kLzKvYZv9gQOHDp+n8b6uZLxwBZpB0uHgWRSnpYLSFnFbpq+01I5W5/K
         GFmA6sYdHnh5FbiDPCFWlGsx41XepiqH8j8BF8xBTCPKY+e0e+InD3Me+s0qx24auBq+
         mVsfkgaI56Ga6HU3c4fwPrNyr70UjNtKLqDn8Xy7md0oDLQKOBkbXuf6Wv5kSYyU3vZ7
         ps1LNINxpSMnxxs3YL6JwnADc1dJ9pyWTnXMRu0zfcEIcMlrBuFNKc0B6Jm/Ut3tQ6rP
         CVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OSssIMDDFqUl1GaxKIZoLI2sUJGkDJOGUapWzIMb5/8=;
        b=d/TyWbv590Ivegv4qN2utaBjMS4Cr+H8xJgNvA4C+OqsB1NkVCJfjFN5wIj+tYZlVb
         MdMCYb08zp+k/nOm1J8jT6BuOUYdz+UMgy0Hsh6vjxz/smSazmpJNhcmWslcYar1DE0e
         HFDQ/3VYHslMBy4/sr10CtvBxcWgNpkLMgZ5nfwBWLoZ5R6XgDzhW2nvkdcEYyUrxWaf
         +kFy2dcT6KhMKH9ZYrgU3D/gy8EF0tDIuFzpWgz2/z6QcbSo/h278v0l5MIxzOHRgDzW
         nqGKJKwUzlRbBf3wcz0uxwyzKqP0e5L6u06Zq8GF4XdvgOF1I+tHgDFyh5d3bywNsVfo
         geRw==
X-Gm-Message-State: AOAM533il7q8o/0om1R7nA2LTz/Q6tNo7F6l/Zo+95ptcW1ZL27gl4Co
        Hey1kTYX0BIGXu9JH8l+I/8=
X-Google-Smtp-Source: ABdhPJy5hR3/+cKJ6KiI6xkkeErNtWGkKFQ3XJfZrhmJhXWZYQgVOcxzwixbuEfCULkgbhqPkEGweg==
X-Received: by 2002:a17:902:e5c7:b0:148:dba0:2906 with SMTP id u7-20020a170902e5c700b00148dba02906mr1947995plf.33.1640164490052;
        Wed, 22 Dec 2021 01:14:50 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id k6sm1918550pff.106.2021.12.22.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 01:14:49 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe
Date:   Wed, 22 Dec 2021 09:14:44 +0000
Message-Id: <20211222091444.5034-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the acpi_create_platform_device() function may return error
pointers, dwc3_qcom_create_urs_usb_platdev() function may return errors
too. Using IS_ERR_OR_NULL() to check the return value to fix this.

Fixes: c25c210f590e("usb: dwc3: qcom: add URS Host support for sdm845 ACPI boot")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/usb/dwc3/dwc3-qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3cb01cdd02c2..df27d903ba98 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -769,9 +769,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 		if (qcom->acpi_pdata->is_urs) {
 			qcom->urs_usb = dwc3_qcom_create_urs_usb_platdev(dev);
-			if (!qcom->urs_usb) {
+			if (IS_ERR_OR_NULL(qcom->urs_usb)) {
 				dev_err(dev, "failed to create URS USB platdev\n");
-				return -ENODEV;
+				return qcom->urs_usb ? PTR_ERR(qcom->urs_usb) : -ENODEV;
 			}
 		}
 	}
-- 
2.17.1

