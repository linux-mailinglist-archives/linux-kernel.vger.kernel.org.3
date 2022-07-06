Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55FC5684C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiGFKIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiGFKHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBF25C48
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c131-20020a1c3589000000b003a19b2bce36so5703322wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D8DtgYwJoP/V2130+PGEO/pkL1xXDKz8qmvliOW/LJI=;
        b=MAbBA1ZvhfFw4fDm6wOAOKOuxS/qKDxsuvcH1T72Dugsw9aoGSmRktizFEXOJn/XZo
         VzGmTecvl7q22iDePjsT21Y+RpDifbceiBq4CyuIxr5uz7lnkMy25yZYiuMgA9p5tWMm
         JU7caoTydExMRtKdVO/svDNqO2CG5mtnOENdjFLoDWWUJtH5OouT0+meYHPcNxEx+vLU
         k7Er1mT0v30LUtgolRto1kXf6ilOqpuOOu8yvS0e/JN/5puHNHMcf6caIvaRNiwQ5FbB
         gC9dRkZ/+veunifxFt07o3AwkXlvYOC+6AiiKZb008NbXoMKU4JWAnTeyRn4x+JxH3I5
         umgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D8DtgYwJoP/V2130+PGEO/pkL1xXDKz8qmvliOW/LJI=;
        b=UWQxetYWRAM33TyxN2Zt/KRMqBo+QqRz1jYcc7TtjIBubjG451bLDlTMFzfTMC4oQ5
         OTy6J3XcpBmW7IABG/d03sBJ0GPP/XtjYRDXiD0WviIuK45GYkyGbZJCLIaNGi7C8k2t
         bcv77GOnJ3/rH/J19wERMzUrIGgHphQQX3WSkqSxXiudaZWL1Z6UN7XfMNH1tP2Riqmc
         +qhlCZy5AhICZlLhs3n/M3Tv/jzX8MZY9exujaP/XO1CzG35eijTdPCqlFTEzLbeFgev
         piklu9Gev38M/hOHOrfDX9kSRhlkNfeeMN4U/YVbzhz8NS3p9gW6LjnZaiAnxjdeNDJR
         V+3Q==
X-Gm-Message-State: AJIora+4DOpQr8uTlZrdr4zSceqUm8qr2iz1RTjCh8QgkBbKw6/TQQje
        XvcR8B/SsPWVPnSUxC0m/WHZ4w==
X-Google-Smtp-Source: AGRyM1sTiuaoxWI3ZvWwLGuTZmjpKap/Ril3DCU2PyAV7HdhhcPy4GNOJ1qVBRpsmcrHbFW2K3KwPQ==
X-Received: by 2002:a7b:cb98:0:b0:3a2:afc8:72cd with SMTP id m24-20020a7bcb98000000b003a2afc872cdmr13222310wmi.98.1657102055591;
        Wed, 06 Jul 2022 03:07:35 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:35 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] nvmem: mtk-efuse: Simplify with devm_platform_get_and_ioremap_resource()
Date:   Wed,  6 Jul 2022 11:06:27 +0100
Message-Id: <20220706100627.6534-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
References: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

No functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index e9a375dd84af..a08e0aedd21c 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -41,8 +41,7 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->base = devm_ioremap_resource(dev, res);
+	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-- 
2.25.1

