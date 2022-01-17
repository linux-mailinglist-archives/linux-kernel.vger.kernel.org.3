Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FEB4901CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiAQGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAQGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:01:44 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0042CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:01:43 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso29155664pjo.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=9nmGSMsNg7TpxFokhDu2M3YQG+slmr+fovI7GFM6KVY=;
        b=iRTT4mTT5f1JQ5w0wUvrSV16Y5UDiUO1mVCE5/mlInMIjd6sKt/7tNNHXKf0wRfmNm
         AKuj7JjnpYCNvEpTf9VfNr256jPLicl3NVOunXMiFXsI1GS41KKHTuZP2WmzALqFrmaV
         wK6KjsQHEFlmpgQ4oSVg1UAc93xi43Jm9o63AzxTjTg2jfNVHsTZ0+dX4vE5Au4HVXzk
         vL38KcJ2QXJGlMHbTHH+tiB+NL+IrQvrm02dTXLCPhH42FymHhH157n/Llf+Icx078ve
         HPmM16CDdTvqR5KNPILIUkesMlGNjAtvuq72Cptk0uvKBntxuw45D4AMCtrOmZqnIXxW
         RqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=9nmGSMsNg7TpxFokhDu2M3YQG+slmr+fovI7GFM6KVY=;
        b=nUtc5TMDQmHGvAobXcEIvTKILFMD14Vyn/g4/PB6u6Ec6r1DaL3GNoillnCnrkVGem
         aXCy3GlHKiqF2pmyqlumxBqlpb69V0sbLRqChT9btX6+55gsKvOdLaiBwMIaiqfJ1lem
         F3NvUITHyHBuv6jZkslup/J42rESl1g6JiKb59jzcfqJSPaiOCxU2cmzpQn8JWhPlkRg
         BAS2xJ/04e/R0FZzpspoqnvTIEsVMnBdgkzDNU7MFUsdhCSXF0fL4oxLoyaULxhnzJZ3
         a/L7IhjyVz98aT2IeLyYjVx3sB10FNRBCDyqT61DNSE1KdielExXUO/sAV+gaS/EJywW
         x3rw==
X-Gm-Message-State: AOAM532jk1Q0pRdqTs67OtdXUuDx5hIujKEN0nCuPp/CSnif3eo10nLx
        +tQ0sshm1dSvexc4lEAl1I4=
X-Google-Smtp-Source: ABdhPJxV8pjGiuIn2t9jdM5gDt/vpH51KFiyyYnlex25bCokaNm0pQ9bIpQrOjQP6abfjsc6T82l2A==
X-Received: by 2002:a17:902:8b8b:b0:149:66d6:b034 with SMTP id ay11-20020a1709028b8b00b0014966d6b034mr20674789plb.129.1642399303478;
        Sun, 16 Jan 2022 22:01:43 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id k8sm13464707pfc.177.2022.01.16.22.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:01:43 -0800 (PST)
Date:   Mon, 17 Jan 2022 19:01:38 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: pi433: change order in which driver config
 the rf69 chip
Message-ID: <20220117060138.GA11140@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117055849.GA10644@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is an explicit dependency between modulation and bit rate
configurations. To ensure proper validation of input value for the
set_bit_rate routine, we must ensure that modulation has been set
before.

This patch ensures that set_modulation is always called before
set_bit_rate for both RX and TX routines

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index f9f86e2c44a9..17ff51f6a9da 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -167,10 +167,10 @@ rf69_set_rx_cfg(struct pi433_device *dev, struct pi433_rx_cfg *rx_cfg)
 	ret = rf69_set_frequency(dev->spi, rx_cfg->frequency);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bit_rate(dev->spi, rx_cfg->bit_rate);
+	ret = rf69_set_modulation(dev->spi, rx_cfg->modulation);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_modulation(dev->spi, rx_cfg->modulation);
+	ret = rf69_set_bit_rate(dev->spi, rx_cfg->bit_rate);
 	if (ret < 0)
 		return ret;
 	ret = rf69_set_antenna_impedance(dev->spi, rx_cfg->antenna_impedance);
@@ -290,10 +290,10 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
 	ret = rf69_set_frequency(dev->spi, tx_cfg->frequency);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_bit_rate(dev->spi, tx_cfg->bit_rate);
+	ret = rf69_set_modulation(dev->spi, tx_cfg->modulation);
 	if (ret < 0)
 		return ret;
-	ret = rf69_set_modulation(dev->spi, tx_cfg->modulation);
+	ret = rf69_set_bit_rate(dev->spi, tx_cfg->bit_rate);
 	if (ret < 0)
 		return ret;
 	ret = rf69_set_deviation(dev->spi, tx_cfg->dev_frequency);
-- 
2.25.4

