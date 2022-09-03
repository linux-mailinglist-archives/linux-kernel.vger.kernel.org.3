Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0AA5ABBF9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiICA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiICA4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:56:12 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB194EE3;
        Fri,  2 Sep 2022 17:56:09 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 76so3450019pfy.3;
        Fri, 02 Sep 2022 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xyJjUidnudJLgIqG5SiNAwy6tRLfWVHMLupHXGHYM8E=;
        b=egVUTjzKxCuf59ViPh/9XDNdI7lLI7bph08ZC0TzYNvDbNcoBf66q/IJ9hKpXKugKM
         HxSI0FpplauIrZt0NgMmz2TLRZv8jHW7aEqZUWmZtsWBMQ1Ct3syt51OAVJ/0A2550Or
         uES1KCRA//hefGSiryQpiWNeTtmrzb77Yd9BOGj8air3KjWHyOEdLyJAkRazV7zLaDyt
         pnt51tRALZ4aU2Ygy43PCBpWaq2q1Il/SbYjiX4KuENM04+B7ytKMkyeNITEG67NcXFZ
         eTdv1NC47PuTIfaSSqtriBakW44a2oEOtcGnmCIOL3WuvmYwP4dipdogg0H+zf8jT7cL
         8sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xyJjUidnudJLgIqG5SiNAwy6tRLfWVHMLupHXGHYM8E=;
        b=YrRYv2LjNeKhEDHk5aQaN+G5Dl1Rm0mZiUmwVxRxJGDAmIshqLdhpKl6q7d0IdJCP1
         0isp3SzX9GfxkZksq1juOTQo7qyyN9iLkuhE1SbTqJ9rPIg/8daUy0DRyedr/BmeUB1C
         EhVKOny9XuDVUZnXjDq9uoJbO4wTcQK5wuRiHBKj3dT0SFKSXbV4n0KGvfBv0VhABU/t
         urPRbY5ZJ1k+gNSvSXiGaRfuKLznMgmtF5827c8xQJ4xeiycEDmA22XhaNber+TsVkid
         U0UOVDsqe4RLnq79ooefmwgBZdnyThbzliPqraU/vqQVmjierKlc73ZixybKwuG01RVz
         mK/g==
X-Gm-Message-State: ACgBeo3OuRYeolufEdmuN4R0vjk1koAAnZOZyoR9Dmg+wgkxan2aFSsU
        mhXhfYESaxGSdNx4VGG/9rM=
X-Google-Smtp-Source: AA6agR6V0VjewkBJ9cuTuCw6uCDSkgavq8AVtPqNivS+eC50jQb8KKSaRsklwFn6rw1uExwRy1ye8Q==
X-Received: by 2002:a65:5b4d:0:b0:42b:31fd:b2c0 with SMTP id y13-20020a655b4d000000b0042b31fdb2c0mr32251039pgr.609.1662166568713;
        Fri, 02 Sep 2022 17:56:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b001f7a76d6f28sm2152933pjb.18.2022.09.02.17.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:56:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 2/3] leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
Date:   Fri,  2 Sep 2022 17:55:26 -0700
Message-Id: <20220902-get_gpiod_from_child-remove-v1-2-1e47125df20f@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
References: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-fc921
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

devm_fwnode_get_gpiod_from_child() is going away as the name is too
unwieldy, let's switch to using the new devm_fwnode_gpiod_get().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/leds/blink/leds-lgm-sso.c b/drivers/leds/blink/leds-lgm-sso.c
index 6f270c0272fb..35c61311e7fd 100644
--- a/drivers/leds/blink/leds-lgm-sso.c
+++ b/drivers/leds/blink/leds-lgm-sso.c
@@ -635,9 +635,8 @@ __sso_led_dt_parse(struct sso_led_priv *priv, struct fwnode_handle *fw_ssoled)
 		led->priv = priv;
 		desc = &led->desc;
 
-		led->gpiod = devm_fwnode_get_gpiod_from_child(dev, NULL,
-							      fwnode_child,
-							      GPIOD_ASIS, NULL);
+		led->gpiod = devm_fwnode_gpiod_get(dev, fwnode_child, NULL,
+						   GPIOD_ASIS, NULL);
 		if (IS_ERR(led->gpiod)) {
 			ret = dev_err_probe(dev, PTR_ERR(led->gpiod), "led: get gpio fail!\n");
 			goto __dt_err;

-- 
b4 0.10.0-dev-fc921
