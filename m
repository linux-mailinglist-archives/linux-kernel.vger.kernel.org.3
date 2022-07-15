Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504E6576A41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiGOW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:57:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE2491EC;
        Fri, 15 Jul 2022 15:57:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1704099wma.2;
        Fri, 15 Jul 2022 15:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iDuUrXecTo/5CLMh6hS+IBr3gNGTsk+em0csSjnMpE=;
        b=ZnRywP2ewSD66DsCeKs4r3iEe0UVAly9k/pTZUDcwlH58IT+qm68QqzmVR/Y90doys
         /Z+xx+w9BY2mvwMZuV8h3gVELBZVABLiKMRoV1I//h3Ht9bP3st2Bw624pEETRbvcyTH
         qpMXimPzfMh7kXQz2GwVKjojoncxOz3HCN21ph/iCEncCwISUikBcqiuhh9Ecnu/fAj3
         BPWG0Pf2NKg59uafn5fB2qK1ZJbcanfvsKqguFTBkOPFN10oXaI7udHXbipvk7hRT/1r
         g7UsTeUJuXoLgiWtVSDhaC01T2ur3miqw36COikYy5EiHwuXkwbII1db7k1qM/ibFNeX
         peKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8iDuUrXecTo/5CLMh6hS+IBr3gNGTsk+em0csSjnMpE=;
        b=Y7JCln8Tyh/8Xd9k1KagnZBz4SLYFaDVvW6pw+oY65v3XQjvhkJVp/h6uLbAlaHQhk
         iedM6hPUNaaoXDDLIZQO9v26Z5bBrmJnO/QC7kbi9roZUu+QMlhw8h2LN8zR60BiTvYH
         HCOGHf+zVAK+Y0J3lfVtKXZyKNq14lPNh5p2yIbbpW/Q2a+7k6u1u4Fc9aSXvFyfBesB
         UvK7El1KZsA+xTeU/I64cRWf0JXTahAQWezxVZY4BcHKEoFf1pvfiU9je4l/Pfsk+nb7
         Jt3GSu29yRRcNyqgiY0hjnCzJjwWN25vXn0iKJFGNzsbhehccBm8srD4xPeZrrF7X1Vr
         ukQg==
X-Gm-Message-State: AJIora8TzPdBJirepCaRwk3urouAthZ36XRhfIY3MhI91y+phQygVMdu
        uzjQSEPTBN4aVorRZQCYBNw=
X-Google-Smtp-Source: AGRyM1uAqhh721MvyJaDjyXpFyHlqsT9I6UWct5c9rsAnk+SVTN1xutiUnu/Fekz63LIXHAeSahCwA==
X-Received: by 2002:a05:600c:c1:b0:3a2:e9c6:46ed with SMTP id u1-20020a05600c00c100b003a2e9c646edmr22697227wmm.194.1657925823461;
        Fri, 15 Jul 2022 15:57:03 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p17-20020adff211000000b0021d9207e6f1sm4719104wro.34.2022.07.15.15.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 15:57:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: phy: remove redundant store to variable var after & operation
Date:   Fri, 15 Jul 2022 23:56:57 +0100
Message-Id: <20220715225657.353828-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to store the result of the & operation back to the
variable var. The store is redundant, replace &= with just &.

Cleans up clang scan warning:
drivers/usb/phy/phy-keystone.c:62:5: warning: Although the value stored to
'val' is used in the enclosing expression, the value is never actually read
from 'val' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/phy/phy-keystone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-keystone.c b/drivers/usb/phy/phy-keystone.c
index 358d05cb643d..f75912279b39 100644
--- a/drivers/usb/phy/phy-keystone.c
+++ b/drivers/usb/phy/phy-keystone.c
@@ -59,7 +59,7 @@ static void keystone_usbphy_shutdown(struct usb_phy *phy)
 
 	val  = keystone_usbphy_readl(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK);
 	keystone_usbphy_writel(k_phy->phy_ctrl, USB_PHY_CTL_CLOCK,
-				val &= ~PHY_REF_SSP_EN);
+				val & ~PHY_REF_SSP_EN);
 }
 
 static int keystone_usbphy_probe(struct platform_device *pdev)
-- 
2.35.3

