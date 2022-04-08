Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4194F9D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiDHSnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiDHSnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:43:17 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D512181159;
        Fri,  8 Apr 2022 11:41:13 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bq30so3761930lfb.3;
        Fri, 08 Apr 2022 11:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=bcvankhDxfLfx6D7fW/2lZAI/BCIZ/B0dEaD7uTgeC7ogjGO3IsAm4myP180aX1+kj
         iEu8P3CFMNABlQ+5lr4XT+cdNfPASt28YgZMCK6GykWQONWCiP3B1u2ExDjgnSSa/d09
         jx64awaD3cDrgg+pkUP4V5sjWP1Vaai5pWfRlbFi53pIqIgzeJBBD589Y2QWpBDXfSKv
         WSZzPMxFbzsNorxsHdM/Ah4e+Muhop9jKlmw3u/UGK75j68gwndQcPK7JC6tgMEnzmqm
         2YnuHu4hNUGrHRZJioy3hh29LywLyQcGODW9xwiEXJ1g1dahCcQMI9sHglCbZgcBEWpp
         bHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=XKljkKterHzTmsW/0ScDrWuE1L/7HZMyEHBGZCsQ2hhT+oDXJb0XVujjRhJA0eMN33
         iNMOBtj5CU4b11h2TQMl25PBUJPEiEU1YCNHmmX9IhsdmFE7typk7J1lqx5gn2wmCdqL
         dKMARz+Ys2TQ902fzeSoHGtf7vs9fu+VMpAEDXoBUfSGbRF3S+2wSbQ20GuyNGO93kzr
         mSZByWRVsbzlWeKDP7qZWSuENtc9diliAAht0Gkp6ADvgP5q1s+PAlwMuCxeuNBfzV2U
         XM/OspYvKtpsycFldin2J/kw1L01P66qzVWfpu9DN2aqY3YcAtsOPyn7q0kr06itYmzy
         YvqQ==
X-Gm-Message-State: AOAM531X7cCl804CEMG+nvuNQT4na8TJiNe3TQtPjvHTfNqxrBhBEzsl
        g2ahCgeZvwta5oeB3+rkq8B93fhXLY8=
X-Google-Smtp-Source: ABdhPJxj5fROSftre01R4gKx64ccim3sOMawHqr3xe/gGQfCMEsncx6WWM/emukJGfcs5cIar7f9bA==
X-Received: by 2002:a19:4f5d:0:b0:44a:2905:84ea with SMTP id a29-20020a194f5d000000b0044a290584eamr13357589lfk.120.1649443271660;
        Fri, 08 Apr 2022 11:41:11 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id v17-20020a2e9f51000000b0024b006037eesm2301201ljk.139.2022.04.08.11.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:41:11 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/2] Make AUX gpio pin optional for ktd2692
Date:   Fri,  8 Apr 2022 21:40:53 +0300
Message-Id: <20220408184104.13665-1-markuss.broks@gmail.com>
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

