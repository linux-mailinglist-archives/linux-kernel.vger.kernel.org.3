Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE1C55092F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 09:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiFSHk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 03:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiFSHk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 03:40:58 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26091E035
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:40:57 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id b7so8801721ljr.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 00:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SijtfyVKmKZ61VgfgYPFK0haQYdmhgE2KuP17MEIvzY=;
        b=i/JdKT25OBXNk009zoIAjdJ2zMdGJS0OWHK5gXVeft63f/tB3nZYHhhG9wRfTaRP0a
         zPGE1m5//7qxkZwVP6fV/kaiJks8+ZQ52JWjuRR6kUuNx4i8tgMLruV6tDM0ZJcbQpnX
         WZYXe0U36AQJgWj+vEM1PoWBEEFtUsQpnF9QTrKdxc/JCUWRhTcrL28uvY94YQPjB7fn
         sGjv65HoLAY1LXRWIQHAbngEgqkOUcac/FNP07faXhXmU1vs6Ynwyt5pKd6aTJziddub
         emFY3b1lKvGh4SXHCbM6vNt8eVrNjOFt/l76ZsY/G6FvklGvAZHBmh6qO+mUBGK6FyFQ
         DWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SijtfyVKmKZ61VgfgYPFK0haQYdmhgE2KuP17MEIvzY=;
        b=uQpKv3MXyJQxPabJMju3luGf1Jtj6o13EcpPIu7wgctGtiB9OR8rskwnkV8myS+m7t
         xpITHzvGXZEuC3gHqEeQIJGR6DhH4v/RIu10QUgZ7L9zUmCfQeWHOwUd5lcLwJY0zAQm
         oVllQ+ubqOtz2cvj5jUlDz2MpZ2DDQcF8E6J5Q1XXUEJ58+JlbVS3c2+fnHw9mxGvMSm
         ENjvyNNyoAYpkBx/2enD77kZfKmUTBCasRVWkei+yBDy/aYYLMBSNUuJ6gYwOfEH0jH5
         ucxULrO42AwQLUhaiuntt4XvSN+2V89+JtzwxmHz5ZRL6tueLUh4fuUsnN1of/Zi3IC7
         Fi+w==
X-Gm-Message-State: AJIora/Zp6C3PWnrO3n5q12u6ENT2GOe6axfjMSdfwj8uPTyJ6MLpKui
        et3TxmUSe2lirAGNuPS5b/XWEiGMJ4vnLw==
X-Google-Smtp-Source: AGRyM1uArWeunq1mpXu0ABwBTWouCfr8aZh86/rGC1mBwSmmuoRGZYQU4h/4XVK0b24G/JqpjHpQfw==
X-Received: by 2002:a05:651c:1025:b0:25a:672b:92dc with SMTP id w5-20020a05651c102500b0025a672b92dcmr1792714ljm.118.1655624455382;
        Sun, 19 Jun 2022 00:40:55 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id w25-20020a197b19000000b0047f67dbb533sm209242lfc.70.2022.06.19.00.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 00:40:54 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com, mw@semihalf.com,
        jaz@semihalf.com, upstream@semihalf.com
Subject: [PATCH] serial: 8250: dw: enable using pdata with ACPI
Date:   Sun, 19 Jun 2022 09:40:30 +0200
Message-Id: <20220619074030.1154429-1-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
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

Commit 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata")
caused NULL-pointer dereference when booting with ACPI by unconditional
usage of the recently added pdata.

In order to fix that and prevent similar issues in future, hook the
default version of this structure in dw8250_acpi_match table.

Fixes: 3242fe805b52 ("serial: 8250: dw: Move the USR register to pdata")
Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/tty/serial/8250/8250_dw.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..3b79bd5c9c9d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -773,18 +773,18 @@ static const struct of_device_id dw8250_of_match[] = {
 MODULE_DEVICE_TABLE(of, dw8250_of_match);
 
 static const struct acpi_device_id dw8250_acpi_match[] = {
-	{ "INT33C4", 0 },
-	{ "INT33C5", 0 },
-	{ "INT3434", 0 },
-	{ "INT3435", 0 },
-	{ "80860F0A", 0 },
-	{ "8086228A", 0 },
-	{ "APMC0D08", 0},
-	{ "AMD0020", 0 },
-	{ "AMDI0020", 0 },
-	{ "AMDI0022", 0 },
-	{ "BRCM2032", 0 },
-	{ "HISI0031", 0 },
+	{ "INT33C4", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "80860F0A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "8086228A", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "APMC0D08", (kernel_ulong_t)&dw8250_dw_apb},
+	{ "AMD0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0020", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "AMDI0022", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "BRCM2032", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "HISI0031", (kernel_ulong_t)&dw8250_dw_apb },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.29.0

