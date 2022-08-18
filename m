Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DEE5990FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbiHRXM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241453AbiHRXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:12:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5D0CE4B1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:02 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id c5so1851938qvt.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=qjb4UgDhX3ydD5kec1iqNaG0SI9GdLWkjzQByMg9NrQ=;
        b=g8/ws7q79GlxKc5ucYMbw++jeXfp2K0Zi95QP/YtmX6Yfo1D77X9pgZaA364BqaTb0
         tVbbfNI29WLDLiND5lK2Pd01q/I4AOvpmhmwjeNrzZNE2RMwF9py4MGc8rpP4XA1PO5x
         y+4f5NwFlti42304Z37C0BiqrocI2QmE9PCxKjEGirzad6jfdow9Xg6UdJwev86mqXjl
         CqFmaHeAYSOO+Amv2C+q4uTsN+QA5j4jeOz+feIoApm9MlAKnssj2B4EcH5jfWGQlyom
         +xw9eCaxrGNFgtU5NHwGacbTLUUPgVSnW7lq4iTeKvc51EWdanartn3UFWU5QNpEoLbh
         b5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=qjb4UgDhX3ydD5kec1iqNaG0SI9GdLWkjzQByMg9NrQ=;
        b=3OTy0EARI2N8WCW7uHJ6hkKCKtDqJTsWcW5hdNxj/egLzb4YLZqR6J8bSiwUAULSfV
         dGvBe3SC8QErp6chm+LnuGBmFcQ+3+1YB5wuaBcTCjyHLSyT8XxwYv7RruzNRJgSpgfK
         BB5h6SgYXBrtCJnawMr0Syku0NWLHBVUd10z1gLaW3t1OBdniYnPKYg2x6O0ImuN51gL
         n4zLB+6LYZrZEgo5bYolvXEkgHRwNpgsxRIBwHbAD7mzqTVRYLMtA7dZ8cSboY/A0QN2
         L0F2+avShltXq/qsV0sS+dZb3K0HVFvf+A7lLpSRFUNQSNBLvGXBPFKK+78OPHbYPCAQ
         ivGg==
X-Gm-Message-State: ACgBeo03XqlWuQtV0UAIwZAVPV5n1BnziKjQJRT6jDdDmcDgpN0hwgja
        EPzfsiGQB2uoN/a/VcasO93GXg==
X-Google-Smtp-Source: AA6agR4KKxeQ/P/SWs4vqAaffTyu7nBhtltEhYQjOe1EDTSgsdFR1vBA8rIaTBjskNnuT46vtIX3mg==
X-Received: by 2002:a0c:e246:0:b0:491:d36e:e3c9 with SMTP id x6-20020a0ce246000000b00491d36ee3c9mr4445052qvl.68.1660864321248;
        Thu, 18 Aug 2022 16:12:01 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a245000b006b5f06186aesm2864801qkn.65.2022.08.18.16.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:12:01 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.or, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 5/6] gpio: 104-idio-16: Ensure number of irq matches number of base
Date:   Thu, 18 Aug 2022 12:28:14 -0400
Message-Id: <dde2f3513258c945dc10b853638098a1cdb1e1f1.1660839809.git.william.gray@linaro.org>
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

The 104-idio-16 module calls devm_request_irq() for each device. If the
number of irq passed to the module does not match the number of base, a
default value of 0 is passed to devm_request_irq(). IRQ 0 is probably
not what the user wants, so utilize the module_isa_driver_with_irq macro
to ensure the number of irq matches the number of base.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idio-16.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 65a5f581d981..73d95b55a8c5 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -30,7 +30,8 @@ module_param_hw_array(base, uint, ioport, &num_idio_16, 0);
 MODULE_PARM_DESC(base, "ACCES 104-IDIO-16 base addresses");
 
 static unsigned int irq[MAX_NUM_IDIO_16];
-module_param_hw_array(irq, uint, irq, NULL, 0);
+static unsigned int num_irq;
+module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
 
 /**
@@ -333,7 +334,7 @@ static struct isa_driver idio_16_driver = {
 	},
 };
 
-module_isa_driver(idio_16_driver, num_idio_16);
+module_isa_driver_with_irq(idio_16_driver, num_idio_16, num_irq);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDIO-16 GPIO driver");
-- 
2.37.2

