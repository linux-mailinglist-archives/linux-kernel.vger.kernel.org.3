Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835174C8222
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 05:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiCAEUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 23:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiCAEUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 23:20:11 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6073B2715D;
        Mon, 28 Feb 2022 20:19:31 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ge19-20020a17090b0e1300b001bcca16e2e7so1019338pjb.3;
        Mon, 28 Feb 2022 20:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=7WIF/rFsMrFPDrw2gcHgdrGC1wbIw9S68Ygx0AL19Vk=;
        b=VSx8ma8+sJkVK46M3dr+CRRWuxL6aLikfae2qs0RVjdpBMssulwb5Db+eLz2zxJ8SV
         G4ZKz+Id920UoV44bx+z8KmceckPYlRpdkVPxpHsPr+27hoVm/2wn1RPiJCWm8OuhkdL
         +6kUP9MtVdyUenH6/wiF/IKNiLS635kz9c5iJiOLx0EYF+L75/S0Xbz2kF+S2jOSiVSj
         o+wmFxm0VbkwXsEueEOJ4/HqpN1K80+a9LCLacBuE1EJ/+3wrOSnSGChJ3rJqPJYh+QC
         6ZpFnmsNo38y+UA7uW950MYGJcO06LM9/pT0jK9MWjqtBzEOc0WBzNcaZYC9hBwT1RG1
         MCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7WIF/rFsMrFPDrw2gcHgdrGC1wbIw9S68Ygx0AL19Vk=;
        b=cjuCy3rhAhg+Et6aSxdmG0OH8VJy4K7d4vjMxP7rSnD7rnab3sgcU2d0IQyc+CH4j4
         6irzUKEXMkFmzzoCVBavKoLhu7Wbb2/8bQORIJClBd3N0LqxNsmtatxxTegRblTx7ayf
         cn9VAcqhD+e/toqe59J19iWrjhK3jgjN5PcUyQGYPKZfokzd/XyBYezr03rYOUdwIg6I
         mOd2OIwEXw5PNeteEC3vPOXNmOVKZcReXz5j8vFm7y/F1iJ3jcdQrYjyxlttxp3rd7T0
         +nOrVzn0QnyfLRLeW1RfdTPPFSJ6V3SkQfG97qf2UozjZQvCu8oSpYKiiXzEHnBmHbpU
         Q/Iw==
X-Gm-Message-State: AOAM530zRdlkXHgDCMZxJY2TrbQixxIV7r44vUs+nXjGlIGgHN7SxlQz
        1iiA1DeYP5654sPk/DzIZ3c=
X-Google-Smtp-Source: ABdhPJyiNeiPwEIfZOlYvf1sRBNQdoT2npPd/t0z7m5dBQlhBSRoTv1YbSDoyQryp5nLPOrXZrYOZQ==
X-Received: by 2002:a17:902:a50c:b0:14d:4e8b:d6f with SMTP id s12-20020a170902a50c00b0014d4e8b0d6fmr23500435plq.42.1646108370901;
        Mon, 28 Feb 2022 20:19:30 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id k20-20020a056a00135400b004ecc81067b8sm16193721pfu.144.2022.02.28.20.19.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 20:19:30 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        p.zabel@pengutronix.de
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH tty-next] serial:sunplus-uart:Fix compile error while CONFIG_SERIAL_SUNPLUS_CONSOLE=n
Date:   Tue,  1 Mar 2022 12:19:46 +0800
Message-Id: <1646108386-29905-1-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Fix implicit declaration of function 'wait_for_xmitr' issue.
2. Fix 'sunplus_uart_console' undeclared here issue.
3. Fix use of undeclared identifier 'sunplus_uart_console' issue.

Fixes: 9e8d547032("serial:sunplus-uart:Fix compile error for SP7021")

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hammer Hsieh <hammerh0314@gmail.com>
---
 drivers/tty/serial/sunplus-uart.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 450c8e7..1c7a30b 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -441,7 +441,7 @@ static int sunplus_verify_port(struct uart_port *port, struct serial_struct *ser
 	return 0;
 }
 
-#ifdef CONFIG_SERIAL_SUNPLUS_CONSOLE
+#if defined(CONFIG_SERIAL_SUNPLUS_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
 static void wait_for_xmitr(struct uart_port *port)
 {
 	unsigned int val;
@@ -562,6 +562,10 @@ static struct console sunplus_uart_console = {
 	.index		= -1,
 	.data		= &sunplus_uart_driver
 };
+
+#define	SERIAL_SUNPLUS_CONSOLE	(&sunplus_uart_console)
+#else
+#define	SERIAL_SUNPLUS_CONSOLE	NULL
 #endif
 
 static struct uart_driver sunplus_uart_driver = {
@@ -571,7 +575,7 @@ static struct uart_driver sunplus_uart_driver = {
 	.major		= TTY_MAJOR,
 	.minor		= 64,
 	.nr		= SUP_UART_NR,
-	.cons		= &sunplus_uart_console,
+	.cons		= SERIAL_SUNPLUS_CONSOLE,
 };
 
 static void sunplus_uart_disable_unprepare(void *data)
-- 
2.7.4

