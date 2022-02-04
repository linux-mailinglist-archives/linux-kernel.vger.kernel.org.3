Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B72F4A9B0C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359343AbiBDOdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359340AbiBDOdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:33:42 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB4C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:33:42 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v129so1100754wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRfuw26kbdaIgCIMJCrn0p/ikh8G5VstHoJyqrHzaY=;
        b=N5GoAcSlGGBJtMEbJ0ukMjcahDwIi6iA2QZkJabB//WJv/G54PfC1Qrfzg7/ZI1TYh
         GXhH0QCbw+gpq7uTm0dWhu7TcRTYxOcV5k7t/lsc6n2nPvf9RmCPWHgzUrMufrxVAT1G
         Lsm/WHY6QYMbH7NqBUFUJRx5DCm2DZkKPdQVSIC86woRjsZkuzlUJwbFshTnN4NtWfni
         7g1L/qjPxy12sXSFEjZJ3ZERFtzvB35xQ+w8LuY1lSKUAqPW88dNka/ITANmbxgilrhl
         egqC9SA4Fpv10xkSU1ukvLxU+IEjvuHmqg3MBKOUTv65hnqvE0/FUcvuWcLHrwN3pQ52
         jyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9HRfuw26kbdaIgCIMJCrn0p/ikh8G5VstHoJyqrHzaY=;
        b=HkJNGhoH/KvxfXDmhQAgtZyIM2pAfGE/Ifef3EbSBa1yGfccdYOqwH1f1SH5s2Lqlq
         nZNUolyIVqWklN1lqAlbx0Fxb9jQiUedhKiUEiOMxZ3JLoVEd6vH1hfkTTeePjE94CK8
         OV7THpW6w5YLfDVP4jrMY2B0GHWZi5koIpK5LwVD9feNpvM/ReSMdMG9TRfGPrFQvV7e
         ClTp/rUpleVlsPUaQEISYZ/f1eBl3O6nbZs1WCwTOIFYVS8Hpcp4V2p2fB0IKdXg0eg8
         N+ApbDVdWinxzqJ2jSlFpPF7gbEp6sWJm2h5C3mueqk+oYNQQrdAYIEShDr7GHyp6aji
         UVfQ==
X-Gm-Message-State: AOAM530toxF1e3k+2jj/euaCnpB4pYXNJ1ZtiMTzROEWVteshKR8bp1r
        Uj4TarehrDN0Uw6KPd/mmbVLlQ==
X-Google-Smtp-Source: ABdhPJzM7rirBHeEKddHJTpT/8Ll2fTTFTnqEyoWqAVCMisHdXwtzMHwgV7V/Gu8b3v9CLpo+s2nlg==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr2438315wma.159.1643985220416;
        Fri, 04 Feb 2022 06:33:40 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3fbe:ff10:110:739])
        by smtp.gmail.com with ESMTPSA id p14sm2426053wrr.7.2022.02.04.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:33:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        biju.das.jz@bp.renesas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v3] drm/bridge: dw-hdmi: use safe format when first in bridge chain
Date:   Fri,  4 Feb 2022 15:33:37 +0100
Message-Id: <20220204143337.89221-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2327; h=from:subject; bh=e5N2iKj5YSVB+9PoyzM1SrjuyNvunszme9UDF4PNMaY=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBh/Tk4oLM2pdcdSB7huyqScnob/k6VvXol8zz9+/KN tCOP+9WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYf05OAAKCRB33NvayMhJ0dKGEA C8cPNgB5xfu4qvomB7nSOs2N1+E1x6dlkhbX5Pl6yeV61+6btrGe61Ca8kDv3E/lubtBCDjytFLCyn ot2ZtSgYUbn59l0WyO4fp5eijMILLBg+RFbA54pxb3O0qmHYsEU7Xf6MvULgsUzv30d6Q1BzK3ZhmQ vLYJdjRuCkwHtD+FWgZNfHuL85wLRH9H7VZVsHYM5DvNq1LDZWblU84uhJxa9x1IhH9QNvYWdbudNh MKj2nW9417G4++HwulDwqtI/h/aKGoNVLkM4lPByFQWeSdwjNvDhDAgKIPyr13TTWyFeI6KqPfF1A3 TWXAbdiI7bEnjhmJCfAJENISJ5BfajEcUyhrOQAWMptsL4cVi6HjfvsgJ7fk92Vagt1Nc95yRZ7wbo 1bTnzRW+eTlILZsI+oVc7neJRo7iPwqz4VMbuisNHLCKtU5U2RsAui/aJ3bkqTCN6aZcMMLeWN9jeR 5Sr1981EYsHHYevtwp6rua8Vp7OdaS+OKj8oikCfxhPLf3OvfEXQfejn3G+qVTbzN71qu5i5wvgQqL t9m+gl4nkmJ8zwHcJQRE0LVoIXTexE55U14yiHBdhcw/9T5GxhjHDrcOGerygvHY85iKIdCK4V2TKR 7o1ZuRlo0Ua/FP6wyvXTE3d3eDNII2wzb5RcOErBgidOAqri1TtWNksiq83A==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the dw-hdmi bridge is in first place of the bridge chain, this
means there is no way to select an input format of the dw-hdmi HW
component.

Since introduction of display-connector, negotiation was broken since
the dw-hdmi negotiation code only worked when the dw-hdmi bridge was
in last position of the bridge chain or behind another bridge also
supporting input & output format negotiation.

Commit 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks")
was introduced to make negotiation work again by making display-connector
act as a pass-through concerning input & output format negotiation.

But in the case where the dw-hdmi is single in the bridge chain, for
example on Renesas SoCs, with the display-connector bridge the dw-hdmi
is no more single, breaking output format.

Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Fixes: 7cd70656d128 ("drm/bridge: display-connector: implement bus fmts callbacks").
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Robert Foss <robert.foss@linaro.org>
---
Changes since v2:
- Add rob's r-b
- Fix invalid Fixes commit hash

Changes since v1:
- Remove bad fix in dw_hdmi_bridge_atomic_get_input_bus_fmts
- Fix typos in commit message

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 54d8fdad395f..97cdc61b57f6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2551,8 +2551,9 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	if (!output_fmts)
 		return NULL;
 
-	/* If dw-hdmi is the only bridge, avoid negociating with ourselves */
-	if (list_is_singular(&bridge->encoder->bridge_chain)) {
+	/* If dw-hdmi is the first or only bridge, avoid negociating with ourselves */
+	if (list_is_singular(&bridge->encoder->bridge_chain) ||
+	    list_is_first(&bridge->chain_node, &bridge->encoder->bridge_chain)) {
 		*num_output_fmts = 1;
 		output_fmts[0] = MEDIA_BUS_FMT_FIXED;
 
-- 
2.25.1

