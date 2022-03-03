Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8758B4CC0DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiCCPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiCCPNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:13:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8501043397;
        Thu,  3 Mar 2022 07:12:55 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id u20so9068301lff.2;
        Thu, 03 Mar 2022 07:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcEw33IhwCSXhCAOEzznBRk7sVuMjubPA9NfR/kktrI=;
        b=Ui/wIrlfgf+emNcCMxoStcQcqMAbsgijpSRUmw1uLuj1Eo5vXsVexAuQO8IgtbOg7/
         mgHWCZMbJIU5KbwQYTt6r68ETv0LoH36faM0iw3bOGqw0NGS0horsIDb+0p1xk2GgEQB
         dE/+xNzLdznQc5gy/lX8yWmeN07J1HFkuAjq27jMpI2LCnv/UL75Tzw8O4buRWw6cIwx
         wC/LRjC4tuOJy4Dau5/07vtfIGc2YsKNmUHVaEw/yPqJjcs5dUK29O4c2/Gf0RgA+Z+V
         cZAWUhV8y7Ds4OgvzFLSpZaPOwIK1++GhRAy1wpZwN52bnPpX6J1pPev/ZRovuL9ANOG
         Nhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KcEw33IhwCSXhCAOEzznBRk7sVuMjubPA9NfR/kktrI=;
        b=EqLazuLXClwJiKaK1J9YgTpJVZ/hZwKkH83I2CwHiF6KB/klzIVNL8CBVuCidDMl1L
         5wfX7IgDjnvaLwFrgvTnipdYfiNZjPMRp2HFEY0Xt5Ipea65daIQUypv011jqBVESJem
         bmBdRhXG8ILRXKrrEVnP13QoOU4dgdqn0kAEBJ1kwWIbbU6fcZp1trDV7inA/x+gGpz1
         0pobwD6n+ZeBRiDyBRw8wx+N5Bhu/ABGRoMwnrTQOYxAzVetCNNC2gbeSFT2oulWop0S
         buGyw/H+rs5o8gh8sRRQ4qSF6M7MbU3T5+WFogK6LpXnOGKcCmKes0SA4G89FP5/k9rV
         4lVA==
X-Gm-Message-State: AOAM530cc1DccgAVuuhc7iRGCFM9dScr1ZbLSUVPv+gh+jQb8FUERvdf
        Ml6Wy9Zw4XwR/guJ+pz2UY/S6i1UiQ80a78o
X-Google-Smtp-Source: ABdhPJxqHTxQxqL2E/+jznvgRiRNcAJ9/x4px4936ZBMnI/K3XwadC6n+hrgdlOb/eRjuI+TS3Vh+w==
X-Received: by 2002:a05:6512:1284:b0:445:b88e:dc4a with SMTP id u4-20020a056512128400b00445b88edc4amr5690457lfs.46.1646320370666;
        Thu, 03 Mar 2022 07:12:50 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id a10-20020a056512374a00b004438dd764d1sm476022lfs.306.2022.03.03.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:12:50 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v8 0/2] Add support for Imagis touchscreens
Date:   Thu,  3 Mar 2022 17:12:25 +0200
Message-Id: <20220303151227.25659-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.20.1
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
v8:
- use poweroff action
- power_off returns void
- ret -> error
- combine dev declaration and assignment
- use same style for error everywhere
- return devm_regulator_bulk_get() directly

Markuss Broks (2):
  dt-bindings: input/touchscreen: bindings for Imagis
  Input: add Imagis touchscreen driver

 .../input/touchscreen/imagis,ist3038c.yaml    |  74 ++++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/input/touchscreen/Kconfig             |  10 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/imagis.c            | 348 ++++++++++++++++++
 6 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
 create mode 100644 drivers/input/touchscreen/imagis.c

-- 
2.20.1

