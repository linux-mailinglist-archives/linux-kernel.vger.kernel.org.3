Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC3537AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbiE3Mfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236166AbiE3MfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:35:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1047CB11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:35:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d26so8856849wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lbYsntMLq1GN0TWediUrrDdKB95gK6V8mOFIJ/plIGA=;
        b=6PIvfuSRJgpUpEkUtolL+elU452K0LIs/Lk0e8ySI1W8R7XRUH431mK1hLv3cpfqv0
         2ZivpNy+gpcusmBB8mk0Ew4hQQzierrs2JMj4MSTb5RaE1pnm5r4BB+rMCLfpOATrfQ1
         fdgRBLMqOOfK4fOdnWAONoFqqYZa441FyfaRHJHwcNmWWpMHldEdkBWgLnLLoV6jgILp
         UhF1HWrNlnLykhYQKA9UwLBePuuFaE0k468BQeVRY9pdlVrIjvnbtqfZHqI9FifYwY0d
         RBeEm4ojUdqz9Xr9zBAlKsKLKwezW2a8pkmUhSR3NeD6xwpo7+xnIR9BI4/jC0QQ716W
         7sXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbYsntMLq1GN0TWediUrrDdKB95gK6V8mOFIJ/plIGA=;
        b=VhHO4QHgHPrcvZD3jwSLUbdYiwNyvBQwhHurnprriQ59iiGKVdqsM4y55rWIizEPZ6
         XidOniptxy8hI/YHzQK/M5acj8B3tC89K77ILNQxrKSuA+5J4CKjelNup6eOfkWQtY9J
         +6jF5AANsD0xdgOD9fbXEj1VfjrZaRcnu4pgzjgupu0qM6nWeAEsp/1jGJptsbt7ocM8
         KLzXRrPJxwZqFjd06haWAMM8reuwVC8HFOkvk6WPiAHzHHRUJ3CDQgo+X0g5PPuKg+u1
         MVJAK1V7WQbgMIJGilNwSrWZn871j4gi5uf8gB8758WAZJavZ7pNc3vPbe4ewc2SFo1s
         3G+A==
X-Gm-Message-State: AOAM531HPLiq632b8nS1dFX+D26WmL5poHmeejTdSCcHL/iwSfO2ERAK
        9Lluoo28Bo1ooR6crF4/ThL4gA==
X-Google-Smtp-Source: ABdhPJylyu+I3dilKUdZVnw2PpnKf2fn0YNljSSTog9+EycAuB0MX1E9Uhj466cMXJhLxItBU/M5Yg==
X-Received: by 2002:a5d:648a:0:b0:210:2c59:a07a with SMTP id o10-20020a5d648a000000b002102c59a07amr7301097wri.195.1653914103914;
        Mon, 30 May 2022 05:35:03 -0700 (PDT)
Received: from helium.lan ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d47c3000000b0020d0cdbf7eesm9380895wrc.111.2022.05.30.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 05:35:03 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] pinctrl: mediatek: mt8365: use MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk
Date:   Mon, 30 May 2022 14:34:25 +0200
Message-Id: <20220530123425.689459-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530123425.689459-1-fparent@baylibre.com>
References: <20220530123425.689459-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8365, the GPIO64 modes cannot be set using the SET/CLR register.
Use the MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk to workaround it.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8365.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8365.c b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
index 57f37a294063..a49fa685f5f5 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8365.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8365.c
@@ -454,6 +454,7 @@ static const struct mtk_pinctrl_devdata mt8365_pinctrl_data = {
 		.ap_num = 160,
 		.db_cnt = 160,
 	},
+	.quirks = MTK_PINCTRL_MODE_SET_CLR_BROKEN,
 };
 
 static const struct of_device_id mt8365_pctrl_match[] = {
-- 
2.36.1

