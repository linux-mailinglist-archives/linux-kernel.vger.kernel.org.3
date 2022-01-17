Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE9948FFC6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 01:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbiAQAoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 19:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiAQAoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 19:44:02 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D85C06161C;
        Sun, 16 Jan 2022 16:44:02 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id k15so58577626edk.13;
        Sun, 16 Jan 2022 16:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyTjsYAqJre6WBuJN2gLwpHyZHUA9DXs/0qZoICj1G0=;
        b=jQuaq0y+O5L6GO4bjUCOQ9A/Mg373V15MBKhEAX0Rvrk8AUTttyNuRg//wLxc/dQXQ
         W9c5Xrweqcw5rLf/YZ4xbsI+VXMiwauZCA0Bdehno9ZK2tRWkQCdXIslj38ZguicXNzP
         H9FmrocNbwh09OEt+81WwfhVfTCJcpxFvwHOz/r2UDIGCH30GHQLpObvPGLycQunuQ1u
         2NfhuTJaZ5tSj1tR+1kgX5veWd6+bNaObmTDLcO64OA3RiFfCrq+9oOOaaJGAM9NJTvJ
         p+gzkGsZTw1HWPeHmQvZ9lJ62S58Z/oP1Fz3BhXHITVM2KGcPbs+Y0YohUEQXPIEyCZX
         y/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyTjsYAqJre6WBuJN2gLwpHyZHUA9DXs/0qZoICj1G0=;
        b=n4tGOnP7gEE4oHFoYyHFy6/knimq05rTEqUKYzyQE3tCmCczkzCA3EVCWUuUgprYht
         yahn0X0rzQtq3MS1kV+aV6rQGqDkZ9IG18/7Ewmf+ADDoFbFA2SAqTejWIVZQGfE6MuZ
         JcON3fSvpqH2KvQykhMExeVh/h/nsj5GFx6zr/XZsGQ3HC/rGVhQPwecQ3l7tACUGCQZ
         lhFMGgi0QFlQbFi//xiGsxkv9W7gvTPG8pTLbRtCNjFZwW1oQTFqhK32le+lo8SD/WtP
         4gOJvfx/Sdn61evdlmI1O0SYcV3idUykqyARicjQuwShmXKgAiBlKE2tC8sylZE1euAJ
         66Hw==
X-Gm-Message-State: AOAM532Wv07+Ip0rsfs2sM+0IWwIbcJOGEQVKOakF9dq4kjogcfS/P2s
        /i5QWF1r4NOMb4wFIseuLmw=
X-Google-Smtp-Source: ABdhPJycHDJDK2wIcZ9MrKh20kbDlM+LzNtCQKuPryr8jJpJPvyJUwDwk9l2Zpc42McZ1yARtziNUg==
X-Received: by 2002:a17:907:961d:: with SMTP id gb29mr14852565ejc.123.1642380240431;
        Sun, 16 Jan 2022 16:44:00 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id go41sm3879266ejc.200.2022.01.16.16.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 16:44:00 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] drivers: phy: qcom: ipq806x-usb: conver latch function to pool macro
Date:   Mon, 17 Jan 2022 01:26:41 +0100
Message-Id: <20220117002641.26773-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220117002641.26773-1-ansuelsmth@gmail.com>
References: <20220117002641.26773-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert latch function to readl pool macro to tidy things up.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
index 6788e0e8272a..ab2d1431546d 100644
--- a/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
+++ b/drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c
@@ -112,6 +112,9 @@
 #define SS_CR_READ_REG				BIT(0)
 #define SS_CR_WRITE_REG				BIT(0)
 
+#define LATCH_SLEEP				40
+#define LATCH_TIMEOUT				100
+
 struct usb_phy {
 	void __iomem		*base;
 	struct device		*dev;
@@ -156,19 +159,9 @@ static inline void usb_phy_write_readback(struct usb_phy *phy_dwc3,
 
 static int wait_for_latch(void __iomem *addr)
 {
-	u32 retry = 10;
-
-	while (true) {
-		if (!readl(addr))
-			break;
-
-		if (--retry == 0)
-			return -ETIMEDOUT;
-
-		usleep_range(10, 20);
-	}
+	u32 val;
 
-	return 0;
+	return readl_poll_timeout(addr, val, !val, LATCH_SLEEP, LATCH_TIMEOUT);
 }
 
 /**
-- 
2.33.1

