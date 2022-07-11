Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BDF55EA00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiF1QgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbiF1Qer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:34:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1355326DB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:31:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n8so4413079eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV071olECEu2/Ezmqg7bgOsDRoG54OcMsrjIhEz/HxY=;
        b=Qa1Xsd/SAEcqOFctzhZ2ITrvHpAKlBNkgsWdWrlhWBDVG+phXclxnB3toeB+QEo1vx
         VGUq1VhpB/tqonLXMxOfbw2V5f+cUR5Iyi5u3Khqj3aDMwBL3FAydA+wz6At1EKQmIX4
         zlj1nvDLFne26VH3rZUpS4UoTWBzFL2VKgsI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV071olECEu2/Ezmqg7bgOsDRoG54OcMsrjIhEz/HxY=;
        b=F684p9kKLx4PdQFokEGx6OruJkkHb6I2WGPGjjiUVCMAcal5Oqgd63tBqEiQgF59AK
         U9EAXOW7vXSXVDOX+0SxiK8Br6V2IVHFZ2oRbynLdSaOREeHaEyQ0rt1t/gpoy8ClfO1
         8aiotQ7tdT2zF+T5ZoH6zR2dUmAmEmC/3rvOMxh8ig025mo4MWzuv/oiQgg9u8BzN6Wf
         GSsbF5MXi9bSviiXLVr+AlT0eT0I7HHuoIkbdyoTUPahbw73UEOSJ7JFzaYx7C8SVzfz
         8oKqj+mr/WuHsjyPkBO82/qZ6ab8TZf0UT1HixERWE04QuC4ZFsbEANFccR0RR9iDPpb
         e12w==
X-Gm-Message-State: AJIora9nAiQbSL/NgtZKx0eOg4CGhleeYC5r5OSIu1H/YxJm+LYMeawL
        tGbwq6i1qKZReZxb7Rn784SiNE5FC1gLQQ==
X-Google-Smtp-Source: AGRyM1sBYiHVqvAao7ebFu6YzOjM0r/hZUSSLLp/29zzE6hCI/AyZi8PN6ZVXgdWM+yasPoaI9ooCA==
X-Received: by 2002:a05:6402:4244:b0:437:726c:e1a with SMTP id g4-20020a056402424400b00437726c0e1amr22041449edb.107.1656433914004;
        Tue, 28 Jun 2022 09:31:54 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b0042e15364d14sm9916952edb.8.2022.06.28.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:31:53 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 04/12] can: netlink: dump bitrate 0 if can_priv::bittiming.bitrate is -1U
Date:   Tue, 28 Jun 2022 18:31:28 +0200
Message-Id: <20220628163137.413025-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
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

Upcoming changes on slcan driver will require you to specify a bitrate
of value -1 to prevent the open_candev() from failing but at the same
time highlighting that it is a fake value. In this case the command
`ip --details -s -s link show' would print 4294967295 as the bitrate
value. The patch change this value in 0.

Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v4)

Changes in v4:
- Move the patch in front of the patch "[v3,04/13] can: slcan: use CAN network device driver API".
- Add the CAN_BITRATE_UNSET (0) and CAN_BITRATE_UNKNOWN (-1U) macros.
- Simplify the bitrate check to dump it.
- Update the commit description.

 drivers/net/can/dev/netlink.c | 3 ++-
 include/linux/can/bittiming.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 7633d98e3912..5427712fcf80 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -509,7 +509,8 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	if (priv->do_get_state)
 		priv->do_get_state(dev, &state);
 
-	if ((priv->bittiming.bitrate &&
+	if ((priv->bittiming.bitrate != CAN_BITRATE_UNSET &&
+	     priv->bittiming.bitrate != CAN_BITRATE_UNKNOWN &&
 	     nla_put(skb, IFLA_CAN_BITTIMING,
 		     sizeof(priv->bittiming), &priv->bittiming)) ||
 
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 7ae21c0f7f23..ef0a77173e3c 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -11,6 +11,8 @@
 
 #define CAN_SYNC_SEG 1
 
+#define CAN_BITRATE_UNSET 0
+#define CAN_BITRATE_UNKNOWN (-1U)
 
 #define CAN_CTRLMODE_TDC_MASK					\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
-- 
2.32.0

