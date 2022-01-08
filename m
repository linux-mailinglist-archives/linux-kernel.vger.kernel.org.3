Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082B488453
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbiAHPuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 10:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:44236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233948AbiAHPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 10:50:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641657010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nutHqRyjAUxs0OigylRB1piW55HI8TWHHwTVtcKgRN8=;
        b=fGZB5zbsX0GfqthVikzZQCgMybG5NOq5Q0JwqehAS4rCm874VZTE3tjQJdwJ3Jk/xTcPm6
        OeuMHwGZ5EBv2OCs3+LYO0KR4hrTxEUgPpVI0diok0M3nfciMGLbIgWgQyVsRyTVfMveBi
        x2GjfGyXb1qyvBgmJN/cu9O5nF/zTC8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-P-RHVBGVMaaShUxOPGVmoQ-1; Sat, 08 Jan 2022 10:50:09 -0500
X-MC-Unique: P-RHVBGVMaaShUxOPGVmoQ-1
Received: by mail-oo1-f69.google.com with SMTP id q6-20020a4a3306000000b002daad7a3be2so6130312ooq.11
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 07:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nutHqRyjAUxs0OigylRB1piW55HI8TWHHwTVtcKgRN8=;
        b=QtnxEQxtwp2w9z/qUJPvpHUTMej0D36pJlez9NXptjEgEjPk/sOUDEjTA+5DYM6Y1U
         37RCqBNwwb0UZKyp0ozs4zrCkmERj0DYwi+lttIjj80wtkxfuOPdCoI4Smj8va/TEWmM
         L+ZGwm0+FYg/NNQwa98W+AWuIz4W2/yWLdTTbEb5sGEuPA9KX8A3ZJTN1/TiVCu8W3Ni
         f8EbVYUo86Z8KMHWXwPMFwVVR3E1sus2AuO5FUVF2T5ltaHR6/PpZvqAg5Q59SgnhFKN
         SEKWeijQyV/3qE67fb734iP9C7utHeTQI3/S7ag36PyeGyaAB2rzJZvPDpNwthJQFoNx
         cQSg==
X-Gm-Message-State: AOAM533OpvQ2aD5251nDXqhjw3dhu21ZnT+9luV390o52QzL7oZUQ2nb
        9SZR+Nvpf+w/gf8EYY1SbgUFTDSkR0a5i1sxIQkfL8Dq7sxRIif06G4O9FfVbqdvfr/KUT/uLXO
        ruaxERQRhPvFUMfL/yVQzlBH6
X-Received: by 2002:a4a:d5d5:: with SMTP id a21mr43792304oot.43.1641657008670;
        Sat, 08 Jan 2022 07:50:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDAnHZJpVjRqSRJBkvJ07yYIEgasx5S6n/t1vzZoDi6lprUw7Ku1TMowLE/zzd5lBQtwBZWg==
X-Received: by 2002:a4a:d5d5:: with SMTP id a21mr43792283oot.43.1641657008487;
        Sat, 08 Jan 2022 07:50:08 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q13sm384815otf.76.2022.01.08.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 07:50:08 -0800 (PST)
From:   trix@redhat.com
To:     nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
        Mark-MC.Lee@mediatek.com, davem@davemloft.net, kuba@kernel.org,
        matthias.bgg@gmail.com, linux@armlinux.org.uk, nathan@kernel.org,
        ndesaulniers@google.com, opensource@vdorst.com
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: ethernet: mtk_eth_soc: fix error checking in mtk_mac_config()
Date:   Sat,  8 Jan 2022 07:50:03 -0800
Message-Id: <20220108155003.3991055-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
mtk_eth_soc.c:394:7: warning: Branch condition evaluates
  to a garbage value
                if (err)
                    ^~~

err is not initialized and only conditionally set.
Check err consistently with the rest of mtk_mac_config(),
after even possible setting.

Fixes: 7e538372694b ("net: ethernet: mediatek: Re-add support SGMII")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b67b4323cff08..a27e548488584 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -385,14 +385,16 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		       0 : mac->id;
 
 		/* Setup SGMIISYS with the determined property */
-		if (state->interface != PHY_INTERFACE_MODE_SGMII)
+		if (state->interface != PHY_INTERFACE_MODE_SGMII) {
 			err = mtk_sgmii_setup_mode_force(eth->sgmii, sid,
 							 state);
-		else if (phylink_autoneg_inband(mode))
+			if (err)
+				goto init_err;
+		} else if (phylink_autoneg_inband(mode)) {
 			err = mtk_sgmii_setup_mode_an(eth->sgmii, sid);
-
-		if (err)
-			goto init_err;
+			if (err)
+				goto init_err;
+		}
 
 		regmap_update_bits(eth->ethsys, ETHSYS_SYSCFG0,
 				   SYSCFG0_SGMII_MASK, val);
-- 
2.26.3

