Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAEA4F9C24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 19:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbiDHSBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDHSBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:01:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E986A188575;
        Fri,  8 Apr 2022 10:59:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id k21so16376622lfe.4;
        Fri, 08 Apr 2022 10:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8ldH75DpUXw+cHOPkEL+Os84zbLfTTSbUgqmJGQe1Q=;
        b=AeHcwHeYzcVI0VlIAFuPe4/2CgMzqgX8RQSxvaf93TM/s6oymRkMmus1agso0Ey3S6
         Xfs8MMc6wSWOsGRYj6Npf/ybntjKWqN7UniO4O83VMAL/OtXij4hp1K2s020KwUUMNKh
         bNCjid8cSKYuk992sGLkoGDesjCDvcUSsCe4t9S1ysga3Ckl1MXTELZ+P3YjtxDTu53Q
         1mhXmvVenMn8WA+Oe9NbaSlCg/53/coCB3Pwdjq75u8QIfZlsc3QZMzvcGtM+UeV3K+q
         +zct323QhgH5BTxetif7VYNcEr/8Bl4UVjIMgfe8l8TY1IVY5aL+E7H77umexPirwbor
         h+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l8ldH75DpUXw+cHOPkEL+Os84zbLfTTSbUgqmJGQe1Q=;
        b=g/71uxphlYOU7F8ldrdyitUegAS09KKDhD3l3BB3nwaxL7tVgClCONQP6eSopXPVup
         o34Dxd8j1th/7fvbmor9MlmBzil/09Py3pRzznx0Rn1maZW/4QL6g990bgtVQrHZGUdH
         vAeNWLKI1fpUgkrRlWcsuuhSSG+yoYPZOTBU5dah9A9bzQTEDb3piZwN/5wh39Lij0C/
         KTciCQ+Qg2xPLpVV5CprrLph0OxqzwBp8g7Km6z1kma0Rs2EnHJxUPKUxWtHs6rsxe5x
         wmULEsGXdP7+6SGEznlhPNwWjvdiu8sPsH6bmVOkg6yk+//TlKqu3tKfv1lZhoYOQf7v
         8lbg==
X-Gm-Message-State: AOAM530ua6CZgswxJX3XZMx7I0eePwNnobQO2LZ7s14H0T1gGMienkM5
        Q4cC/PWSiQ1ayXHFyxVwf5EZTbyXpoA=
X-Google-Smtp-Source: ABdhPJzlbv3TypspOgqHa0j5UXcJ3yBiFClekaUzswai6xLSLWg7iqcQk2yhL2HM0+t+BdUgY3sxWw==
X-Received: by 2002:a05:6512:68d:b0:44a:cc2:78b5 with SMTP id t13-20020a056512068d00b0044a0cc278b5mr12990324lfe.43.1649440776788;
        Fri, 08 Apr 2022 10:59:36 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p3-20020a056512312300b0046b83c2f92fsm272456lfd.58.2022.04.08.10.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 10:59:36 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Make AUX gpio pin optional for ktd2692
Date:   Fri,  8 Apr 2022 20:59:25 +0300
Message-Id: <20220408175929.281453-1-markuss.broks@gmail.com>
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

