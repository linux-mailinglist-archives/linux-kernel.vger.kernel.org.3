Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852057D146
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiGUQRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiGUQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B479E5FDF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658420138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PPUfN2aC/PVXDzfJ07LBJeBzGqwt66XBq8iYF1IJ01w=;
        b=II7ss+O2pkFarlRHTTihC9WY/29SDirOnwXXJiR5oFOAKQ9+etUK8wN0aZK1xMFzziaL6Z
        L5P11d6lZKthrPBWA8f7rjWQoS6NRH5xM8VeaeU7JEgQIJQBxwCc9CdL2zqPo8YSMH2/Nf
        RJZ6CV4blLFMVMycdJOCa+dxScAjtvM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-8YrzhRtmOMakX6TrTtHQVg-1; Thu, 21 Jul 2022 12:15:36 -0400
X-MC-Unique: 8YrzhRtmOMakX6TrTtHQVg-1
Received: by mail-qv1-f69.google.com with SMTP id lp7-20020a056214590700b004733d9feaf6so1361537qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PPUfN2aC/PVXDzfJ07LBJeBzGqwt66XBq8iYF1IJ01w=;
        b=O8trmznMG+/KuNOi0Dr24TKUOvjFT+Ib2TKf3U7fQfuvhPuJWfjCm8HJmHpmy9KK8A
         EXjks97ZTfLLXOX/cuzhx+WOC/tloGqztt5e+mjh46KYrQcIqY/4j23BYhC7Mxz3GPZk
         8M1UQL9k76SCpJPsN7W7u3U71Cns/gxOtdQFk/mwjdTCmOAUwLsF1PMKR/ofS1oCqIty
         5Jg0RbEGcfz6sSSLJvjRh0OQeMb+PjSkE1WRpEvUlRq/5/xoZl6HtWoEhpHxN+HaS66I
         qSx+VieyOJbvBiI77nTeZ4T5pyYeqblqGt4QVe3ZQOozTMgzCxb1T/Rb2H+F7BHKpmgB
         eP9A==
X-Gm-Message-State: AJIora92DCkySy0l9Lx2AY8lXx1BjBXmcH2VV97kfPP83EDYavLLIMza
        b2coNnXk06K4lQoUYyJoy1uD97WJssQtuJKAWx/IoTy98BWJBSKOAbDS/08w2C+hUwXnfig1mME
        aUlKSyWbOpn9r8O4HgRWAiC94
X-Received: by 2002:ac8:5a52:0:b0:31e:f585:3d66 with SMTP id o18-20020ac85a52000000b0031ef5853d66mr15116751qta.90.1658420136217;
        Thu, 21 Jul 2022 09:15:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vBeHanWUmyHthB96zttRkCX6UHShHu5dTY7wk2xVfGz3V9RUE/OA/ewP2v5Pq5J8ymODrXBA==
X-Received: by 2002:ac8:5a52:0:b0:31e:f585:3d66 with SMTP id o18-20020ac85a52000000b0031ef5853d66mr15116722qta.90.1658420135971;
        Thu, 21 Jul 2022 09:15:35 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a410200b006b5cb5d2fa0sm1868385qko.1.2022.07.21.09.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:15:35 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        mailhol.vincent@wanadoo.fr
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] can: pch_can: move setting of errc to before use
Date:   Thu, 21 Jul 2022 12:15:26 -0400
Message-Id: <20220721161526.930416-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang build fails with
drivers/net/can/pch_can.c:501:17: error: variable 'errc' is uninitialized when used here [-Werror,-Wuninitialized]
                cf->data[6] = errc & PCH_TEC;

The commit in the fixes moved the use without moving the setting. So move
the setting of errc to before the use.

Fixes: 3a5c7e4611dd ("can: pch_can: do not report txerr and rxerr during bus-off")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/can/pch_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/pch_can.c b/drivers/net/can/pch_can.c
index 50f6719b3aa4..32804fed116c 100644
--- a/drivers/net/can/pch_can.c
+++ b/drivers/net/can/pch_can.c
@@ -489,6 +489,7 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 	if (!skb)
 		return;
 
+	errc = ioread32(&priv->regs->errc);
 	if (status & PCH_BUS_OFF) {
 		pch_can_set_tx_all(priv, 0);
 		pch_can_set_rx_all(priv, 0);
@@ -502,7 +503,6 @@ static void pch_can_error(struct net_device *ndev, u32 status)
 		cf->data[7] = (errc & PCH_REC) >> 8;
 	}
 
-	errc = ioread32(&priv->regs->errc);
 	/* Warning interrupt. */
 	if (status & PCH_EWARN) {
 		state = CAN_STATE_ERROR_WARNING;
-- 
2.27.0

