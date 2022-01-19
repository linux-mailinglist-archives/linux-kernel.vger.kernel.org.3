Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B97493A41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354459AbiASM2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347469AbiASM2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:28:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF1BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:28:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i187-20020a1c3bc4000000b0034d2ed1be2aso12789238wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r544K7uLseHgCwnr0wVsLsWb82uTNW4lOUdN19AMQDw=;
        b=ceClqTAml5TYR5w+T+ZUWlwr1D+2NbFkj4hG8uCQABlOpUcRyrrtPMpIl7N/U2sTCd
         uHy+5wvddi5ifxY2MRj4gPyKyMexkgoGN2BcnSdELPzOdgrBLXVyhyKFTVTAnBhjCaSq
         upeG3CpIhfmFfjyZER+/wNiTMnAqdPBwK7PG6rB+BdYy2kmLDEzlVPLDAa6+9yQl51Mn
         uX+3SYqEG0XjAQNmKp1DJRxIp2NdNDAuQZpw1PKuN0l4rJajkxh12xqHAqy5lQ0kE3yY
         WmT6OzgdO2wTmA62wb/p7F09kM9gYqtMxelo/nX7EFeTqku29l9GNYSzhaAS2x8hkClm
         sW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r544K7uLseHgCwnr0wVsLsWb82uTNW4lOUdN19AMQDw=;
        b=uYjKuH9NHPo3SNzhWEsHfs9zMS+I9mN2A6XYdRIIQVYsjMYHmSnl+e+UOJgSmHl9i1
         Ll8LiHzogw89dFz+OCcFgswmHLU3leKjxLezBg3JxejoxCBMpbmNthxOmKF8z869MA5h
         O68AN/gZfvq92HYyMeLIzTQAOtybHGSTPeAfoYDiM+CZEv5AWWzqiLz081Dn+UjTNikx
         LLEhgP6WydQoo9zjarBoB5k4LD30NCL4jucGKFb5pHGY83y4dKUDjZof7E8XQu6jXjx0
         6DguwAeXt+4Pzn41OpI5TWOjfXeZx1hLpc/0mWtSxuEyRT7D7UO+pT6K5sxFwGTFSZ3Z
         aIyA==
X-Gm-Message-State: AOAM533tDn0KhcLxZlCR1PlXp4/T2If5HwY4+FcanQEyri4Ke27O481P
        DlZo0/8xN6SHlPP4Tz1XrcjCakpsya/CVQ==
X-Google-Smtp-Source: ABdhPJyW0VTGSUd7xafQtG4NJPiTaXvdlNPbOk8sepjeULE2SjuZDvmR9Pomag4u/PrmPjUi+Tsqmw==
X-Received: by 2002:adf:f94c:: with SMTP id q12mr28259235wrr.166.1642595325796;
        Wed, 19 Jan 2022 04:28:45 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id j16sm19406933wrp.76.2022.01.19.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:28:45 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kieran.bingham@ideasonboard.com,
        biju.das.jz@bp.renesas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Subject: [PATCH v2] drm/bridge: dw-hdmi: use safe format when first in bridge chain
Date:   Wed, 19 Jan 2022 13:28:43 +0100
Message-Id: <20220119122843.1455611-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Commit 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks")
was introduced to make negotiation work again by making display-connector
act as a pass-through concerning input & output format negotiation.

But in the case where the dw-hdmi is single in the bridge chain, for
example on Renesas SoCs, with the display-connector bridge the dw-hdmi
is no more single, breaking output format.

Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
Bisected-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Fixes: 0656d1285b79 ("drm/bridge: display-connector: implement bus fmts callbacks").
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
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

