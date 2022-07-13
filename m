Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D9457367B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiGMMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiGMMjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:39:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7FCF512D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:39:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w15-20020a25ac0f000000b0066e50e4a553so8340303ybi.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GlEwVVGZwmExSzZdU5QHRpYeRho/uS6G6Gk9NxHKj+M=;
        b=TKKOqIpzg+qDRzqTWDhgVHUP+0Z/FLyemlhq/cxI6jZlEhtiWxdp7r27jfRMk0GgwM
         ueZKz60Wc8SQJr/kywB/A8TZqbXNK6jJX34N2UbnpW2B6SEs+TBZwfdSwOi1ww1g2vXz
         GwesH64lPhF48vPYHsX8nztKQPjAqRwvrVha2MJP9kH5dHtLcFWqCzS8qYDo2/qHpJe+
         gcic3CGixWEBW8Jt+qUhdNf/jfRSaZDe/koNLCt+6bwfw1xs5ef0UwvF8zWlrTBAAVQp
         6aw56MCd9+hVVCXJU6h/I05kc5bt3pBvhM5Mtp7a6nl2OMVFWecuf594GrNksrFTaJIF
         hPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GlEwVVGZwmExSzZdU5QHRpYeRho/uS6G6Gk9NxHKj+M=;
        b=a3K+e5boD5ylMSe4GB60svgzNYmje0JYHPFQ03kNf07eJWvBRcVPLNM5DXbX3oOZ1E
         TOATVqd300sQRJuRSesitemLNS/xy1QRkOOWTOu/q24HgA+zlmvroK1L5FioSGmHOMmb
         CCpcZLP8tVXivzF+J5TaTK8IaLiW5aZs2zhpiseQU6fp08eAhEdaYwlIjuJRakHQU/B8
         r1uGcMUIimO0SKW468Q2hjsb5GYXDrrthngbWhm+Ydvn6wgagL5inRThEe+NOhgmwUU7
         msRz5m1MOf03GVJ/pVQlVeblJD9z5wsco1HeYazvRs2SerxpJ9M6R3YRqtODQt8/FRvN
         +ztg==
X-Gm-Message-State: AJIora+SLtLCYr6tjzyER9Mym8mC7rsOPNl8VAroLtvF29MmjhZmB+BX
        9E4w5JuwnTJqGdj51kCG7ncCIW1JILEpwVEtSdNJ
X-Google-Smtp-Source: AGRyM1uA8G/SED3/+nKnJXpMZcYPGNm5LhG0bCzZ/6u2FEPS8x5tQ+nKm+Q1e0N5V5pwyVh7yiI5QkTKFBsDCx94l2yK
X-Received: from vamshig51.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:70c])
 (user=vamshigajjela job=sendgmr) by 2002:a25:7356:0:b0:66e:ccb3:54b1 with
 SMTP id o83-20020a257356000000b0066eccb354b1mr3121081ybc.569.1657715969704;
 Wed, 13 Jul 2022 05:39:29 -0700 (PDT)
Date:   Wed, 13 Jul 2022 18:09:22 +0530
Message-Id: <20220713123922.2284522-1-vamshigajjela@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v2] serial: 8250_dw: Avoid pslverr on reading empty receiver fifo
From:   Vamshi Gajjela <vamshigajjela@google.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, manugautam@google.com,
        VAMSHI GAJJELA <vamshigajjela@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: VAMSHI GAJJELA <vamshigajjela@google.com>

With PSLVERR_RESP_EN parameter set to 1, the device generates an error
response when an attempt to read an empty RBR with FIFO enabled.

This happens when LCR writes are ignored when UART is busy.
dw8250_check_lcr() in retries to update LCR, invokes dw8250_force_idle()
to clear and reset FIFO and eventually reads UART_RX causing the error.

Avoid this by not reading RBR/UART_RX when no data is available.

Signed-off-by: VAMSHI GAJJELA <vamshigajjela@google.com>
---
v2:
- update as per review comments (re-format comments, xmas tree ordering)

 drivers/tty/serial/8250/8250_dw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index f57bbd32ef11..bfba89e6c875 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -82,8 +82,18 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 static void dw8250_force_idle(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	unsigned int lsr;
 
 	serial8250_clear_and_reinit_fifos(up);
+
+	/*
+	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
+	 * error response when an attempt to read empty RBR with FIFO enabled.
+	 */
+	lsr = p->serial_in(p, UART_LSR);
+	if ((up->fcr & UART_FCR_ENABLE_FIFO) && !(lsr & UART_LSR_DR))
+		return;
+
 	(void)p->serial_in(p, UART_RX);
 }
 
-- 
2.37.0.144.g8ac04bfd2-goog

