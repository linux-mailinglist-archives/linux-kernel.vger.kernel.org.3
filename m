Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6724B35A3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 15:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiBLOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 09:32:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiBLOcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 09:32:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 339A1B0B
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644676316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2RrLAaTIm55Ngk8UdioYWo7osufPENpoKGdvpn3KCgg=;
        b=af0Fa0twZEqW/6pK2JCsIEBmvHp+3JmNmph/0Go2qrq4OpfMfojGHdCZTFVjcOjL16J5XA
        n7+rIR5mjQjGsmnboSlmVHMuQCwyh2SZuqa6P8I2UFL2LSDpCu0ZpY3weK/FHjS2PrKTzs
        t40KjWTpuN1KYh7vTRjDnZm38c8UNDY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-QO9GoHqJPimjoVEl1wB0_Q-1; Sat, 12 Feb 2022 09:31:55 -0500
X-MC-Unique: QO9GoHqJPimjoVEl1wB0_Q-1
Received: by mail-oo1-f72.google.com with SMTP id k16-20020a4aa5d0000000b002eaa82bf180so7622894oom.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 06:31:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2RrLAaTIm55Ngk8UdioYWo7osufPENpoKGdvpn3KCgg=;
        b=aSOwA0KiYmuIWz014ogKUuT1j/ga6NH6k/QyeuMiuerNNuvV2wmNPrI9jAOANvtg+j
         Ed9m0rBJ8z2VBrqR9eHP43mPvtrbvtcEhBPwdybrXc8El/Ru0ZF6k07XqWTlyGoe3jhc
         3kuUJMq3KI0LpEy8ysoWT3d5miXfEM7ev5DjqUBEvw5s4X/KWdu4qxha5DN6IuJORWqX
         EzPGkExqfnexO9CVntbTZ2UubdLGmZFykY9SLz3STRohp9iButiUFKjnUCe1UAF5DOsr
         7tKA39Wgr03cInh2I3/LK1g7NfaI+4yZeXQGVX96DyITSTvcHOZH/5tFJLyYupdSW/N6
         Yt3w==
X-Gm-Message-State: AOAM531sGGBcl81+y8DVobnZDzm5D85V/4s0ThPR6jlkvwU1qWJcyG0E
        SmRARmIWYg2UYOllC0teFc8IKvqnU9/FEBn8xIDYuNpNB1E/jy9HXmFi4z8D49/Fdwx6hy+c6I7
        QH9EBzee9eFYDlqtK6RPfQx+c
X-Received: by 2002:a05:6870:c20e:: with SMTP id z14mr89784oae.226.1644676314641;
        Sat, 12 Feb 2022 06:31:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyewSCG+Wjgi3m3HNFwwEl/PZn24w1xKwlIP0KYeT8iviwBv0C2E7QojZ59pqN553AnOO1WwQ==
X-Received: by 2002:a05:6870:c20e:: with SMTP id z14mr89779oae.226.1644676314420;
        Sat, 12 Feb 2022 06:31:54 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q11sm10520833oti.3.2022.02.12.06.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 06:31:54 -0800 (PST)
From:   trix@redhat.com
To:     broonie@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] regmap: irq: cleanup comments
Date:   Sat, 12 Feb 2022 06:31:44 -0800
Message-Id: <20220212143144.2648689-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replace the second 'which' with 'the'.
Change 'acknowleding' to 'acknowledging'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/base/regmap/regmap-irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d5604f497296..81f6356f0589 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -537,7 +537,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 
 	/*
 	 * Ignore masked IRQs and ack if we need to; we ack early so
-	 * there is no race between handling and acknowleding the
+	 * there is no race between handling and acknowledging the
 	 * interrupt.  We assume that typically few of the interrupts
 	 * will fire simultaneously so don't worry about overhead from
 	 * doing a write per register.
@@ -1082,7 +1082,7 @@ EXPORT_SYMBOL_GPL(devm_regmap_add_irq_chip);
 /**
  * devm_regmap_del_irq_chip() - Resource managed regmap_del_irq_chip()
  *
- * @dev: Device for which which resource was allocated.
+ * @dev: Device for which the resource was allocated.
  * @irq: Primary IRQ for the device.
  * @data: &regmap_irq_chip_data allocated by regmap_add_irq_chip().
  *
-- 
2.26.3

