Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40B6488553
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 19:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiAHSQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 13:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiAHSQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 13:16:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BEAC061401
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 10:16:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id c71so24037075edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VShwSPVfj7GfXP2tBCw17qNbBXH8y4PIVu4DylC+Yk=;
        b=deXjQd7iwt9NyWs3LiY3Y9oI7jXD9KYC0IAF+0hRTqNmUO46HyW8ILfoOLGfgz//vh
         bCPBuxZGgnjzyrl2hGUk+zougES865YL10Wa9bFX33dyhBpICNXBvbv61Ex2fXGdTLOW
         js2nQ8zOWSmp/Ib607pVKzFkn2YJ6TnrNafCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VShwSPVfj7GfXP2tBCw17qNbBXH8y4PIVu4DylC+Yk=;
        b=Urt5ZyUNRqGbk0r7VUMPxHw/CKArMd9W8SUTfEFtWDXav7VVvjmo40Vhw8j0Zo9Swm
         3Cr3itHA+qSiLtNOKD+BlMjuwH67RRDb1Vza8yQixnVwEIUX/GsQCT8MYI5bSiNMEkZM
         lK3gSt8yjxICFbIZuxBpW6Y5dXmrNdKPl9uq1qTKqF4p4wOjSgM1+ldHj6Bpb9Wpkd7Q
         d4m2MpxWud70hXDXC075iDnL0/zeBCS2PWTvv6VtZZ/103fYqWWaMfVzOOwT2ByDH5Sa
         D4706eOjri/LE5dIoOYFrV9j0GOsRPu2dvpUkwxRqM5/cU1F7vBZ35HipSdymANqpfb2
         7MVg==
X-Gm-Message-State: AOAM531OZiWGAbT5PMIBAWvs6/sndujkgcgZOe78Rr92bD0yyX8sosSN
        MGupiLr8nX2ax58cwFeK/4VgMcsmB2/v3w==
X-Google-Smtp-Source: ABdhPJwV7uU0oXOSs+GBb8Le/beFcuoTyG5jHEtbobZSHjJAhyGtEFElIRca3PoA1E/tV1K+/Oy+rA==
X-Received: by 2002:a17:906:6c1:: with SMTP id v1mr51856789ejb.638.1641665798545;
        Sat, 08 Jan 2022 10:16:38 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-95-244-92-231.retail.telecomitalia.it. [95.244.92.231])
        by smtp.gmail.com with ESMTPSA id cm12sm1016616edb.6.2022.01.08.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 10:16:38 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [RFC PATCH] can: flexcan: add ethtool support to get rx/tx ring parameters
Date:   Sat,  8 Jan 2022 19:16:33 +0100
Message-Id: <20220108181633.420433-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds ethtool support to get the number of message buffers configured for
reception/transmission, which may also depends on runtime configurations
such as the 'rx-rtr' flag state.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/net/can/flexcan/flexcan-ethtool.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/net/can/flexcan/flexcan-ethtool.c b/drivers/net/can/flexcan/flexcan-ethtool.c
index 5bb45653e1ac..d119bca584f6 100644
--- a/drivers/net/can/flexcan/flexcan-ethtool.c
+++ b/drivers/net/can/flexcan/flexcan-ethtool.c
@@ -80,7 +80,24 @@ static int flexcan_set_priv_flags(struct net_device *ndev, u32 priv_flags)
 	return 0;
 }
 
+static void flexcan_get_ringparam(struct net_device *ndev,
+				  struct ethtool_ringparam *ring)
+{
+	struct flexcan_priv *priv = netdev_priv(ndev);
+
+	ring->rx_max_pending = priv->mb_count;
+	ring->tx_max_pending = priv->mb_count;
+
+	if (priv->devtype_data.quirks & FLEXCAN_QUIRK_USE_RX_MAILBOX)
+		ring->rx_pending = __sw_hweight64(priv->rx_mask);
+	else
+		ring->rx_pending = 6;
+
+	ring->tx_pending = __sw_hweight64(priv->tx_mask);
+}
+
 static const struct ethtool_ops flexcan_ethtool_ops = {
+	.get_ringparam = flexcan_get_ringparam,
 	.get_sset_count = flexcan_get_sset_count,
 	.get_strings = flexcan_get_strings,
 	.get_priv_flags = flexcan_get_priv_flags,
-- 
2.32.0

