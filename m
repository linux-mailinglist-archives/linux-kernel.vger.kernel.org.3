Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B8D4AB446
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 07:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiBGFtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 00:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240499AbiBGEpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 23:45:20 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5878C043181
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 20:45:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n32so10918889pfv.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 20:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xm+csgTnUDpErNmAVkrgFErEXLw5b0TmRhIzFrD3fEI=;
        b=ZcLnfup6DNDpRzMQqOuZ1AEsYS5RZiB2wSMVTgckVjNJgJhRK4jnkKi1QI3N3NQb6c
         CSBYImE44yFaJxI1jivJ0lUaXqp7X2aSvD3wHodKOss/dFNn7058OW33BFadFL+8mh7s
         Gz5Je7m/xJzA5hZvZPBd0hgCIqYuEO2yLuPskTfe8aIuc1AtNj930FMbrmXzf7xz2WJH
         raEXQiiIxSDZNwdw5ELaS8IVXRbpn3zH8ytBAdweX3in0ly7HU3mj9HP5NQcUHeQxCLd
         d0thewP68xUX9NyI33ll+lTZHlP9dFqG4MGbj76OKUXIbK/uQjNIGpB6jW80UAj7OTws
         W/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xm+csgTnUDpErNmAVkrgFErEXLw5b0TmRhIzFrD3fEI=;
        b=LnU1vI1w4s+A94aDGGpSo6QK+yUs7dC1sNHsHTPwAnF9HXnKUaNVw1sSyZnoftGZ90
         bgtapTJJ6PzQ5r6ucmn8NUNLqdPt/n0mAII71lRnfubnc5F558rHGxsIUjQRlLKB4+f0
         3rZJQuPWdkD42DjpeSt0gvfrEcanzjIWC1eTr6xoD/Y5Ei1yGJZ7o8lMJmDpmOLaZHsB
         zUbFpcwnAzPXAoqgnXhKg7xa40DcKdZ71COXzjEdItIiwde5FeKGqQIGMlajDIvKhr+2
         wE2LgWDs3ePIA6FGKnkrE6ZxPsGjtzJKkNGsLHrHH5rkURPCDoVNLsMveRqEMhDO/BgF
         SMnw==
X-Gm-Message-State: AOAM533XD4qdVhWSyjActjYcz5gPC9elw6SYrHXSIWlX8FeSRYXt8Dvb
        P2CqfLdWaouCTJsB96rfZDs=
X-Google-Smtp-Source: ABdhPJyPCMpuNpkKXy+ZFMXYRJ32ati/EOJ/H73r5FSn36l0djCcNVzhQCZ2uY0xAxg8et9t6FAZAA==
X-Received: by 2002:a05:6a00:1513:: with SMTP id q19mr14016623pfu.12.1644209119026;
        Sun, 06 Feb 2022 20:45:19 -0800 (PST)
Received: from mail.google.com (219-89-118-172.adsl.xtra.co.nz. [219.89.118.172])
        by smtp.gmail.com with ESMTPSA id ip4sm9145214pjb.8.2022.02.06.20.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 20:45:18 -0800 (PST)
Date:   Mon, 7 Feb 2022 17:45:12 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove need to recompile code to debug fifo
 content
Message-ID: <YgCj2P59AbFFmnbA@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging content present in the FIFO register is tricky as when we read
the FIFO register that changes the content of fifo struct which reduces
number of possible ways of debugging it. Rf69 uC has the possibility of
triggering certain IRQs depending on how many items are in the FIFO
queue, so being able to know what's in there is an important way to
troubleshoot certain problems.

This patch removes the requirement of having to compile pi433 driver
with DEBUG_FIFO_ACCESS set and let that be driven by printk verbositity
level and/or dynamic debug config instead.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

#1
In my mind, I didn't like the idea of having to change the code and then 
echo "module pi433 +p" > <debugfs>/dynamic_debug/control to only then
be able to read stuff being sent/retrieved from fifo. It felt somewhat
redundant at a certain level. On the other hand, I understand that
removing the conditional compilation will force a for-loop to iterate
for no real reason most of the time (max 66 iterations)... so I made a 
trade-off and in case anyone disagrees with that, just let me know and I
will be happy to change to a different approach.

#2
In the past, it's been pointed out to me during code review that I tend
to add code comments which could be omitted. In this case, the for-loop
seemed a bit odd without explaining why it's in there. Let me know if
you think I should keep/remove it.

Patch dependency:

This patch depends on the following patches being applied first:
- https://lore.kernel.org/lkml/Yf9ivRB5qpmA5rY2@mail.google.com/
- https://lore.kernel.org/lkml/YgA4XHU4uf6YkOk5@mail.google.com/

---
 drivers/staging/pi433/rf69.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index a8def70808d6..901f8db3e3ce 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -6,11 +6,6 @@
  *	Marcus Wolf <linux@wolf-entwicklungen.de>
  */
 
-/* enable prosa debug info */
-#undef DEBUG
-/* enable print of values on fifo access */
-#undef DEBUG_FIFO_ACCESS
-
 #include <linux/types.h>
 #include <linux/spi/spi.h>
 
@@ -829,9 +824,7 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 
 int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 {
-#ifdef DEBUG_FIFO_ACCESS
 	int i;
-#endif
 	struct spi_transfer transfer;
 	u8 local_buffer[FIFO_SIZE + 1];
 	int retval;
@@ -851,10 +844,9 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 	retval = spi_sync_transfer(spi, &transfer, 1);
 
-#ifdef DEBUG_FIFO_ACCESS
+	/* print content read from fifo for debugging purposes */
 	for (i = 0; i < size; i++)
 		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
-#endif
 
 	memcpy(buffer, &local_buffer[1], size);
 
@@ -863,9 +855,7 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 {
-#ifdef DEBUG_FIFO_ACCESS
 	int i;
-#endif
 	u8 local_buffer[FIFO_SIZE + 1];
 
 	if (size > FIFO_SIZE) {
@@ -877,10 +867,9 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 	local_buffer[0] = REG_FIFO | WRITE_BIT;
 	memcpy(&local_buffer[1], buffer, size);
 
-#ifdef DEBUG_FIFO_ACCESS
+	/* print content written from fifo for debugging purposes */
 	for (i = 0; i < size; i++)
 		dev_dbg(&spi->dev, "0x%x\n", buffer[i]);
-#endif
 
 	return spi_write(spi, local_buffer, size + 1);
 }
-- 
2.34.1

