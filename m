Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E2E5A231D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiHZIgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245301AbiHZIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:36:31 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD1659E8;
        Fri, 26 Aug 2022 01:36:29 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 72so921106pfx.9;
        Fri, 26 Aug 2022 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=YbMT0C8eUp0BW2NLRGkZ4JXaxnOUCNokkqd9eU3Ah6g=;
        b=OANVg3+i8e1pyB4GoKs9n/x+tPP2Pw20uXs2QHJe9hUvr8xRcQGNTFih4ntnhgIPdo
         dRDl+KXQ7VwEDHObGZiCjBrSrOIpqRZ83z6O3rhRWf8nA60HlW86YTKOzDBzx4z+4JmU
         TtLvZ3lQA2P25AmSGCvCYL4PvQM8vTOsnSPd4ooddB/fEjDl9DGv2Q8Q2/mAjMvTxqfw
         1rjdOnkzmT9GLR4V4bY3ekNbzMl+EY8L/+PJrDuk5kW30rEpokVOGkUM/w1b1nCjR2ut
         f026g2ACumth+/Kezvri9BY20e66IizatFtNFazVyiR0F0ZDzA+FYAXY1LtJ+EnH0zZQ
         rSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=YbMT0C8eUp0BW2NLRGkZ4JXaxnOUCNokkqd9eU3Ah6g=;
        b=cXu11Mfs0HlaTMNO5pz+rao7aIP86buBxQrxO/wBwrb91keUqLuDvRl6UyyxrMG21k
         Ya8bOSsgedk6wn+3nQbsnwmTSIWrpzpv2OtR94+OI4sAkuHX6zLsFyYmPK/FVBkDIQfP
         Nn2Jp8ctiopvyzy0ClzvGwD779R7iAUsC7est3j24CJoiM65gat/+XLFwjo/uSFgI0Fl
         AFGT2tDaDzt5wLK/BADq11jm5CiTubDi+VI7Oh0mvPpxbGTZLf9hv6i7glgJNgkxaeHU
         kGRZbb7mMpl2xoyI+kOfUv4at4nDdOQ6qgOIi+JYuFg8D6OubMsJDLItP1E8NMt4ZzH/
         9eHw==
X-Gm-Message-State: ACgBeo16kehQc/VGZk0USINWC4D5kzdxtNGs6duOk09fFugjQiPY2xTm
        Q8yYjUYNlMfwH7ipNbV93GvbaEmak1q+NA==
X-Google-Smtp-Source: AA6agR5Gn/w0xJuK9y28teAbU2uTs4udROg7HXllc6MKFBc5aLZJDcpQss9kWbimLF4KZM1PzG8dgQ==
X-Received: by 2002:a65:6541:0:b0:42b:1b04:327b with SMTP id a1-20020a656541000000b0042b1b04327bmr2407864pgw.145.1661502988188;
        Fri, 26 Aug 2022 01:36:28 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id x25-20020aa78f19000000b005377c74c409sm1095054pfr.4.2022.08.26.01.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 01:36:27 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] drivers/tty/serial: check the return value of uart_port_check()
Date:   Fri, 26 Aug 2022 01:36:12 -0700
Message-Id: <20220826083612.1699194-1-floridsleeves@gmail.com>
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
null-pointer-dereference error.

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

