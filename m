Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6955231E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240872AbiEKLfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiEKLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:35:25 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6452380FE;
        Wed, 11 May 2022 04:35:23 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c1so1995728qkf.13;
        Wed, 11 May 2022 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=onb5iDrr9AZU/Apv2XZLPoTcQR9Y3vPO5TDtvXQcOxQ=;
        b=oVqrjx29MINK52QwG0IJPDvlqXIqV1zPBJuiMpjtBXE/hIPoGg2X0+50kTplBxthYH
         D8vgtq7PprMfds50WIs0tN7TVvobuqfjnLIvdWXISuIiqeyE14SDl6KP700a2MzxgN9U
         KmHV6SKRcvfFxc5H0gQFg8kXvtmVCbsfGZAqc8bMksmhSlQaFXrPcvPZBevEYfcwda2m
         jHnGyRIfPk7F7REPHZz6eG3+tIEv+Cpt7/NgiuVGUr8fWtzNw+WwdCOKvKoZ2RXTTMxv
         mLVsvIBTP+s6aq5z94/ajvYjXSudDUOeXLMEHNAvjE26Ie5qRTNfXMVAcxU3Li5u7xdI
         vKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=onb5iDrr9AZU/Apv2XZLPoTcQR9Y3vPO5TDtvXQcOxQ=;
        b=NuU9RF1C0pVVsea2jrxmfvc6/78zp5hlimyQuthfzaHwvguWjW8r1UVhiyrBEZpuAB
         xoK2dwUjGmM9tu3m2I3mYsbFazQWi7vErTNkYavSbLKVwygVHfuohCykxIEeuemrjbtH
         DId6wSoG/CJn1uDQDgIBw0RtJVOrZ6tXBTqnxWWsrxqsilBQGolBrBjNE1gMNLxDH9qO
         HGGikg2gij+S6j7KtsIIKNX8BZhxsngTvZsX//+56qsgji1m71/YH7vDo7Y0yITpmWzf
         aHTGd88nFp49AyAmDEyys7M8+FP/Ex1Z4x/HAEgFhAqm6TvSDEpABNcAy0/o+MW8MsLe
         /pHA==
X-Gm-Message-State: AOAM533MxupbtBpNL38jGXokL6amL6cjIiAqb1s1zM+gS2EPeBynp+D1
        ot2pyvk54br6ubgQZBZGKJk=
X-Google-Smtp-Source: ABdhPJxvEn0z8OWVAW1knWQ+gSB6bMqF0l8ZwTwgkUjNFMazkzowO+pRO9zxox34S+7OYWmauNF4wg==
X-Received: by 2002:a05:620a:2407:b0:6a0:5027:f4d5 with SMTP id d7-20020a05620a240700b006a05027f4d5mr16378491qkn.318.1652268922439;
        Wed, 11 May 2022 04:35:22 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id bw26-20020a05622a099a00b002f39b99f6basm953377qtb.84.2022.05.11.04.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 04:35:22 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [PATCH v2 2/3] drm/panel: feiyang-fy07024di26a30d: make reset gpio optional
Date:   Wed, 11 May 2022 07:35:15 -0400
Message-Id: <20220511113517.4172962-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511113517.4172962-1-pgwipeout@gmail.com>
References: <20220511113517.4172962-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some implementations do not use the reset signal, instead tying it to dvdd.
Make the reset gpio optional to permit this.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index a9cd7135cb51..ee61d60eceae 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -209,7 +209,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->avdd),
 				     "Couldn't get avdd regulator\n");
 
-	ctx->reset = devm_gpiod_get(&dsi->dev, "reset", GPIOD_OUT_LOW);
+	ctx->reset = devm_gpiod_get_optional(&dsi->dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(ctx->reset))
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Couldn't get our reset GPIO\n");
-- 
2.25.1

