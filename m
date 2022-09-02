Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0CC5ABA46
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiIBVkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIBVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:40:29 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7613E326DD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:40:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id w18so2741680qki.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=+8Ft1mVGdwq0RIV8cOnix7sgy5002RZB61A7qgepDD0=;
        b=mn6P/pezyV0nyqwkgmNcfOjKB4yTZPoV/I8xuQYyZQxw5Q+xbj8Wlzc25aAbV7FGbK
         Gx2gniQJ4aSGPujlhqbJrYo3FKsaUfayKjS4DNbASUEB3jX5lP5SydoI0rRVoPi3AoM6
         aaq1Hc3PgzsRKh4o4JrARzKeFB4JCcQHlT2EZ91ZfzHzrEt1JngdwVtnYI2U1avwpLYA
         YNj506+cGaphNqnqkgj0PLvVn9qVLuUu00eer0idNvRFRjusoOobTXc2QY7Gj+j/cBIt
         uzq6fedSpSRGljs5stELZkcDl9XBn1bWAxoTvUmUzeh32fQwS0NC+6qtuUROtZqCplWs
         wSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=+8Ft1mVGdwq0RIV8cOnix7sgy5002RZB61A7qgepDD0=;
        b=tSD0xMXw4izmYUCAua2j2y6gn+V8Ciy54wWm+P4puG109tVXXWS8AVzp2x83eIVcaL
         fOQqt6PMROSFqBug/ZOETbPmdUMkeN8RMwJvK1flcaq6a5gBk7wIz1wGfYTK2hgZFuwi
         eTpRkiGyumVTcTgKrdmuH/kFiX/NUilKjtfXg5/+yIKST+BlDh7CPge5ErRPctsg5VuK
         CG+2fpBejEjLAtveXIvwo3vXTGodSxm8OGUbQXpP2OiOCFDBug3jpNVptQOY32anySrc
         gT2apPRS2gaN3DEzrwY2GpU0Z/GaEhDu+1Xfix7xedFj//kP4VsxQgbJkccADd1udx5F
         RuyA==
X-Gm-Message-State: ACgBeo3b3WAqInSRyeDXI+he7wvrwkiqS8IAS2Rk16VuLv4ItXSFLql6
        Ov/9IZYXB8gMh+9mmz3XPvFypg==
X-Google-Smtp-Source: AA6agR4uJASxNPWEK/cs1v9m6Yj/4v+DmsqZAcam1NqmGYpkOusEcWnxWsFIW0eCeWTXt2L/3brnQg==
X-Received: by 2002:a05:620a:4114:b0:6bb:33c2:45f9 with SMTP id j20-20020a05620a411400b006bb33c245f9mr24616586qko.374.1662154817936;
        Fri, 02 Sep 2022 14:40:17 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm1819533qtp.23.2022.09.02.14.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:40:17 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/4] Make irq_chip immutable for ISA drivers
Date:   Fri,  2 Sep 2022 13:45:22 -0400
Message-Id: <cover.1662140119.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel warns about mutable irq_chips in ISA drivers:

    "not an immutable chip, please consider fixing!"

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

William Breathitt Gray (4):
  gpio: 104-dio-48e: Make irq_chip immutable
  gpio: 104-idi-48: Make irq_chip immutable
  gpio: 104-idio-16: Make irq_chip immutable
  gpio: ws16c48: Make irq_chip immutable

 drivers/gpio/gpio-104-dio-48e.c | 10 +++++++---
 drivers/gpio/gpio-104-idi-48.c  | 10 +++++++---
 drivers/gpio/gpio-104-idio-16.c | 18 +++++++++++-------
 drivers/gpio/gpio-ws16c48.c     | 10 +++++++---
 4 files changed, 32 insertions(+), 16 deletions(-)


base-commit: 6ae8e1d0d5e5de922315830aea975c63e8c70b2f
-- 
2.37.2

