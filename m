Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE504C182F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 17:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiBWQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 11:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbiBWQJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:09:30 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E316C249F;
        Wed, 23 Feb 2022 08:09:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x5so44857460edd.11;
        Wed, 23 Feb 2022 08:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyZRbXUmNhOeC2PbqfcoC4tf9cHQR1dNU7NBuU/qb9k=;
        b=AWiaWyGsWe9eDbFoRVqklvwEiIlJiCMTsLVqBy7gKYDTSOTSXZ62tbEiFGtlwRl/W8
         uJg6aW+VVk4BzQ6ZRYq9bnWRkr45Xi35j+sUx/xrVKHkYuGBr8If7hxtyweYJxAwuR8v
         ys6Sk1L8DRQpZae5fYcmo75wG890PgFwBtPOfDTALzLTrZUa+g43hK5Fk5I9CYjP8f9h
         B0oG29nOsKb7QmZ536lo2qlTTEQN5+cSda1jGpeo08NJSStbWUMfCOrZHheP594Ow9VY
         MniS9nOUyJ9n0uhrXtIvwKRKUVPgpE3BwRVr86gWxvom41lxyhF12xdU+sOk6vSEdxAG
         UQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZyZRbXUmNhOeC2PbqfcoC4tf9cHQR1dNU7NBuU/qb9k=;
        b=I2Z91HoZzpJOngzI8HOZdu038u4rGCpC4diW9Obj4vqXsqWEJMlqbev57ugJdKqYDG
         PhE065DK0n3otigZjfZ8YAVyYgXXcpd9Ogn7sPOGOSnbcXhYYQ/QiOTrgvlUFTyn4sdd
         oMVgstH4fBhGCyMPOC7WsH2mNPMAER3yhcb1A/V5njTeEdr0PreB6+ltiY9/e1gDsks3
         yc2ppv5WbyO/ZZIrLA5yw9zENRlVArF/Yyg1c36t+d4H5cDAkbhbetxJLkCzu1QK3bXl
         1dHakI2ckRrPTrAtWxC/Is5rgWnoFqAWgWJB4Ooz28JteJ+gaDxb4RHUBYtuUkZJXZ9g
         KsgA==
X-Gm-Message-State: AOAM532mL+JThCJappYQEpYUC4k6wBKC3Bayneo17jjyqRr2/3ZEt1xN
        /sbSRceLPueyCuo3VVG7y3C3KbeHwbEicUvh
X-Google-Smtp-Source: ABdhPJxaogQCfFn/TmyftzshXaeheo/8/ijlWBOdflnWtsny2/OMWrpxYUujGL6iYBsKbra7mVgUxg==
X-Received: by 2002:a50:f61c:0:b0:413:3b58:32af with SMTP id c28-20020a50f61c000000b004133b5832afmr113530edn.49.1645632539897;
        Wed, 23 Feb 2022 08:08:59 -0800 (PST)
Received: from nergzd-desktop.localdomain ([62.122.67.26])
        by smtp.gmail.com with ESMTPSA id x7sm52005edr.12.2022.02.23.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:08:58 -0800 (PST)
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
Subject: [PATCH v7 0/2] Add support for Imagis touchscreens
Date:   Wed, 23 Feb 2022 18:07:39 +0200
Message-Id: <20220223160749.37001-1-markuss.broks@gmail.com>
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
v7:
- initialize ret with 0 in _suspend and _resume (kernel test robot)
- use a separate ret_be variable to avoid casting to __be32 (kernel test robot)

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

