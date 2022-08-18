Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383A0599108
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 01:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345758AbiHRXMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 19:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344032AbiHRXMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:12:01 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E07CE474
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:01 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id mz1so2278918qvb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MsO4YVqRB/LxYJYvW/oS7wwQWO4uPdmi9GWambEMbVo=;
        b=naQCv8X64zCQp8iIgBZaU+rAQz2523+/kBGlVj5Q/er2cqxiqXtVK/rttKDQlgSFAp
         5zY081jcutGekPFCjJC3mdWkjxpiYXKUyc0ZYDvkrtW+Vg+x/WANRZ0hlIU6uwWpNwuz
         RrrDt1N/XTjrTkqZTIFrNZ7/cjjNUeUOeGz8DCfUVgoBhV+fZPEpWJsOXQzTQCahcqkO
         o8r0Z16LHk7vzB65br/pItrm+Z4Es9BBXZOEl93h9SmX+nhTME44hKQv+JAoC5FEd6b5
         vTd3ZR0MaEr8ViEVZpbwiWlIWXWdIHCGboGIeRVbI0NZAuXqo3360OGeyu4UFe1QrV7G
         x0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MsO4YVqRB/LxYJYvW/oS7wwQWO4uPdmi9GWambEMbVo=;
        b=PxdGJbFN9EY04kOV2Okn09GvGfrW0nitsww1NGkp3+Mw2xNhmAgOzPsHkcD+CrjOJf
         ez3sFR/qXiferdUxJl3KXV4Zn3+FhrGDtCM9zW+XepH0nsEn4CnpjL853NbxvgFLDlH/
         AKkmGHOV6rkHp6NMbG8zZQvUMVw0czmNjAsgDN1mqJkcy7vT+/Rh7BDN/V1yR1bkGVxZ
         NjSCDiuHqrY2ZYpBbjCYvAqKd3xZyUP8D9EbI25K8Z/bjmuFUZ6JvLJoKkOPvf3XN/Dk
         0UrPxmS2rEFNmKorZUomE8G542cJj5VZGPfo4cfzcamxfz+5LTjIJNA5oFQYNqv5Tcw0
         VfQg==
X-Gm-Message-State: ACgBeo1Y1eWMIVq6+JPcDiv5cwObucPgreUVjyo9539CB9674SQ8IkSM
        QExqzgNDCGGsrtnN8qW0AjyVog==
X-Google-Smtp-Source: AA6agR572EmSRg7psOMyjjr8QtyJyPm/wTr5K+kDpOFNrf0Qm4gJUF3+oWRroS8wmfmyQzV3J++Qkg==
X-Received: by 2002:a05:6214:5287:b0:476:7938:5b76 with SMTP id kj7-20020a056214528700b0047679385b76mr4454411qvb.131.1660864320495;
        Thu, 18 Aug 2022 16:12:00 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id h16-20020a05620a245000b006b5f06186aesm2864801qkn.65.2022.08.18.16.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 16:12:00 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.or, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 4/6] gpio: 104-idi-48: Ensure number of irq matches number of base
Date:   Thu, 18 Aug 2022 12:28:13 -0400
Message-Id: <0b7dbb8b35bc2b685fae5ce66ccee5b7c4a1fdc6.1660839809.git.william.gray@linaro.org>
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

The 104-idi-48 module calls devm_request_irq() for each device. If the
number of irq passed to the module does not match the number of base, a
default value of 0 is passed to devm_request_irq(). IRQ 0 is probably
not what the user wants, so utilize the module_isa_driver_with_irq macro
to ensure the number of irq matches the number of base.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idi-48.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 40be76efeed7..2b0256eefb70 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -34,7 +34,8 @@ module_param_hw_array(base, uint, ioport, &num_idi_48, 0);
 MODULE_PARM_DESC(base, "ACCES 104-IDI-48 base addresses");
 
 static unsigned int irq[MAX_NUM_IDI_48];
-module_param_hw_array(irq, uint, irq, NULL, 0);
+static unsigned int num_irq;
+module_param_hw_array(irq, uint, irq, &num_irq, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 
 /**
@@ -300,7 +301,7 @@ static struct isa_driver idi_48_driver = {
 		.name = "104-idi-48"
 	},
 };
-module_isa_driver(idi_48_driver, num_idi_48);
+module_isa_driver_with_irq(idi_48_driver, num_idi_48, num_irq);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDI-48 GPIO driver");
-- 
2.37.2

