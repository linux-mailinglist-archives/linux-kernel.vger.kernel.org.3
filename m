Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2B59910B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbiHRXMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344637AbiHRXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:12:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B17FCE474
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w28so2276259qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=eBJoaksl+YDmVk0O/pMB/ZWpuni/68BYE7uK17qPOPI=;
        b=xakoErxZSUn3M3G50lV9eRRWIJxMOyIHxInZiI8/UfKU1bPMLtT/WMbnve4dhDBixc
         8Gi1EgJ1nhXbf48+YoeIB7br6/fSYtwBLzCMhxV5neXzi1fPkolFL6sWU0gLKCKPqeSY
         rtn+xQLKZ8S3iEpjNEjEx+GK9gdRKo9LMieshT5oH5c72+FBaAwRANE1U1Q8JSDzoKP5
         kh4o2K8YhcZr/lj/kGHgIT6cgp+Xv2AxUuN0DgfsDsccvliqvNjnSTriEReAsav0/fHv
         nELgnV5kbOkiOEv47yx4vJ9umtypcD25uBBNL593DFatqGwVA4UB8+T4GgKOJAXXTnoL
         Q9Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=eBJoaksl+YDmVk0O/pMB/ZWpuni/68BYE7uK17qPOPI=;
        b=jkRHTRAiprMxX3TK09TfTl4/6JmQzPwNIzNHgjgCLwTvkQN6fAPNejHI0g1nXPNUmI
         8/sdFFU07fLcHVE4tr03tD9HhwXFi5i5+N2bE0TKcw5e3hUW/r1dM+BJwbvAa+LVkqUN
         ETu7x9iJF0k377HYk9eQMJVAPhRAz2cCF6+j1WJTr9zipm3oFlFBnPM/vk/wVqR6+fp/
         +Y6srXP5XZpa3GUa7Do/+6s1zJbuhE+XpSlvEwhoIj/hNnf8/WKWgiCtTrMB8GSUgW3e
         GI1IiFMYF6aJhODz7jpGgmzrAXM2tbwTch2yzZPe2vt+WNWK4obEBbd8GEH+27madSMg
         lm8w==
X-Gm-Message-State: ACgBeo0n3M9IZ2NKTyi+qK1b+L5WXg+JN70KZGCgNexI1R4eT5c2wQXy
        QKAEx6fq4lb8DSVQFfg/JbnkTg==
X-Google-Smtp-Source: AA6agR5LbLxbEJDZOylBaSii5Kmhjzv03KBdIUZUGm6q9y86rSRISNpUWYGBW4Um5Wu+oN87fbGLcg==
X-Received: by 2002:ac8:5bcc:0:b0:344:57f7:a065 with SMTP id b12-20020ac85bcc000000b0034457f7a065mr4596776qtb.444.1660864319785;
        Thu, 18 Aug 2022 16:11:59 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a245000b006b5f06186aesm2864801qkn.65.2022.08.18.16.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:11:59 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.or, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/6] gpio: 104-dio-48e: Ensure number of irq matches number of base
Date:   Thu, 18 Aug 2022 12:28:12 -0400
Message-Id: <8a7db52e7ba040ad3523a15c6f9369e3d1f46a02.1660839809.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1660839809.git.william.gray@linaro.org>
References: <cover.1660839809.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-dio-48e module calls devm_request_irq() for each device. If the
number of irq passed to the module does not match the number of base, a
default value of 0 is passed to devm_request_irq(). IRQ 0 is probably
not what the user wants, so utilize the module_isa_driver_with_irq macro
to ensure the number of irq matches the number of base.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-dio-48e.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-104-dio-48e.c b/drivers/gpio/gpio-104-dio-48e.c
index a41551870759..8b5172802188 100644
--- a/drivers/gpio/gpio-104-dio-48e.c
+++ b/drivers/gpio/gpio-104-dio-48e.c
@@ -34,7 +34,8 @@ module_param_hw_array(base, uint, ioport, &num_dio48e, 0);
 MODULE_PARM_DESC(base, "ACCES 104-DIO-48E base addresses");
 
 static unsigned int irq[MAX_NUM_DIO48E];
-module_param_hw_array(irq, uint, irq, NULL, 0);
+static unsigned int num_irq;
+module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-DIO-48E interrupt line numbers");
 
 #define DIO48E_NUM_PPI 2
@@ -358,7 +359,7 @@ static struct isa_driver dio48e_driver = {
 		.name = "104-dio-48e"
 	},
 };
-module_isa_driver(dio48e_driver, num_dio48e);
+module_isa_driver_with_irq(dio48e_driver, num_dio48e, num_irq);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-DIO-48E GPIO driver");
-- 
2.37.2

