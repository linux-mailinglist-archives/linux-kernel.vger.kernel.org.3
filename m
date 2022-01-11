Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B671B48AC56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238674AbiAKLXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349409AbiAKLW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:22:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26818C061751
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:59 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso4615489pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+ilDo9mJ+cpPuGCqkGmDZyvh/0Rruh2V0ekaWY5ySY=;
        b=XkXs2sVlbZdBPoaVV9J3sUozK4gTSDSKFBpUFuCVPECXindDuuQ1V+69UJz2wI+lx9
         G6MHB4muSD4ctmT/HkVVxQo3zMvDGWsavRPYgTq7KpqN0X1y2YprO5D9lkL926BJZm/v
         bMjRRBKqfMAEvtXOqXCHy2Na2MY9YUo4VQ9qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+ilDo9mJ+cpPuGCqkGmDZyvh/0Rruh2V0ekaWY5ySY=;
        b=us1DJPKQwIdMm3RHcAldHgzQcE57zt71DGOO/Up0KgB4liVoumUHwpAg3hS41HruIV
         Fe+tEHCmlTkBsd5+wT00jULV5BHoJwLlC4D8rq2PFUU8PpGD9P3VngUkMRAqO2X1qI58
         uzLAiXQ2QdzZS8mxklIMtan1T3cPNtgwuH4sz8ruzzrsrWT1fUmRgUjg1Eh0WhVVr96e
         3iSC6k3USE0TOjMKzvKQGKYkJ+yQwgHkrAqqcZ9k1+J9aG+hnVepnigfDKAL7g/N4+ch
         dXX7luCw8WJIhnQBsD1eieXwazhDmi8/wk8bwK1T3uLh+T38O1SHrrAPToCHJJt8GBEW
         Vk4A==
X-Gm-Message-State: AOAM533gulEFyacp5DZP1QPSUI/6/fv/totTjGvql1GWExWmgBJnDVDu
        ySfTDNVkOEhRgyvjBTgCmtbF0A==
X-Google-Smtp-Source: ABdhPJwJRu06xQL6ByRV/9lgZHfl9RI+kH9RbPfqsP9o1NoMgEXTitj6cL5swsO/MkT7xBO0RdfRUg==
X-Received: by 2002:a17:90a:9f95:: with SMTP id o21mr2601030pjp.44.1641900178730;
        Tue, 11 Jan 2022 03:22:58 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:22:58 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 4/7] pinctrl: mediatek: paris: Fix pingroup pin config state readback
Date:   Tue, 11 Jan 2022 19:22:41 +0800
Message-Id: <20220111112244.1483783-5-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_pconf_group_get(), used to read back pingroup pin config state,
simply returns a set of configs saved from a previous invocation of
mtk_pconf_group_set(). This is an unfiltered, unvalidated set passed
in from the pinconf core, which does not match the current hardware
state.

Since the driver library is designed to have a pin per group, pass
through mtk_pconf_group_get() to mtk_pinconf_get(), to read back
the current pin config state of the only pin in the group.

Fixes: 805250982bb5 ("pinctrl: mediatek: add pinctrl-paris that implements the vendor dt-bindings")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d720624d8cd2..d259f075c62d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -736,10 +736,10 @@ static int mtk_pconf_group_get(struct pinctrl_dev *pctldev, unsigned group,
 			       unsigned long *config)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
+	struct mtk_pinctrl_group *grp = &hw->groups[group];
 
-	*config = hw->groups[group].config;
-
-	return 0;
+	 /* One pin per group only */
+	return mtk_pinconf_get(pctldev, grp->pin, config);
 }
 
 static int mtk_pconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
-- 
2.34.1.575.g55b058a8bb-goog

