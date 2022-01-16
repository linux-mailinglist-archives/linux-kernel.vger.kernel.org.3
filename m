Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6246748F9F6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 01:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiAPAVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 19:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiAPAVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 19:21:32 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71393C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:21:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id g5so16454183plo.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=fqrsaF7Uj8TrLkr/9naJv0nRYKzN9WZ+d0Uopgz4n52MStij9+dXrVzkPVEIQ0xw4z
         W110qsbf6cXjhTOj0miAw8erTdMMft2KM05jTRKdpJx29IxBPagUY7tOsHMu0ud90CYI
         tqnKJnXxKkdf2ANbmY5G2HLXC61JgJ8sTHIB0tOaJFHUJbbLplPyR1GviAwhf7xv7kh+
         ZusKk8eZY0LmHWFFqyfjR9lCFOxj+HMFEFuxaOpR3nVX5riDofEv4HfAMoHHrluQzkMl
         6wpfi905JuyzPR20rJs9Z8qQJpjH0zE06TF+aXpRX4lf+Zge08JG1LR6ZR+dxNn8kfeq
         jlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=xKcklcFRy2KU5T9RB4z4aE+GUkCoOMtpH015JSf1WFe2rp6qH6jwZAKxDZzUKKmJg2
         pAqbHd3Zve7/UCs8qFwuiylMCXFJp1IkaaDbVWr8lyHoylC8AQAT3/A4ODt5NyBHttDe
         fEstrGBS20AF342n9TlEs7+RpYlsLmV/bV9uuUiur+LAW55F2AGC/zxFqcq4yo/gvT9g
         NV6fu8zpSvwK64bKud3R5LGbq5qb6A79jvWDthjtrBqa1bZfqrwFPwk2vBMA59pjyku9
         Rut7Py/rkVYKF3BGXJIg1WK+7dgHi+GWh+7q+YjoJQRfQF1dvR6sm+kEw8dBzOGu4pwI
         RzCg==
X-Gm-Message-State: AOAM531kipcbGbak8Va0trqG3IbnTcD10HR1eC2zHtGAbgqs1taeTlpH
        G9ETGGSsz5eM5d+/YcCkVd2F5q4CaMsuL9lD
X-Google-Smtp-Source: ABdhPJzaI70txsP1xgWplbsFMwOdu0h/KONnRJw4HB/3/hLs3BFx+nC5rf4v8JkrsqkyKZkFk5j00A==
X-Received: by 2002:a17:902:6bc1:b0:149:7c61:ad31 with SMTP id m1-20020a1709026bc100b001497c61ad31mr16072684plt.93.1642292491975;
        Sat, 15 Jan 2022 16:21:31 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id h15sm10320729pfc.89.2022.01.15.16.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 16:21:31 -0800 (PST)
Date:   Sun, 16 Jan 2022 13:21:26 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: pi433: fix validation for min bit rate
 supported by the device
Message-ID: <20220116002126.GA23135@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220116001726.GA22699@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf69 datasheets establishes that the minimum supported bit rate is
1.2 kbps regardless of modulation.

this patch replaces the errouneous validation with the correct value

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index ee8c81d164e1..f4ac17adcd83 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -226,14 +226,12 @@ int rf69_set_modulation_shaping(struct spi_device *spi,
 int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
 {
 	int retval;
-	u32 bit_rate_min;
 	u32 bit_rate_reg;
 	u8 msb;
 	u8 lsb;
 
 	// check input value
-	bit_rate_min = F_OSC / 8388608; // 8388608 = 2^23;
-	if (bit_rate < bit_rate_min) {
+	if (bit_rate < 1200) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param");
 		return -EINVAL;
 	}
-- 
2.25.4

