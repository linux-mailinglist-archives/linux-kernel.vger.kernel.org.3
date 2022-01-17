Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8201D4901CB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 07:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234527AbiAQGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 01:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiAQGA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 01:00:57 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FF4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:00:57 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so7008476plc.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 22:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=bzXRibkL6gMspoMTyv32gwea7E+SjcByYvMKrn+OpRMWQvPQHkqJLNUpxhFO/2dnd+
         Bi8f+tQgp/VEMvIxH03Ak0osC+8Wh1dJ3RNLO4patFiYMQyJNP1jONINPUYJbcM7jHHp
         donOX/7l8Irwb84ORSQGk5bgUoZ4X26DmKTEWrqQO3jS96+FdHRoBuxkfVP03AVN6j4U
         eNJR8kpYQYoUmBcwo/1P31OsCWJO4ftIq1f2uSz3emLO7OqmlXZQQoTpaxr/Y+ZljwQO
         X/ojPgNbDbEqaRQYVrgCQwx479DFSs8Jzoxc/kRxnC0g/KwEA1RdlAxLuVWehRS6YR83
         jo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=vmI5obZJChROSVQzReKLArfFA6O6EbFVOPbqT4ROOPo=;
        b=YZfDam35gQOuZ2bm5pARxvohf0rngWOXdGjNbIfRcsK8g2trJ5EWXyfm8jHVryD9C+
         LP0oWGNW2JNTveH6Kmf9CAn8W0jL6P0HIRPr8Shm28nTps7Ubt67CmJ46qizqO9J/P4o
         /z7xbYcV1IYvk8e4Kt5M3JlxnLJqaz8oJYEqTww8XgWSRpv/5dXAztlx9bMfC6uMoCtv
         f9y+eT1M7Aa81n4a6Ti64UwoLhMw602Lru0z8OYRnKOTb1Ls68RbkJSrCF1Qr+svxL09
         h8X4P+26fnkW0WUcR/GvpovQpd0b4AM+HKXkHZID9l4np14/tYVuLOC8eJ6xq2Q8vyKy
         StTw==
X-Gm-Message-State: AOAM532IBHYSfh4cb2H8CL/izzAdECnqqz8EjX2q7W5/QjMfQ2raWLOz
        ppCf+aQhIuwXrQ/ha5nIO6UxjX3DXG5kiWAUmLY=
X-Google-Smtp-Source: ABdhPJy8a32ETgRL0olBS3qP/6S7LC7VlalHzWMXG4NzGgYhIGqvk2ybzhzIs+cvef4g3kQUc8IN/A==
X-Received: by 2002:a17:90a:247:: with SMTP id t7mr32719997pje.198.1642399256665;
        Sun, 16 Jan 2022 22:00:56 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id h7sm12858657pfk.173.2022.01.16.22.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 22:00:56 -0800 (PST)
Date:   Mon, 17 Jan 2022 19:00:51 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] staging: pi433: fix validation for min bit rate
 supported by the device
Message-ID: <20220117060051.GA10941@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117055849.GA10644@mail.google.com>
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

