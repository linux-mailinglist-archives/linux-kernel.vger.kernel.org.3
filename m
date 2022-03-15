Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247A74DA35C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbiCOTka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351419AbiCOTkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:40:22 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F4729C8A;
        Tue, 15 Mar 2022 12:39:10 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id v14so136274qta.2;
        Tue, 15 Mar 2022 12:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFCbz7FlNevBgSrjKRG8KK3STwFo/kY9uOkLzfQEECQ=;
        b=oW4TE3zBivfIf/rWyWV8dLljW5PGeKY76PqSqjJiNAM3CajLiZ5vEx8pWh+NFpmtEl
         gMZHNxC8UOpIJiwQvQh3cseTr0O39uVt0swketNuRfVskzmMJRhOHtl/qIUUF26+FpM3
         zmEcIS1+/Rriyec863ewEAW0XBrYWsaj1LJ1geXR15Mf/0EN87/v7Fs8lt76dLsfXBbR
         rxq4ujQllBp1qJGCeChXsW8RQcxankSFkOdjXU5G7Tv4THEFOX01ix7WmiebHasyq5dI
         XStWD98s+AdqrtXJc9KnSU7LfVlgWiA8QPwXY8ShotK5sq/x1CDMlpfZjp3d6JOtB3HG
         r0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFCbz7FlNevBgSrjKRG8KK3STwFo/kY9uOkLzfQEECQ=;
        b=C0BKRYPCssrvdFfIjgusOMc9wfxldgBuBo54aY6XveGPNjE9sb89aYloc2ZW7z6aSj
         z6oAIO6+03JPCUFXqTZh4G4Gsd39f+WwiioEL2tFGVI02yOLMjdtm3RcmOvK6oVOp1Yu
         61P3gma5SDJB2x3ogTMeEbE79Er3j98atINNLy5XPSRBsQaanoJxh5vJ+wvGUw5V56iL
         dTkOJzQny4xhjvCjXtuKC/C8lyXn7fZUjA8JlrbppVbcDD0y2KPODCNOyyUuOExFtXT4
         /7jmDJXjjxElajtRi6A8w+jz5eacViTHq0UzeKfQ4ge3jVg8pJ+r9hU4sm3Sd4Tx89zD
         whUw==
X-Gm-Message-State: AOAM532eDQ5QK+NHmG6rymrhDGDJaJaw+7Jbfv0/8kLyxOqkWNTmzRYO
        jFpZ8Xb2CxpLSmp0+jh8t6w=
X-Google-Smtp-Source: ABdhPJytPJG7ZHJs6/c0xg+icxv/Chr0DUw2L6C5hu9ZQVP/ms5bX/yUfn6s6oNE+y+ptKiKv+fi0Q==
X-Received: by 2002:a05:622a:588:b0:2de:9242:8788 with SMTP id c8-20020a05622a058800b002de92428788mr24208093qtb.76.1647373149187;
        Tue, 15 Mar 2022 12:39:09 -0700 (PDT)
Received: from ishi.. (072-189-064-222.res.spectrum.com. [72.189.64.222])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a22c400b0067e02a697e0sm1440798qki.33.2022.03.15.12.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 12:39:08 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [RESEND PATCH 4/6] counter: interrupt-cnt: add counter_push_event()
Date:   Tue, 15 Mar 2022 15:38:55 -0400
Message-Id: <9da3460113b5092e8658e12f23578567aab7cc5f.1647373009.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647373009.git.vilhelm.gray@gmail.com>
References: <cover.1647373009.git.vilhelm.gray@gmail.com>
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

From: Oleksij Rempel <o.rempel@pengutronix.de>

Add counter_push_event() to notify user space about new pulses

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20220203135727.2374052-3-o.rempel@pengutronix.de
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/interrupt-cnt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 9e99702470c2..3b13f56bbb11 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -26,10 +26,13 @@ struct interrupt_cnt_priv {
 
 static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 {
-	struct interrupt_cnt_priv *priv = dev_id;
+	struct counter_device *counter = dev_id;
+	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
 	atomic_inc(&priv->count);
 
+	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+
 	return IRQ_HANDLED;
 }
 
@@ -209,7 +212,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
 			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-			       dev_name(dev), priv);
+			       dev_name(dev), counter);
 	if (ret)
 		return ret;
 
-- 
2.35.1

