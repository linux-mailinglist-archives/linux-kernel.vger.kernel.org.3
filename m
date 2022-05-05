Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B752E51C3E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381287AbiEEP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381312AbiEEP3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:29:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D3AAE6E;
        Thu,  5 May 2022 08:25:29 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i5so6562669wrc.13;
        Thu, 05 May 2022 08:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1OVr3xIZZW/mOBLy/F/QUZmki1qQeC6Q7iYf34ntqE=;
        b=HZYgSC4iXeNN6XzNiEF5EUVNbyDUloZLIuntKyEkdsrF7RfVMAjswIkbqul184/LyW
         OstwzdP6rCAz6qAb6C7GTzghRqpZJ9fGPumcE+7OyGC1YDl8RDT4rlsw6O9+b9T6bkPL
         4/ev1dz9ULyW0qYRpgGqebUtI+dVjVS8vSK3vve5CsAN3qOa1vvK1HGWg9YdaHB6pQ+7
         m6UjIdsCOjYklT0pGOQtBiJ7HwegnLN+s6HCXRFOXErHyNYcL/XPBuKgMqDilRwfC7Yq
         HDbgsS3p+Eg3geCyt3+gXqpcV6lj/J8hxxk1pIZBrtjawzZiENQ5t4RNoRY45XQ7WB5d
         bLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L1OVr3xIZZW/mOBLy/F/QUZmki1qQeC6Q7iYf34ntqE=;
        b=oaDAbTq4FzNyxjbHrX+smQawg3iXzQQvx45Jr9ARn/mWXOO/UsCb3ER2R3ZiUZpI3r
         eqB2hJqICq/cEtGzLzJqOMNGeqgLHhFWslSY3BqGjTrmHmFs0pLPfZiY2cb0i6Dm80/e
         BaOmX+bf7JxV0rma91/v+v2pUadlNv2S6sb4hwlmTV9vqMfSRhxhDEVx9xAp0VC1Gbwi
         aw2bHsqETdQrJbrs/FPbbPU1Zrbo2vfchewwXOBOrKH2IT1VPfj/pwjTPipt44/SA4yD
         fqye1RjN8B3fH8eT4wL8igcYKDEBqRIIUK/z44oFgtjH1mn1uzJXIc/V7r773EhNfTys
         7mPg==
X-Gm-Message-State: AOAM533vVXERGpZuUqAx3eTJZy+2WmRBWEZCBDjFvVmd6ZtxeZUSblvQ
        uRHZ9DAaFOp6pV5gsOjO+3E=
X-Google-Smtp-Source: ABdhPJxbrtQHChsVNjw3acL3J/+SwxEgQrcFecaLzmoiGkfhYZbm2s6ZU4aOgNH9Z0nqnSMwiFw/FA==
X-Received: by 2002:adf:dd0e:0:b0:20a:d00a:fcf0 with SMTP id a14-20020adfdd0e000000b0020ad00afcf0mr21160472wrm.239.1651764328360;
        Thu, 05 May 2022 08:25:28 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h12-20020a05600016cc00b0020c5253d8e4sm1578679wrf.48.2022.05.05.08.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 08:25:28 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     pavel@ucw.cz
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/2] Make AUX gpio pin optional for ktd2692
Date:   Thu,  5 May 2022 18:25:15 +0300
Message-Id: <20220505152521.71019-1-markuss.broks@gmail.com>
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
functionality and only affects the amount of current going through the LED.

Also convert the txt device-tree bindings to yaml.

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
v8:
- introduce a patch changing dev_err in gpio access to dev_err_probe

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

