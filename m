Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49189497611
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 23:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbiAWWlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 17:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiAWWlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 17:41:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7227C06173B;
        Sun, 23 Jan 2022 14:41:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso33026639wmj.0;
        Sun, 23 Jan 2022 14:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FnoUpruS07e9SliOMBRd2B9mJrCRv0Zfw7LhMPxVu6s=;
        b=kg0Jqz/pJCi7QBRbj36+52ElSW/YbjVvXQdKUmD/cL0yPHmnl/NlfGzaPESB3mFixz
         IJZ9JRIuWZ43wnrQ834ZfNT9dIbFnot4jNSHwYk7D6IBLDQ6JqrTsSZqSWKblEDl/WFl
         mXWSJGYK7M07ulzXtyMs7Zpv7hqLbXk0zmy1R7a6M+y9UNECqJm+9/XdBCuwh9bVnBE1
         FGqwnsRg85Q0YX/vUVZME2T4vycLKom1sLxwS076lwlk8qeTaSZk4R37TjubW9hoNUVi
         FSBqSoZh6emLtfpu2agRJlprOXN8lw+ZFt0mvBFGlhbus5WILA+4mCqT5R9w/pkWEajG
         Vecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FnoUpruS07e9SliOMBRd2B9mJrCRv0Zfw7LhMPxVu6s=;
        b=ht8+NV9KfFKM56TKlpbPIrrj97X6GZmrxrg37vHdtf/JWp+bzryxM9S4tHIhZxO0VV
         S64GKlCpGeaF1MXNrJ37cCkMAmqwAdRIaXg9c2iCt3AfseVe/k2BkReLYIkoMyvs5UHj
         B/pG+sykY0+KtMGsS1z7SoIisQQasSMiQIUV4toI9vskMAu1W78IheCxkF3TmzXHMvvu
         X5C2RDg5WitwAFigGWWffvvzulYYckjlO4Wj8Nwf3Shb/UykTkiFSM7LvT3uTtb9X7+c
         jyUJVnR4cAP2a88whqJfxo7614H1lhOk55tP7T7R29IL2b8iIxRDN400n+2EdbjbEMqM
         kDvA==
X-Gm-Message-State: AOAM530Mtb+QcdE4NAgkLHJDqdNM6CFPbXLWPRaFZT9rZkbP18Ef0TfA
        QYZnwHLbrGWddUfrR1lRObDprJ7yEGyhww==
X-Google-Smtp-Source: ABdhPJz/GDl8nKFqCDuTOIS5Tcd/O6yx8D7cCNU/Us+Wog3rwAYnPRWhEjqSgv2MF06UW9JNew6h2w==
X-Received: by 2002:a05:600c:218f:: with SMTP id e15mr953069wme.187.1642977704477;
        Sun, 23 Jan 2022 14:41:44 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v124sm17395157wme.30.2022.01.23.14.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 14:41:44 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: magellan: make static read-only array nibbles const
Date:   Sun, 23 Jan 2022 22:41:43 +0000
Message-Id: <20220123224143.6583-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The static array nibbles is read-only so it make sense to make
it const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/joystick/magellan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/magellan.c b/drivers/input/joystick/magellan.c
index edb8e1982e26..653a09362a1e 100644
--- a/drivers/input/joystick/magellan.c
+++ b/drivers/input/joystick/magellan.c
@@ -51,7 +51,7 @@ struct magellan {
 
 static int magellan_crunch_nibbles(unsigned char *data, int count)
 {
-	static unsigned char nibbles[16] = "0AB3D56GH9:K<MN?";
+	static const unsigned char nibbles[16] = "0AB3D56GH9:K<MN?";
 
 	do {
 		if (data[count] == nibbles[data[count] & 0xf])
-- 
2.33.1

