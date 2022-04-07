Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04D4F7D63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244617AbiDGLA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiDGLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:00:21 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1369010FDC1;
        Thu,  7 Apr 2022 03:58:21 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id d40so1408774lfv.11;
        Thu, 07 Apr 2022 03:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPP0D+z0IDd44ZdD/ERMbUpce+RzSVT1iFXSNsCKFkI=;
        b=Vrq3wqT9Yy+lScwQjwrpYNdVVuF+df1AXf8NKz8voG6upS7Z4DtBYThuw4jsNCxTBw
         VCQtG8QXyitctbs84e93WkRvhXOgQ9NBlM8D4IhKzeN1qbS2CH9iNrUtzYfUzbUYVrU6
         3JwKKjwDSWC6LUG02OfB4P2/Xra94QxQIZwDG8aPn41LA7Zu0qdUo4BSNKjBStscZu2j
         0kygSVGI6KSfbElmC/yhKmJZWf6uUW9/z/DX5B+YimDBXWJSNo7C5F68qQzB3M9lORbs
         KkDWkceeTixfH2xhyGr55UoxWsN9gilmZJb0gu8Cm0YMC02C8eGKs4ppv8SMDslgrzzN
         t2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iPP0D+z0IDd44ZdD/ERMbUpce+RzSVT1iFXSNsCKFkI=;
        b=NamFtQnW38amL9EHw8KFkrtng98GGgChMSDAwmUFaZOPV/gY6IwsFks77+rLf5xHTQ
         sH6cNbMK3PswJY62lkH19Zy+U8FBu2/xF3o6by+eKfV3jm62QXf3Tjp4wdW6wsN/SpiF
         8xxyhwvjSn5djq547W1A1BuyZ2Ul+AQSCiLTdYDhznomf0ny8nCeQdzx9s78XzGS4rCN
         st9Uj6KnFqtY46WiXTat1OKmzDo2lzCwSZmuWizz8ShRhwNn7Dn0mkO4SBL6f42GNs6Z
         QhUjVsTUG7qXPSXIFDphUkHBMsSphaCvi2kuMT/uLg5VoubjKbmE8rTtTm02zxWZBEFY
         80Kw==
X-Gm-Message-State: AOAM533nEMfTX8BIOXOuw7P8PdCigwvZDMKEcfizr0+gDDFsK6TMerm9
        LKQiFPu47vl32Qzx426S56r24ze0t1I=
X-Google-Smtp-Source: ABdhPJxBPt8+NklYLn0p3RGLWz4vBwvu2EdD0iFMLgbtVOvvDsf9T1DjGMJmF3jliMOVv5Xj9usMsg==
X-Received: by 2002:a05:6512:150f:b0:45d:ccac:c43c with SMTP id bq15-20020a056512150f00b0045dccacc43cmr9467948lfb.604.1649329099065;
        Thu, 07 Apr 2022 03:58:19 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24572000000b0044ae25d47d7sm1990273lfm.143.2022.04.07.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:58:18 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Make AUX gpio pin optional for ktd2692
Date:   Thu,  7 Apr 2022 13:58:07 +0300
Message-Id: <20220407105810.20399-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Some appliances of ktd2692 don't have the AUX pin connected to
a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
for driving the front flash LED, has the pin not connected anywhere on
schematics. Make specifying the AUX pin optional, since it is additional
functionality and only affects amount of current going through the LED.

Also convert the txt device-tree bindings to yaml and pick up maintainership
over the yaml binding and the driver itself.

v2:
- fix the dt_binding_check

Markuss Broks (2):
  dt-bindings: leds: convert ktd2692 bindings to yaml
  leds: ktd2692: Make aux-gpios optional

 .../bindings/leds/kinetic,ktd2692.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/leds/leds-ktd2692.txt | 50 -----------
 MAINTAINERS                                   |  6 ++
 drivers/leds/flash/leds-ktd2692.c             | 18 ++--
 4 files changed, 103 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/kinetic,ktd2692.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/leds-ktd2692.txt

-- 
2.35.1

