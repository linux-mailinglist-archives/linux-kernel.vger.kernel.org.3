Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DF51ADE0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377554AbiEDTjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377557AbiEDTi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:38:59 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C9212754;
        Wed,  4 May 2022 12:35:20 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x18so3383066wrc.0;
        Wed, 04 May 2022 12:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMBVcPvfdOGpcRb8oCuPrUcLjm4n14Svx/JKtfhn2yQ=;
        b=Ux+vOoiCXJhaJ6V0YGgg4lYzeYeXaqhZ3Nv+FkLc5FrBtLfaTxBiuYno04DMy0ch8y
         weTWq0vFBlFXSs1InfVgdcp215nDx+Vgd/u6Ivu2Arwv560x6N5zB7EdxUQeFv3PYjd1
         7nG431Va9IVtGQgxjtV5BFnFH2660S/ksNKmNSXx0kpscVNELk9h7KaSfVxLaREyEk/5
         I8DqgHUzfYpGga5gx7JDYI3ATkUQ3+DSw9EjRHsRSNHGswmlR3SNBYycDtPBsE3YYiVD
         gwYXJOr3wfEKXpeQmHWsjxs4Ka0bHqQNl+Aj7VJd4cjLs1/eqfg9ybaJ3Pd/45+jjbQF
         9v+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMBVcPvfdOGpcRb8oCuPrUcLjm4n14Svx/JKtfhn2yQ=;
        b=3ajSxeq+4Tl3nGyKOOrSa2cQ5cwXBeCEoPggO5t9Y9k6q+VwmnjE8eVMJH8mFIOhyt
         PgmfSlLVpuKDsxLHh0DKrK8E3IaN3QYAH/oeGS1XzhEb6sGxpXYLHFTsdM8JQMcNNzbl
         76c78IPcrkSyCDIDLYu+eBWLJvbIoZ3NJtLu3otSD6hcjCVeaMXSaf4hZ3+9Puyt+2+D
         fHTlMYPwvCvtB0Nl1hhzmmbkq3Q4JZoaCmXvQHzqjFgBNRhR2X5Ok8UHdRV+lqJjFR9y
         BZGSGeTJjNrtWCu0FrNXCP05ZVIh1h8jm2mzGcDe1aWO7FLsr0ajA0xnxBu8jetlAWhl
         S8DQ==
X-Gm-Message-State: AOAM533w9kz0dR5I+cifsM+ATMnktINambVyyUF3sUaQpP8uCuDyX493
        ROsxZBpOhTtn64ZJqaK02I3uj0t+el0=
X-Google-Smtp-Source: ABdhPJwWyRu2fZfqUT3vpgO5d+alY5bqVY2UcqI0FiWvtbeICjzNqriuIqLSiX8JG/De2/QA+9VwMQ==
X-Received: by 2002:adf:decb:0:b0:20a:c975:8eec with SMTP id i11-20020adfdecb000000b0020ac9758eecmr18092105wrn.438.1651692919367;
        Wed, 04 May 2022 12:35:19 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id 67-20020a1c1946000000b003942a244f2csm5519358wmz.5.2022.05.04.12.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 12:35:18 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] Make AUX gpio pin optional for ktd2692
Date:   Wed,  4 May 2022 22:34:34 +0300
Message-Id: <20220504193439.15938-1-markuss.broks@gmail.com>
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

Also convert the txt device-tree bindings to yaml and pick up maintenance
over the yaml binding and the driver itself.

v2:
- fix the dt_binding_check
v3:
- set the aux_gpio to NULL to avoid passing ERR_PTR as a gpio
v4:
- maintainership -> maintenance (description)
- remove the if (led->aux_gpio)
- use devm_gpiod_get_optional for aux gpio
v5:
- use ret to pass a correct error return code (Christophe)
v6:
- use PTR_ERR properly (when IS_ERR is true) (Christophe)
v6-a:
- ended up being a mess, corrected-v2 should have proper tags now
v7:
- drop the MAINTAINERS part

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

