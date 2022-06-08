Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4755439D8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbiFHQ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343830AbiFHQyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:54:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9353C8834
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:51:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so42664783ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHEZAJdjR8GiF2rcZjyRDsrMR8WF0LYSErHxMnZ6s20=;
        b=MZKbWtENK8RJ8mhEjef9zX1yTSZS9BgXM713QnAIg2L5afXoz8jXYkkuBHY/6qGvq2
         Xe/QJ8v++KscQsY1vp5+FFXyjT5O8ONPWQHFmXAXNoZICKoiCOJhQrjDn+sSrZffVhnr
         COMtwcIGOuyD8SJi3niX6Nfuh82Vs1jbao2PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHEZAJdjR8GiF2rcZjyRDsrMR8WF0LYSErHxMnZ6s20=;
        b=kngJyN6hufuoajw9cbYfyBaLz3H2XM4RSASftAtIeRXy3f+bPTBf5uuuU8WJraudYQ
         cfmutCZuAVYnpRvStdPYcBQocc2945j+prPaGKGJWlEk1mV+a/lBnnDkSuvXV/XIlX/K
         EzzS/6UAUS34OZ29M3iTzp2+cHHgNqsOBT9ZT9xDUqLA1sWOxKEidBa6NlX8eDGVCInd
         8XCyT4TyJRQk3r4ewSsb+WqrPyfAlpRIaAAHtZ5W66RLJejiET4ZMo1ILUN78vo/qSFg
         a6VJERTyIyuRYTp34IFdrLUL61JrvzjoM1ObUScCP3EH4Xlos0fcFP6Ewik1s880XGQN
         AT4Q==
X-Gm-Message-State: AOAM533Wm7e1rg6f1NCROVATtEfovXVKn1rEen1ExUl25GXtA+6QtU+E
        vRj/20jlWefCx00r0VSUR5TgWZX22ba9kQ==
X-Google-Smtp-Source: ABdhPJz1QODapFEAg4YigkTF2RHGdIx+/6uauzW1WsQ+9FsAAZvY0lK1/PlsjrZhGolAZLbjarVnZA==
X-Received: by 2002:a17:906:4a83:b0:70b:156f:9098 with SMTP id x3-20020a1709064a8300b0070b156f9098mr31951137eju.109.1654707095099;
        Wed, 08 Jun 2022 09:51:35 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:34 -0700 (PDT)
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
Subject: [PATCH v2 08/13] can: slcan: send the open command to the adapter
Date:   Wed,  8 Jun 2022 18:51:11 +0200
Message-Id: <20220608165116.1575390-9-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
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

In case the bitrate has been set via ip tool, this patch changes the
driver to send the open command ("O\r") to the adapter.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Improve the commit message.

 drivers/net/can/slcan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 8561bcee81ba..ec682715ce99 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -461,8 +461,15 @@ static int slc_open(struct net_device *dev)
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

