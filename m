Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25459D0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbiHWF62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240399AbiHWF6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:58:12 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D3F5FF46;
        Mon, 22 Aug 2022 22:58:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x19so11904505plc.5;
        Mon, 22 Aug 2022 22:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=kOs/jcTHYsbej5MeX8EJYJ3A6QtxNAQXK0zGIk4XV7Q=;
        b=Z1DtFuuH9I0FCIzeU/iRHjWTnLu6j/SnUynHLg28niEJOH9cP/pSiJz2f47CjKJkFq
         nJJuP/rr4oM77VXx5GEddEdK3JJGOuQKkfjr63fuwBXQ/qCEwSOLbTPmhnUdHJ5q77Ki
         x5Q89gK8OIT3AVNoAM6PxdZ+cF2zX0NqMVZ2b9G1aG/oTGEaYV9uDHrsKhFUuzqYUCkD
         FSKIBmSOfC17d0fM2yfa5NxwuXftynFAQObPrztgDQ0R2zpOt71WJNjJ7IyCBnSCLF9S
         XW9xMKUMibwX2j/Ig/TPEKJnIOuYAJOcrHUdzPDcaJaSmN40Gxuvl/EkJMwVpyV884zr
         ETUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=kOs/jcTHYsbej5MeX8EJYJ3A6QtxNAQXK0zGIk4XV7Q=;
        b=cNFXFvZAHcdU/JSzyg6KAICf/R/0HNbSDeeR7ZbjlmcZ0NCKDiQJ+BNvQfcvCAeON8
         Gj6okp0cFccfwn1ANZAKhmtmd90+cxrRUgSDa5hFiiAQ3HacuGaypazDQF7LLtrCI5W/
         w0vLPbwg6UXwfV50xB3vGf/fshtlxaIRVDukuXAoUBNel4dfT92/cnjwo5QVaWcQLSFB
         3T76tUYMvM+kEunVdWMO7F8y9nPNYIe+UC+cvXqO/LA1h/PzI6OynQBjIFm15P/eY8PM
         +wO6xgRXLqtfkfWx6toFC0JDwwSZKkTMVDo1rabndC+va0fSfIzVWSJk2edjVt2BwM4J
         5Zrg==
X-Gm-Message-State: ACgBeo3g5R4d2Br3Ab6nsGFELYw2FhtfxPpLeMVNgj0tFprdVcbicvcw
        9Hxq2hDkHZuMdJLgDABLXiiW7rAuRz4=
X-Google-Smtp-Source: AA6agR58wVy4H5++RAMV1HgRQmfJcbiXY5u64q3YPSmYVZPZHr11Q+kxtjqqgm4ycswK+KViydWHUQ==
X-Received: by 2002:a17:90a:dc15:b0:1fa:c517:7f14 with SMTP id i21-20020a17090adc1500b001fac5177f14mr1797889pjv.117.1661234287000;
        Mon, 22 Aug 2022 22:58:07 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id k10-20020aa79d0a000000b0053612ec8859sm7522332pfp.209.2022.08.22.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:58:06 -0700 (PDT)
From:   lily <floridsleeves@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        lily <floridsleeves@gmail.com>
Subject: [PATCH v1] drivers/tty/serial: check the return value of uart_port_check()
Date:   Mon, 22 Aug 2022 22:57:39 -0700
Message-Id: <20220823055739.1451419-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_port_check() can return NULL pointer. Check its return value
before dereference it.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 12c87cd201a7..760e177166cf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -194,6 +194,9 @@ static int uart_port_startup(struct tty_struct *tty, struct uart_state *state,
 	unsigned long page;
 	int retval = 0;
 
+	if (!uport)
+		return -EIO;
+
 	if (uport->type == PORT_UNKNOWN)
 		return 1;
 
@@ -498,6 +501,8 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 	struct ktermios *termios;
 	int hw_stopped;
 
+	if (!uport)
+		return;
 	/*
 	 * If we have no tty, termios, or the port does not exist,
 	 * then we can't set the parameters for this port.
@@ -1045,6 +1050,8 @@ static int uart_get_lsr_info(struct tty_struct *tty,
 	struct uart_port *uport = uart_port_check(state);
 	unsigned int result;
 
+	if (!uport)
+		return -EIO;
 	result = uport->ops->tx_empty(uport);
 
 	/*
-- 
2.25.1

