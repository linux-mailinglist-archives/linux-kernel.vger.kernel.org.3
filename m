Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3A4C47F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242024AbiBYOzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbiBYOzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:13 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E6922558A;
        Fri, 25 Feb 2022 06:54:40 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id bm39so4697897qkb.0;
        Fri, 25 Feb 2022 06:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAvP0iQoBy21i3qD7tVUxZCHh5iSPEaSiol2a9udnKA=;
        b=aNLFGsj4FJmueFuo2LVRjfiHSM0zLdvJGEAw2sKF1E0sl1LCQd+CYUZnpd6yR47jhk
         Gwi3OgUlxLj3+Vr7WteCi5fJo+BRXUKp7qFfoakdnRNStlgxojsEyP4KJonfuXCAqNFA
         vAVprF126cPhPwk4JHZjgPBZnxbRS1nnQxEt4f1DjkxuyFc2vAp2ChwkJeOTS5L7PlDE
         awaAUe+FhpN3GfKlV93MNcP1TmDKrdqO0tgiLN6pG7BBUVORorVGLl5RnLR6lKdl1A7v
         zUJSY1NYonl8l+0whl+SWfiP2ISdXYYJqpTpE8mufcOi6+4ZO9k/vLXTTqYLbaRsrP+t
         JCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAvP0iQoBy21i3qD7tVUxZCHh5iSPEaSiol2a9udnKA=;
        b=cNFwSznCw2MkTdMwW5UVST5rCLpEYfBvD1VeTIR/mrEvOUFdHF4Jlys8m/FpE/fxco
         +sdOnxHrrdhz3LaweIqjBa/2XIu9m0DdAfaaVxod0qUPpnAMH4uRlmzmullbFXEGHRNL
         3ynfLfuJKo7iDmJhYaTFm0v9liVsszQbeRMJqnyDk1qOfJsbNT7kmOzLQZw55i7QG5Th
         joWfQvEr6dP8oM3TIKCY4PyhERv1jtMqDR8IuvANWEtujMz241Q6kYVc273zEhC3Adci
         9KY6zhiY07u7KG3/Tf0tZwmq0k3c1LRwJzim5nPuibZ90YrG/Ozfn/LwhIccrdj2YJmO
         d+Og==
X-Gm-Message-State: AOAM532V+G880+cS41++gx9xheWh1PQ9ynDz1Bi3JoCORjTyjwtFjX9K
        nkdo303WL+rz79EnqBfpPhA=
X-Google-Smtp-Source: ABdhPJyx3j8sQ1IUhKaQb6ADND8qxpw70u/EON/lG+Roz4kKFKjOLC80o18/WD04ZC5t7L6fH4HJRQ==
X-Received: by 2002:a37:ac0a:0:b0:60d:d66d:e4cc with SMTP id e10-20020a37ac0a000000b0060dd66de4ccmr4938522qkm.10.1645800879750;
        Fri, 25 Feb 2022 06:54:39 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:39 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bin Yang <yangbin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/8] usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
Date:   Fri, 25 Feb 2022 09:54:27 -0500
Message-Id: <20220225145432.422130-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
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
 drivers/usb/dwc3/core.c | 4 ++++
 drivers/usb/dwc3/core.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 18adddfba3da..032d40794fae 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1167,6 +1167,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		if (dwc->parkmode_disable_ss_quirk)
 			reg |= DWC3_GUCTL1_PARKMODE_DISABLE_SS;
 
+		if (dwc->maximum_speed == USB_SPEED_HIGH ||
+		    dwc->maximum_speed == USB_SPEED_FULL)
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

