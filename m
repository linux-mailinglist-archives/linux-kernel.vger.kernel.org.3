Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB674D5BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiCKHDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345199AbiCKHDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:03:14 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D261AAA45;
        Thu, 10 Mar 2022 23:02:11 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id c4so6675405qtx.1;
        Thu, 10 Mar 2022 23:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaMUR8eqBjunf19pL1HP7SUWTLVHC5595sNbHKANJ+U=;
        b=OvAfQl8HBtshuXU8uIh/jHIk9HdF3cvpD3sqHlw+eFWZfkRfO7CDL0bwZD4yUFXM2U
         k8aWg48VK+MlXncM5P93BdY0MF/tashrOdO38JNU51w27sOmWCXkWfEFRm2NdlAJ7rOK
         nC00Lxd9cZnESHWqrP6g+oY12KhA/6M0XD1mzzBv3Nha6KMhFYiAQhg34lXo6h0iAxlO
         V+ibhZTIIubUr8b69+lZvUAQ79Ch2pOzwzGNSykj4gc8tdXTRqL2u09U+L8v5DYHe+UQ
         CVz/5vpJImv3xmLlg9VA3H3yuG6beg2h0oVQSKWUjYMX9K6No3zqLvHc3gnCP4sF/NAT
         sEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vaMUR8eqBjunf19pL1HP7SUWTLVHC5595sNbHKANJ+U=;
        b=c00zq7vKbp5aA6UC596RHGQ+C1NcDv5EN1xszNS3BpLe2XZPaFNjtI5kwDIm8cfdoy
         h4mDd6KlAhUetzn+Orbob/r8o6egG01yR4uohY85GE+aJ9/L6IrWHcSv2NYWuUW8UG6c
         1Fvs4BBx/XhB3lIKirSgHmG+gUjztVYsBA5WwS5nvnAinRI2+/uw+gulYQ48hSKp95Wy
         /MGfvfk5gho9wOdozT+oBBFMrnus7HqtI17NdBKeZjyixEc9hPy4U9m+UO8c4VZpeL6Z
         DLnAbBWmGuKCHyub17RuJa/hdwDtZ0/iE6ZzcSsmcup/4UqlmoEx+yvvsfvBL7VvSESh
         44Tw==
X-Gm-Message-State: AOAM533nocn38KDq5TXJZxMeJnccdCc/9XZS3gj+q16/89aC9pK+cycA
        IPYi/00tC8WWZkrCrraOJaEhfec6KtQ=
X-Google-Smtp-Source: ABdhPJxTOE3DoJ1oAmVNsMPoW5pI9Iu7bwKQM5vPdI81FzaUDVD2xeLjU5iMaFeRMx/thPSy7D65KQ==
X-Received: by 2002:ac8:5c07:0:b0:2de:97ee:6d8d with SMTP id i7-20020ac85c07000000b002de97ee6d8dmr7018722qti.110.1646982130702;
        Thu, 10 Mar 2022 23:02:10 -0800 (PST)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id k8-20020a05620a138800b00679fc7566fcsm3352834qki.18.2022.03.10.23.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 23:02:10 -0800 (PST)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org
Subject: [PATCH 1/3] serial: 8250_fintek.c: Finish support for the F81865
Date:   Fri, 11 Mar 2022 02:02:00 -0500
Message-Id: <20220311070203.18159-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.34.1.75.gabe6bb3905
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

This driver only partially supports the F81865 device. The UART portions
of this SuperIO chip behave exactly like the UART of the F81866, except
that the F81866 has 128-byte FIFOs whereas the F81865 has 16-byte FIFOs.
Therefore fill out the support for the F81865 in the places where it is
missing.

Tested at 1500000 baud on the iEi NANO-PV-D5251-R10 board.

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 drivers/tty/serial/8250/8250_fintek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_fintek.c b/drivers/tty/serial/8250/8250_fintek.c
index 251f0018ae8c..d9f0e546b1a1 100644
--- a/drivers/tty/serial/8250/8250_fintek.c
+++ b/drivers/tty/serial/8250/8250_fintek.c
@@ -316,6 +316,7 @@ static void fintek_8250_set_termios(struct uart_port *port,
 		break;
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81865:
 		reg = F81866_UART_CLK;
 		break;
 	default:
@@ -363,6 +364,7 @@ static void fintek_8250_set_termios_handler(struct uart_8250_port *uart)
 	case CHIP_ID_F81216H:
 	case CHIP_ID_F81966:
 	case CHIP_ID_F81866:
+	case CHIP_ID_F81865:
 		uart->port.set_termios = fintek_8250_set_termios;
 		break;
 
-- 
2.34.1.75.gabe6bb3905

