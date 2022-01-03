Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE334838C7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 23:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiACWXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 17:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiACWXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 17:23:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88613C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:23:40 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so38870173pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=7+eoPrWBnsqkg0fAIVFgS3RBVP3KC8VrN3JsKcU1B2s=;
        b=qtj9PmHsxSdp7OE/XuGTlwgKnbDoIUURq0wfKaiiDDALCRrdayT+9xjFEsWhI7vLb4
         BbqcGT88h0lVM5Gfh46Q6MeeC8rsy82tUVANZfyxwxpbXKDR7sFVsSqqmQ68bvyaxN+W
         BQG2+f2fBvjbYY1iHT9H43gb2QcXdNM55GQGslFN07n08CGDQ01OdZp/oDgX/3WXMdaR
         /1cgmXHqCrhTUYM1nueD53dfKAPck0BHMKbC5cnB/2ZyCBCLnCNgJvTVycS1Vpyaj7zG
         lAl5QDD7K53HeaEmFg4zoR5Y+lUDloz2CdBh0bQyDNsto8DUUxGVp6mdyy1EBDYCWbTc
         Q+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=7+eoPrWBnsqkg0fAIVFgS3RBVP3KC8VrN3JsKcU1B2s=;
        b=S1phbuinHC1tGMm/t9asFfz0RuWEP6ViREtrGrW7+KEdVCj4PBeZ6bLNv3vBzL8o43
         CDfC8Hqkk4bUgGheW0cRuWrtVW0N0hC0+5oByH9gfc6czywOZLhWvZb34DKyAARpYQRp
         PPrWnnTafmG0kZD44PP188fXdRM8HNxXFLCM+GASDHbjHdf9r+Gdf0uQ3CHegQVCNi84
         cyUyD6Wk4k00sl+li0LachUTDbJCcwUX0qUk1+nQBRSno8y9AQqlfw7PhtSBbkM2dS0+
         1qXuSbukEDt2shgiAn2vKtH4B0a0Rmi90A05RORuGrDQOfCWEkTYCRXcNII2xzJF3sNi
         uc1Q==
X-Gm-Message-State: AOAM530AXTZS/tJJpG0HnQq+OEadojWd9qGbXGWEPmnA8tRx7oxpviW5
        IjJcfynN5tg9ifCcLuho8LfiiN+2cQHEMw==
X-Google-Smtp-Source: ABdhPJysJhKoguGpq3/J9PCTTlVxZMUULoo0yDkuPQntMcxGzIddWbt1iId27NX5njZwg7AMVdmCXg==
X-Received: by 2002:a17:902:f54e:b0:148:e8ae:ffde with SMTP id h14-20020a170902f54e00b00148e8aeffdemr47740869plf.25.1641248619969;
        Mon, 03 Jan 2022 14:23:39 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id l2sm41574351pfc.42.2022.01.03.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 14:23:39 -0800 (PST)
Date:   Tue, 4 Jan 2022 11:23:34 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: pi433: fix frequency deviation check
Message-ID: <20220103222334.GA6814@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdL5rtWw2PTXdsRM@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf69 datasheet states that frequency deviation must exceed 600 Hz but
also that frequency deviation + (bitrate / 2) should be less than equal
to 500 kHz to ensure proper modulation.

This patch validates that both conditions are met so RF intersymbol
interference is less likely to happen due to misconfiguration of the uC

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v2: remove typo correction from this patch - Req Greg k-h, Fabio A.
v1: https://lore.kernel.org/lkml/20220103081135.GA11642@mail.google.com/
---
 drivers/staging/pi433/rf69.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e62e61ef4d27..d64df072d8e8 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -255,13 +255,25 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
 	int retval;
 	u64 f_reg;
 	u64 f_step;
+	u32 bit_rate_reg;
+	u32 bit_rate;
 	u8 msb;
 	u8 lsb;
 	u64 factor = 1000000; // to improve precision of calculation
 
-	// TODO: Dependency to bitrate
-	if (deviation < 600 || deviation > 500000) {
-		dev_dbg(&spi->dev, "set_deviation: illegal input param");
+	// calculate bit rate
+	bit_rate_reg = rf69_read_reg(spi, REG_BITRATE_MSB) << 8;
+	bit_rate_reg |= rf69_read_reg(spi, REG_BITRATE_LSB);
+	bit_rate = F_OSC / bit_rate_reg;
+
+	/*
+	 * frequency deviation must exceed 600 Hz but not exceed
+	 * 500kHz when taking bitrate dependency into consideration
+	 * to ensure proper modulation
+	 */
+	if (deviation < 600 || (deviation + (bit_rate / 2)) > 500000) {
+		dev_dbg(&spi->dev,
+			"set_deviation: illegal input param: %u", deviation);
 		return -EINVAL;
 	}
 
-- 
2.25.4

