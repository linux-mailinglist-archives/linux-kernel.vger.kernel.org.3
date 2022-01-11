Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7001E48AC52
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349362AbiAKLW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349353AbiAKLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:22:56 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE5C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:56 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id pf13so9331663pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YKaz4u+jHXBZ/hE7lcVwwzVS+M4mWSZteuvchYRq/nI=;
        b=gGo3fMPxrCjwBdkX5n77T17fwS1TD0PV3va335HdH7rjAjuCJ0jAPYlRuotwXbwx62
         FR1Vw93XtwPIQGZzMkdQW3ZdXNdqz7TvjYROqPnDGb36AvEUnrzIgJVC7utxf6LpIJca
         Kthdo7em4vemrrx6zllmjUlfChywO4GB3GN2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YKaz4u+jHXBZ/hE7lcVwwzVS+M4mWSZteuvchYRq/nI=;
        b=TeIW7N+LVz3/7Esnbt7QHBAVl3JLNOgfb0crW/U1/axls+4K2p15GCasYSpqDA/dCe
         PFKhCL0V7fuH/YEvWPXREsX/rYS9hWVnK9Eq8a8FPZ8iMbw6xuhJ4tlDCynGb6ydZ/un
         wT16A7A2Qv8CTrLjPVYZtuDw45MPdKOJHG16vV+p2/jkWra0qVkRT9LC3y6PAggSJVI8
         dM9SfOV0sbapvmU2GDtX92Ob+vVFC8Fr8NldqhpQAtl11haeylUKsw2/Xcx4yUh9Euvs
         kxC1xXumax2Zk70wIWGggt9cid70KcjvRHPCcgUh/dxlrMLVdaY++R6pv4HGwVSAsQvf
         n1OQ==
X-Gm-Message-State: AOAM530rAlHlyR8YfCU95oCAffI1/WnGIOhHg9zQR+i92bNVOvxvUbBP
        QAhJLC+RH1rroj1LmFM6x7x7wg==
X-Google-Smtp-Source: ABdhPJz5glPbeZkuNFNbmk+GbZakSX+Fxp59hDSbXI0GT47ku5rb9OI1mykAOShWopjv/FxhhGTH+g==
X-Received: by 2002:a63:725a:: with SMTP id c26mr3569100pgn.611.1641900176245;
        Tue, 11 Jan 2022 03:22:56 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:22:55 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 3/7] pinctrl: mediatek: paris: Fix "argument" argument type for mtk_pinconf_get()
Date:   Tue, 11 Jan 2022 19:22:40 +0800
Message-Id: <20220111112244.1483783-4-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index 1ca598ea7ba7..d720624d8cd2 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -188,8 +188,7 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 }
 
 static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
-			   enum pin_config_param param,
-			   enum pin_config_param arg)
+			   enum pin_config_param param, u32 arg)
 {
 	struct mtk_pinctrl *hw = pinctrl_dev_get_drvdata(pctldev);
 	const struct mtk_pin_desc *desc;
-- 
2.34.1.575.g55b058a8bb-goog

