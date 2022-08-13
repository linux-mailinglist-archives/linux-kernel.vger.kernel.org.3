Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7C591BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbiHMPwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 11:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239896AbiHMPwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 11:52:30 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD60663A5;
        Sat, 13 Aug 2022 08:52:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d16so3075164pll.11;
        Sat, 13 Aug 2022 08:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=wXlUQdFctfwLyRD5zF+7rXToKitnaCZz9jhyoAy8hSA=;
        b=ZL44Ch7WG8igTcjx9l0J1ExwWSXMhlQX+OAcqFmgXsEOOMORc7I2tzoY3XL/Kb8Brh
         R9xeR6CgPpPqgxzDmTyQtYzqZaJB79WtnvWoIXG4GjcXj/Po+lylEl/WnQtMNkNTMPb2
         sBIaJIccsiG/TqSkjEFLFiyTGwIAgxuzVQRRuu1fkxPgsmIZcoWWpc53iwcrEHnZK2c1
         tafgqPnvoK2Rqd75dksyOeT+qhDdLQhsVlBBl67/okXpI2ixNpJ8YdpgN1Az9z7d0lGn
         6ixgLhCh6odGDt+81t8PwLPVETX10wUrGP4JKbEifkd6VVWzBHpndtndmEGO/3vJsIw0
         mFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=wXlUQdFctfwLyRD5zF+7rXToKitnaCZz9jhyoAy8hSA=;
        b=4hhrY1Vwwd/3G+BxPWgjVFERxL//YP92S1IvT9YCfyNbrq57k+fg6PL8yaVQ+Ljgz8
         FeDmgQrOeUEelGpKNewUVI7j+xd6EgmRMMiP71jhpSFsD1UGTHQBbK/5aY0+4q/XoOqp
         aCRPhhG32jf+NvewzglPvUcVJ+lGmWXi7FglmQWok1WGhnVf/JLUbK1Wixmf3YhWXjDy
         E+7mqm3Q+nbvVof0+yGiyM9DkNuzP1XhG93ZFhbCH72tIG9dqvUO4GFzhtcu+CCt9TI+
         An+GqkGVBVU4j5/X7LP9C3BYXvBB3OOoG62+FJvpIuwB9lOzqFjp3FOoDE/kfadReZw6
         CEoQ==
X-Gm-Message-State: ACgBeo02d8+DiNti5zhyyJ1hG8i+33/IjT7fDDo4Zd75fcOOvuk3qTc2
        bmfKmzMZQPDucZgNypKWak0QQWKMXwtTeuswvpwlkg==
X-Google-Smtp-Source: AA6agR4I327JQGY91FLmMpaq95gWBOEVRN82vcRnVLfzpjqKa9eXdL9ON+1WO34Qh7oQifTwAO01xQ==
X-Received: by 2002:a17:90b:3711:b0:1f5:179c:ad64 with SMTP id mg17-20020a17090b371100b001f5179cad64mr19079838pjb.11.1660405949027;
        Sat, 13 Aug 2022 08:52:29 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id 10-20020a62190a000000b0052e2435784asm3726245pfz.8.2022.08.13.08.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 08:52:28 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     alcooperx@gmail.com, gregkh@linuxfoundation.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [PATCH] serial: 8250_bcm7271: move spin_lock_irqsave to spin_lock in irq handler
Date:   Sat, 13 Aug 2022 23:51:13 +0800
Message-Id: <20220813155113.13427-1-91tuocao@gmail.com>
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

it is unnecessary to call spin_lock_irqsave in a irq handler.

Signed-off-by: Tuo Cao <91tuocao@gmail.com>
---
 drivers/tty/serial/8250/8250_bcm7271.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index 8efdc271eb75..fb525c435723 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -560,7 +560,6 @@ static irqreturn_t brcmuart_isr(int irq, void *dev_id)
 	struct uart_port *up = dev_id;
 	struct device *dev = up->dev;
 	struct brcmuart_priv *priv = up->private_data;
-	unsigned long flags;
 	u32 interrupts;
 	u32 rval;
 	u32 tval;
@@ -569,7 +568,7 @@ static irqreturn_t brcmuart_isr(int irq, void *dev_id)
 	if (interrupts == 0)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&up->lock, flags);
+	spin_lock(&up->lock);
 
 	/* Clear all interrupts */
 	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_CLEAR, interrupts);
@@ -583,7 +582,7 @@ static irqreturn_t brcmuart_isr(int irq, void *dev_id)
 	if ((rval | tval) == 0)
 		dev_warn(dev, "Spurious interrupt: 0x%x\n", interrupts);
 
-	spin_unlock_irqrestore(&up->lock, flags);
+	spin_unlock(&up->lock);
 	return IRQ_HANDLED;
 }
 
-- 
2.17.1

