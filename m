Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC65A6037
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiH3KFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiH3KEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:04:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC56E97CF
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m7so5879999lfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6fhUpiDdMZcWZUaWUbXbRb4sHeETmJADlLAQy+exeAY=;
        b=TtbwcO7ZGfsVk6bMaFJMErijlaX5Idim/xWNOHASzEAorJOT/8k+MskAxlbOrnJhAa
         1P/2sV6H89Ui31DqMnwuFzoPCakmj+lzT2p/86ZzVQp6OKEvIaDmC1t91MpN5bRZ48K3
         jHbDHUHes+9r6D3cP/+kRv+B040E895eeynIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6fhUpiDdMZcWZUaWUbXbRb4sHeETmJADlLAQy+exeAY=;
        b=fU0M8uM1uCHSxGpM/pfkdmcf6QerNh+AKzc2oGD2oHXXWx2qiX5olnZ29NVK2ab38M
         4avaW0kpaaqcxiv1wvJrEe2P9XOINPyNY2gZGcoyJXYYlIO4pm7hwLHlXtCxnV17wsvV
         G3ZIBT9Dn8C8RkAYP0diQkPtR+2mvFUa5qWC6PmHQjv8z9X1RaX979AXtaq3JMWKr8Wm
         Nv8+Bsl5+3/7pQHVrHRsuGTpMu9dHHAFs67fwTQFCTxI6Pp77M3cyjg5LoyO02GMZ4xz
         B5KBjqbCDKKkpcWdiDsKHJFh7NEB86MhlgP/ks+xfRXMsykZrOxYTx5ZmVDYjPV2fLb6
         EX1g==
X-Gm-Message-State: ACgBeo2lfy+r2D0IWCk2rthGRMGn4tRkVrSS35DkpTJ8kZbIoPjgot69
        L3fFBT1D1rp8OwC4d4WIFUSGqA==
X-Google-Smtp-Source: AA6agR76RHNe5vTDCC1ieI1IXnYKr9Y1BkvAhNx/kACuW8wWHNnKiExMD/KhSTrE6H30oFaTBnHmZQ==
X-Received: by 2002:a05:6512:3dac:b0:492:f042:a208 with SMTP id k44-20020a0565123dac00b00492f042a208mr7050360lfv.285.1661853726125;
        Tue, 30 Aug 2022 03:02:06 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512114600b0048af6242892sm1573435lfg.14.2022.08.30.03.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 03:02:05 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] rtc: isl12022: drop redundant write to HR register
Date:   Tue, 30 Aug 2022 12:01:50 +0200
Message-Id: <20220830100152.698506-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's nothing in the data sheet that says writing to one of the time
keeping registers is necessary to start the RTC. It does so at the
stop condition of the i2c transfer setting the WRTC bit:

  Upon initialization or power-up, the WRTC must be set to "1" to
  enable the RTC. Upon the completion of a valid write (STOP), the RTC
  starts counting.

Moreover, even if such a write to one of the timekeeping registers was
necessary, that's exactly what we do anyway just below when we
actually write the given struct rtc_time to the device.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/rtc/rtc-isl12022.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/rtc/rtc-isl12022.c b/drivers/rtc/rtc-isl12022.c
index 234201ea2f7d..659f8e7f33f0 100644
--- a/drivers/rtc/rtc-isl12022.c
+++ b/drivers/rtc/rtc-isl12022.c
@@ -173,7 +173,7 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 		/* Check if WRTC (write rtc enable) is set factory default is
 		 * 0 (not set) */
 		if (!(buf[0] & ISL12022_INT_WRTC)) {
-			dev_info(dev, "init write enable and 24 hour format\n");
+			dev_info(dev, "init write enable\n");
 
 			/* Set the write enable bit. */
 			ret = isl12022_write_reg(client,
@@ -181,20 +181,6 @@ static int isl12022_rtc_set_time(struct device *dev, struct rtc_time *tm)
 						 buf[0] | ISL12022_INT_WRTC);
 			if (ret)
 				return ret;
-
-			/* Write to any RTC register to start RTC, we use the
-			 * HR register, setting the MIL bit to use the 24 hour
-			 * format. */
-			ret = isl12022_read_regs(client, ISL12022_REG_HR,
-						 buf, 1);
-			if (ret)
-				return ret;
-
-			ret = isl12022_write_reg(client,
-						 ISL12022_REG_HR,
-						 buf[0] | ISL12022_HR_MIL);
-			if (ret)
-				return ret;
 		}
 
 		isl12022->write_enabled = true;
-- 
2.37.2

