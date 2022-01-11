Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBF048AC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 12:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbiAKLWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 06:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238683AbiAKLWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 06:22:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E45C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:52 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so4660923pjj.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 03:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMXmZlFguOt5qjM8Mju3XqareZLrVjvBoxrDlqW40Jg=;
        b=UFLB81h0iX3ZqYtdi07F/FwaSLK2hfrLHRXrm+quboO7VeHcwM5jwLhqE6NRgJ68Mm
         oqkmGHi0Tdk3gJKKrvD93cjMflMetaaCsTxWcDVX6A7icNVuGxJ+RZwWL+V0cK9L5FMx
         Cpv4tzns3Z9SVuL6P+y5hNNuU7+/6YWG9fuUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMXmZlFguOt5qjM8Mju3XqareZLrVjvBoxrDlqW40Jg=;
        b=ZI7edqDq8LOseMlZCzIA9Pkpn6RGXoESoM3UTFcI5NIsypkGZk75ces+36sbQcpVR2
         ydWNMYHgm6uWI3G3MlqzRmCmexmNmGCk+Os9Wl6fHrp21mv52XPaOSIHrnIB2ARD6Q21
         1GoOMlpDKoJnBD4zI+EZTlH+TtNE6eL6TjSK6wfK6VKx3T5L6hzuzfNMkV3q3uguhqY2
         xYpO7KeMc5PNkTdGPryyCbp72JLSltsKxx4VjZV9Xtb0mWBfNhU2x1t2P0jP7DPaig22
         hTfSAtkumZvG2W8spjsU6xoSRpCoxtApSBpvsRqcKfLpifUEWEkPd01IxDPlVMmr7oJZ
         6B3Q==
X-Gm-Message-State: AOAM532QpTY3sWfiOgMWbyK8iB2U1mixcMjVBWpPhkYHAolU79eS29Cx
        SMP51CeMY1yMy3PQ/WvN0Z0KsA==
X-Google-Smtp-Source: ABdhPJyGUCS1OeFe84DG12JyMqhdck1JEx4lgTsvVydKsQtX3NxZFt66NL+LGUYUbSR71Xtv63tKYA==
X-Received: by 2002:a17:902:7c05:b0:149:a3b4:934c with SMTP id x5-20020a1709027c0500b00149a3b4934cmr3888753pll.42.1641900171738;
        Tue, 11 Jan 2022 03:22:51 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:e7ee:1824:8575:bc5c])
        by smtp.gmail.com with ESMTPSA id f9sm2053845pjh.18.2022.01.11.03.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 03:22:51 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guodong Liu <guodong.liu@mediatek.com>
Subject: [PATCH 1/7] pinctrl: pinconf-generic: Print arguments for bias-pull-*
Date:   Tue, 11 Jan 2022 19:22:38 +0800
Message-Id: <20220111112244.1483783-2-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220111112244.1483783-1-wenst@chromium.org>
References: <20220111112244.1483783-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bias-pull-* properties, or PIN_CONFIG_BIAS_PULL_* pin config
parameters, accept optional arguments in ohms denoting the strength of
the pin bias.

Print these values out in debugfs as well.

Fixes: eec450713e5c ("pinctrl: pinconf-generic: Add flag to print arguments")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/pinctrl/pinconf-generic.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index f8edcc88ac01..415d1df8f46a 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -30,10 +30,10 @@ static const struct pin_config_item conf_items[] = {
 	PCONFDUMP(PIN_CONFIG_BIAS_BUS_HOLD, "input bias bus hold", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_DISABLE, "input bias disabled", NULL, false),
 	PCONFDUMP(PIN_CONFIG_BIAS_HIGH_IMPEDANCE, "input bias high impedance", NULL, false),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", NULL, false),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_DOWN, "input bias pull down", "ohms", true),
 	PCONFDUMP(PIN_CONFIG_BIAS_PULL_PIN_DEFAULT,
-				"input bias pull to pin specific state", NULL, false),
-	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", NULL, false),
+				"input bias pull to pin specific state", "ohms", true),
+	PCONFDUMP(PIN_CONFIG_BIAS_PULL_UP, "input bias pull up", "ohms", true),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_DRAIN, "output drive open drain", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_OPEN_SOURCE, "output drive open source", NULL, false),
 	PCONFDUMP(PIN_CONFIG_DRIVE_PUSH_PULL, "output drive push pull", NULL, false),
-- 
2.34.1.575.g55b058a8bb-goog

