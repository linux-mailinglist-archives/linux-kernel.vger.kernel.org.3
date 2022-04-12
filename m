Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFB14FDC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380031AbiDLKUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376701AbiDLJ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:19 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F61F60C;
        Tue, 12 Apr 2022 02:03:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q142so16626081pgq.9;
        Tue, 12 Apr 2022 02:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeL9OUUuVYyPAwmLxhfNrEy3AwKesyiaX46zNs16JBw=;
        b=PDCh3y1YtisU9UUHOnDvKa5w6dKulSdUSg3Sj9TdSOkJpLKfiIFdUzcix8WEdWnOrG
         t9Ul/Wsp1nJ2qt6RCbSnxTCAwd/KwVJPdrZ4dyRKbl+Jauh1XpQ3alf/NkwmD6XTM+Ms
         BBEHaSyP4cDW8FFWBV4E3BAQxv9Vk+KyRqP8Yf2vY0xHXEoVOIsbpy/ta11eLZe3WBqH
         flCy4GlDBO367JzYAayNLqTLGvVB8RQcSeeRJ/wCKi69Jw2ie7nrBS0EJUEj++ofXO9T
         mbdwEWqOAklYtCAb7dPu+CEw/IcY5MeMJb1ySIlut+Ix+13Q1T3PDWSxFHMixAj4Kc9s
         6u2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeL9OUUuVYyPAwmLxhfNrEy3AwKesyiaX46zNs16JBw=;
        b=rlN+QSkvbf+JcD4U3w7Qpug7/CT+aNocWQplYKC4CR2yqk1+UxYVF7XOJsuxl6QIa9
         +i7RTcFxRMaz1qY9soF2eYu5X549xTd5NoCiCnYpqMf6X0gx/P6dDO9w/J+/UkZkc8h4
         CUk5Mdf4vXhRRb8y9iH+/F9v//iAwtA2XkoaVDZGMArFoUAY4VLXzBXZ6GYzgxpCzfas
         YBty0D+JqhWy83zC+DL7XLcnF87o1E8EL6tClVA7gcuLSXhyFJQt4p62CNs7XDLErisU
         7gemIXsBt1B9mZysptusXOhr8pM7xoSodfwEvg5BLrBmpl0+/GBrmYdd6VIF7vQQbb4Y
         BuuA==
X-Gm-Message-State: AOAM531J4Mta7l9HW8zJdJQsXfDcfvyAzFLXSFpRZmVuTzFu9mCQZPcj
        CT9Shx1tS0/gsDydx3jZdW4=
X-Google-Smtp-Source: ABdhPJy7OVOB4oSM//e1PiinQTfpq0sbwC5nxLoAJdtrcRvnN5OvTFVdRKhIFveJM1YiiZTQXJHNwQ==
X-Received: by 2002:a63:dc4e:0:b0:39c:c5b2:94d6 with SMTP id f14-20020a63dc4e000000b0039cc5b294d6mr22046984pgj.365.1649754184245;
        Tue, 12 Apr 2022 02:03:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r8-20020a17090a0ac800b001c9e35d3a3asm2110537pje.24.2022.04.12.02.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 02:03:03 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        srinivas.kandagatla@linaro.org
Cc:     gregkh@linuxfoundation.org, sdharia@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] slimbus: qcom: fix error check return value of platform_get_irq()
Date:   Tue, 12 Apr 2022 09:02:59 +0000
Message-Id: <20220412090259.2533316-1-lv.ruyi@zte.com.cn>
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

From: Lv Ruyi <lv.ruyi@zte.com.cn>

platform_get_irq() return negative value on failure, so null check of
ctrl->irq is incorrect. Fix it by comparing whether it is less than zero.

Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/slimbus/qcom-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index f04b961b96cd..b2f01e155d77 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -510,7 +510,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 	}
 
 	ctrl->irq = platform_get_irq(pdev, 0);
-	if (!ctrl->irq) {
+	if (ctrl->irq < 0) {
 		dev_err(&pdev->dev, "no slimbus IRQ\n");
 		return -ENODEV;
 	}
-- 
2.25.1

