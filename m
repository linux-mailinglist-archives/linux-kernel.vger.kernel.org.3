Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15411577047
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbiGPRAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiGPRAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:00:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0338D2019B
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id t3so10032199edd.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+8/uBRwlHoO2r+QA6MM57OwP4K1pVboHuwKMksUhKgk=;
        b=iQf244o1h93pAg9m1W4w/6vuu9JJdJA98gcI3UDofl9Bg3jug7Dc2ylxEPWGgGO9jw
         wH5nuTOlDOYv0tJPKq2LtZcAryJ0BiT0VMcDTmjArkavoYei7R2Iaw88Odgs9SBGmITG
         lL9vXDXCSd1+/WNnZox7f5ubzIRHPtNxOHRXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+8/uBRwlHoO2r+QA6MM57OwP4K1pVboHuwKMksUhKgk=;
        b=yHaao4LFsW923QBAU9UkJ7yKTJGxKQpz4TrzYyxg6AaiNWQs1VOOxFsCOvUnHHTyGd
         00QyiG0IrGBb32b23MYyP+IYrpUS1jE7hVYS2RUvqxvxjWska3L7dY4k87Choe4UEHh3
         bYx0fa9iuNjlyVIha7Xnvh2H44KkqOy39uWEqv99ajeJfjVtHtob6y279YRV3fWg7a9h
         WWPjZUd+gwn+CAmTc3lhDDdvW0JVQYN79wdnf8XOykuc3vXCafQX3xhTxUGQvR/cpbEc
         cl9G9MMkUIrsLlP7Wj+tWMJ1HwIX9/HNqOUpM5R+VBVWz+QR/s8kf6dlQ6CiYuEaoRFT
         wgsA==
X-Gm-Message-State: AJIora+zENRaNXslMOH05vnuj9EE8/etpkb/D3T9j587M4P95O1U+lcp
        u7nlR5BklU0ffn40V6hW0CTziCWjo6z3xA==
X-Google-Smtp-Source: AGRyM1t55RN31Ums6GxHVUvFkF2Wqoi7Xm0eT+h6dmVYgHSUCJQ48VY5jWJwhZujDP2KwFLdpu85oQ==
X-Received: by 2002:a05:6402:e85:b0:434:f9d9:3b18 with SMTP id h5-20020a0564020e8500b00434f9d93b18mr27275747eda.37.1657990819011;
        Sat, 16 Jul 2022 10:00:19 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-182-13-224.pool80182.interbusiness.it. [80.182.13.224])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906538300b0072b14836087sm3363135ejo.103.2022.07.16.10.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 10:00:18 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 5/5] can: slcan: send the listen-only command to the adapter
Date:   Sat, 16 Jul 2022 19:00:07 +0200
Message-Id: <20220716170007.2020037-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
References: <20220716170007.2020037-1-dario.binacchi@amarulasolutions.com>
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

In case the bitrate has been set via ip tool, this patch changes the
driver to send the listen-only ("L\r") command to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/slcan/slcan-core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 7a1540507ecd..d97dfeccbf9c 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -711,10 +711,21 @@ static int slcan_netdev_open(struct net_device *dev)
 			}
 		}
 
-		err = slcan_transmit_cmd(sl, "O\r");
-		if (err) {
-			netdev_err(dev, "failed to send open command 'O\\r'\n");
-			goto cmd_transmit_failed;
+		/* listen-only command overrides open command */
+		if (sl->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+			err = slcan_transmit_cmd(sl, "L\r");
+			if (err) {
+				netdev_err(dev,
+					   "failed to send listen-only command 'L\\r'\n");
+				goto cmd_transmit_failed;
+			}
+		} else {
+			err = slcan_transmit_cmd(sl, "O\r");
+			if (err) {
+				netdev_err(dev,
+					   "failed to send open command 'O\\r'\n");
+				goto cmd_transmit_failed;
+			}
 		}
 	}
 
@@ -801,6 +812,7 @@ static int slcan_open(struct tty_struct *tty)
 	/* Configure CAN metadata */
 	sl->can.bitrate_const = slcan_bitrate_const;
 	sl->can.bitrate_const_cnt = ARRAY_SIZE(slcan_bitrate_const);
+	sl->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
 
 	/* Configure netdev interface */
 	sl->dev	= dev;
-- 
2.32.0

