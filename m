Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16054886B6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 23:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiAHW07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 17:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiAHW07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:26:59 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9E9C06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 14:26:59 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo2557535pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 14:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=D8/JlBkAi0y2afqFLTSdtNkXWi33ii5rg2RxUo+G0fw=;
        b=bN3MVvkfKJivM2T2cJDqmlhQOdX7hl67Y4ZMxe96VQT6KBz2UzdDTcRaihcSlGavVC
         aG4egn1C8ad95sLbBc5VyJRsAmbiAJ3MFO+er1VJ7fU33Rin4xjzEP31N+/1Bn8HjQfd
         A8YsHvCK8uZkMaTGbsn/som/FNEu0y79fiI9Hi4qb7gxZTq8X7PDMpnJLVCfRPBLyLDd
         QdyIZZrI218IufrSPmTvPHznlZnLM5J+keYU/Gz0FaKhaM9CuSoWevIRLMehWsGCDhKT
         zMsPewNVKTfnGxJPxJHRyasCR8Zt/ZNfqr6Pdsd+zPDzNpKAKXJxQTzeT9J9tgrmrnHe
         6TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=D8/JlBkAi0y2afqFLTSdtNkXWi33ii5rg2RxUo+G0fw=;
        b=jTWpAtezXhj0K6Dg0OdtrCZDJGG3tZs520jndaV6enx/GG8QdtBSuPQIhkZyNuDzmi
         ZJb+4gC+sEwUjcDz4uJLeUphjW11v58AuDSRwP5PLKcnBXwR0raQSLiMZvG0lTGstqyL
         asZzeSfgBXndKuSFxm2C7iKdK7bFr1ICF23qfoYUqI6Oo315mzK+RPhi8SsbNbnSfFb5
         WDR+H596k07l4jaf35blxEmmjYjhwgxfSFpB6OYpXg3UOCcwBMfL5SEqFlKjGGA6MJiK
         GPJ4RNYNePdrag4ybGAHv0rn/m6LTxalIqiGXCXq2PIJejF1XHcOTq9+whHr4Ez9GG9z
         aPSQ==
X-Gm-Message-State: AOAM531iWFlEl6YhNMXpirb6vOyd8YtUInFAxJUkwT1QzJAInhlkEo1M
        C2qRo2O2HtD58qy9ffXhMLwSUjdmpoHnO4BN
X-Google-Smtp-Source: ABdhPJxHB1SgPy0t8v5ZXm5kSrMORgFDGQZvDyTED5ESzv2Kx2QAwbzskMFjgvPk5OE+fVP/HptLoQ==
X-Received: by 2002:a17:902:9890:b0:149:8930:47e4 with SMTP id s16-20020a170902989000b00149893047e4mr53655131plp.89.1641680817983;
        Sat, 08 Jan 2022 14:26:57 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id lw5sm2892998pjb.13.2022.01.08.14.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 14:26:57 -0800 (PST)
Date:   Sun, 9 Jan 2022 11:26:52 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: enforce tx_cfg to be set before any message
 can be sent
Message-ID: <20220108222652.GA11883@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

this driver relies on exposing a char device to userspace to tx
messages. Every message can be sent using different trasmitter settings
such so the tx_cfg must be written before sending any messages.
Failing to do so will cause the message to fail silently depending on
printk/dynamic_debug settings which makes it hard to troubleshoot.

This patch add a control variable that will get initialized once tx_cfg
is set for the fd used when interacting with the char device.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
Patch dependency: 
- This patch needs the patch below to be applied first as both tweak the
  same file.
https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/

meta-comments:
- I'm not entirely sure if -EPERM is the best error code to return here,
  I'm taking suggestions
---
 drivers/staging/pi433/pi433_if.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 051c9052aeeb..3e9913f4bc7d 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -108,6 +108,9 @@ struct pi433_device {
 struct pi433_instance {
 	struct pi433_device	*device;
 	struct pi433_tx_cfg	tx_cfg;
+
+	/* control flags */
+	bool			tx_cfg_initialized;
 };
 
 /*-------------------------------------------------------------------------*/
@@ -823,6 +826,16 @@ pi433_write(struct file *filp, const char __user *buf,
 	if (count > MAX_MSG_SIZE)
 		return -EMSGSIZE;
 
+	/*
+	 * check if tx_cfg has been initialized otherwise we won't be able to
+	 * config the RF trasmitter correctly due to invalid settings
+	 */
+	if (!instance->tx_cfg_initialized) {
+		dev_dbg(device->dev,
+			"write: failed due to uninitialized tx_cfg");
+		return -EPERM;
+	}
+
 	/*
 	 * write the following sequence into fifo:
 	 * - tx_cfg
@@ -897,6 +910,7 @@ pi433_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 			return -EFAULT;
 		mutex_lock(&device->tx_fifo_lock);
 		memcpy(&instance->tx_cfg, &tx_cfg, sizeof(struct pi433_tx_cfg));
+		instance->tx_cfg_initialized = true;
 		mutex_unlock(&device->tx_fifo_lock);
 		break;
 	case PI433_IOC_RD_RX_CFG:
@@ -950,7 +964,7 @@ static int pi433_open(struct inode *inode, struct file *filp)
 	/* setup instance data*/
 	instance->device = device;
 	instance->tx_cfg.bit_rate = 4711;
-	// TODO: fill instance->tx_cfg;
+	instance->tx_cfg_initialized = false;
 
 	/* instance data as context */
 	filp->private_data = instance;
-- 
2.25.4

