Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E58599102
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbiHRXMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344997AbiHRXMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:12:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040F8D020F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:03 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id u10so2260168qvp.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Qu2TGN9CjzD6yBI864XHlOsKzcqX8LEumSWv7yTr8E4=;
        b=cTlnrtwCj7fKbVCMWOP/7ScYWUlMmukWmTTFb2XdY90Tz/AP4dF+ykyJzJ7/idgkd2
         4aHh/bEcy4TIOIJYoXzJO/J3vkU9qH06467V+eRGumgqLs5YkNHeKz/o5kIWJVp+EgCk
         0UaKfzjbcg7GV8YsKuJalVI1rUyrc1+Wef47/9RWH6jEJ00yaR6G1XJ4vR5leuYaeaTk
         sPPqNb3pICpAzSW4xsrlb86cTligYLSUwhAwZZj6z3+X6/aXNTACOJis4R7mrLVBgbUx
         26h8nVjIBsLhpfX28dw5LCewnIFXpj0FMlSmibtJUbHL0yKk0RUkComkY+oPSGVjpwBy
         i+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Qu2TGN9CjzD6yBI864XHlOsKzcqX8LEumSWv7yTr8E4=;
        b=h+nTzU+nRWa2wsHQ0eZnvAFpKzqi4VE4HggMZy16d+/KavD2JOc39nQ9MJOLG7xFo2
         LcHfwXandPGn0MCkFcNlx+lhFj8YmgOZxGkgjbiubgfQFadoE8MD3uTJ0BsdC03QBdvR
         HliDdBQtPobO+9LaIsmmkEOgjquLm++RNAZCf1lmqxBvGZLKIErI6jgcHNiPC/dHliH7
         Vwtwg33aHZ+0Cnq5PmH+d3Z8BM2I1mU1BmfAT7xW1I9sYYXGPZ35myc/7XXuflsTH2aN
         v9d4XEpAWqJVJgoZMS7BPYAnGQQPcEZ+CsLVDQsOJqfDrmI3A1MjwLsjUaIKQ/gJEtTS
         vbug==
X-Gm-Message-State: ACgBeo0jlaqiYpOJwGCSbWGJRSPkUNuGkdHKuSUjNgQjxlYvyKeU+4Wq
        Z65JDmbGJ+7ZgVwIEl3Zo5ATzA==
X-Google-Smtp-Source: AA6agR5h9prYuf/tQ2t5gzKdwitmkasVnnvFulc/++B9Z/rQtTvdgQnhTj9W8wGOHlcPPeACKF/J9A==
X-Received: by 2002:a05:6214:19e1:b0:476:95b7:1dc9 with SMTP id q1-20020a05621419e100b0047695b71dc9mr4442306qvc.124.1660864322045;
        Thu, 18 Aug 2022 16:12:02 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a245000b006b5f06186aesm2864801qkn.65.2022.08.18.16.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:12:01 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.or, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 6/6] gpio: ws16c48: Ensure number of irq matches number of base
Date:   Thu, 18 Aug 2022 12:28:15 -0400
Message-Id: <f90ee47388495677191edf3cfb94801cce09a6f6.1660839809.git.william.gray@linaro.org>
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

The ws16c48 module calls devm_request_irq() for each device. If the
number of irq passed to the module does not match the number of base, a
default value of 0 is passed to devm_request_irq(). IRQ 0 is probably
not what the user wants, so utilize the module_isa_driver_with_irq macro
to ensure the number of irq matches the number of base.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-ws16c48.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index b098f2dc196b..88410da91aaf 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -27,7 +27,8 @@ module_param_hw_array(base, uint, ioport, &num_ws16c48, 0);
 MODULE_PARM_DESC(base, "WinSystems WS16C48 base addresses");
 
 static unsigned int irq[MAX_NUM_WS16C48];
-module_param_hw_array(irq, uint, irq, NULL, 0);
+static unsigned int num_irq;
+module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "WinSystems WS16C48 interrupt line numbers");
 
 /**
@@ -497,7 +498,7 @@ static struct isa_driver ws16c48_driver = {
 	},
 };
 
-module_isa_driver(ws16c48_driver, num_ws16c48);
+module_isa_driver_with_irq(ws16c48_driver, num_ws16c48, num_irq);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("WinSystems WS16C48 GPIO driver");
-- 
2.37.2

