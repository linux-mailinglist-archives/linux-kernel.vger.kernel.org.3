Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85E15ACE69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiIEJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiIEJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:02:09 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9713ECF2;
        Mon,  5 Sep 2022 02:02:07 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 78so7553060pgb.13;
        Mon, 05 Sep 2022 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=IwCY9yh1KV6YjPlP2Mxz2uSKn9Ob1reg8TYa2z2RagI=;
        b=FzdOMOH5IMtW8sJTuSfMIJTpTH6spbLKut2EpMKZm5k2cDKbUDmckQ4tI/lPvHrvkP
         S5e5xFQtlmZnPYXTdY7B/VqmG0bLXgGI2MP8AscK36AwikTtkSmykNXxIgcrpdX921MN
         eSGv5WIygQ7zl9uQIHPA/DTJ03ljGkWE1Wdei2r53uTNXjBx3aT7qaLyF5xTuv5pUWkW
         7XQma2L9a4NCQ5E71VhOgj900DI497Bl9A4rkk4xAOwM+dScTteHTSqkDR3YWH/MA9Sg
         tgjih8UAsO9q5oqu0hXWBoYaGoeT2Umce43seMh1ZUs8B6Cfsw59hk3AjDxjLpc5IL64
         X3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=IwCY9yh1KV6YjPlP2Mxz2uSKn9Ob1reg8TYa2z2RagI=;
        b=oNrXlPpUCf95AyqR/jdSbItStg1A+L7U1xYgZhtNUlpG5U/XXpvnjnp/edPhPNnK/R
         fdaKkCxwzs1u8kooz3udW+uLB40DxgjAZbt3FfjWLXfbX6ByYuLrV6QwgqC1/JAtW4Wj
         HDn/q9RH1yXP7IrnlE/QQtT34uQ3YMXyljawlCQV8EZAjf8c/g5yLLjA2nl8MJLTJNSJ
         zQ7jxABzikc4Qk+Ke0xBmKpKWZsm/E4oTiur+KYJV1dGbJXiHM1rL+2551C5ixlA9ecJ
         tJTA5OLE4S57LtuhIb9jovqR85iGVVZdkHgFSPSgS3ZMggCjXK9tzFzgRbKxs3wufVlR
         AePA==
X-Gm-Message-State: ACgBeo370vgEwWvc/SQZo4wPxu/Ku85MaYLLumSI0RkfhorUrgnPCRmV
        i6bIzNYD6+j8dXJv4kEF+b8=
X-Google-Smtp-Source: AA6agR729EAnDAibxD7vrrp494UwgXkaymVpUFvy0Z8dmdHN3mEILRA0KgVX1CCmS5Dgw6TH4Wl1hg==
X-Received: by 2002:a63:a43:0:b0:430:9ec5:4775 with SMTP id z3-20020a630a43000000b004309ec54775mr15474272pgk.572.1662368526552;
        Mon, 05 Sep 2022 02:02:06 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902bd4800b00172c7dee22fsm903427plx.236.2022.09.05.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:02:06 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] media: tuners: Remove the unneeded result variable
Date:   Mon,  5 Sep 2022 09:02:03 +0000
Message-Id: <20220905090203.335184-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value xc_send_i2c_data() directly instead of storing it in
another redundant variable.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/media/tuners/xc4000.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/tuners/xc4000.c b/drivers/media/tuners/xc4000.c
index a04dfd5799f7..d59b4ab77430 100644
--- a/drivers/media/tuners/xc4000.c
+++ b/drivers/media/tuners/xc4000.c
@@ -282,15 +282,13 @@ static int xc4000_tuner_reset(struct dvb_frontend *fe)
 static int xc_write_reg(struct xc4000_priv *priv, u16 regAddr, u16 i2cData)
 {
 	u8 buf[4];
-	int result;
 
 	buf[0] = (regAddr >> 8) & 0xFF;
 	buf[1] = regAddr & 0xFF;
 	buf[2] = (i2cData >> 8) & 0xFF;
 	buf[3] = i2cData & 0xFF;
-	result = xc_send_i2c_data(priv, buf, 4);
 
-	return result;
+	return xc_send_i2c_data(priv, buf, 4);
 }
 
 static int xc_load_i2c_sequence(struct dvb_frontend *fe, const u8 *i2c_sequence)
-- 
2.25.1
