Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322E5468889
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhLEAI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhLEAIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:08:53 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7E4C061751;
        Sat,  4 Dec 2021 16:05:27 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l16so13966070wrp.11;
        Sat, 04 Dec 2021 16:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yC4M601le6ee6oQ8Ai6FfGeF+kc+ch1qwxc6keK/wAw=;
        b=AW0cefID8iErQnZxHYoxpb4CKNaNuA6zAtTlskrbIOQEcsLwvMgXUbQww6YOw4aOEt
         f288wUnMDUX+MywyZRi1PWrycMuzaHDIwJ/fV0xNeOGHc/6s2cnNm3mAvWkatDvFFgdh
         6U9WQG1klNGVoji7/KO2QafYJ5Czk69uPmpD+5k3aIzwYuJ8fYVoiRj1upS1AF7OazVI
         UN1L7V3oyrflNUywMN+EBqZ7vFrkB0rCEB2HN2InAYL2/lGr7ULI86IQZpiruXoSKcmt
         5Yl1h7qoJtqPnxGAPbxehsjbSbKEcexbZGyt8EmUAVu4CmSFFLtVnQyvOh1NQuQPA22S
         o12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yC4M601le6ee6oQ8Ai6FfGeF+kc+ch1qwxc6keK/wAw=;
        b=u+Ox/FEc/5WfJoiidYEa9s27T6MXEbb8YPgSQIcJYTTby44KosRzuDEwxjQ6H2UfTn
         BG796P8NXmfB6j+r/Wr8y9Xn3XO02GKIdxRyycjREUB5izvXSnpaklgXyWSPWhDeIXs2
         zE2hBYFHOh93R14qidKDYkt29ab7qf3ZLLvYJif7E+f9685rr1wtbNXj5tvijMwvO9PN
         2JS45r8merDZQCahNSYZibNeAR+zbBL3mLq48lxaIZcEjg3ONG3O70RLXSxzBt6cSp2g
         VwCpnQedthBZbMfYx+90Vk5AdfeJVZCEX+t2ebNqxswCas7XJ2p4fbfDjlpJujguwDjh
         SBmg==
X-Gm-Message-State: AOAM530/eiqTORqulNXHcMW0flijzdkBnkP2TRBnTxlksOxgYXkr3dog
        v2m72+52HffiOMSzIV2pXPE=
X-Google-Smtp-Source: ABdhPJzlH8VI8KMaYzxuhVquJGX/SvuBAhrMSbpOcctFPMrq0tSzmFghEKVLthjsRuVyKuN3ZK2pMQ==
X-Received: by 2002:adf:eac8:: with SMTP id o8mr32100757wrn.337.1638662726167;
        Sat, 04 Dec 2021 16:05:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id b6sm10034667wmq.45.2021.12.04.16.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 16:05:25 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: ucb1400_ts: remove redundant variable penup
Date:   Sun,  5 Dec 2021 00:05:25 +0000
Message-Id: <20211205000525.153999-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable penup is assigned a value but penup is never read later, it
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/touchscreen/ucb1400_ts.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index e3f2c940ef3d..dfd3b35590c3 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -186,7 +186,6 @@ static irqreturn_t ucb1400_irq(int irqnr, void *devid)
 {
 	struct ucb1400_ts *ucb = devid;
 	unsigned int x, y, p;
-	bool penup;
 
 	if (unlikely(irqnr != ucb->irq))
 		return IRQ_NONE;
@@ -196,8 +195,7 @@ static irqreturn_t ucb1400_irq(int irqnr, void *devid)
 	/* Start with a small delay before checking pendown state */
 	msleep(UCB1400_TS_POLL_PERIOD);
 
-	while (!ucb->stopped && !(penup = ucb1400_ts_pen_up(ucb))) {
-
+	while (!ucb->stopped && !ucb1400_ts_pen_up(ucb)) {
 		ucb1400_adc_enable(ucb->ac97);
 		x = ucb1400_ts_read_xpos(ucb);
 		y = ucb1400_ts_read_ypos(ucb);
-- 
2.33.1

