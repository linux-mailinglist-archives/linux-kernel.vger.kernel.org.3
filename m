Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3703583925
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiG1HEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiG1HDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 03:03:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618765F9AD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:03:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a89so1008219edf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rbjoK64u0Nv21CxxlQFKwTPmVGnv7nDMih2pZ9805sY=;
        b=C7FiLKyPZ4FCyqVqKHTH0u3kzThIUIHGzGmpENUKjs7lLn7nuUq/F0CDRctZUOrMk0
         t/sOrj4XKkHTilO8LlZmAL9oP2tcS+Sy+UE/uX2MEMsB1NNAd7leYUH/HnurR9cskWjj
         Rz7KsIi2lK03nyurAxH0h8wZB/OCTTkST0yaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rbjoK64u0Nv21CxxlQFKwTPmVGnv7nDMih2pZ9805sY=;
        b=an8UloI8KVaRl1XHWJmvydcmfc70QtNxF40yQJOQxhspyeR7GsNvwtXSPnU0rTV+U0
         azu7kwxRZiyRQ34e+u03ZaAWStH4BnhvtNrLpUOqwIYohgGcKwFU26OdiizYNSP0N+ek
         01QvQjqSZfgAnZN0oHJZM7Ra37rFAb/cQMC21XfIpidZCA3btSHYgYdPISxkLtry1OYu
         EOJJkAixIlYyDEzXAL9Qo5abH2pg1mUjvae7GzngDYCOe+YXmZKVu8W3xjOODysqexVh
         1SRP5bGve7ZgLHADiHIAPVQkO/VNb4HX9AZ1uPasTVqIVKGI3iZpbn3MpI4qSyNO8ryc
         W2Zg==
X-Gm-Message-State: AJIora+DgBHKDu1aksitv9j5PKU0QlvhCShuRadLdW+4VGQYiY+ax372
        xmkL+NdpTmF/vpooiHw2Y9W02wyhAhh4lA==
X-Google-Smtp-Source: AGRyM1uBR5AmviksetzaG5WE2+2jyI37tQsV8728O+HE444Wk7IkXUhiFt8/ACmFoia+fP8TRbtmTg==
X-Received: by 2002:a05:6402:194f:b0:43a:298f:f39c with SMTP id f15-20020a056402194f00b0043a298ff39cmr26569587edz.106.1658991791472;
        Thu, 28 Jul 2022 00:03:11 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7d152000000b0042de3d661d2sm154742edo.1.2022.07.28.00.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:03:11 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>, netdev@vger.kernel.org
Subject: [PATCH v4 6/7] can: slcan: add support for listen-only mode
Date:   Thu, 28 Jul 2022 09:02:53 +0200
Message-Id: <20220728070254.267974-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220728070254.267974-1-dario.binacchi@amarulasolutions.com>
References: <20220728070254.267974-1-dario.binacchi@amarulasolutions.com>
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

