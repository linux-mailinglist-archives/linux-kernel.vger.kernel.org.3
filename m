Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826F94B1FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbiBKIHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:07:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbiBKIHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:07:39 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917F7D69
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:07:39 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t14-20020a17090a3e4e00b001b8f6032d96so8103008pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xAUT/gQq29nJV2O5W7LW1nLis7KlGvFawT35+Y71sHg=;
        b=GHGGarrC3d6LAv2KMugEICgtYfLX8+oSQ7ajZSMOk+Mqt93Ft4+B0+dFXmDtB9pVbd
         QUkK4L4+kB5rEQMEgiUbqWdAfVbB7T3ehIXhAWF9hsSVbP53mHhfDHQQwsN8wQ+mnMaT
         Apy3XXTt0sn4Po9CwISNy/63MSAznmyjyIE4iXNX7WF1oBUCnRIQ/Ve+i8umiPmJ6XuL
         XmF/rynZ9oAT7h5Ej+bWZqAo6vZPVQmFsEw87qQHr6PsX0AI9XdUqws33/B56S5Rm9e1
         c2jE53KVihmEnwYbSSIp3u8UzGXvJlvuwbpTJNjkR0SJg0ABQOMzlWbFO1ciw5VR6X26
         EQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xAUT/gQq29nJV2O5W7LW1nLis7KlGvFawT35+Y71sHg=;
        b=dIHj6XRn7xOjVksDo5rSldMPXtnoL1pmtQlYzawbIJOLfZVBMnguGEvQn7aTQcwsze
         fR1hbNTGi/TSt5eu+RfJYkSt/DFTCiQ5YVXd80k/vTVal1IG8B2sVD3S7+PhJUuxuzdA
         YS4hls9mZfAuiFViC4QWv56bdDUK3xYD1og0yiwNMmsmyG+HY5axU4ZGdSSiMVkmJ1Kw
         C22JgjkjqqbyLAkfBN5AKGxBzDirId/1EHhNOed0VPbbW0YL01ZfPOb8PgQCRUmh45nj
         fVo10xGnzp7if3UgJsv08s94ewj4p7esUD18VSYSKl/mMR3jRZhdq9yaEhgPHOFVuzYQ
         Axlg==
X-Gm-Message-State: AOAM533j1h7Tw9YbFXNGGAKyoKxqXQINTzQHObZFRTdWvsVobe1uBmLT
        oBsp62/+INGB/4nntv1GP3w=
X-Google-Smtp-Source: ABdhPJw8agmr/Wkjjlbpw0m/muQtFl1SPv09lYm2nrDz5cf6Hpr3AnJ1h6sTedjjDczGVxLW0dinqQ==
X-Received: by 2002:a17:902:ba98:: with SMTP id k24mr397500pls.44.1644566858982;
        Fri, 11 Feb 2022 00:07:38 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id z27sm18548399pgk.78.2022.02.11.00.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 00:07:38 -0800 (PST)
Date:   Fri, 11 Feb 2022 21:07:32 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add rf69_dbg_hex function
Message-ID: <YgYZRArwwF7Z1B4f@mail.google.com>
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

dev_<level> functions don't support printing hex dumps and the
alternative available (print_hex_dump_debug) doesn't print the device
information such as device's driver name and device name. That type of
information which comes in handy for situations in which you can more
than 1 device attached at the same type.

this patch adds a utility function that can obtain the same result as
print_hex_dump_debug while being able to honour all possible flags that
one may be interested in when dynamic debug is used.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Meta-comments:

the initial discussion to use print_hex_dump_debug started in this patch
but the original idea got merged into the brach.

https://lore.kernel.org/lkml/a630d8381cee0f543e0d77614052e1d04ab162a5.camel@perches.com/#t

---
 drivers/staging/pi433/rf69.c | 39 ++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 901f8db3e3ce..82d4ba24c35f 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -822,9 +822,37 @@ int rf69_set_dagc(struct spi_device *spi, enum dagc dagc)
 
 /*-------------------------------------------------------------------------*/
 
+static void rf69_dbg_hex(struct spi_device *spi, u8 *buf, unsigned int size,
+			 const char *fmt, ...)
+{
+	va_list args;
+	char textbuf[512] = {};
+	char *text = textbuf;
+	int text_pos;
+
+	int rowsize = 16;
+	int i, linelen, remaining = size;
+
+	va_start(args, fmt);
+	text_pos = vscnprintf(text, sizeof(textbuf), fmt, args);
+	text += text_pos;
+	va_end(args);
+
+	for (i = 0; i < size; i += rowsize) {
+		linelen = min(remaining, rowsize);
+		remaining -= rowsize;
+
+		hex_dump_to_buffer(buf + i, linelen, rowsize, 1,
+				   text, sizeof(textbuf) - text_pos, false);
+
+		dev_dbg(&spi->dev, "%s\n", textbuf);
+
+		memset(text, 0, sizeof(textbuf) - text_pos);
+	}
+}
+
 int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 {
-	int i;
 	struct spi_transfer transfer;
 	u8 local_buffer[FIFO_SIZE + 1];
 	int retval;
@@ -844,9 +872,7 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 	retval = spi_sync_transfer(spi, &transfer, 1);
 
-	/* print content read from fifo for debugging purposes */
-	for (i = 0; i < size; i++)
-		dev_dbg(&spi->dev, "%d - 0x%x\n", i, local_buffer[i + 1]);
+	rf69_dbg_hex(spi, local_buffer + 1, size, "%s - ", __func__);
 
 	memcpy(buffer, &local_buffer[1], size);
 
@@ -855,7 +881,6 @@ int rf69_read_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 {
-	int i;
 	u8 local_buffer[FIFO_SIZE + 1];
 
 	if (size > FIFO_SIZE) {
@@ -867,9 +892,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 	local_buffer[0] = REG_FIFO | WRITE_BIT;
 	memcpy(&local_buffer[1], buffer, size);
 
-	/* print content written from fifo for debugging purposes */
-	for (i = 0; i < size; i++)
-		dev_dbg(&spi->dev, "0x%x\n", buffer[i]);
+	rf69_dbg_hex(spi, local_buffer + 1, size, "%s - ", __func__);
 
 	return spi_write(spi, local_buffer, size + 1);
 }
-- 
2.34.1

