Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0007D58F460
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiHJW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHJW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:27:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D0C8D3FA;
        Wed, 10 Aug 2022 15:27:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id v14so6734039qkf.4;
        Wed, 10 Aug 2022 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=Ei64+VEKclLsM5qrzZu0dqiqpVuMadQ8WSJ6SrSoMJY=;
        b=JgYGzOHH4+2+22+5NR2HmYc0TEyXYdkb0a0S/KfVY5qMNUAD5zsxchwOlk2JuQd3hZ
         iCp28MYSI26L6kswEHZ8a+1b5k07EWT1Cwgr4zmYEtw3y1Bc/4Vj9b69WlggOg3ZlXnx
         MK2dI/FJ8uZE6uqXVSKDky/5ziX7kuP2dlwO26Oe77GUP2vjclSh5N/bZ3y5DrBLH1PB
         5Br8wZZ4BKs0RndGX/cpu8p4jIbu8aYhBWpHTax7K+jym2Hc83Zo0eb8ZElTvRwoiN2v
         wkMfiqdvIbHLj7iqbhQJ3nLl0e5heK1q4lVaOITTNuJJ9YseHr/YGJtypeuCZZ4ULPcB
         X66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=Ei64+VEKclLsM5qrzZu0dqiqpVuMadQ8WSJ6SrSoMJY=;
        b=2wD0wwmFLFAQnnbgTBOcs7x/O8jD/9AQQMip32Y0Jg5EY80F3dQxUqBrKKYA2yxE5n
         JvBlEYeX5vAT7ABH97a25+dEDMk8blr5DotbgzavyIa3Zak86lWY7IX8i6XcNmHjpa4c
         mVm3G7YtvxGhCFy5ef4z/jQQdG81Ud6ttVvvFA/VMKl9SQmYxexRdK8/psKPRESwkqeL
         JwQioU5DP51iv81GsH+S09diiqMXt5NDGE1p1VrLRYX/WGQOE2eJ9+anAUkEeRprwXAh
         dm+kdKGxIEAJmlk/wgVa9QOY10vrAMeuE4VgMEb3BocAaOpvd1xnPuz7J84K831earB0
         jtXw==
X-Gm-Message-State: ACgBeo0u6Y9JnTezmH0CBb1Dn4YRsjX+jC8ionvI9/nLTGD28YldZXTe
        22rdmp8dpJ2rabkET+rYUkw=
X-Google-Smtp-Source: AA6agR50XJB9h9WsazxCCIGr0gHClGxaGHEb1eg6mB5hZVbDIzoOVOzmh+X/i3ghnPKMptLQCn2P2w==
X-Received: by 2002:a05:620a:28d4:b0:6b9:5667:46ce with SMTP id l20-20020a05620a28d400b006b9566746cemr11364761qkp.216.1660170469452;
        Wed, 10 Aug 2022 15:27:49 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y29-20020a37f61d000000b006b8e8c657ccsm711341qkj.117.2022.08.10.15.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:27:48 -0700 (PDT)
From:   justinpopo6@gmail.com
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 1/2] usb: host: xhci-plat: suspend and resume clocks
Date:   Wed, 10 Aug 2022 15:27:34 -0700
Message-Id: <1660170455-15781-2-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
References: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Justin Chen <justinpopo6@gmail.com>

Introduce XHCI_SUSPEND_RESUME_CLKS quirk as a means to suspend and resume
clocks if the hardware is capable of doing so. We assume that clocks will
be needed if the device may wake.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/usb/host/xhci-plat.c | 16 +++++++++++++++-
 drivers/usb/host/xhci.h      |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 0448558..a68b2b0 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -432,7 +432,16 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
 	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
 	 * to do wakeup during suspend.
 	 */
-	return xhci_suspend(xhci, device_may_wakeup(dev));
+	ret = xhci_suspend(xhci, device_may_wakeup(dev));
+	if (ret)
+		return ret;
+
+	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
+		clk_disable_unprepare(xhci->clk);
+		clk_disable_unprepare(xhci->reg_clk);
+	}
+
+	return 0;
 }
 
 static int __maybe_unused xhci_plat_resume(struct device *dev)
@@ -441,6 +450,11 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	int ret;
 
+	if (!device_may_wakeup(dev) && (xhci->quirks & XHCI_SUSPEND_RESUME_CLKS)) {
+		clk_prepare_enable(xhci->clk);
+		clk_prepare_enable(xhci->reg_clk);
+	}
+
 	ret = xhci_priv_resume_quirk(hcd);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 1960b47..182d1d4 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1899,6 +1899,7 @@ struct xhci_hcd {
 #define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
 #define XHCI_BROKEN_D3COLD	BIT_ULL(41)
 #define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
+#define XHCI_SUSPEND_RESUME_CLKS	BIT_ULL(43)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.7.4

