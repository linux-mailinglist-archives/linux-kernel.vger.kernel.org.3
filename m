Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083784F7E69
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245005AbiDGLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiDGLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:53:36 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC26160FF2;
        Thu,  7 Apr 2022 04:51:36 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x33so2724532lfu.1;
        Thu, 07 Apr 2022 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u09dbr2J3kWX6uA8quc83UCris5KYtbTqkYaBN/TfUU=;
        b=DlgvL2jitqBXAHqL63GXHMC94DMVkHePzuUlrAHuCFdMzJk4kSksdZrV4qFeJ2PCyk
         UQ5xSmIlkrc24HW7n4GZJbpCoNolVH376u2SGitmiPhWZvQurmZtX7Sti77gFmnNq61P
         wTMutTkRpUyT00Bvpl+mhLMjOOpbNvDbuda28cM+pmjbxSiY9IyytWPdgYHl+N8JTaqO
         xyT2TyPzPbDtw7npit4w2Ve5YIRd4MhDBWTKBcwKuuEL8rb+MAsZgBk+i9g6T8iziM6t
         G9yrPvd/VnAAp9Wle0s+G1BsbF0YlbywsTZJJ6w4oZAPMXs2CdoxZhwN34YPJScZeGMA
         vzsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u09dbr2J3kWX6uA8quc83UCris5KYtbTqkYaBN/TfUU=;
        b=Qtegu+vRntD+XoblPWOHy5s+eqjre1SD4n8rHWs7zAihT2BvKuDGQ964FDhNS6WetX
         mkAPyAO7whSpFbZ+tS40y/Dt3jaaGS/G45Grp4jOu0G9hhpHKyMxKPcvN4x6G9IZECD6
         uT0iZCME6j3tzrozKJpGaR32wFmspNh3aOxRIGcedtyFGH/Z9sM77v75NkepoPfbvKOH
         g1XEFjJ7pGmVtea+fhFFxEhRtO0xSTYzSvZrthSESPBnShBDALPKhseqzaZ9XaohD0V0
         gdd5i7MgtH7DkGI4UYxH7FUdQIfKqiuOHvBCoSKW9UFbd19cfpBE3QrPrdUtMsmy/JZK
         +LSQ==
X-Gm-Message-State: AOAM531j8dLTRI1o2Ge3HpaJvRGxeMOHHCyMvzc6ZYJXzGyvVgVPwvIh
        FWOYnbY1qFdYUMVVtxJY6Ml8rEvdvVQ=
X-Google-Smtp-Source: ABdhPJx8jP2VaJwm1llTHyjsLGBW8X2d60KjIl5HU4kD4ZNMB1nzwljTIx+roRV8Pq54FTREvarmmQ==
X-Received: by 2002:a05:6512:2210:b0:44a:d493:bb9c with SMTP id h16-20020a056512221000b0044ad493bb9cmr9110087lfu.3.1649332294248;
        Thu, 07 Apr 2022 04:51:34 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0044a2580a2d3sm2143666lfj.156.2022.04.07.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 04:51:33 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 0/2] Make AUX gpio pin optional for ktd2692
Date:   Thu,  7 Apr 2022 14:51:23 +0300
Message-Id: <20220407115126.69293-1-markuss.broks@gmail.com>
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
v3:
- set the aux_gpio to NULL to avoid passing ERR_PTR as a gpio

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

