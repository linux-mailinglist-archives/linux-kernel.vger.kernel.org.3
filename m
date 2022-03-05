Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBF4CE618
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 17:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiCEQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 11:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiCEQyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 11:54:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CCC40900;
        Sat,  5 Mar 2022 08:53:42 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f8so14459038edf.10;
        Sat, 05 Mar 2022 08:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnICtdrKBzusdGxlyHl7enNc8IAVDezeQhCdTV5JKag=;
        b=p+QjerLuez8O5QBcv+wAfHoueIWcVuxVHRWxCWsoi9AbhnuL/LMyUJa7wxwUAsdRT1
         MdI7kH0zaUyoK0F+YzOKqk6NQbFaM5Tndnc8tcU7UQb93ncHzA9vxce++bwozjM8PRJn
         kfipC/QPVMJRrqOCVtuTYkC+DTOQfHgkgeJSwBAT5Lyz9ZxFcbmvTAtoG2wtZkbRpqVi
         LctAitFRVPcRXrLDBsksQkjh8m7mLVPNnZhvgjnqbrUOwHuMdjkOAjFTBoZ7mTTPS3/X
         QKC/WiQeKfziKyz+2ZQmEvMXrKEjL79EjIQ/YSzm+THsVsFT5Y9qIMvCFQlkMwFD7Hlk
         IeAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnICtdrKBzusdGxlyHl7enNc8IAVDezeQhCdTV5JKag=;
        b=A3oDFLoG0Ko2WbYXPG0iP8mSFE/dIhZXVQhJp91mu+agx/dHhFsFuyElGxSwgyu/8S
         wyELnZM3eyXV1UuksDEKvqlbbKx0FueH5/7sbO8sCoz609XUNKqgdXR6gkmu1bDI126k
         TMmokAO9oBi33M8Q7QiU57zAJtAmMI/NyZoW7hF0D2QMkR444MIj3oxH3wsWxMSV7y0p
         9DZciNX1R4ICXmWqXjlporM5ntPm8VpdahubMZWJg0QXMbkbb8g9DlPdqMGI/knv9u1i
         P9R1xpg0LBZ8zidPU6YJ5EqCtfv2swxx3M4/E89s4Ke5D68PiQxUJifKrEBfVhiVKFCd
         SUyQ==
X-Gm-Message-State: AOAM532i4tYGr1zHCo8pEIOfpCcDdoBFKp8gFaFtjftqhM9eMCkm+eD8
        +URNliD6kl328LX/l9xbTfmfmMUbxy4f6w==
X-Google-Smtp-Source: ABdhPJxoC6PBf31uGQ36r0/k0WVQJF9AnWs1Fmm+0OQR1A+ysmMI7LwQLTkXxDGom+1rHH+8jqte4g==
X-Received: by 2002:a05:6402:3549:b0:412:b31c:5509 with SMTP id f9-20020a056402354900b00412b31c5509mr3659801edd.224.1646499220498;
        Sat, 05 Mar 2022 08:53:40 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id go41-20020a1709070da900b006d643bdd4d4sm2990932ejc.56.2022.03.05.08.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 08:53:40 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v10 0/2] Add support for Imagis touchscreens
Date:   Sat,  5 Mar 2022 18:53:28 +0200
Message-Id: <20220305165330.13061-1-markuss.broks@gmail.com>
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
v9:
- don't return in power_off (forgot to commit)
v10:
- check for error before sleeping
- duplicate msleep in imagis_start
- return 0 since error can only be 0 in imagis_start
- move poweroff action below imagis_power_off

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

