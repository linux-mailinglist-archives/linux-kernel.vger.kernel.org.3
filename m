Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C3A4C6EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiB1N6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbiB1N5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:53 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5727D02F;
        Mon, 28 Feb 2022 05:57:13 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id 185so10335848qkh.1;
        Mon, 28 Feb 2022 05:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=axLq9ESk4KLwkRhxFwrsPb0IhXxAtdnSMp5bxmAzIv9jg7Ka+soIzf8ERaxP1neUMI
         x5AP662tSuRGrmnrT2/XP41iPtF0c53qMrnUAInWhVqdK5WK8i3tsGzEL3hTrVEobJ0s
         DlD0Wqa5Y7H1CmQEEJxiq1q/L4S+GS23T03gXXgzad+j40I1VR/O+Blqb8R7m/4qxpdP
         3j2kccWHmuoG8sCn7iNlt2c4hzleWmscG3jBeZ0id02XjkHXlZROaGU/DKvi709oLp7U
         5i8DRBkPj4conLmXDexlel3pRFEHcPn+9+J3bJcgNR7Hpq1Q9Kj9lH9/r3VBLNkbFJvM
         mKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=zJ0sdRffP3cW3tIJLFl8Sp6hRkeCsSLeIioX+WRdr4aWmPdjSE/LpqGTFXsLM/ztlf
         jYjrL/AOazXeFqxcSbk7rKrU6T1givz/bPgb2fCtFsdL6q1PSGepR7qAXYOdHZ5dlqDw
         +rRBDeu/R5Zyq+XD1PdA9EWlEbO5ZUEsxGIvXW/pQfveyTMm72o67mIvGcrcSOgR9NcO
         cFVTUnVBkfyIw0HQw2mnOSXFH5KY8FQOZHzaM3dd79mEfGKmlcUr189KqXnwyGOr/cKU
         F9BKjXgOeEx5GgOvh+p8bkhwBHS70RnBS/ixa7muB8W0lGy9/1TIPaF1SNsVWcxKxw2c
         CyUg==
X-Gm-Message-State: AOAM531nXspN+V+G7Vablar1OpCn6EAA/e3HUSzmBvU3jrPmaoNh9PSp
        HV++VFPQcQ8hVE54C7c0xvQQNSShdOOGpw==
X-Google-Smtp-Source: ABdhPJzG6wOa4TN1QLaAMRRFyvPIWxUudagzxS54MIfEGeVgC11S4FrJNmCjk/EhdBzDgihkBBzPzA==
X-Received: by 2002:a05:620a:138d:b0:646:d79f:84ea with SMTP id k13-20020a05620a138d00b00646d79f84eamr11333629qki.501.1646056632345;
        Mon, 28 Feb 2022 05:57:12 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:12 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, jbx6244@gmail.com,
        Bin Yang <yangbin@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
Date:   Mon, 28 Feb 2022 08:56:56 -0500
Message-Id: <20220228135700.1089526-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Yang <yangbin@rock-chips.com>

In the 3.0 device core, if the core is programmed to operate in
2.0 only, then setting the GUCTL1.DEV_FORCE_20_CLK_FOR_30_CLK makes
the internal 2.0(utmi/ulpi) clock to be routed as the 3.0 (pipe)
clock. Enabling this feature allows the pipe3 clock to be not-running
when forcibly operating in 2.0 device mode.

Signed-off-by: Bin Yang <yangbin@rock-chips.com>
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/usb/dwc3/core.c | 5 +++++
 drivers/usb/dwc3/core.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 18adddfba3da..416d83a055fe 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1167,6 +1167,11 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (DWC3_VER_IS_WITHIN(DWC3, 290A, ANY) &&
+		    (dwc->maximum_speed == USB_SPEED_HIGH ||
+		     dwc->maximum_speed == USB_SPEED_FULL))
+			reg |= DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index eb9c1efced05..ea3ca04406bb 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -259,6 +259,7 @@
 /* Global User Control 1 Register */
 #define DWC3_GUCTL1_DEV_DECOUPLE_L1L2_EVT	BIT(31)
 #define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
+#define DWC3_GUCTL1_DEV_FORCE_20_CLK_FOR_30_CLK	BIT(26)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW		BIT(24)
 #define DWC3_GUCTL1_PARKMODE_DISABLE_SS		BIT(17)
 
-- 
2.25.1

