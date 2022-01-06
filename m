Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0346486221
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237426AbiAFJbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233845AbiAFJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:31:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA5EC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 01:31:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so2546510pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 01:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BMLt2QumeGD9jQLaoBjlJLURrJZ4jSTbdeE0pBvjO0w=;
        b=jA+tR3qz5fx0WcVnQNT1NftyBwt7OnSF/WGYaL4GzLzZPkhiUKaoEmkEmgRiZLpfEK
         QOxmGg+JHDy8NDbexrsDwpMqR4cMCkEcJU04syQfiuQft3qXC0U+HVhsZvGF/sfQbDn0
         YwQ4CYks7SYGGBymFIagDMP/yZA9/A+lB0UFwdOw3kWCILldKknzcdNdJTnkO8GbJuBW
         tumQZnzy7IHjxE5gXt0m6u76hfs6P2u6GqD1dVr0sqXEa6HSm0lqO1dp5dfdNp6VoyhI
         2QW6SvRJ/MNn0hfHwIBj65HO8zHIqU5xzRN6ay5+t/vUTMlm0kiiO9O1QDbFLRzUlkY/
         PY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BMLt2QumeGD9jQLaoBjlJLURrJZ4jSTbdeE0pBvjO0w=;
        b=BpwuB855GrUpxDFkaPrS2w3nQZMEiU6R8iTmPKDYoeEskKWxV1kaH8/L0Q8rWfqsSM
         QF5yOYb4GM6iFaviTCcO6kvaD4ByLxV+4pk2w0YVM/R/yR+lliC+fvtIPeY/84Wc8Ra0
         Ud30Q0bcFJ83tXsdOW2QyPwVNl3oK7oQLLaEYJuxFLpV3ZclViKwXwXapn86eCIYQgqf
         uhg7t77/Vplbc5MIZWUUiVhXjC/UapKtj9EjTyKrgz14/G+9l/mEbsUwH2trRvRXquTj
         iJc2tyPM7RbjYiRHSB6IUTc81G+ewpHXWSqPKFhZMCqapIxXSS1N7GQqqYThxDN5A+Nj
         /mSQ==
X-Gm-Message-State: AOAM532aOSjfoQKuL+FFXkvbU5Nr6dF+7hTK9uKQNPznVHXO0XzSolCF
        5V5DYcAxQ06tMPlMm5JAqWRO5nBt3iw9HmBv
X-Google-Smtp-Source: ABdhPJxjJ0lB2F47YWMXm6HPXLKir2XERaDOFDlKiokXss965OvQDvJdUTJJoO7uBRRtudAGuDQ4VA==
X-Received: by 2002:a17:90b:4b0d:: with SMTP id lx13mr8923107pjb.89.1641461475394;
        Thu, 06 Jan 2022 01:31:15 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id r9sm5510303pjo.14.2022.01.06.01.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 01:31:15 -0800 (PST)
Date:   Thu, 6 Jan 2022 22:31:10 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220106093110.GA20011@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a convention for the pi433 driver, all routines that deals with the
rf69 chip are defined in the rf69.c file. There was an exception in
which the uC version verification was being done directly elsewhere.
While at it, the Version Register hardcoded value was replaced with a
pre-existing constant in the driver.

This patch adds rf69_get_chip_version function to rf69.c

Additionally, the patch below must be applied first as it was sent
before and touches the same file.
https://lore.kernel.org/lkml/20220103222334.GA6814@mail.google.com/

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 4 +---
 drivers/staging/pi433/rf69.c     | 8 ++++++++
 drivers/staging/pi433/rf69.h     | 1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 29bd37669059..a19afda5b188 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1116,9 +1116,7 @@ static int pi433_probe(struct spi_device *spi)
 		spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
 	/* Ping the chip by reading the version register */
-	retval = spi_w8r8(spi, 0x10);
-	if (retval < 0)
-		return retval;
+	retval = rf69_get_chip_version(spi);
 
 	switch (retval) {
 	case 0x24:
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d64df072d8e8..1516012f9bb7 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -102,6 +102,14 @@ static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
 
 /*-------------------------------------------------------------------------*/
 
+int rf69_get_chip_version(struct spi_device *spi)
+{
+	int retval;
+
+	retval = rf69_read_reg(spi, REG_VERSION);
+	return retval;
+}
+
 int rf69_set_mode(struct spi_device *spi, enum mode mode)
 {
 	static const u8 mode_map[] = {
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index b648ba5fff89..ca9b75267840 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -17,6 +17,7 @@
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
+int rf69_get_chip_version(struct spi_device *spi);
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
-- 
2.25.4

