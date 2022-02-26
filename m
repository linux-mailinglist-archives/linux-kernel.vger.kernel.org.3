Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E744C57A0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbiBZSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbiBZSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:42:36 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DFE1E64FC;
        Sat, 26 Feb 2022 10:42:00 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id g23so9331368qvb.4;
        Sat, 26 Feb 2022 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=ohRGljgT9n6KnhWzIuhLOYMf4bAC0dxu6b56hKPwmyQR2gsWwMTrz14Z51YO4pyzTp
         iLnS19UfDKhkgkv/iN6+wX8hVbk9GrLjjR1XSU/zfMnLNb4TRio7YbcyLP4Qxt1KQQQL
         UQKbxD+rgoKozrjZwohwOnOROk5jpDk0ma0XXbOqCoKJFcYwzVwtuIJptoOUvcpFz9Hp
         xpwShpVieevWiy289bGM3OikL75ksOKsxT4g8p0dNGP5ygFWTo3XhzBzME0n2Tz4U7V8
         bUnv7P/jvEhCjy7m1d3ythOsojy6Dt3RpC9udGp2AecZfpx6YRnFdxXiam/qzTVqKdH4
         Tr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JPaFw68OuUtIuwUUWQ/YAMH/m6245D2UW9piC4irepM=;
        b=gx9nRJbixMfHowclL+MJQF87zSaho9TkxgYFpILRdX/Qu0m0Ywnahh+ZO1hJG1zrZr
         P1ZX5wyyfFIft4GmjOKcrTpVqm7fYnuXMRPbK31R0yiyL1FP7+yfNDTmaXIbcc1l0Q3L
         6op7sRXmrRbDZwXII/0sWg57OWKoFUg5ooylJsLGkLgt7HX2ElxxONlqOYdoYRd3o7jS
         o1yh24K1goadc/qaZ/x2rqCOJu5K8I4jTz9oCKjHRHT67iqg7YFrZE9kIPsAZvEISTd3
         1tHi2sBdisY8b9GYyzf05Cl5H5TO8aDynCqlvt7UXJcPOLu2A2pR0OXjE4D68vvc9qNZ
         57AQ==
X-Gm-Message-State: AOAM531rrHZrCxuOYiLOUUp54eMkgr8GK/4C1yNn/D5ruEiCbOLlywN7
        RmyaUP9YlW4He4Nzx9CLOYU=
X-Google-Smtp-Source: ABdhPJwJUDRCCIp2NWBMNr9lFrQqnh7qaiYPDRkqrxmJD+kt1LzNR99zq5nU9nI+38qgTE3HZz9VZg==
X-Received: by 2002:a05:6214:1c8e:b0:432:4f21:aedb with SMTP id ib14-20020a0562141c8e00b004324f21aedbmr9584724qvb.74.1645900919471;
        Sat, 26 Feb 2022 10:41:59 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id p68-20020a378d47000000b006491d2d1450sm2891983qkd.10.2022.02.26.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:41:59 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-rockchip@lists.infradead.org, heiko@sntech.de,
        michael.riesch@wolfvision.net, Bin Yang <yangbin@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
Date:   Sat, 26 Feb 2022 13:41:41 -0500
Message-Id: <20220226184147.769964-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226184147.769964-1-pgwipeout@gmail.com>
References: <20220226184147.769964-1-pgwipeout@gmail.com>
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

