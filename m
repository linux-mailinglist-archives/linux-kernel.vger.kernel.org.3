Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C8848AC51
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiAKLWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiAKLWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:22:54 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6224BC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso4731565pje.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=46vNWfCGa2Jehdt6uZRwpjv1YuVkkZW0i1eDoXg3Zec=;
        b=esN1ZqLdbAEajmfzapP7lVnID9P/08CQO2LHxbTx/fXJK2zW7AWZ0c4ExQDVXI+MpD
         IQdW1TQW6LYYuf6XIiavBx+9srFkNSiWGEx1h5dU088pogGNcDq4dmpG1wlE+EsVrfZu
         xAcGnSViss/JWwSg4ZNjfYNd0Rntk2rgGZBSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=46vNWfCGa2Jehdt6uZRwpjv1YuVkkZW0i1eDoXg3Zec=;
        b=xybZaY2UocpzHljRbvobRDJZjbILhdHFLrkwB1fxTZIedOxpEt3JXImMGIkjjOaGE6
         SLbG7P0bbTDUFdfbmMCjOZdeGnDoZoUeg8G2cVUIcbS3kRLyFW5rVoCVXJeUgkahuX5N
         5zQW/E09j4ig19YOoV8V3hxjSClA6ANO+1c+JWkdJnqhS4F8POX/EUVf9OsZIU5NA1Px
         yr2e9w2yAjmH4faER+dScmmodfzbrgqbfuK6nINBpMW1iPR1ykp1Bt8IB1UOv7u3XWca
         JZ4RoVB60Uhg0hIwPTDps6rRkpkZF7ArFd7s1wSGWTCGvoHBsarEmyXas7Y0okna3YBt
         0AhA==
X-Gm-Message-State: AOAM533bjWC00SElu1mLs0n2laNAkDbDtCe8XAIZS/nCJtGxcwBspX35
        iLn7vxpDZ1udxhou+3RXb+RjPQ==
X-Google-Smtp-Source: ABdhPJwGHRyF5VOXfXoWha8dpfJ67L3LRTTCjIs8gZdPc2xLLP6Qjr3mcaU9/n+Caiu6e8jM6+wH2Q==
X-Received: by 2002:a63:2cd5:: with SMTP id s204mr3583363pgs.121.1641900173986;
        Tue, 11 Jan 2022 03:22:53 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:22:53 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 2/7] pinctrl: mediatek: paris: Fix PIN_CONFIG_BIAS_DISABLE readback
Date:   Tue, 11 Jan 2022 19:22:39 +0800
Message-Id: <20220111112244.1483783-3-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reading back pin bias settings, if the pin is not in a
bias-disabled state, the function should return -EINVAL.

Fix this in the mediatek-paris pinctrl library so that the read back
state is not littered with bogus a "input bias disabled" combined with
"pull up" or "pull down" states.

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index f9f9110f2107..1ca598ea7ba7 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -97,8 +97,8 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 			if (err)
 				goto out;
 			if (param == PIN_CONFIG_BIAS_DISABLE) {
-				if (ret == MTK_PUPD_SET_R1R0_00)
-					ret = MTK_DISABLE;
+				if (ret != MTK_PUPD_SET_R1R0_00)
+					err = -EINVAL;
 			} else if (param == PIN_CONFIG_BIAS_PULL_UP) {
 				/* When desire to get pull-up value, return
 				 *  error if current setting is pull-down
-- 
2.34.1.575.g55b058a8bb-goog

