Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6A51A420
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352530AbiEDPj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352227AbiEDPjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:39:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1034C13F8F;
        Wed,  4 May 2022 08:36:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id w4so2540124wrg.12;
        Wed, 04 May 2022 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=OzDqxyHbtYeDKrbrTJE+wQ3eBeVaumtj37IaVVAeC9ARzceB1OKgoX/Ecrlmwm9iaB
         o+V9TzsI/CHFFauL72Fr/+cLIT8RUzsVeDCyTeMcAYEqlwB5YXecflTnLFI1DiY9F2QJ
         aEmy50AFpD1CFucaIwSRby+lK5/75kGs81rB/zl5Q5WzKEfcVY0F4lFnqR2lckssDTKa
         IquL8ME5UQt+na69xRnnTuFwIzIjzsC96RNQYGfYDy3tBRvjKxgVR685oTbhhrNys3Cn
         6vdenNK+Eg0IqpSSR2kKMwgRO4gIlt3FlHAkHg33SDBudvZaG5WLKDLvszYV4+AGFu17
         URCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PLmxdEGvqe0b9xKOHj+/DgoHCwSTpZrIfVZVX1IGYVE=;
        b=MMj4OAy8xpMTO99+JElbXHQM/HFLdpFUii93fXgXCPpb40SevLRJphpaxstg8C4Ywl
         S6Agv6dRH30lNqMSpGtrMTLwUjkqqdwiwTPoeOcODA2BL2bq2iE2lXxiLIn8aE2Bo1by
         73OSAE6BDLot0Nlq43+xGrUVcayvtiMIr0g0GPUExCtnoRLr/UgzI7I4LEA7p6QMnxv0
         wEbxtJyW9M5niXPli5CcxodWE09JDIM9Km9Tq1+xrQyXBTEXr71fSfAcEzD5LTtokf7z
         VWAc+XT7MWTSijF/AQgGsgwKVIGlmBTRtniQvCdYQqIEnpHrB7RcrlDnygm8xcxz+s7X
         TSLg==
X-Gm-Message-State: AOAM5306lZumYbzxWSTkNaNCgB+T9qchSKfiT6MzpnDrE+CRJBlwZdGZ
        oyd/nLf0P5Fo1ZZw00MWe1E=
X-Google-Smtp-Source: ABdhPJxXJZwtpwN+dj9ID9AzZ+EepHOZVktPwMq57j37W7RlCqQl3a3t8JCpKzmmYfcTuOUXK8+Mfg==
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id h7-20020a5d4307000000b002079f82e238mr17696612wrq.430.1651678575602;
        Wed, 04 May 2022 08:36:15 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id e13-20020adfa44d000000b0020c5253d8c0sm11955838wra.12.2022.05.04.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:36:15 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v6 (corrected) 0/2] Make AUX gpio pin optional for ktd2692
Date:   Wed,  4 May 2022 18:35:32 +0300
Message-Id: <20220504153536.10749-1-markuss.broks@gmail.com>
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

