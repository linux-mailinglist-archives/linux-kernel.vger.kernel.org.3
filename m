Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4E55A3F94
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 22:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH1UMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH1UMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 16:12:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3419611C07;
        Sun, 28 Aug 2022 13:12:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q63so5955772pga.9;
        Sun, 28 Aug 2022 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9soN0wm6hv307d0QdiXW3V8ZD2iEqF6yqG5Fdm6pSKY=;
        b=MlsaHs/ZvsnXehqTYRrgR2oXkOzouaQTBhJ/NmRQezKTdvOPTA50UXLvYcv/C5kUYh
         zco441bi9Y8hV8nt/Ay7oEUxqwo12bEZuVauSQlOzFg9WC1xZS33fSVQ9qOiDR5uZRoM
         1gZhg1d/qShiwNH77Yu9Wgrtcf7Qij0aIEQoSVn8Ab6R+9FiXyxIDdmBiPqoJaI87SSm
         6PkRw0dtMG3dSZrg4Fozen/zXEvrAe/vD3DbOSFBH03p2y7qSd3bLzGlpY1kVnae+xsL
         jZX3B2Lsod8lRUN9EEllGgnMHCrN4x0APEwgNbdr7KUVgqNg9XCaTa2q1uEDyzAqFQSi
         UR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9soN0wm6hv307d0QdiXW3V8ZD2iEqF6yqG5Fdm6pSKY=;
        b=6IO4lbMDcAgKzDYz6NONX62YlI9tHXoGAEEF0M3aSnJzDiUTty8c+W8Zx6zVV3uLBm
         rq1DzerW6TisYsmfNaRrzxAgRu2KYR42Bmn7TcRjZJutcKAjf5C3A26TJhII3fkUQqbb
         VAvJkvJTzWREgRZU5D2pj4H5ukaFYJuBnqRVd+/zsacjd8aCAZI67Qi+3NeMS3ZvJX/h
         zilHn1r6ePIcj3NCgxF/h31UD7lkW3bsbM0pu9iYoEJT1yGsqn+7OJwsLL7b2l1pL687
         S0QR5kJABEtMLHlpf2NtPo76nFhVoFgBKEt7xlw1xYa51SI5YTZLCRUs5xnXswU8pA4L
         Qeqw==
X-Gm-Message-State: ACgBeo2atmBK5eDW5gDJekjkSkeAUDO75xrkZ0oXrURVfNZnLshwJIfX
        xhjPhJ/3pcREFS6DD/gLK58Kwe20WxOS0g==
X-Google-Smtp-Source: AA6agR4o1dIr42qehpjbxlGn5Nhw0Y8o2rHySokVEpyDf5VmwLBEKbyGmSfsBsR6BGsHT0GEsYpQQg==
X-Received: by 2002:a63:484a:0:b0:42a:1a4:517e with SMTP id x10-20020a63484a000000b0042a01a4517emr10996753pgk.86.1661717532427;
        Sun, 28 Aug 2022 13:12:12 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id i13-20020a17090a4b8d00b001fb3aba374dsm5183884pjh.31.2022.08.28.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 13:12:12 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v3] drivers/tty/serial: check the return value of uart_port_check()
Date:   Sun, 28 Aug 2022 13:11:59 -0700
Message-Id: <20220828201159.1945416-1-floridsleeves@gmail.com>
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

uart_port_check() will return NULL pointer when state->uart_port is
NULL. Check the return value before dereference it to avoid
null-pointer-dereference error. Here we do not need unlock in the error
handling because the mutex_unlock() is called in callers.

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

