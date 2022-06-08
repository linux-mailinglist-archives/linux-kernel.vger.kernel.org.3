Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18D543E53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbiFHVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbiFHVMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:12:13 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B552FA600;
        Wed,  8 Jun 2022 14:12:11 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id s1so17529744ilj.0;
        Wed, 08 Jun 2022 14:12:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PhK8gQeeDf/2yHkxa648eCoqZ+9RIeWpPVRZuyaKxg0=;
        b=KS23V2K42GnimefksDVOvghhWTJmZ2WhcezIbTNKDWi9JIU+buIyCvTjEteK/tudiS
         t3jUFqAUfKo9EoRpod8l3L37mV2sg26y6ktKrzLpda7iGYClDMA3LYNF+7IDwmMbyi2s
         w2LgAb226BVxol6VzzKq66HE6DHeAUFz3XtQhCtQ2kPSBVqQ3uBAbr+O4mW0IT+YXHri
         +7wafnHvGVAok1Qis/R0sKh5/v6pN5SjtbLKQXCjrS+hfganbgMkpQkiQF4w9FRMNLC1
         ulVDg6qYfWZOnwnz8N2KfqlUY7ACAlqQT4zRDY6pQolJn17QdlBq5VIWRXfy3lpvnDIj
         rlmg==
X-Gm-Message-State: AOAM532vLH2JqEKxB8mbbkh23ME29Br3dvjzSWZ4p6INuGcFrzaZ4iPW
        fwAjswfzmxTIGQUjQoD/mg==
X-Google-Smtp-Source: ABdhPJxUUCQsJvfQM0+vAJPEKWtpiJ1lC0N1AjSkw3LRVkHiUgY0wszhleAUy2dMyX4wgiWWPhHmXw==
X-Received: by 2002:a92:cf01:0:b0:2cd:aeb6:b3f8 with SMTP id c1-20020a92cf01000000b002cdaeb6b3f8mr19782664ilo.265.1654722731199;
        Wed, 08 Jun 2022 14:12:11 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id v11-20020a02cbab000000b00331bd537addsm3295264jap.102.2022.06.08.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 14:12:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Artur Rojek <contact@artur-rojek.eu>,
        Maxime Ripard <mripard@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] dt-bindings: input: Common property clean-ups and adc-keys conversion
Date:   Wed,  8 Jun 2022 15:12:02 -0600
Message-Id: <20220608211207.2058487-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors the common 'linux,code', 'linux,keycodes', and
'linux,input-type' properties defined in various binding schemas. As the
properties are common, they should only have a single common schema type
definition. Note that 'linux,input-value' was not included here as it is
only used in 1 binding (gpio-keys).

The clean-ups are are result of the discussion on v1 of the adc-keys
binding conversion[1].

Rob

[1] https://lore.kernel.org/all/20220606184243.1057145-1-robh@kernel.org/


Rob Herring (5):
  dt-bindings: input: Increase maximum keycode value to 0x2ff
  dt-bindings: input: Centralize 'linux,code' definition
  dt-bindings: input: Use common 'linux,keycodes' definition
  dt-bindings: input: Centralize 'linux,input-type' definition
  dt-bindings: input: Convert adc-keys to DT schema

 .../bindings/input/adc-joystick.yaml          |   2 +-
 .../devicetree/bindings/input/adc-keys.txt    |  67 ------------
 .../devicetree/bindings/input/adc-keys.yaml   | 103 ++++++++++++++++++
 .../input/allwinner,sun4i-a10-lradc-keys.yaml |   5 +-
 .../bindings/input/azoteq,iqs7222.yaml        |   8 +-
 .../devicetree/bindings/input/gpio-keys.yaml  |   8 +-
 .../devicetree/bindings/input/input.yaml      |  24 +++-
 .../devicetree/bindings/input/iqs269a.yaml    |  15 +--
 .../devicetree/bindings/input/iqs626a.yaml    |  11 +-
 .../bindings/input/iqs62x-keys.yaml           |   9 +-
 .../bindings/input/max77650-onkey.yaml        |   8 +-
 11 files changed, 150 insertions(+), 110 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.yaml

-- 
2.34.1

