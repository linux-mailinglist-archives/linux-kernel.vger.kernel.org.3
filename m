Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B52547C9C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiFLVlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbiFLVkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:40:21 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8542A724
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:40:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kq6so7662738ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AAKaIth+G/AmEuzfr70Dsvzk4FxXYLQFFVrvRHhl0zE=;
        b=Qr//VDTJlM3yW6NMOsV6Ote3kssYtDIpQaISCw/bS+xF96jzFDXuevaWjaTtWkVcSK
         vYCwdE4iWIVd8vDsjmjwW5ejgo2/mhUw09BsmMuB+Nxt2mmnRL+VB8nLL30uTe4MXkU7
         dRU9p68g51DFLMOdk5sBrL8dgNnxp5yqS/Aec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AAKaIth+G/AmEuzfr70Dsvzk4FxXYLQFFVrvRHhl0zE=;
        b=KtggBO25YFZzGakH4RB+PY4arLQe/2vz8mlCXWfO0zy8dJdSFV6ZPBnsXsY9Xr3YST
         44A9NVovMbhZcBjfLa+rVh23vFtzswQIaDMSP01qpuwFx0EB7bVZqYJSouy/QMKg4U71
         wouw1vDKo9DXWl6NIIB5rzZl4JpIXBK0xTmnYDPefEGrSDJ5Rx2HAy8OnLMVoenFdHgb
         YZG/RfqwnLsTKYqd3ZTT0rW864L9pUeUAvbslS8956sONnsuyk/ZBqhzMLu3STmNz8Gu
         QtWIPFzWw908283tKK5c0NRd2QwYWiPEgUjJbsimkFASDbCMqop7o6u6I/XjVKzojSiA
         61IA==
X-Gm-Message-State: AOAM531qbgzQmLtwYsdYPrzlg4HmCaNYjUxe9VPCydQoZZ0nusT13lGy
        ImhmG0Vp0IXNOWanLNDRejmrOlpGAQM1qA==
X-Google-Smtp-Source: ABdhPJw1gEsC80Io0jkEH7Fe3Uht5G0w201EyPmerbdjsm0uSmJLIrZjPwPByXsqXi4uCYhG/Egfhg==
X-Received: by 2002:a17:906:1c9:b0:712:1115:42a5 with SMTP id 9-20020a17090601c900b00712111542a5mr15154695ejj.662.1655070010102;
        Sun, 12 Jun 2022 14:40:10 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b00711d546f8a8sm2909398ejh.139.2022.06.12.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:40:09 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 08/13] can: slcan: send the open command to the adapter
Date:   Sun, 12 Jun 2022 23:39:22 +0200
Message-Id: <20220612213927.3004444-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the bitrate has been set via ip tool, this patch changes the
driver to send the open command ("O\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Improve the commit message.

 drivers/net/can/slcan.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index be3f7e5c685b..9bbf8f363f58 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -495,14 +495,23 @@ static int slc_open(struct net_device *dev)
 			netdev_err(dev,
 				   "failed to send bitrate command 'C\\rS%d\\r'\n",
 				   s);
-			close_candev(dev);
-			return err;
+			goto cmd_transmit_failed;
+		}
+
+		err = slcan_transmit_cmd(sl, "O\r");
+		if (err) {
+			netdev_err(dev, "failed to send open command 'O\\r'\n");
+			goto cmd_transmit_failed;
 		}
 	}
 
 	sl->can.state = CAN_STATE_ERROR_ACTIVE;
 	netif_start_queue(dev);
 	return 0;
+
+cmd_transmit_failed:
+	close_candev(dev);
+	return err;
 }
 
 static void slc_dealloc(struct slcan *sl)
-- 
2.32.0

