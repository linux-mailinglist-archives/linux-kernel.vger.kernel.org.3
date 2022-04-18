Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8040504F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiDRK5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiDRK5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:57:54 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E915FEF;
        Mon, 18 Apr 2022 03:55:15 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id q75so2211736qke.6;
        Mon, 18 Apr 2022 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJYathoFEIzfoBsN3XEQLNGQPaiEyKTpa9HUFEQqI7g=;
        b=otiHr0bhsPiEU8mmgnUvrKkI2Hme7D0hd1f1xUpHNTxAtDGxbXw9qmpRIQM6ZHTWe5
         NIHfSibH1l72sCyeyrbuauPKdGlrlNA8FnuLZ66avEHTeGDchDF8A7qq701Js0eX6wio
         /vNqY5mmF7uugqodylWVPUwWcxxPkdMTo/CMOAkNzQAB9wG+chcbUaUnSzr3awWtnsHk
         yU/wYJx6EEUNHF9MadCIfmp1nfv7+9ZUOcfv8qlGqGP3KXYD6855+yrEAN0j8MbwB9oY
         ZdMgcLn7RLOc8R7f0AIpFLRoWErnEG3YKu8jXNx27x/1LQ8NTQms4mc8NNP1lPCV4NAE
         Oi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mJYathoFEIzfoBsN3XEQLNGQPaiEyKTpa9HUFEQqI7g=;
        b=x/RIdtHsJ8COIPQDLyd9KPpcgYprtWfJ8mndYBwz2lq2++fGR/ZFI9zMmRDjVS24Nz
         EPxTgkXT6T/dTH1O8rccxbMudK5Zc5VKZEuCo4kBB6SzBauOvTY5hR/xg03GuyoK9dw4
         qDgwmcWz0910qM7lGP/wAss2kPNlw9Z+iUX3I3UE6u+j+JfLdzek/tPfWG9fV8fdvoNF
         Zd9VJmLPe1q4DeWVhXThXiOGIDKwryTpOwau9UywV7zJEEKCwrzcb2CBq+vteml8ijYO
         5BAetMT10U9Rk3JLC1xJhIUvW8gL2jnZbHCTNKD/ksKjwj9VI0F5FAEXyB35fkFXqUQU
         GHag==
X-Gm-Message-State: AOAM531jqgbdcRg4C5VlnHYjVBeS2cqIcnxLPplK7tDjuLrtHjGWon87
        o/iqZ1HatpynUhN1wVJeMlPWxakmj4I=
X-Google-Smtp-Source: ABdhPJy+BvVT6h3LQ1zXnfSsqa+cdvoxW7L+2hRCS6LsGQccYUmqYIb9DnXTiZn1BzbGJ4c2WDPN+A==
X-Received: by 2002:a05:620a:2415:b0:69e:784d:3a4c with SMTP id d21-20020a05620a241500b0069e784d3a4cmr5166230qkn.14.1650279315087;
        Mon, 18 Apr 2022 03:55:15 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d126-20020a37b484000000b0067e60283d08sm6287438qkf.40.2022.04.18.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:55:14 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     ohad@wizery.com
Cc:     bjorn.andersson@linaro.org, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] hwspinlock: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Mon, 18 Apr 2022 10:55:08 +0000
Message-Id: <20220418105508.2558696-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Using pm_runtime_resume_and_get is more appropriate
for simplifing code

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/hwspinlock/omap_hwspinlock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 33eeff94fc2a..1fb3a2550e29 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -94,11 +94,9 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	 * the module SYSSTATUS register
 	 */
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
 		goto runtime_err;
-	}
 
 	/* Determine number of locks */
 	i = readl(io_base + SYSSTATUS_OFFSET);
-- 
2.25.1


