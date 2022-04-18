Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B484504AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiDRCFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 22:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbiDRCFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 22:05:22 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F99013EA5;
        Sun, 17 Apr 2022 19:02:45 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id a186so7617815qkc.10;
        Sun, 17 Apr 2022 19:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VkZAEYMLIIT6wqJ5/0I8DnFHNDmyrMwWCb2AFSlInc=;
        b=W/yt8BKYn2vSc0FYmkTVcqRuRLiPZbv4Ac0/F5BIF8njnmn3xQmEkcxJ6vu6XEonH+
         3wx/Vs0nS3s4tCgbJcowRqXSukBtp0eppu7frUiwR1EyzFTiSvBDGys9sO/C3iKxnnAu
         9Q4mW58a8xupi8TudtBMgtOK4aU8P9SDqUhsW1Dsl7HqWVKxuaK+73uWD2sot52ZehGH
         E5Y4XTtF6q3q/gw2U0CNAJCaZLWsk/ApIPapZ0jhrsOf/vpKJe0Oym9GlI7y2jIAdEP0
         sdlCwhQyut45lc1pQrPgr4ch60ivdCs8SSd2BHOJhfjpkW3CfFaj+zUWEHvNCI8lkJFb
         ZSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8VkZAEYMLIIT6wqJ5/0I8DnFHNDmyrMwWCb2AFSlInc=;
        b=rOdbo5VruFfxoKAjUJjThIhGyX0ec9nhUjFzU9kGTbWlikNlimOh1b6UzNUw87zU9D
         vmk4DMeXBrtPdrUtjyrIvqFow4CaKwlnEMeBjoVFBcaJJ+MdOqL9BYSTSgNHzfRFQ3XD
         X0l375QgjVVrIsruzyqBvlEzCToQaN7I16G3Zm/DiKEcUcEGLNS3M5GMkrPforvqHRz0
         3T/mFLXTYU2URytWHVQHsG0k0BVkN5z/kqbPaujR4c0rBq26+8ToeDDHFvuAOaOWyait
         XHobP6lGSn2yH5S5B5cd/mjBc4P5Q8PP2P6Po52yUlC8Hwb2C2cX25XRg9kXvMoGwOho
         NKRg==
X-Gm-Message-State: AOAM53303e6SHT58bxob1Uo0tk7GheWn2WCavbg4EeaCzvAPPdNJzJry
        Q7IonNqekusiJDcvHhv5co4=
X-Google-Smtp-Source: ABdhPJwiTz3+00MIicg7kGu59ibe/c0yNNTkFvyg/D/+fDTAyfUC/2UbpQfHoL/kpEcVyHXISQXiaQ==
X-Received: by 2002:a37:664f:0:b0:69c:81ae:a293 with SMTP id a76-20020a37664f000000b0069c81aea293mr5441718qkc.614.1650247364509;
        Sun, 17 Apr 2022 19:02:44 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h5-20020ac85845000000b002edfd4b0503sm7236920qth.88.2022.04.17.19.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 19:02:44 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     lakshmi.sowjanya.d@intel.com, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Ruyi <lv.ruyi@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] pinctrl: Make use of the helper function devm_platform_ioremap_resource()
Date:   Mon, 18 Apr 2022 02:02:38 +0000
Message-Id: <20220418020238.2556989-1-lv.ruyi@zte.com.cn>
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

Use the devm_platform_ioremap_resource() helper instead of calling
platform_get_resource() and devm_ioremap_resource() separately.Make the
code simpler without functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/pinctrl/pinctrl-thunderbay.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-thunderbay.c b/drivers/pinctrl/pinctrl-thunderbay.c
index 79d44bca039e..9328b17485cf 100644
--- a/drivers/pinctrl/pinctrl-thunderbay.c
+++ b/drivers/pinctrl/pinctrl-thunderbay.c
@@ -1229,7 +1229,6 @@ static int thunderbay_pinctrl_probe(struct platform_device *pdev)
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct thunderbay_pinctrl *tpc;
-	struct resource *iomem;
 	int ret;
 
 	of_id = of_match_node(thunderbay_pinctrl_match, pdev->dev.of_node);
@@ -1243,11 +1242,7 @@ static int thunderbay_pinctrl_probe(struct platform_device *pdev)
 	tpc->dev = dev;
 	tpc->soc = of_id->data;
 
-	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!iomem)
-		return -ENXIO;
-
-	tpc->base0 =  devm_ioremap_resource(dev, iomem);
+	tpc->base0 = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(tpc->base0))
 		return PTR_ERR(tpc->base0);
 
-- 
2.25.1

