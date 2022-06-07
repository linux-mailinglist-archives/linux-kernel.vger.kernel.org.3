Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6D53FA47
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbiFGJti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbiFGJs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:29 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBEE731C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:48:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x17so23354085wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXpKooudMy6rrQwP/L+KMO1DefLsV+CIObJk2wvPyQY=;
        b=evbcgwrLodZU34XIuCVwQJ3ZMo3BmLtfmTXxcVazlsr7692yB1F8ObOD6ndVu5m8TB
         0iC4uL2nZl/xr/Ii5EumdyjFolS8uOSJAlZrIY9+ZflNisRcBBd1HT3VPlIwwBY45A1t
         vEUr7GkLX5gv2JWwGeeW7ahfTJLgGgSlMQgCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXpKooudMy6rrQwP/L+KMO1DefLsV+CIObJk2wvPyQY=;
        b=L6AGBN2z03tzUSaLmt4oyLnotcdJ9MqW5O1oPt7fypBD5G2iM/eIquTjYv/VuC4/eR
         UbHfNmkk6xbejKCUX4+LTNLclVrvPZvcUussr3WWYqhCfKWSOVb0CbQBR97hC9OIIH+p
         z3TDIbLoDQPxqoiO9SuUOLKh0LjPtNSrJ5mtZLTPZD5+PGOngBv69KvDUAQ/f9aLNyps
         JnA2FeHZWUNGKmwMQ8tYHC/+f3oR3eY0fDtDXOwqx9P4cLvckwQ44Ty/u8mHy8A1yOcN
         kVsABguAGDKcEkq2cyI85lve9laNfQovZOvjjo7KgcAr2oktAe/JWRHjwcTpVyostuOv
         92BA==
X-Gm-Message-State: AOAM531aey3UrcIXBiUFWkOz7nGVa3dFY7W67I01Zvph/0rbSmo5TLFV
        74voY490euUuhPeiTzyYH++XM3uluOxDwg==
X-Google-Smtp-Source: ABdhPJxYOdn4DVYlunCpkOzgrtDCbJ2/Jslh1+k+syWIHIYTieic8n5KCh3ZOQJq/yovCDgxmJHhLg==
X-Received: by 2002:a05:6000:15c7:b0:218:4a5f:75bf with SMTP id y7-20020a05600015c700b002184a5f75bfmr4603612wry.94.1654595305547;
        Tue, 07 Jun 2022 02:48:25 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:25 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH 08/13] can: slcan: send the open command to the adapter
Date:   Tue,  7 Jun 2022 11:47:47 +0200
Message-Id: <20220607094752.1029295-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the bitrate has been set via ip tool, it sends the open command
("O\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index f1bf32b70c4d..f18097c62222 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -469,8 +469,15 @@ static int slc_open(struct net_device *dev)
 	 * can.bittiming.bitrate is 0, causing open_candev() to fail.
 	 * So let's set to a fake value.
 	 */
-	if (sl->can.bittiming.bitrate == 0)
+	if (sl->can.bittiming.bitrate == 0) {
 		sl->can.bittiming.bitrate = -1UL;
+	} else {
+		err = slcan_transmit_cmd(sl, "O\r");
+		if (err) {
+			netdev_err(dev, "failed to send open command 'O\\r'\n");
+			return err;
+		}
+	}
 
 	err = open_candev(dev);
 	if (err) {
-- 
2.32.0

