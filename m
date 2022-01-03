Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E71482EEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbiACILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiACILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:11:41 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B8C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 00:11:41 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r5so29574823pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 00:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oiEfYts536J1XlebKdzcdP3XXTCS0kXxLUqO5AkEJ40=;
        b=iSJMYQ2Cj4iZmCj4OdlF8CzzypM9mJqA2+nRQYYMvd6hiNfEB++LzTPVLHhtkSp9rK
         1Sf/zeQlPVJqwjx+xP74L5lXLNbJPmsSnVH8AxESoWzzZVqGhVPoNwKkM5CT6N9hjAC5
         RpG7tPf7qIuceAp5DxBI7xXYR/IcvKue4xky8vessf0kHPYPxD2QYCufTpqh7cCaicBI
         GRLxrR2VFB5uyqkaJ7O7SFudv/0eeaHT0CoS+Gm2Jdp62+L1LEuRhuh23mlDBe3RbVlP
         stGxW9qUEKlyeS0BBb7hS0F6N+dRJ6SCqysWcnpwOqzv7FcOKCwjHlOjHN98fGnDqunz
         dsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oiEfYts536J1XlebKdzcdP3XXTCS0kXxLUqO5AkEJ40=;
        b=X7x2PFxu8U/9T7d4ooqvpvvmZt6cjCB7XZYTFTn3NZam+Bh1Ik8LXBz0bNw0Roloze
         iQt+WAoPSDM466NpiSmUFKiJ03m41uL4hkH+KtalVmgPfgeGRtvXJsWL941sLNvTRF82
         sLuVfx6K7lZJb86FVOmPPyac1Et/vnRm4cAfUlLH5/kBvU4ub3zeMewi/G3tIeyhMoZF
         TDjV/iW3c0esbpd/69XqEm0Xdc6j6iEt0XJyDclIgo4j9qHllls+s6UX+o9YRhPkfmMz
         0ED3rcUW6BhGKI8t1a2QpcowgM8u84J5+Q0PAzzD7fxU+nPRtY24c8XxZkw9kl0qIcLz
         A2og==
X-Gm-Message-State: AOAM531ApXdkIaRmRW4mmBjxMFCKiDMQxN7wHHADB3Wa0gt0fapHxM7e
        OiJ0D0l/Uekcru6ZMu7CHnc76rGDvkVKpw==
X-Google-Smtp-Source: ABdhPJwnuH+20i3BZtl8dJzs0gIRj7V60TV1uj3NgoCFwUnetkcPhXhwgaXmCxw0epTawoFacj1edA==
X-Received: by 2002:aa7:88c4:0:b0:4bb:5a48:9801 with SMTP id k4-20020aa788c4000000b004bb5a489801mr45376592pff.67.1641197500800;
        Mon, 03 Jan 2022 00:11:40 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id s6sm17413771pjp.19.2022.01.03.00.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 00:11:40 -0800 (PST)
Date:   Mon, 3 Jan 2022 21:11:35 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: fix frequency deviation check
Message-ID: <20220103081135.GA11642@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rf69 datasheet states that frequency deviation must exceed 600 Hz but
also that frequency deviation + (bitrate / 2) should be less than equal
to 500 kHz to ensure proper modulation.

This patch validates that both conditions are met so RF intersymbol
interference is "avoided" where possible.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index e62e61ef4d27..cc22915fd489 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -255,17 +255,29 @@ int rf69_set_deviation(struct spi_device *spi, u32 deviation)
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
+	 * frequency deviation must exceed 600 Hz and but not exceed
+	 * 500kHz when taking bitrate dependency into consideration
+	 * to ensure proper modulation
+	 */
+	if (deviation < 600 || (deviation + (bit_rate / 2)) > 500000) {
+		dev_dbg(&spi->dev,
+			"set_deviation: illegal input param: %u", deviation);
 		return -EINVAL;
 	}
 
-	// calculat f step
+	// calculate f step
 	f_step = F_OSC * factor;
 	do_div(f_step, 524288); //  524288 = 2^19
 
-- 
2.25.4

