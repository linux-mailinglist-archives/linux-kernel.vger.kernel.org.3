Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F34D84F7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiCNMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbiCNMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:25 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D49E13D24;
        Mon, 14 Mar 2022 05:19:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v14so8582827qta.2;
        Mon, 14 Mar 2022 05:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVYKucc+mwxRpju7dONX1SpktjTFhTUwy2wjrEfefyQ=;
        b=n0shuxfyOM8Zda4w8ipEKK8UObmHK3LmrpQ3t+xg0Jj9XkRebEcQhgE9fw4MBbnLRh
         pcXjvEMVUy+fsgwGqDSA/XrcoUoaFK7DSJfCjCkxVQ+VxWzg6KvCrnORuBMqI97dYnQh
         7trdl8csfaPCjXopD89hVBdF4f4O69mgHijQ/8+R2Pr213wbGRVi8zC0nDWicljzZNsA
         i1NS1jI6UZXAnXJLSKxkNzT7Jst8xmZR0j5bIt4L/e24ey/nFEMEoyk3+kbKzLcjVvmp
         hcbWOiG6OGFGSdBCQG39mMosO9kof/QEQa5rhdcE1y3sk5qMX+mneuZ9HIFYMuWv01pj
         Pmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVYKucc+mwxRpju7dONX1SpktjTFhTUwy2wjrEfefyQ=;
        b=EpLXBbZ5lfwgJ3Up+vS4ki2FabbFLgJGSkqnWO/6gMA49sVbSuZJNjtaellw4pCu+M
         g4B1SFxfuUoJJ6WmP5kJ2kcq6uVIGxUGdgeMtBO+RFOKpVlIjpRLYJas/G3QKt1AWzSS
         Ae+PQ69X0rqdBYiXrAeaL7Oak/orIXngbeBSIXJCBOBamc3Twbo1pvHYtVY1p0YRMTk/
         FdjqauiPXAUuplchTgDm/pMbU09y3U3719z78Oqr6n1maIhB5VOvLIMcgCMz0a2vx/8Z
         AG2WztMMQXUEIs214Rt4OCh5RrSId7F7Q3x4TWjjSbi7ifr34kSVSeknIiptxyccDFGm
         vK0g==
X-Gm-Message-State: AOAM5336NWIYFDksY8s0cWy7Fx6b7hqxyPG5fYXz9Os7rysP76A9RJGZ
        ZA0c/2IzDaii0BgVN46mQG5BOiGU2Dk=
X-Google-Smtp-Source: ABdhPJxSZ4mzrAEulUGO1qJ/XWF06fSdwlNNmz59bevtMoPaToPh7VyN3clT9vrfsUBK5u285uPDhg==
X-Received: by 2002:a05:622a:40e:b0:2e1:d4cc:88bb with SMTP id n14-20020a05622a040e00b002e1d4cc88bbmr3180031qtx.595.1647260347262;
        Mon, 14 Mar 2022 05:19:07 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm2945349qtx.58.2022.03.14.05.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 05:19:06 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH v2 1/3] serial: 8250_fintek: Finish support for the F81865
Date:   Mon, 14 Mar 2022 08:18:56 -0400
Message-Id: <20220314121856.10112-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.35.1.455.g1a4874565f
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

This driver only partially supports the F81865 device. The UART portions of
this SuperIO chip behave very similarly to the UART of the F81866, except
that the F81866 has 128-byte FIFOs whereas the F81865 has 16-byte FIFOs,
and the IRQ configuration is different. Therefore fill out the support for
the F81865 in the places where it is missing.

Tested at 1500000 baud on the iEi NANO-PV-D5251-R10 board.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 251f0018ae8c..47b15d2d9901 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -63,7 +63,12 @@
 #define F81216_LDN_HIGH	0x4
 
 /*
- * F81866/966 registers
+ * F81866/865/966 registers
+ *
+ * The UART portion of the F81865 functions very similarly to the UART
+ * portion of the F81866, so there's no need to duplicate all the #defines
+ * etc. The only differences are: the F81866 has 128-byte FIFOs whereas the
+ * F81865 has 16-byte FIFOs, and the IRQ configuration is different.
  *
  * The IRQ setting mode of F81866/966 is not the same with F81216 series.
  *	Level/Low: IRQ_MODE0:0, IRQ_MODE1:0
@@ -316,6 +321,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 		break;
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81865:
 		reg = F81866_UART_CLK;
 		break;
 	default:
@@ -363,6 +369,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81865:
 		uart->port.set_termios = fintek_8250_set_termios;
 		break;
 
-- 
2.35.1.455.g1a4874565f

