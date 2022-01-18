Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACE949312D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350208AbiARXGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350205AbiARXGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:06:01 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0685FC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:06:01 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 133so632956pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Hmwr/NvAL+svS57T9uxuMiXf8YJx8mtgioZKYfbMWac=;
        b=BaFC4GCONEYspssy1GYPeTrMNDkEWVXKVAKOqw11b2bH5ij+Bh0ZcVZbIsqSHsX3Qr
         VrvkcDgelRGHD04GNSeQ0EawjnuSS9Sp6OTDcXsq37iiAC2I8naWSF1c+9wsh9n3YcWY
         3UUa0zb2PG4/5oVgSbmFHG7VXw9wZJeB6DaGJZ8weyAX2Yc+1eyx2+cRLXOAg1q7/ZXD
         KL41pPLB6TArHpxRyXvcNKB9PRLiEm2cvYeQvn9tuNFja0Ns0l8vokrywxaaFURf9BFa
         zO996iFxIxH5Fi5k0TWEzkOL3CE9Pj1dwf1j4lCF/0pFPFt8ppVxSJOGfVXIu+R4ihfH
         F/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Hmwr/NvAL+svS57T9uxuMiXf8YJx8mtgioZKYfbMWac=;
        b=AYvL24sjlFnmSAdeiUeTDHezU6Sf9RdiGIgS37ugGrpwfoT2cBQL27iIlng6jk/oSK
         FSNQYMOke+6NIl6Tn1ibB77L+nvY0B7F6VVEPnfh6XKWyIpoRPi4zWME8w+2+CmECAu1
         LwGztpyzqJ5XPiFsiTpqtiztbI734hxzkQ8yGwGpr0cKCBDC2Qt4h6Aw7G2LzoZRYE8g
         E5MhpyM7aoJpO7iQ+NtUeP+NxHWidwvGTYNleVzPQPFtNgpxH892bbjPU8bHXpOlKsIq
         jJLNcbQ51gHfznpsPPGO1MPGQdG3E9MOyoHYilf09lPL3MNIBQGTDvPE/uVWwJwTH3Eq
         VgRw==
X-Gm-Message-State: AOAM5304a6aSlquz21ZoyZoIBdHT6F/SzP4v8d+YrCX7Yo5UB8ozurHf
        mrMjMD5rCAhlbmu4ost2o7A=
X-Google-Smtp-Source: ABdhPJw921ktYTKfD/b2cs4LS0dFFhpk51eulzdZ6obyPw2URyw/MnnVlyi5JrOouALyMeIx+POfCQ==
X-Received: by 2002:a63:b10d:: with SMTP id r13mr25084906pgf.257.1642547160571;
        Tue, 18 Jan 2022 15:06:00 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id t8sm15305456pga.15.2022.01.18.15.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 15:06:00 -0800 (PST)
Date:   Wed, 19 Jan 2022 12:05:55 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] staging: pi433: validate max bit_rate based on
 modulation used
Message-ID: <20220118230555.GA4961@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118230312.GA4826@mail.google.com>
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
 drivers/staging/pi433/TODO   |  2 ++
 drivers/staging/pi433/rf69.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/TODO b/drivers/staging/pi433/TODO
index 63a40bfcc67e..b9e6c01a02e0 100644
--- a/drivers/staging/pi433/TODO
+++ b/drivers/staging/pi433/TODO
@@ -3,3 +3,5 @@
 * currently the code introduces new IOCTLs. I'm afraid this is a bad idea.
   -> Replace this with another interface, hints are welcome!
 * Some missing data (marked with ###) needs to be added in the documentation
+* Change (struct pi433_tx_cfg)->bit_rate to be a u32 so that we can support
+    bit rates up to 300kbps per the spec.
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index f4ac17adcd83..d60514a840c2 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -229,9 +229,17 @@ int rf69_set_bit_rate(struct spi_device *spi, u16 bit_rate)
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
+	if (bit_rate < 1200 || (mod == OOK && bit_rate > 32768)) {
 		dev_dbg(&spi->dev, "setBitRate: illegal input param");
 		return -EINVAL;
 	}
-- 
2.25.4

