Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657054CC2D6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiCCQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiCCQc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:32:27 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E882D19D610;
        Thu,  3 Mar 2022 08:31:40 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bn33so7498928ljb.6;
        Thu, 03 Mar 2022 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drrXuCjL2z4FDL87HsReVqcV2r7Uflss6SxoU1I1HFg=;
        b=adRuWBXwSA0Ep4zpLmSZGOt+vaw8z/ElkSlCIQvWEH5OLSJXPIoSbKDFmsDOtDdneP
         8Q4CaabPcYTKZm1PY4ApUeIksE9gabXmzFObT/TBwNH/yYip4Kg7oSUA0Q1mxdwCR8YL
         3xHUnPZQHmCNCUh1YzoEDMBvayhZ9up7tkat0+q0heVlx9TIF+DT5vzgqTsl1d84QBp0
         HTsSaMDaSJzUU6+j+WYAN/jotvb+a9TUbXlLXmuqIxlzEtVlceUqUfs8h/hbyHDFRaVV
         VEydHvG77ZOixCoRLNd4CQr4kXcgf3xhYIlKKp+0T7H7RnrbHVtEROi34euxCQxl6utV
         J0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=drrXuCjL2z4FDL87HsReVqcV2r7Uflss6SxoU1I1HFg=;
        b=Y53Sj5e82iCz5eZaW6BUzVjDHFOW/hFDT8HAtpTbk7GgLgsZLLSoqHwUVcYCKyfL+q
         hgmmjzYNHUsiNuIbs8YOWN78vZMpKqzHc0+APfTCjfMWkW9ntXb7qVH0ggTUycb7asMf
         of2fK+AvbuyP8Aw7e+bqoqYuafiH+v40WNx48i++sKJte8Em+bocqScAZe7awkLP8ecu
         2t2b7jGeDgIERVsp4c/AyOcRUrG5j767Yb7I3ulFxu9yMdax6pnckqqKLrj8oKwlGBcO
         +ULCKnsxZ2d0vpk+YjWcJcxBho7/cABXslweITwgnYU86tahAVy1j7bchea9r6brcOek
         hLzw==
X-Gm-Message-State: AOAM533VOvALFn2+uJ9CccO6/HoVv4EdbZv2BD0Ki1l52MlDC8hMb8EX
        nUJJJsjaNp0OQyleBDH2v/HA7VRAYY4hMmxT
X-Google-Smtp-Source: ABdhPJyFX6dhosG2Z6F8VUxYz9Osho3hkDOYsaQx2f8oEZvSi98s6f0tMpyhyZr8dgQvQRF+c2zObQ==
X-Received: by 2002:a2e:7007:0:b0:246:4382:c5e5 with SMTP id l7-20020a2e7007000000b002464382c5e5mr23386957ljc.377.1646325096745;
        Thu, 03 Mar 2022 08:31:36 -0800 (PST)
Received: from localhost.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id g18-20020a19ee12000000b00443af3721f2sm510678lfb.237.2022.03.03.08.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:31:36 -0800 (PST)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        jeff@labundy.com, markuss.broks@gmail.com,
        dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, rydberg@bitmath.com,
        sfr@canb.auug.org.au, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 0/2] Add support for Imagis touchscreens
Date:   Thu,  3 Mar 2022 18:31:31 +0200
Message-Id: <20220303163133.1418-1-markuss.broks@gmail.com>
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

