Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56688575A9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 06:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiGOEuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 00:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGOEuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 00:50:03 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0578583;
        Thu, 14 Jul 2022 21:50:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id e15so4879262edj.2;
        Thu, 14 Jul 2022 21:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvvexJbqPqq4lL39PXcVlXT7tJUoqQu20StZfAm/qug=;
        b=TKt2XzmQKO18+T+3BkvCif7POatQPUVTZ9atPOhrn8Exf2EiYWgo7Ky2BVhrabECzu
         cs3Uc84Bgpo8laJLJMmKBowUx0sDGVOo8a4i+fnNmKX3d+6r9YMLEFxSzPNBucwxIiqG
         mnodb+M6H6ZEoWMEiDxvSXMJiPqnl3WdfCsJCC2vdQ46hRKw9ghZZoFtnYQZCu9F8xdn
         7dlaSt1jdYrsRWaFhsqZnDwFuThD00BnLnIDIC/0AV+JsO2oaVGfufrKouItRlyyzyAK
         NJNXTyeT+8+SorYYIkw9AbWGvD/9ySfAyyJARsGMcAJte3z8z+oOKy8XngtuaQg/KMY2
         NusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvvexJbqPqq4lL39PXcVlXT7tJUoqQu20StZfAm/qug=;
        b=RWVz6T3VcDSFiZ7e1AKCsa2iWDUXu5GiivIn240PJ9qrks597QY6H1cl3B1XHmc3nJ
         QetIrkVnvuzqrQQdzVaAxuPznH4aXTtoj2kFOuGKfsfsNclTc/f3K17yPWniXC2gLbpc
         PKIhfMQtrm4CH3pn0KhSGPV2zXYN4T1zOJSc/MccQcFiteKjNbmSW5/pXlRc40Di/h9Y
         ZxMwFYMrw2Bf0oYok/BTAFnrC71koKi0PW+zrwmKqd+Paw+UsH/joX999dGcC6W2eSoh
         fV+wMkcqPtc+pu0Ar8kCARJcNeY2jMI9khaPgC4rNSJMDP/CT4zGq00m14HP3zgzjmTh
         nHHg==
X-Gm-Message-State: AJIora8kfxCo8CvVDYSOMPPIyC0gJ4BuLAGP0B56YkAMfS9mtpgsfB6V
        mw7DhZyLcNN5R/nuipT6OTg=
X-Google-Smtp-Source: AGRyM1ulo5y5xbd7VoeTcDpGi9j0pd7pBHU4v97fSxp1rBKtdJVRXAsSVMxBoe0RfygaHyUxWh7ymg==
X-Received: by 2002:a05:6402:1f01:b0:43a:239e:e65a with SMTP id b1-20020a0564021f0100b0043a239ee65amr16369747edb.428.1657860600479;
        Thu, 14 Jul 2022 21:50:00 -0700 (PDT)
Received: from demon-pc.localdomain ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id cd2-20020a170906b34200b0072a47b18f7csm1541351ejb.42.2022.07.14.21.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:49:59 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v8 0/2] AD4130
Date:   Fri, 15 Jul 2022 07:49:46 +0300
Message-Id: <20220715044948.434149-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


AD4130-8 is an ultra-low power, high precision, measurement solution for
low bandwidth battery operated applications.

The fully integrated AFE (Analog Front-End) includes a multiplexer for up
to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
selectable filter options, smart sequencer, sensor biasing and excitation
options, diagnostics, and a FIFO buffer.

V1 -> V2
 * add kernel version to ABI file
 * merge ABI patch into driver patch
 * make copyright header similar to other drivers
 * rearrange includes
 * use units.h defines where possible and add unit sufix to
   SOFT_RESET_SLEEP define
 * remove ending comma to last members of enums / lists
 * remove unused FILTER_MAX define
 * use BIT macro for PIN_FN_*
 * rearrange SETUP_SIZE definition
 * group bools in ad4130_state and ad4130_chan_info
 * put scale_tbls definition on one line
 * remove newline before reg size == 0 check
 * put mask used as value in a variable
 * remove useless ret = 0 assignment
 * make buffer attrs oneline
 * use for_each_set_bit in update_scan_mode
 * use if else for internal reference voltage error checking
 * inline reference voltage check
 * check number of vbias pins
 * remove .has_int_pin = false
 * remove avail_len for IIO_AVAIL_RANGE
 * remove useless enabled_channels check in unlink_slot
 * remove unused AD4130_RESET_CLK_COUNT define
 * only call fwnode_handle_put for child in case of error
 * default adi,reference-select to REFIN1
 * default adi,int-ref-en to false
 * of_irq_get_byname -> fwnode_irq_get_byname
 * P1 -> P2 as interrupt pin options
 * add missing comma in db3_freq_avail init
 * cast values to u64 to make math using units.h work
 * add datasheet reference to IRQ polarity
 * add comment about disabling channels in predisable
 * add part number prefix find_table_index
 * return voltage from get_ref_voltage
 * add datasheet reference for internal reference voltage selection
 * add comment explaining AIN and GPIO pin sharing
 * parse channel setup before parsing excitation pins
 * only validate excitation pin if value is not off
 * use FIELD_PREP for bipolar and int_ref_en
 * put devm_regmap_init call on one line
 * introduce a slot_info struct to contain setup_info for each slot
 * enable internal reference automatically if needed
 * decide mclk sel based on adi,ext-clk-freq and adi,int-clk-out
 * dt-bindings: use internal reference explicitly
 * dt-bindings: set type for adi,excitation-pin-0
 * dt-bindings: set $ref for adi,vbias-pins
 * dt-bindings: remove minItems from interrupts property
 * dt-bindings: remove adi,int-ref-en default value
 * dt-bindings: remove adi,bipolar default value
 * dt-bindings: inline adi,int-ref-en description
 * dt-bindings: default adi,reference-select to REFIN1
 * dt-bindings: clean up description for diff-channels and
   adi,reference-select
 * dt-bindings: add more text to interrupt-names description
 * dt-bindings: turn interrupt-names into a single string
 * dt-bindings: add maxItems to adi,vbias-pins

V2 -> V3
 * dt-bindings: add interrupt controller include to example
 * dt-bindings: remove $ref in diff-channels

V3 -> V4:
  * handle watermark value as number of datum
  * DOUT_OR_INT -> INT
  * AD4130_8_NAME -> AD4130_NAME
  * return early in case of failure when parsing fw channel
  * use IIO_DMA_MINALIGN for aligning buffer
  * add comments for fs_to_freq and freq_to_fs
  * remove support for other variants because of unavailability of model
    ids for future chip variants
  * remove support for db3 frequency because of inaccuracy when calculating
  * remove ternary where possible
  * refactor defines
  * dt-bindings: add unevaluatedProperties: true to channel node

V4 -> V5:
 * simplify get_ref_voltage function and move print statement to first user
 * inline statements not going over the 80 cols limit
 * simplify scale table filling
 * determine table length inside find table index macro
 * current_na -> tmp inside ad4130_parse_fw_setup
 * define full register set
 * put range register size definitions on one line
 * nanoamps -> nanoamp
 * adi,ext-clk-freq -> adi,ext-clk-freq-hz
 * return directly in ad4130_validate_vbias_pins
 * place comment regarding irq_trigger at assignment
 * inversed -> inverted inside irq_trigger comment
 * do not initialize int_clk_out
 * return directly in ad4130_validate_diff_channels
 * add () after reference to update_scan_mode in comment
 * use BIT() for channel offset
 * comment nitpicks on slot finding
 * return -EINVAL out of reg read for invalid sizes
 * place regmap at start of ad4130_state
 * place bools at the end of ad4130_setup_info
 * remove commas after terminators
 * dt-bindings: only allow one element in reg
 * dt-bindings: inline reg description
 * dt-bindings: remove $ref from adi,ext-clk-freq-hz

V5 -> V6:
 * bump KernelVersion
 * use IIO_DEVICE_ATTR_RO
 * nitpick inside mutex comment
 * use valid_mask for validating gpios
 * improve DMA comment

V6 -> V7:
 * remove $ref from -nanoamp properties (to be added to dtschema)
 * use hexadecimal numbers for channel unit-addresses

V7 -> V8:
 * pick up Reviewed-By tags
 * bump KernelVersion

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  256 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2014 +++++++++++++++++
 6 files changed, 2328 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.37.0

