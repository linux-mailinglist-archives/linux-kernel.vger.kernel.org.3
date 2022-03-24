Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B6E4E65BC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbiCXO67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344773AbiCXO66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:58:58 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD0390269;
        Thu, 24 Mar 2022 07:57:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g19so4158697pfc.9;
        Thu, 24 Mar 2022 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=tzNc5ad6fkQ5y5MbKCIX35JEXgZM7wID1Rs6f6kwTik=;
        b=jHlQFugxTCVBJTtkEw2sI3mzKn1VbGE434zzaVMrKDLYArfaIkeXOyzYR+devNaKpe
         JyYYzFkNk40lVnX5GZpXFfSEJMWtRFtOEAcqfoOBqTFZruw7lR4N/yzypK2v9mANU+II
         YaqQp2TCT4XFwSrMGWBgFLN2ZTL2rfZv/WD6JzH+g4jaoleVCyURs2dhNJRlgOpo4xm2
         sJ15SaKUQ9iQgAkuZ/T9+bS/iEG2aQHQ4Y62lgnztuau6Vv0Mts1il3URdUgDk7Ud78q
         2HfCX6QKLWuJMe8y4sgoavoZ6p1pXX0ExrZkZilROriz1XAdhflcn5F3sdhb0HplWYUM
         iFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tzNc5ad6fkQ5y5MbKCIX35JEXgZM7wID1Rs6f6kwTik=;
        b=yUZPP3wOXAZ7tbr8+rNPGGSnkmaU5hozmXwYb35HOHdgK2l8W7RxCPQ5FBfjuY2lHk
         7nsdNqEGxjhpMVEdOveOKv9zfHybLsN9ZjwoxROVLIGv0UmgSsXMTJbBwqOLpzkIvzq9
         YQaHXUi3BLY1Gj4VS0PbL6JASXoeauStDVLeZnpB1DkRc6gDbT3nLD0KIle2CVMRpBCk
         QzE8eImfWOC0VucIoWBM8HcIn7QY1cNfkuJTs+zRCxPRPtDPkwTAj6gcN03hitjib6kJ
         EbLucsoiB41fLrHq662AgimgxTComHqS32q2dMa2xoL/bh0qiwlUctQOndN4waUr8GAm
         YohA==
X-Gm-Message-State: AOAM5333bo4Tt82I//ho6i0iCANaz7QNvq4n/pk8DVDfabO1aVq+aqv6
        gYaXSsvxqtQC9lfzcmdHMwj0UTr4kIs=
X-Google-Smtp-Source: ABdhPJyfqqJTjyVzxxr8SCKmhIm0UzVzoI2Oh5aV13ywr19SQop4DfuIs0S6mlfgqcA8y6WBgLU04g==
X-Received: by 2002:a62:3896:0:b0:4f7:87dc:de5b with SMTP id f144-20020a623896000000b004f787dcde5bmr5741031pfa.49.1648133845664;
        Thu, 24 Mar 2022 07:57:25 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t7-20020a056a0021c700b004f737480bb8sm3777397pfj.4.2022.03.24.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 07:57:25 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@comcast.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org
Subject: [PATCH] serial: When UART is suspended, set RTS to false
Date:   Thu, 24 Mar 2022 10:56:20 -0400
Message-Id: <20220324145620.41573-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Cooper <alcooperx@comcast.net>

When flow control is enabled, the UART should set RTS to false
during suspend to stop incoming data. Currently, the suspend
routine sets the mctrl register in the uart to zero, but leaves
the shadow version in the uart_port struct alone so that resume
can restore it. This causes a problem later in suspend when
serial8250_do_shutdown() is called which uses the shadow mctrl
register to clear some additional bits but ends up restoring RTS.
The solution is to clear RTS from the shadow version before
serial8250_do_shutdown() is called and restore it after.

Signed-off-by: Al Cooper <alcooperx@comcast.net>
---
 drivers/tty/serial/serial_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 0db90be4c3bc..a788d1c899d4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2173,6 +2173,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	if (tty_port_initialized(port)) {
 		const struct uart_ops *ops = uport->ops;
 		int tries;
+		unsigned int mctrl;
 
 		tty_port_set_suspended(port, 1);
 		tty_port_set_initialized(port, 0);
@@ -2180,6 +2181,9 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 		spin_lock_irq(&uport->lock);
 		ops->stop_tx(uport);
 		ops->set_mctrl(uport, 0);
+		/* save mctrl so it can be restored on resume */
+		mctrl = uport->mctrl;
+		uport->mctrl = 0;
 		ops->stop_rx(uport);
 		spin_unlock_irq(&uport->lock);
 
@@ -2193,6 +2197,7 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 				uport->name);
 
 		ops->shutdown(uport);
+		uport->mctrl = mctrl;
 	}
 
 	/*
-- 
2.17.1

