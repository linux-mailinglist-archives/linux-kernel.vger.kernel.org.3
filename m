Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9276A47D03D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbhLVKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbhLVKrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:47:10 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F97C061574;
        Wed, 22 Dec 2021 02:47:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g2so1767623pgo.9;
        Wed, 22 Dec 2021 02:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2xrtYmdK6psZ2un6fT2FNi1Yoram+Ai7iGKYwtN1gQg=;
        b=l4EBBJ2eeDjnV2ZrZ30lFX+MyetiRbFN1DZkq3f5M8NZiZ5uyA0gSTOU8/3qxqnWVa
         SIXhVU9uQDsluB7hpribGBVUIZSnapqMH+KTEUxmpE58WnZKiSn0uY7H4q+JJUKvIwNy
         NqDCKrH8QXrOHouZB34eRHB3+Emjmcxdm+6KPgkk13qJx465g4Fae0Rul0ODyJM4/5+b
         8laWKaA7FNA5/4J0+ZTlS47pzZa1Xs2YdtnFkolPWrGMZ3p1VBe1a1W6nMLSLclFuzGl
         dgOGi1uMwNTE/2wmEhlEP3DYgVVjlZ/10iqxzvebeW2d0/ph3ff38c9Y3ArGiY/lf4dY
         MSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2xrtYmdK6psZ2un6fT2FNi1Yoram+Ai7iGKYwtN1gQg=;
        b=e3Toh/QsVZqMMkd5MdqVjTNjcl1AYou3ozjc0zhlW0iXSGgiR0Cf/7o5tJR+CNkjmG
         neyV+3xs/ET3Bva9ICMLOfNMQeprwKU7oZ5QghdIVUI2CXWEeq9RXr8OZBel0tMihFvr
         yRJYxDdAY3HhyTVmDLJpwscZwY917UWuK0XyRR0rc+r56GjGbU4lSXnmv7XJnt56vwdm
         gENMUwm/suBrz9laOmKNHao+Ccd/G+8/Zb5WoxkMfAhC0CDuRzYa5Mdv88wh1uDNXnte
         vuFsPhyvyxZyY0fMHBXeuUknR17ZmR+o4BjnJ5E9nBy2JTqtKBXh/K9nJ8zN+bqmc/q7
         ul4Q==
X-Gm-Message-State: AOAM533daUjEiuMvAFIoLjzeTsVKijEw1KZLi7fKxF435rGlibh9Btnn
        inOUCDliDGCMtD1r+SWDmRQ=
X-Google-Smtp-Source: ABdhPJyIXniOMacDP8bh10DoBgk9Lgk/oya66FSXeYFxxZMlcIgB0qbK5fdvJaPuNw8dLWfzp9qefw==
X-Received: by 2002:a63:575c:: with SMTP id h28mr2237329pgm.171.1640170029448;
        Wed, 22 Dec 2021 02:47:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id h22sm2545221pfv.25.2021.12.22.02.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:47:09 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe
Date:   Wed, 22 Dec 2021 10:47:03 +0000
Message-Id: <20211222104703.10241-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YcLwh06Z/1hBG6IY@kroah.com>
References: <YcLwh06Z/1hBG6IY@kroah.com>
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

