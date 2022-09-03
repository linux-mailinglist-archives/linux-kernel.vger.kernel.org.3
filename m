Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92065ABBEF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiICA4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiICA4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:56:08 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FCF94EE3;
        Fri,  2 Sep 2022 17:56:07 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p18so3404455plr.8;
        Fri, 02 Sep 2022 17:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=r5Wx1Z4gq4FK0RyKOiQQU29ZAI76JQnot0k6ObZmXuI=;
        b=QLGCKk0zlUFdrrOknL1xomfaTil84PREFjuO+Et/4g1exjnzRUmT6JqzaXVZMVKy6v
         87qttQBTSVBoJUuyBJwPP47Yt9lLWvXdUQJqDyewHWgksBpJ6pWQ0OXJ90NmRgZ/c9kS
         zQodXLvoeIreMADObxvHAo1I6KUHu07+s4nPDeBBcoB8ykFLy1n/KTXniiUz1/J2xv67
         GiRZ1dj3ld4D7h8tCw6sA4DPZMDixoEcBU55UObeXYoWRxXtxgo8eqXggCdZjIfyM1/H
         qRY6MmjRs+IyX749OUr3ZQybV4rQNb6JAqtMejKb8hY5wDoGQTOTxH9+rfqubU19GiHE
         VtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=r5Wx1Z4gq4FK0RyKOiQQU29ZAI76JQnot0k6ObZmXuI=;
        b=A+JblVyAOb6MmxOOZNeySithTUYROUGMl4mMJTTF0tgObTdyNtlJC65ZZnmBLdTSI8
         8GGhDK6ayO9TIz+gh4DmUtMclqnWVKWm7cDdS+i28TgPlq4zc99mTl4Hh402C9LUJgW2
         EkE3nN2FEGepaaXdkrNyG/yhctfEzj3M0spmLMK1CRnu0r7TQ6oMKwMbtjfh4uO5BbB6
         fc7SLvMLEgWNkLNw+w1qFwOhUkjGIdsRXp5+b0wY42DkLisaj4AyI7Nb0oql74VTGEmO
         oBwuKWyS6Dm+Cu7j2oTR/IjmQ63ftZ12w3sGtUkzOS+9zDv84DaQeMNizB6XuNz9XKYT
         +fWA==
X-Gm-Message-State: ACgBeo02i9UNRSqWjN2+7f2ao3wThTJVAkT9fdNmDmYlzOFHOElpHpHU
        gq3jeQS50d4zbdupAZVw8fE=
X-Google-Smtp-Source: AA6agR6JKf4hr9c9inZBUjK7apw8cauUpAUx/7QzEsvm2ClhemP01V00ON0R9p0c2+/FGLG0RneOKg==
X-Received: by 2002:a17:902:e80c:b0:174:e386:c5b7 with SMTP id u12-20020a170902e80c00b00174e386c5b7mr24245882plg.84.1662166566453;
        Fri, 02 Sep 2022 17:56:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:ea21:afd4:e65e:539c])
        by smtp.gmail.com with ESMTPSA id nn5-20020a17090b38c500b001f7a76d6f28sm2152933pjb.18.2022.09.02.17.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 17:56:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 0/3] Get rid of devm_fwnode_get_[index_]gpiod_from_child()
Date:   Fri,  2 Sep 2022 17:55:24 -0700
Message-Id: <20220902-get_gpiod_from_child-remove-v1-0-1e47125df20f@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

This drops the last uses of devm_fwnode_get_[index_]gpiod_from_child()
from the tree and drops the stubs implementing this API on top of
devm_fwnode_gpiod_get_index().

Note that the bulk of users were converted in 2019, the couple of LED
drivers are all that have remained.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
Dmitry Torokhov (3):
      leds: gpio: switch to using devm_fwnode_gpiod_get()
      leds: lgm-sso: switch to using devm_fwnode_gpiod_get()
      gpiolib: remove devm_fwnode_get_[index_]gpiod_from_child()

 drivers/leds/blink/leds-lgm-sso.c |  5 ++---
 drivers/leds/leds-gpio.c          |  5 ++---
 include/linux/gpio/consumer.h     | 21 ---------------------
 3 files changed, 4 insertions(+), 27 deletions(-)
---
base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
change-id: 20220902-get_gpiod_from_child-remove-a62638849e91

Best regards,
-- 
Dmitry

