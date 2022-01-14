Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF36F48F251
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 23:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiANWQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 17:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiANWQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 17:16:49 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C27C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:16:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f8so3834669pgf.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=OttVB1JDlQIH0hruwh7e4jzJ1Iy+SYzWcI9z74YarIM=;
        b=JvBtn0GSCXd6vAqtj8DQaYeUDRg19TCiv9rSLRoPfTSZjbR6M6+1S7UlYA2WU11buk
         qbu/WQgLZdQGevF046+rKgxsgr9hC5QgY5BgzZ/1cNAooxVNi7cCLXRsuE0dZZrbGPtV
         04M3IUbb7sKh6iNKJMKsDnMyTaB/L4Fn2UxZAFJ1Ugm58uI2UCdKYoYkMBBvfPLTrssR
         rKZ72WvgO2UzAXSeecFasBhHenv7OoB+uezilCpPWVeemociUZztPFHwbyTg4PZP0s8V
         4KD/GLpHidzLKh7ujVbDrek6mDJFaRgJNcYhvaiBiZ90p5JFM5P9yWzJ68CFyzOTdAoT
         oK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=OttVB1JDlQIH0hruwh7e4jzJ1Iy+SYzWcI9z74YarIM=;
        b=XdsAH4NunrwRxL7qnZcNGIr2Mr9gGlqmitLzItjTLkLz+p+uwuxt6o+mu0Vi8gVzMN
         +DLvMhjCk2OlRhBbjBBHToc+DuT2szAZ9K0rcyiuxgdGMuaAAP3+3/sxlHYy7eFnnX0O
         XeEQcJ5vw2VqXJcXjWwXdVijPGwrv8W+TOSb5YW4WR5mUHHaqtrPd1xqLPLe5XaJZ+sn
         KDEYeNVW4YWsFVVSR6ZNxfIU+fBEFewfQxXQcMvrVcVLRKWc1IuquuSMuXGfr/ObvuKi
         VUm8r8FaPU3iflyFEOVwwuzCw6330yiyoFJAjFOe1ANOcDayomPayadTBp5BK+mYq1na
         Dscg==
X-Gm-Message-State: AOAM533jdNoDMi3sN9lTsr11pGe3wJFSh7Inurc8JqAm4T3tmbGOKEBT
        Jijs7TjE146R86R7E/Fr7Hk=
X-Google-Smtp-Source: ABdhPJy/Rj6TFe+U/d0OOo6+3Ko57hsBHqhfkURqGKUVYdWRL/6lGMcKVTNOsT7mV122SJDkFzmDig==
X-Received: by 2002:aa7:9510:0:b0:4bd:ce79:d158 with SMTP id b16-20020aa79510000000b004bdce79d158mr10750064pfp.24.1642198608915;
        Fri, 14 Jan 2022 14:16:48 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id k3sm11972788pjt.39.2022.01.14.14.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 14:16:48 -0800 (PST)
Date:   Sat, 15 Jan 2022 11:16:43 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: pi433: enforce tx_cfg to be set before any
 message can be sent
Message-ID: <20220114221643.GA7843@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112084002.GA27596@mail.google.com>
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

changelog:

v2: changed message and remove redudant assignments pointed out during
    code review. (Req: Dan Carpenter, Sidong Yang)
v1: https://lore.kernel.org/lkml/20220108222652.GA11883@mail.google.com/

patch dependency:

- This patch needs the patch below to be applied first as both tweak the
  same file.
  https://lore.kernel.org/lkml/20220108212728.GA7784@mail.google.com/
---
 drivers/staging/pi433/pi433_if.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 051c9052aeeb..f9f86e2c44a9 100644
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
+		dev_notice_once(device->dev,
+				"write: failed due to unconfigured tx_cfg (see PI433_IOC_WR_TX_CFG)");
+		return -EINVAL;
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
@@ -949,8 +963,6 @@ static int pi433_open(struct inode *inode, struct file *filp)
 
 	/* setup instance data*/
 	instance->device = device;
-	instance->tx_cfg.bit_rate = 4711;
-	// TODO: fill instance->tx_cfg;
 
 	/* instance data as context */
 	filp->private_data = instance;
-- 
2.25.4

