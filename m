Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C91493127
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiARXFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiARXFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:05:08 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98551C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:05:08 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso4273002pjo.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=9nmGSMsNg7TpxFokhDu2M3YQG+slmr+fovI7GFM6KVY=;
        b=iZj1UrYomjsoNst1oHFF0dz6gUYl2R3R86cMGTV1/2YCsaWmkXfGqgZFOFtjr1YZk8
         IzRDYzRzSVUkgOz7YAHzK57bJqsCP3rizbqzhXwBC5CJrQOJuPqMYGjjKGkJ3o4BYvIk
         4oo+6gjjUfoVy1Ckai3kqWm4C2xZBOXdqMhW6lz4ehja9HT70/8fmZRBj89UsUOZEq12
         +NXRBGHXQleJFh95XzcRYmw3jQicebSQH1LUzKvWx/GahWQsjyGHyoAAcKY6WEa1yw68
         txyB6DhXh+N0rrtppw5HU+HnL5EwgTJayLY5YbHWF6JfI4xzl40f7Gmsce60kT/7EYoK
         QhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=9nmGSMsNg7TpxFokhDu2M3YQG+slmr+fovI7GFM6KVY=;
        b=4vUcyqIv+WVodwCuIOAU4CoZwCvtuVKBD77a/nVfhcoS351zkUAQcjnzdYP6CAN9Ig
         swHhj8daX3sd7g5lckixO8UWjCDlGC/miEO0N1jy23FE7ZGIc6e2/a39X/zhKKVNOMOt
         N3TvmFLjLjgaX/7F1FdQSzACBRwxUp25Ho8YxSVZG0vEdVdw3SzIfIBRuIOUx7+5dGOS
         dcDOX82fijhwObd3ZKDuYeyR9bhqN2xf0pq6z8xK0Y5Gf5w60/2MQ6HV6e4PNUH1MIT1
         or2vQ3pXyafYNjIERtFGfw9ZNwViSqXvIHYMuEzTMHNzZppfS0O5sgMgmSY4HyBEAE5g
         p/EQ==
X-Gm-Message-State: AOAM530ied1elTl/N8Iq0a+Br5JecCzJyAyFYp/WiRfR3aF70Sk/H+Sf
        40TOl+VE9nLxKnsQ1iQGCUA=
X-Google-Smtp-Source: ABdhPJwBym8eeRcj0DVKaPItufN4k+RbokuV48j+BiichBZQGbGQaX0QAwwJXHJQ0uGtuJEszQPvlg==
X-Received: by 2002:a17:903:1c4:b0:14a:555c:adc0 with SMTP id e4-20020a17090301c400b0014a555cadc0mr29501068plh.101.1642547108175;
        Tue, 18 Jan 2022 15:05:08 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id on1sm3253534pjb.52.2022.01.18.15.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:05:07 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:05:02 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] staging: pi433: change order in which driver config
 the rf69 chip
Message-ID: <20220118230502.GA4897@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118230312.GA4826@mail.google.com>
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

