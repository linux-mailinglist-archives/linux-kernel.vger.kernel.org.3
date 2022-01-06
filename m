Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BC9486BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiAFVdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244271AbiAFVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:33:32 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09149C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:33:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id ie13so3550239pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=WuKRGo9ecKyj+0SJ1Lg32Xx/ZEzcZuPmTJpgDjcU7uY=;
        b=AhRuXFF2ulHp/rvfG1I45ArchYIMXBwQfjay6KahHpQaAneqhy7iGqzYTfDEMB5wKc
         A8VmTa3Ix3Rzd1IaR20QG5S3yoTSnvgfJnTiFfL++7ziPLnM4ptRvE3MThwuZqoA08cB
         0ksjMdSB4B5ueb9BZLaQmzqh/3QxQF4a8j9MosJluV3/OOHaDxjTg9eGjmKjJOFMT4H3
         EiOUXptQrtjvD9x2/+29Vm+v873oz1nokdmIEdg9LNK3KjyBmL/pnF55IxP7QdMWHbyN
         2MxaBo4mox0G1Mbr/eUNIY4ylgmodkLBjLj7PCn6OmYCrskG74mFWuVwNagpqTIR7a22
         0IVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=WuKRGo9ecKyj+0SJ1Lg32Xx/ZEzcZuPmTJpgDjcU7uY=;
        b=UdV5h4ls/JAg2Y+94f5YjZCZdrxfsoMqmNHWpyaapQabAe/xAd0ePtLNJ4P1yxzajZ
         s0NZTOWOGtDk7DWCdPSknAVl6oRKGml6k4yGchZtr4LkgDBBu1c0l6bUGlW/g8PKQ/sP
         z9gRdEOdKsw49oF7Cc0g7xf5nQVeEup+O+ioCqtyebDgPKc6pGtiTwN7xx0ehZKAvpJ+
         YL28w0D25jcRqN5rN0Tu7g4Y7RL1wEhMnyiDYf3M6ovrk48hOp+oaiZk/9WsppcB2TEP
         EHErp+EYO1UNLjWuas079//FiJbtLc9nGAY5fSqcxejXnJoTUF5p4hrbNOd2JuJ5iFZ6
         2ZwQ==
X-Gm-Message-State: AOAM531O4SFD5uno9hahvpDTZXrFA7H0+Q2FDZaBYsxZEsqEWaq8eg49
        q2dNapJVjAZY4x8Ty1ahbk5h6hATXho3mw1e
X-Google-Smtp-Source: ABdhPJxAkBpesp/+H7KaHoCKMNePmUsNKQ1ND3NiASQkIa2G2NvKPPF+Yz0sLtdNLD+Ok4OKSQzYRQ==
X-Received: by 2002:a17:902:6b02:b0:149:9c7d:3ae7 with SMTP id o2-20020a1709026b0200b001499c7d3ae7mr37369260plk.51.1641504811598;
        Thu, 06 Jan 2022 13:33:31 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id s12sm3683830pfg.148.2022.01.06.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:33:31 -0800 (PST)
Date:   Fri, 7 Jan 2022 10:33:25 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: pi433: move get version func to where all other
 functions are
Message-ID: <20220106213325.GA10767@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106201430.GA3416@mail.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a convention for the pi433 driver, all routines that deals with the
rf69 chip are defined in the rf69.c file. There was an exception in
which the uC version verification was being done directly elsewhere.
While at it, the Version Register hardcoded value was replaced with a
pre-existing constant in the driver.

This patch adds rf69_get_version function to rf69.c

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
v2: function names where altered to match suggestions given during code
review. Requester: Sidong Yang
v1: https://lore.kernel.org/lkml/20220106093110.GA20011@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 4 +---
 drivers/staging/pi433/rf69.c     | 5 +++++
 drivers/staging/pi433/rf69.h     | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 68c09fa016ed..1372361d56e1 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1116,9 +1116,7 @@ static int pi433_probe(struct spi_device *spi)
 		spi->mode, spi->bits_per_word, spi->max_speed_hz);
 
 	/* Ping the chip by reading the version register */
-	retval = spi_w8r8(spi, 0x10);
-	if (retval < 0)
-		return retval;
+	retval = rf69_get_version(spi);
 
 	switch (retval) {
 	case 0x24:
diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index d64df072d8e8..ee8c81d164e1 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -102,6 +102,11 @@ static inline int rf69_read_mod_write(struct spi_device *spi, u8 reg,
 
 /*-------------------------------------------------------------------------*/
 
+int rf69_get_version(struct spi_device *spi)
+{
+	return rf69_read_reg(spi, REG_VERSION);
+}
+
 int rf69_set_mode(struct spi_device *spi, enum mode mode)
 {
 	static const u8 mode_map[] = {
diff --git a/drivers/staging/pi433/rf69.h b/drivers/staging/pi433/rf69.h
index b648ba5fff89..c25942f142a6 100644
--- a/drivers/staging/pi433/rf69.h
+++ b/drivers/staging/pi433/rf69.h
@@ -17,6 +17,7 @@
 #define FIFO_SIZE	66		/* bytes */
 #define FIFO_THRESHOLD	15		/* bytes */
 
+int rf69_get_version(struct spi_device *spi);
 int rf69_set_mode(struct spi_device *spi, enum mode mode);
 int rf69_set_data_mode(struct spi_device *spi, u8 data_mode);
 int rf69_set_modulation(struct spi_device *spi, enum modulation modulation);
-- 
2.25.4

