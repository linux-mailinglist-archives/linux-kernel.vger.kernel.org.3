Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7D57704D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiGPRCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiGPRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:02:13 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D36E201BD
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:02:12 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id k30so9974650edk.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj9ELHhL1KjL7gqHkhN2yD+i8QV7t3oEetXKmHdIgWw=;
        b=bZk/Ttg+pcR6vXUqh/H7EkGHz2DOfwnTd2GF8e+YBPlNpaoz3IiBfhngJZMEWTX0tS
         XeJ8kpu4Epyh15uWjLQ+S2naF6KOUtdXWeWsm6rS8hRxgofi6HkSV5U3tdsy2hMOsHYT
         zy7v/28iyl8JP1rFgybjXk3ZC0rKndIOeD+I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj9ELHhL1KjL7gqHkhN2yD+i8QV7t3oEetXKmHdIgWw=;
        b=5477xQ8y+CpOsMHFmzmtrGn9JTofKvuzfPNU8zA3LV39thyIhXqG2ZUukU/Ft9leNa
         vrNj6NobZcZyCN2uQAknS7tmKN1wGrYMnVi7GVe2IV57mx8pRKvGZPQkNWUpMs/zzFcX
         22phtYftTQLTrKKcU8j5bI+rjtHudEFc6aISqgXpyjZ/f2UunEeAFmxzIwQC37B5EfmB
         VhX1Kv1e3RGFOKl608oT/XQdJIXrFu2WCQQSnb0IEWe8lEb1JcmT7gCokWaYRgo29ESY
         Jfik0W+XIEEfAcYEwOHcAt6jfrT0D5RysI5ExQtpH4zJLPfJIp8dle3p9EC/Qqj4+oZ0
         knyg==
X-Gm-Message-State: AJIora9lzuKI5jNAmFUqojrYzYFSauS2cKh8uI+IlBaAriQRKjcRiADz
        hjIl8WNGphO7H1ivUmlXbc5OpgYo4MsvpQ==
X-Google-Smtp-Source: AGRyM1tJCLaZ0ClqAmFmYKdY8ydo568bbQML09uCOoggZew+Iz1u7HVIJOtoWgVsO5VfCO6VV40tNg==
X-Received: by 2002:a05:6402:f19:b0:43a:f5db:bc7c with SMTP id i25-20020a0564020f1900b0043af5dbbc7cmr16309453eda.211.1657990930578;
        Sat, 16 Jul 2022 10:02:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7cd06000000b004355998ec1asm4970471edw.14.2022.07.16.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:02:10 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Max Staudt <max@enpas.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH] can: can327: remove useless header inclusions
Date:   Sat, 16 Jul 2022 19:02:01 +0200
Message-Id: <20220716170201.2020510-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include only the necessary headers.

CC: Max Staudt <max@enpas.org>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/can327.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 5da7778d92dc..5b0686f953ed 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -12,28 +12,9 @@
 
 #define pr_fmt(fmt) "can327: " fmt
 
-#include <linux/init.h>
 #include <linux/module.h>
-
-#include <linux/bitops.h>
-#include <linux/ctype.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/lockdep.h>
-#include <linux/netdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/string.h>
 #include <linux/tty.h>
-#include <linux/tty_ldisc.h>
-#include <linux/workqueue.h>
-
-#include <uapi/linux/tty.h>
-
-#include <linux/can.h>
 #include <linux/can/dev.h>
-#include <linux/can/error.h>
 #include <linux/can/rx-offload.h>
 
 #define CAN327_NAPI_WEIGHT 4
-- 
2.32.0

