Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427C14D1468
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbiCHKLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345664AbiCHKLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABD22D1F4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:11 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v4so16704353pjh.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0mkHtiSV2mMzHIze/I73DmsEuzqXgbxwstSY7Z96a90=;
        b=MqSUVQddC79+cfbGd7rJlWaOGFHsKsVv3nxuDEb0d5t14RJm8RgxTNucAJmbCr/HNO
         aUoOwngfmNE0aHCLm/b7tOtkxPjhGIov5/taNy/0m8E6Jkm4+4R7zGhk6AAp83OyYTXo
         oghpwvy5LQLRP29YCov4efQTYND6/zUAVpnhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0mkHtiSV2mMzHIze/I73DmsEuzqXgbxwstSY7Z96a90=;
        b=vg5WS+hd3YtxgTcchQIMy/EKPCxIixpXqOp3HyPDGjP1X+eZIvINeoUKyjNuk3tPNP
         EyywnKmcmI1Lk5LnuCm82A00J3idBcjQSZNsdljpenmMpwMiQEEr0wsN38LUd+sBQ2ms
         lLUkthlgT/AzM4e99tT8lidjkyt54XzftXIcQ6Sc1X5w0t3vy6Oc0nmeIl8Ch0/LVuzV
         Cyrv02mDlxZGL5rYF7/XxGB1CkHt36GwwXD89T/4H05qNl0F7frlA8zZEcQiHvgLgZeL
         UUiUoky4uahozcBTVXSAZKdaI2FLheH7A+hq7iWBWX98jaYB8VLG+ar9Yt+ivnmfNWFT
         wnIQ==
X-Gm-Message-State: AOAM531VheBP977AUYEgeiHw2TAraxg43noDozBxn/D1Da0kIVl116D6
        mf165lEmimix8jUOrtxZHYjQ+g==
X-Google-Smtp-Source: ABdhPJyFRJs7+lYwOkpKY/+oHApZBU4Bq8/m6MYCzudRdQ6PI/A8Wr1FevXk8zt3kT4tAZVslfcZzw==
X-Received: by 2002:a17:902:db0d:b0:14f:b047:8d22 with SMTP id m13-20020a170902db0d00b0014fb0478d22mr16271484plx.90.1646734210921;
        Tue, 08 Mar 2022 02:10:10 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:10 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 03/11] pinctrl: mediatek: paris: Fix "argument" argument type for mtk_pinconf_get()
Date:   Tue,  8 Mar 2022 18:09:48 +0800
Message-Id: <20220308100956.2750295-4-wenst@chromium.org>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308100956.2750295-1-wenst@chromium.org>
References: <20220308100956.2750295-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For mtk_pinconf_get(), the "argument" argument is typically returned by
pinconf_to_config_argument(), which holds the value for a given pinconf
parameter. It certainly should not have the type of "enum pin_config_param",
which describes the type of the pinconf parameter itself.

Change the type to u32, which matches the return type of
pinconf_to_config_argument().

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 7037560ecda9..c668191933a0 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -184,8 +184,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			   enum pin_config_param param,
-			   enum pin_config_param arg)
+			   enum pin_config_param param, u32 arg)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
-- 
2.35.1.616.g0bdcbb4464-goog

