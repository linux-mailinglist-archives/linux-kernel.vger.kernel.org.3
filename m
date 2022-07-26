Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B28581B7F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiGZVDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbiGZVDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:03:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDEB39B84
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:03:32 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id oy13so28291829ejb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 14:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbjoK64u0Nv21CxxlQFKwTPmVGnv7nDMih2pZ9805sY=;
        b=GloOwx/mjqWNTBIruncM9LkFCOZkc2UOaD7IseiTwHdhn4irmVkMfStnM5n8Zh1qNL
         20V9WdntIvH8ofXnikjslCLyjDCyDLIc6SxHaLnX1LVdQwluiyctg8RrfF7P422yWmr0
         gW/rtFlANqXyZ/euPB9UEWKlLTxfIGasBCw5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbjoK64u0Nv21CxxlQFKwTPmVGnv7nDMih2pZ9805sY=;
        b=dOkyAQ3EDB9cPCLG/9S+k2Fj/9Uyd5dpKUoOr5xEZJtoM+tsDdvPWwGcPNGJX7e0Ij
         BtVCBax06fpNWZlUuPFws9CbIY7K+gusPRCqNI4EY4EWqU4pi5ByXNYH9t1SuQGda0Be
         t9MCB9eLag/+4MovCmG7k3SqJEajp/zMPQuTDsH3dQWGGAbjj03Mecvq3f7EUuPq8pub
         CqdFwhQo9mXzmSvGDI55+dmQK4TCC6TVyxGmEKLYnWMqP4EUYnGRvsYJMCNT/Bgy5MTc
         UM2EC0tw7FObLxI1nsE8mAvBdhhXuPIpEcfepr06GBMvBwT8+DlFXNNk0NXBfabDW9ZT
         4zCA==
X-Gm-Message-State: AJIora+YzJuW+hAbo/hAxCH41db3WMzXmEYNpwRMJq1JBt7F5a5LYx53
        XXEfxQo7aSwsId4AaAU7Mpc2Kxr1Kemmkw==
X-Google-Smtp-Source: AGRyM1snew7kUCiFo9sAiSZ/cUgI5GLDEj3mYvcTRpfTmRKgyveqFEysewT5GbasKZ2X1WB3sl+v1g==
X-Received: by 2002:a17:907:3f1a:b0:72b:394b:ad32 with SMTP id hq26-20020a1709073f1a00b0072b394bad32mr15286276ejc.445.1658869412188;
        Tue, 26 Jul 2022 14:03:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-87-14-98-67.retail.telecomitalia.it. [87.14.98.67])
        by smtp.gmail.com with ESMTPSA id y19-20020aa7d513000000b0043a7293a03dsm9092849edq.7.2022.07.26.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 14:03:31 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org
Subject: [RFC PATCH v3 6/9] can: slcan: add support for listen-only mode
Date:   Tue, 26 Jul 2022 23:02:14 +0200
Message-Id: <20220726210217.3368497-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
References: <20220726210217.3368497-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For non-legacy, i.e. ip based configuration, add support for listen-only
mode. If listen-only is requested send a listen-only ("L\r") command
instead of an open ("O\r") command to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Remove comment on listen-only command.
- Update the commit subject and description.

 drivers/net/can/slcan/slcan-core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index d12d98426f37..45e521910236 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -726,10 +726,20 @@ static int slcan_netdev_open(struct net_device *dev)
 			}
 		}
 
-		err = slcan_transmit_cmd(sl, "O\r");
-		if (err) {
-			netdev_err(dev, "failed to send open command 'O\\r'\n");
-			goto cmd_transmit_failed;
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
 
@@ -816,6 +826,7 @@ static int slcan_open(struct tty_struct *tty)
 	/* Configure CAN metadata */
 	sl->can.bitrate_const = slcan_bitrate_const;
 	sl->can.bitrate_const_cnt = ARRAY_SIZE(slcan_bitrate_const);
+	sl->can.ctrlmode_supported = CAN_CTRLMODE_LISTENONLY;
 
 	/* Configure netdev interface */
 	sl->dev	= dev;
-- 
2.32.0

