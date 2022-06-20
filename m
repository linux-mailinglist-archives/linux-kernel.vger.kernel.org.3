Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9545B552220
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 18:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243724AbiFTQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239334AbiFTQVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 12:21:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B1192BA;
        Mon, 20 Jun 2022 09:21:18 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o9so6589782edt.12;
        Mon, 20 Jun 2022 09:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YdADQE+PSV8I3ZXvNOu55ZB0fgWPvIx+IddoN16sWQ=;
        b=p9CG1jlzMnM7aTcmUmOFDBBVF7GfligIFqoXvckJ2gi1IID6twIH0Hjoa8mdIMlmlx
         PoEXzezYWAqsJgxqOl7QxO0PnjApPFa18Gcuc/MT9xWvdKk3IcTNyBszAKkY8AKg4UIR
         6XEAThGehJg+kCx8fDCqzeUpqGk4yuXV5v8ReTq9eEUY0hJmIAM3VfbANGqR0B69lMDN
         ZbpdmkSXXG/0O/Cdw43U9A6b1HWjIah/P7OBwWxNgsqAb3XQogJODc5M8p6uo1JGwqn8
         bljo7Dp5exjTwSrg0UP+ZLx9CNuROsB3YFrzYwLUrfXMjIECq/s7wXySarGnIaZn8KJu
         pRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YdADQE+PSV8I3ZXvNOu55ZB0fgWPvIx+IddoN16sWQ=;
        b=kYwSEtyo/SIShvyOjNC1x9XOd0v5FLzgq+AfOb6I2agd7R0d+FC8XZM+iRJdlO6gS3
         1df6pA6ZY/yX6VtAmtHRNClY3iG0cpTm7ydL45l+xJlKtiw/EIZweg+jPS3oJ8Sq5pL2
         mX7WDkQDqFlKXeBSKHRZ78f9sM2bhreAWZUjlhYG/8AZAo7dPCjq6uCvZynBaib9sW3J
         9TIiT6qgjMld7qBNi71HfIzPh9XPoxizmCkkMg8wr1E5cWnzl/glhdCUWQ+iX9kkVPIA
         DWoP7u3yleSfKqHHD8ar9eEswofQ3WSWqemPHrCzSKgaEV6kNEF8CaG5h1zqwWwJkyc6
         3dZA==
X-Gm-Message-State: AJIora9yvGaf6FxIGEx6QU9IQ5Qe4oPW+UgZbHnxtaK6M+rSK0svhvWE
        gZKyvwwd0KlqK9xuqWCh9j4=
X-Google-Smtp-Source: AGRyM1uuGU8pKeTrVT+4iKYSedA4SNNR2Z6fPP2qmzAur9HuB+IHwNDa0bcq8UROeSG42jZGYo2SbA==
X-Received: by 2002:a05:6402:35cb:b0:435:89f5:288d with SMTP id z11-20020a05640235cb00b0043589f5288dmr4267842edc.311.1655742076705;
        Mon, 20 Jun 2022 09:21:16 -0700 (PDT)
Received: from demon-pc.localdomain ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id 2-20020a170906328200b00722dceb3f8bsm318744ejw.151.2022.06.20.09.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 09:21:16 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v5 0/2] AD4130
Date:   Mon, 20 Jun 2022 19:20:57 +0300
Message-Id: <20220620162059.1097264-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.36.1
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

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  259 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2003 +++++++++++++++++
 6 files changed, 2320 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.36.1

