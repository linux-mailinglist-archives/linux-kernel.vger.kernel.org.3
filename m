Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4749759C16B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 16:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235664AbiHVOLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 10:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiHVOL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 10:11:26 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73B133E2A;
        Mon, 22 Aug 2022 07:11:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w13so4388565pgq.7;
        Mon, 22 Aug 2022 07:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=p7nFqFJ6GyduwW/jaAManajXS9BcTBoJW3Oy3Zrj+Us=;
        b=bphPJ9HNniChNozFrr8pN3OyWuoEb0pXuMv2UiJ0i+iBLZzhawlJHDZRkhECE4YNRk
         ZuuvFb/T8k2Ul/mSmo3vLbqKo/o7QHfSCSXrKXurOnL5AEribeJAX9XKncFDzmmhfe/e
         lssIcPM5I1Utx9D+nI3KVKZ1bWHdAx4FsW8l6A1k48LMbW+Ji6dH67g5DKF2S9rXJted
         8P8yYeSPTNmXm9qoazNSrjLOr8gazh7WRUGI7DEDU58LIi+HMy4ajgou0wG1ZkW+9tut
         x0PsilyPTvamDP9z8HJjabhd+bioVKOwnNbrKagLIZVvTx9ou5yq2lLkH8dfa8pdmlXX
         fBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=p7nFqFJ6GyduwW/jaAManajXS9BcTBoJW3Oy3Zrj+Us=;
        b=DxEpcfoe04PxzC+aElqQW2IWaBmS2V9nafXl2xj16lmfNkxOWlzt/99ftVbHnl0abc
         PZV9IZnHrHiPbqv9DBGWxdXzOzq1zfHko6S/6GKzSNM6aUtg7wffiPvmcD5MuTSAnX2/
         j5gBxbJu9uYRF1Y8//Vdeg5bZJJMwahz2wOb6A896HDtlODIiHulS8EP8Dg4731P8Ob1
         4n6CwFUcEn52PKQv1yxc5oQQOJag+1paOYcvVaml21cjMJCPWXWTt75aNGWb8dPiZKrW
         Wr9LdxK3dkeGMOE/2/B4Iv7Wo2gi8Mvo+Qt/Kc4v6CzLOeShDHKgn3AHrBhWzwjiawi/
         Wbnw==
X-Gm-Message-State: ACgBeo0cv80xFLz20MWCVv3bpuWISXACKjxZ3goreBPgFgiT3uL2v1Du
        rcJjeLABxfLjjrxI7hNgBkwCi1pDG+2vFOgt7VE=
X-Google-Smtp-Source: AA6agR6adpyvp+DDP9uK/VhDoIlFGyKFzKJohwDSBAIOeH9QK3/ZoHCTz84zb/mdVjiQ1SJPy+2DVw==
X-Received: by 2002:a05:6a00:1402:b0:536:bf1c:3d16 with SMTP id l2-20020a056a00140200b00536bf1c3d16mr3320102pfu.20.1661177484185;
        Mon, 22 Aug 2022 07:11:24 -0700 (PDT)
Received: from localhost.localdomain ([182.160.5.243])
        by smtp.gmail.com with ESMTPSA id r17-20020aa79631000000b00535d3caa66fsm3099167pfg.197.2022.08.22.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 07:11:23 -0700 (PDT)
From:   Tuo Cao <91tuocao@gmail.com>
To:     alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        91tuocao@gmail.com
Subject: [RESEND] serial: 8250_bcm7271: move spin_lock_irqsave to spin_lock in interrupt handler
Date:   Mon, 22 Aug 2022 22:11:10 +0800
Message-Id: <20220822141110.17199-1-91tuocao@gmail.com>
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

it is unnecessary to call spin_lock_irqsave in a interrupt handler.

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

