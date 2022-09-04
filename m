Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A85AC1E4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiIDApn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDApk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:45:40 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF3537183;
        Sat,  3 Sep 2022 17:45:37 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso8962124pjh.5;
        Sat, 03 Sep 2022 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=yiI8vUugtIpeaPdVDy43MHb5OhzVd8Kd6wmhxpx4bk0=;
        b=YonJMI8WlkbXbOI4z2jfaHNFpDbTyqclD2BLn0PDfzi7A+7FESFY0mkPNvraXLH4l8
         qqfNp2+0vX+qGuJwictF5OCs8lEI+B3ZsaJ493Bd47MPvHaa2Io0wR8UBwe/uuqR4ZZ3
         srAbszsqqFz6j/qRrQzB6Ka07yClL/Ox+wCrRQdCuzi5Fm7XTngVi7Z2NdWm6ma9MO53
         PadkELKoJy4xYFPtm70B6BLXnbTR7s7Fj1xJnjHPfaX9dP1jC4bfbO9Bm2kQb+VD25of
         GBhDNmqx4CDvC+T3QMU06ovBe6fjHBilJ/Y1Ohb1J21DDrDPxWnViNR7L3Ph+3FZzng3
         p8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=yiI8vUugtIpeaPdVDy43MHb5OhzVd8Kd6wmhxpx4bk0=;
        b=UvutqMzoScFdaSKdjySKZukOBewrdwsqTR6SxANSad5Jli72cAaMYOu4XpcUKWp00Y
         Zn5zYeeks4XB/Ckbi1UToYlDFfuA7idsl6K2vNnuvx/Q1vR/9OpbY9H972+o7r2a3ySs
         RhzwQXgrLutXTZyB0MRZyLv3D6EbRbAFhRQGcNqPGkElIyOenklK6xqzCj+r5raTpt4W
         qBkl/5xPbq5pefV0uOswnWnuyuTT4L8Wgr0S6p6ip18JENzDlqo9BAT8h3cp5WqCx2Xu
         g2As/LZpv43GzaggZ/oTN5WOHiOuEHgkTgzAU3jZ7bW/i/Tv1nbB9tqc9Z4x9qke/7tx
         9NDw==
X-Gm-Message-State: ACgBeo1KHVy9qBF+huW/S1MqZcAQ5cpGdzE1XIKCg20LvqmDDnC/6Yo0
        6knpWbtqphM+UHKZDcJBs0VIgoYbUyJQxw==
X-Google-Smtp-Source: AA6agR7QQ7oBZjqnsQWJ7gHu1T9s30dgHNaleJb+Yl0l7KkO960uJzLWx9Is9q8AicVFWA0hxuFw6g==
X-Received: by 2002:a17:90b:3805:b0:1fe:8e4:96e8 with SMTP id mq5-20020a17090b380500b001fe08e496e8mr12439661pjb.223.1662252336441;
        Sat, 03 Sep 2022 17:45:36 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id jc22-20020a17090325d600b00174de2bb5f3sm4272685plb.132.2022.09.03.17.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 17:45:35 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v3] drivers/tty/serial: check the return value of uart_port_check()
Date:   Sat,  3 Sep 2022 17:45:24 -0700
Message-Id: <20220904004524.2281227-1-floridsleeves@gmail.com>
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
null-pointer-dereference error because the locking does not guarantee
the return value is not NULL. Here we do not need unlock in the error
handling because the mutex_unlock() is called in callers.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---

v3: Add the reason why we need to check the NULL value in the commit
message.  The bug is detected by static analysis.

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

