Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8BB4D1450
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345665AbiCHKLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345650AbiCHKLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:11:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0A82251B
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:10:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so1936713pjl.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5/KGSiDUR6Oh1qS3ls1eTa+dOJRLWEHzu5UF9HK4Si4=;
        b=eDoPTw7FlfuMrMk7TZW4fd7c4dDPzW6nXHDmrXSbtsRK6vVG9dhIQ6WrXKOKLXV7aq
         pz9p+6TzCc1cAGkq3MxA4HyZXLYlRrprzCIS02q3HivJhzYBshHAXuBmUwnDRmScWVih
         7AG4tW3YbthMaljSEsRgDx70cRXDSte2hvmI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5/KGSiDUR6Oh1qS3ls1eTa+dOJRLWEHzu5UF9HK4Si4=;
        b=RPpgFtF1Hk3Ta4wYOTftppuWM4NoU2n17bfSD3Ax/8UP94uYT8AArkJTyNYD83jSYy
         9GV6whHxZnO1MhdijSCr7aFfGuOvws7TP6BQQZXUXLXBtYmiI0+naMEy6DT/BwPALfx8
         gzZHZd5yLNuUzebLwiqKf3fFOeVcxIltSbcKSTJ/nrP4oMCnDX/+9NzVBzyV3S/bRl9s
         d8T+yWjSNjzdzMRz7Kqp2cznN+ZLrOviysdX4F4j7dlv/GDyE4c0dlQC0uMXIKjV9nzF
         CXCFEtIsrlCo95OysKH4OvLyH4r+j4G8sudRWpzZ2gQcq91/ltlfABgAGSS/fCCftBy7
         kCxw==
X-Gm-Message-State: AOAM533Grf/lLNObBf855CwpMrH2dJcNz22l0D0qoeJKwQ4Q5I9z2yyq
        mlOfFZ87UQEfHyMC1vUB5Ejz1w==
X-Google-Smtp-Source: ABdhPJxDGvhKYqfJXVj5tcUF1DdM4k4BYagm/EBulkoRUtJ1T6TWbFFUrKL/Ekqds5KSkBCbsoWkLw==
X-Received: by 2002:a17:90a:4289:b0:1bc:275b:8986 with SMTP id p9-20020a17090a428900b001bc275b8986mr3758766pjg.153.1646734207017;
        Tue, 08 Mar 2022 02:10:07 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:73f8:5e3f:6894:8f44])
        by smtp.gmail.com with ESMTPSA id k19-20020a056a00135300b004f734327960sm1707553pfu.106.2022.03.08.02.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:10:06 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 01/11] pinctrl: pinconf-generic: Print arguments for bias-pull-*
Date:   Tue,  8 Mar 2022 18:09:46 +0800
Message-Id: <20220308100956.2750295-2-wenst@chromium.org>
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

The bias-pull-* properties, or PIN_CONFIG_BIAS_PULL_* pin config
parameters, accept optional arguments in ohms denoting the strength of
the pin bias.

Print these values out in debugfs as well.

Fixes: eec450713e5c ("pinctrl: pinconf-generic: Add flag to print arguments")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
2.35.1.616.g0bdcbb4464-goog

