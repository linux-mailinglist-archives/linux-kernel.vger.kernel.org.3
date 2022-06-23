Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57441557781
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiFWKKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiFWKKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1CB49F07;
        Thu, 23 Jun 2022 03:10:06 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E611766017CE;
        Thu, 23 Jun 2022 11:10:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655979005;
        bh=MQ1fY3/YQ3FihXnEhKH3AztkzbIz3/gmcC+bWRFCvME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PBw4goKZ9D8tsWxsCWyAIkBmRrVwO0yz2+VyTndpY80/CNjsum6ZgnxhGGc6TVhwC
         RA1hsnPYrqs+0NJZR1pAtsTPeMKH07O5HBe7WK6WZLcvNJIQwWsm1PZaX0A2u0m3yg
         Tq5Lcck28IuNQluwf36YvUJq5KsFqS1IPnsxSC8zO2JdtRH0ljpZkCJAs1RrSSIrkS
         YgZZkYhW/NluE9v9rqJtcBiIugfwthAMRKNif4nqyp7yXev/0CCMQyc2W+zPbmyRiU
         NxLVWqw4EZpCjRcsi3WsakLcaI3KRrFOhE3yB3LKpmqX8waCwM0s5g1m8Sgt0KTqSu
         +fpQj4iVxrlZQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 3/5] soc: mediatek: mt8195-pm-domains: Allow probing vreg supply on MFG1
Date:   Thu, 23 Jun 2022 12:09:49 +0200
Message-Id: <20220623100951.21153-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
References: <20220623100951.21153-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As done in MT8192, also add the MTK_SCPD_DOMAIN_SUPPLY cap to the MFG1
power domain in MT8195 to allow voting for regulators on/off.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8195-pm-domains.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
index 0529d130b675..d7387ea1b9c9 100644
--- a/drivers/soc/mediatek/mt8195-pm-domains.h
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -162,7 +162,7 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
 		},
-		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
 	},
 	[MT8195_POWER_DOMAIN_MFG2] = {
 		.name = "mfg2",
-- 
2.35.1

