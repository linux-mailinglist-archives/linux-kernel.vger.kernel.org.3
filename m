Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DFE4901CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiAQGC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAQGC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:02:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1152C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:02:26 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l6-20020a17090a4d4600b001b44bb75a8bso8802067pjh.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=oYNbsridkjdw0mrmNIJXC9tA1DTH89l9mm4V1SaB7II=;
        b=CVzimYdjMdj+rMkORT0DnpDSFjsK5qJ9o52H6ByQvWMdtgY+ULePg/qmE2tMabdHvk
         NCRg/UZOcQO/IIMlQifsXFc93W0kIs5iTbcG0wbmhPl10R9FasVW2zO9MBRItg7r0iLY
         ereHzUwWhCM7sKdSyoLFnHkamWmG+Y1cfI/5gEdNGYK0V984ceYzWM0oz+6Mwdr7oqxA
         DiAwEOqTD+tyOi69Mw5guzXwCToQglXG9oG72+KBH7ltncChrRuTWUP0wPYK/eYpeo8G
         s9amfzOhcAIqX1+QbUhVBUBfFgxmGGk7TRFMhncrCcd/E0PX0FPgMz6P7CKPzz60Xthi
         q6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=oYNbsridkjdw0mrmNIJXC9tA1DTH89l9mm4V1SaB7II=;
        b=gWb+25HBZXtLA/iw99fqXGW+oImABbJ0ZjYe6wuPKoErJaf/5h+S4IadN1Qv1LQIis
         psDD5eQrbbYDIBsJjNonJhUUaI12xSdwNM7hse+sdMvsGQHpx3CazsZNqJyxK8xEgJhZ
         kPeLLsXfFfYjwj1vaBnap/7EpOKcJ26P6QHsaEvWMu4k/PFlDaP8diXoehnfEU4r+Ffb
         r16Jr+aRWHpjVBXCA3eCcrp1vtfCDjFlSfBJXZdqG6fIvZXKaiPw+hkC8JMkjIEYz6UX
         iLr88hp9jmNmiCV3YFtJKDpiv5nBk5hUPCE0tcyxNgXHdXTr6VP2jwuxyZhB7PsAK3Uu
         IxHA==
X-Gm-Message-State: AOAM533YjkiumV2ZaqdK00SeOEIjOy+10azuIR/1FaxMWgphMHGzyakx
        Jo8V7kjC78AIhihQNjYRx/4=
X-Google-Smtp-Source: ABdhPJw7wW+Ei3qEjCJEtInStJsZnCDLqtZoUPSL4PynvafDzn+vcdGgEDq8mOjw2RFVXlWs7U0Crw==
X-Received: by 2002:a17:90b:2386:: with SMTP id mr6mr32773747pjb.24.1642399346264;
        Sun, 16 Jan 2022 22:02:26 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id y3sm11160796pjp.55.2022.01.16.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:02:25 -0800 (PST)
Date:   Mon, 17 Jan 2022 19:02:20 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220117060220.GA11202@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117055849.GA10644@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Max bit rate is dependent on which modulation is used. Previous
validation routine only took into consideration min bit rate which can
lead a misconfiguration of the rf69 chip causing the packets not to be
sent/read.

This patch enhances that input check in set_bit_rate to account for
modulation values and their respective max bit rate

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

In the patchset v1 I kept bit_rate argument's original type as I thought that
changing it to accomodate values as high as 300kbps couldn't be part of this
patchset and therefore it should be a separate patchset. 

Given that kernel test bot compilation/test process 'complained' about the 
argument's type, I decided to send the v2 patch that addresses the data type
problem while I work on the patch that will change bit_rate type across
tx_cfg and rx_cfg as this will require a bit more work.

Please let me know if anyone dislikes the approach and wants me to deal with it
in a different way.
---
 drivers/staging/pi433/rf69.c | 14 ++++++++++++--
 drivers/staging/pi433/rf69.h |  2 +-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index f4ac17adcd83..adba69b8365e 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -223,15 +223,25 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 	}
 }
 
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate)
 {
 	int retval;
 	u32 bit_rate_reg;
 	u8 msb;
 	u8 lsb;
+	enum modulation mod;
+
+	// check if modulation is configured
+	mod = rf69_get_modulation(spi);
+	if (mod == UNDEF) {
+		dev_dbg(&spi->dev, "setBitRate: modulation is undefined");
+		return -EINVAL;
+	}
 
 	// check input value
-	if (bit_rate < 1200) {
+	if (bit_rate < 1200 ||
+	    (mod == FSK && bit_rate > 300000) ||
+	    (mod == OOK && bit_rate > 32768)) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param");
 		return -EINVAL;
 	}
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index c25942f142a6..3b8184155326 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -23,7 +23,7 @@ int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
 int rf69_set_modulation_shaping(struct spi_device *spi,
 				enum mod_shaping mod_shaping);
-int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate);
+int rf69_set_bit_rate(struct spi_device *spi, u32 bit_rate);
 int rf69_set_deviation(struct spi_device *spi, u32 deviation);
 int rf69_set_frequency(struct spi_device *spi, u32 frequency);
 int rf69_enable_amplifier(struct spi_device *spi, u8 amplifier_mask);
-- 
2.25.4

