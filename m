Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5844A4F53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359467AbiAaTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbiAaTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:21:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ADBC061714;
        Mon, 31 Jan 2022 11:21:32 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s16so13034293pgs.13;
        Mon, 31 Jan 2022 11:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4fgthDT3x2CEIImte/CKnYW9ye9UcnzsCmxp0s9Vks=;
        b=kOrsCyFpAdlSWDG167+C7QFyFhW+7sBYPpoG7/XQNbD+9GZndgkz0z77mTGVNW1cq1
         EUhG+hkVFqOp0nZrZNtaBifFQ09Wg8VjHs/c2eXSb7XqHGh1QPW7wnabEXLko9U7RBC5
         PSPOtWzlkL9I61L5OeD0sgGYYlyyaXmMUsK1dnYSdP5nApm/D/8gwmGz9/rYrkZ4kba9
         YRmJZZA80yAIA/3PHjemRIbzOPfXAb/gU9n10q2I/jNKt2iuBkY4zPzBma0ySwrjxoko
         U3032YumaOeEZ52NqHiGcrUAYq0wOCVmKfJXY+D+3GqLAQGG3SUkAHRSB5Hg/Tr54Xju
         aPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z4fgthDT3x2CEIImte/CKnYW9ye9UcnzsCmxp0s9Vks=;
        b=X65hg26yvdi8cE6xiH+BBhYXzsondylB3OK3Kxaemokci4plX5uR8rVCW48/6QelZ9
         NkzfAnDwyBMiykDYr4wyqB3MLpIb1ntXOJmP149MW+03HdaM4XF1DnJ+ag7Pzk2VoVqK
         hYv20JxT36A/O2N4ZhdUtStg/iACFAvyo09ZDQUkwxsKwSI7h0cKPzcld3PkQrSm5rEQ
         H1Xs+2lM6+3X/xOF7Ta6YUkSyD7uoEzPJHm4L6gnmckPjS5SYsjPYRndtQHWuSgJa8Zw
         +eJLqV7Q1C1AijMHSBGUuwdOBzjvK+xrJV6BjN32WfAyuLjv47Y9p28u2PJ0TGa/7B+y
         o1Gw==
X-Gm-Message-State: AOAM530yrnejVWVe7XWIslpeMDlN97qX6tSP6vqQzLzY0ErqgnI9Sbry
        l5S3HUXtbxUVlHFaPvPHBBpOsA5sx+I=
X-Google-Smtp-Source: ABdhPJz0bFZQaFHN5cN/+A5kKAOeKb3894s7s0ePyGNqTjez/HVKmyHjmkHluopPQ5990K4WlN5fqg==
X-Received: by 2002:a65:6296:: with SMTP id f22mr17602402pgv.320.1643656891836;
        Mon, 31 Jan 2022 11:21:31 -0800 (PST)
Received: from charizard.lan (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id n2sm29791218pga.39.2022.01.31.11.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 11:21:31 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Thinh Nguyen <thinhn@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: Prioritize extcon over USB role switching API
Date:   Mon, 31 Jan 2022 11:21:02 -0800
Message-Id: <20220131192102.4115473-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is necessary that:

   ROLE_SWITCH && device_property_read_bool(dwc->dev, "usb-role-switch")

is true in order for dwc3_get_dr_mode() to _not_ force us from OTG to
PERIPHERAL mode here:

   if (mode == USB_DR_MODE_OTG &&
       (!IS_ENABLED(CONFIG_USB_ROLE_SWITCH) ||
        !device_property_read_bool(dwc->dev, "usb-role-switch")) &&
	!DWC3_VER_IS_PRIOR(DWC3, 330A))
	mode = USB_DR_MODE_PERIPHERAL;

and dwc3_drd_init() to be called later in dwc3_core_init_mode(). So,
to avoid always ignoring extcon device returned by dwc3_get_extcon()
change dwc3_drd_init() to check and use it first, before checking if
dwc3_setup_role_switch() should be called.

Cc: Felipe Balbi <balbi@kernel.org>
Cc: Thinh Nguyen <thinhn@synopsys.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

Hopefully I didn't miss something important making this patch
unnecessary. Don't know if this is a good solution or not, part of me
thinks than maybe changing the aforementioned code in
dwc3_get_dr_mode() to account for extcon wopuld be
simpler/better. Happy to rework this.

 drivers/usb/dwc3/drd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index e2b68bb770d1..835bd0be87d5 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -579,12 +579,7 @@ int dwc3_drd_init(struct dwc3 *dwc)
 	if (IS_ERR(dwc->edev))
 		return PTR_ERR(dwc->edev);

-	if (ROLE_SWITCH &&
-	    device_property_read_bool(dwc->dev, "usb-role-switch")) {
-		ret = dwc3_setup_role_switch(dwc);
-		if (ret < 0)
-			return ret;
-	} else if (dwc->edev) {
+	if (dwc->edev) {
 		dwc->edev_nb.notifier_call = dwc3_drd_notifier;
 		ret = extcon_register_notifier(dwc->edev, EXTCON_USB_HOST,
 					       &dwc->edev_nb);
@@ -594,6 +589,11 @@ int dwc3_drd_init(struct dwc3 *dwc)
 		}

 		dwc3_drd_update(dwc);
+	} else if (ROLE_SWITCH &&
+		   device_property_read_bool(dwc->dev, "usb-role-switch")) {
+		ret = dwc3_setup_role_switch(dwc);
+		if (ret < 0)
+			return ret;
 	} else {
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_OTG);
 		dwc->current_dr_role = DWC3_GCTL_PRTCAP_OTG;
--
2.25.1
