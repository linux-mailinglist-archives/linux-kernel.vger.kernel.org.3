Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64E5067C7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350355AbiDSJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347348AbiDSJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:38:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BFE1C131;
        Tue, 19 Apr 2022 02:35:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u15so31625375ejf.11;
        Tue, 19 Apr 2022 02:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuBxnJ189gQM2GpBkOVOWvPE4dRFJdO733PMpDnzugY=;
        b=nXxmuvIW6ZxgfQv+rXPIMRnalWMl3L3e86JG8+k3vRoxeA4vceDGKJn+BCN4lZ38Ou
         lnEtQ/tQJEajT0afMjqxQbnjOca7x/LS+6ySLrS8MfSNPZTy6g7NyPqKqVOCyBVVJrGH
         1pXt8/eDJdMlnji5WPbxWpytdng/W6I8Q+4CekHmdS9uFIQ0LMtiz3KBKSWyjLaftcqN
         pxLpd4gAK7bcxPWcqIkdDlcmypA6s60ZiCOBYw1K3gZyHDjKEYYwruEP/9w51ev08xHN
         HjCOgYRaVFdErs0m2cY3NdVIg9D6xzNoH62lGKZyOl8Sook+STJ5HszY7LsEhlpL9wC/
         eAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuBxnJ189gQM2GpBkOVOWvPE4dRFJdO733PMpDnzugY=;
        b=UiEFJ8j5T5CuB+l6lTRV66NcyFTirozYqySR4LaxMXNGWum5mcfssy2VPJy+8kBXza
         E86i1W/p+xNyeNQChgvp9pSszPIEWzGie6FwiNJ6ohWOajDnkqdHI5jz5mTasKrwxLQg
         eVmbv3wjpMJUJVV9mn9sXD1wUDU48p82hFTctTTLwtFEy38VgXswKrNfx/GLYdPgF2fh
         lUUEeRId6W1hqgfWS0J/avzwJZOlYAJ8a06rt4Z4YUIxSkOuy7AO2wMcQvsoI8dE+uT+
         JzXTKDxkrLNfTmCfB9gbdQzLGhkCMnJvnyMJKiCwjG1Bmj2zilEi18BHeKuusSQ6Pzbh
         Y1lA==
X-Gm-Message-State: AOAM530c31OWrHViB87EVYk27X12CcKJh3SlNnWQZ6CQLWGlnOEQq1Bx
        3p+no5vatDjIMcdeDR9zeg5Z5cr6qJc=
X-Google-Smtp-Source: ABdhPJy7WWXMrhON/4PDw44TT/n9U2Y4ulwTCX1Frl4nN88YjHFJgfbziOmg2l3Ye1N1I1iPuN6M7Q==
X-Received: by 2002:a17:907:2d20:b0:6e8:56eb:531f with SMTP id gs32-20020a1709072d2000b006e856eb531fmr12191164ejc.380.1650360951926;
        Tue, 19 Apr 2022 02:35:51 -0700 (PDT)
Received: from demon-pc.localdomain ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id u25-20020a170906b11900b006e08588afedsm5467198ejy.132.2022.04.19.02.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 02:35:51 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v2 0/2] AD4130
Date:   Tue, 19 Apr 2022 12:35:04 +0300
Message-Id: <20220419093506.135553-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.3
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

Cosmin Tanislav (2):
  dt-bindings: iio: adc: add AD4130
  iio: adc: ad4130: add AD4130 driver

 .../ABI/testing/sysfs-bus-iio-adc-ad4130      |   36 +
 .../bindings/iio/adc/adi,ad4130.yaml          |  263 +++
 MAINTAINERS                                   |    8 +
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4130.c                      | 2078 +++++++++++++++++
 6 files changed, 2399 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
 create mode 100644 drivers/iio/adc/ad4130.c

-- 
2.35.3

