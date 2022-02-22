Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CF74C0311
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiBVUfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:35:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiBVUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:35:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462112D93E;
        Tue, 22 Feb 2022 12:34:40 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bg10so46520851ejb.4;
        Tue, 22 Feb 2022 12:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJjW40gRYjxp9MOc6prbOQbeJQ4Y96DDyPM3W2oQ0zQ=;
        b=LopXt5kB3hxGK0aA50DzHk+5tKlxBFD9uSUtVWerRLtJSjayu4367XM1r5cIPFx+Sq
         c7R4HaBJSrHWKruQItW+p5U4+D7gdLHfm4lyOROOXL+7LHH+F39SWgQ0XpaS0731nRZd
         w0svFDzd5lt1KhGVvPfz1BgU36ugsCUoYlluYMxvKYH7Irn8VjYxWrlGZxyX7nYfNSPM
         0oRC0t/L9CzbqWisTVsMbW/QXQcgfU3Z4NRby95+ND3dPSTcj31BmCQLodu6VllVag3H
         3m66m5/vRzsl9wSiY0ZTrBcWYgKQRRDUgng0hzxTkErcwcf4S3Tc6MQmRh5o0HI1E3W8
         +PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJjW40gRYjxp9MOc6prbOQbeJQ4Y96DDyPM3W2oQ0zQ=;
        b=MnMpN5x2xISQ9Qx6kn91IPGsB53S0ms3iQd83STvXrbnt33B3TSYHraweNo590tDRm
         iKkW76iASZ7q2WD/lVJFcj5fwcTM2CEAN6hdUiwuFaHx/2qYC8JGy7TCUonAmF8kTlt/
         5WEgUVYM0wpr+semN5/dAIe6UWwDWaoanQVrzPUnj65DbE6k6oYReqo5dmRSqu874CqI
         sZxuhkGrASrrWJydKUZXZbkxtAJrSry9HxZSWqXiu3JhdTwTJgBjmaJdELfp3FlWeqmZ
         JTvTpVWQB/VKyCH+JiIgLKauizPBg405EAvDliwb4GWK5Fj6Q43YWY+u/v/1p5Q+xRbd
         rmig==
X-Gm-Message-State: AOAM531AFUgKptQ+yipXT6andfbV9bFzIMmQUBEmjZV1JJ+Kw9gdnzHt
        e7/D4PWb1JRdfbUjCS1atmFL2atbpKsNIttr
X-Google-Smtp-Source: ABdhPJz3JHOgC8ANlkEN+8VPzW64fK4g9/h4wZ9C+XjBPur7Es5FiJFR1e3OQobDQmjhGKChv/7BLg==
X-Received: by 2002:a17:907:1183:b0:6cf:ce2f:51c1 with SMTP id uz3-20020a170907118300b006cfce2f51c1mr20466998ejb.209.1645562078864;
        Tue, 22 Feb 2022 12:34:38 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id ec37sm10358388edb.19.2022.02.22.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:34:38 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v6 0/2] Add support for Imagis touchscreens
Date:   Tue, 22 Feb 2022 22:34:09 +0200
Message-Id: <20220222203414.8656-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.0
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

Add support for Imagis touchscreens, used on various mobile
devices such as Samsung Galaxy J5 (2015), J3 (2015), J5 (2016).

v2: rebase on top of the correct tree
v3:
- prefix all defines as IST3038C
- use two tabs for all defines
- add missing <linux/regulator/consumer.h> header
- drop ADDR_LEN and DATA_LEN defines; use sizeof(reg_be) instead
- use __be32 type for reg_be
- add a comment about i2c read not being successful on first try
- use "ret" instead of "res" in read_reg function
- don't use the internal __cpu_to_be32 function, use cpu_to_be32 instead
- use "error" instead of "ret" in interrupt handler
- pass the slot state directly, without ternary operator
- drop the dev_err in init_input_dev function
- reorder the functions in _probe so that the chipid command is read as fast 
as possible
- don't use imagis_start in probe
- initialize the irq after the chip is powered
- save the return value in imagis_resume
- drop WIDTH_MAJOR since only TOUCH_MAJOR is reported
- the "chip detected" message is now dev_dbg
- reorder headers so they are in alphabetic order
- use GENMASK to generate masks for getting the X and Y coordinates and touch area
- drop *_pressure from device tree bindings since the driver doesn't
support reporting pressure
- fix the typo with i2c address in device treee bindings (48 instead of 50)
- add IRQF_NO_AUTOEN flag to avoid unbalanced irq enable
v4:
- alphabetically order MAINTAINERS entry
- alphabetically order Kconfig and Makefile
- drop the error message in init_regulators
- disable regulators on probe error
- drop IRQF_TRIGGER_FALLING
- @ is not optional (device tree bindings)
- don't use items for compatible
- add maxItems property to reg, drop the comment
v5:
- compatible enum is not an item of the list, drop "-"
v6:
- add _MS suffix to the delay define, drop the comment
- change the reason for retry comment
- add imagis_power_off and imagis_power_on functions to turn regulators
on and off
- use imagis_power_on/off in imagis_start and imagis_stop as well as in probe function
- use error instead of ret in calls to functions which only return 0 or -errno
- include linux/bits.h
- proper indentation in Kconfig
- drop the dev_dbg chip id message
- MODULE_DEVICE_TABLE(of, ...);
- no extra tabs in i2c_driver struct
- save the return value in imagis_suspend

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  78 +++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 329 ++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.35.0

