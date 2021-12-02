Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0845466DA9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 00:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357769AbhLBX2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 18:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbhLBX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 18:28:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC616C06174A;
        Thu,  2 Dec 2021 15:25:13 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o20so4163678eds.10;
        Thu, 02 Dec 2021 15:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ug/21sYu1auIP5DvnYTXNQcjBVF5VW8r70LbHDK7QcE=;
        b=pZZTw0RjPY4h0YCqborj+vlwg8t40U1PI+MWuunih2QilvOrRegMM9NngFFLgHiRkl
         x3CyFbmypVikNwUqXiK3uuzlsP0nmFtcEcQBGBDf6hSRXmF4hSymlCInuDCVtr85hI01
         i42+T2mWb9WSoJfo1TWaANtR0FPfXpBP2/EyW54oQ8Owe3smBk9DF4sPxntuonbXAkQW
         R/V4RkrcllulAVeCuucr6x0hTNEWueiSd9bLLdA878U3s+V2vZB/SeOsgCiqJgsEt4k3
         s55AyeQ/pPsQOume7ynNC9BWEa/BM+ASUpBMgNyamKu4pE8u4V9eZQhlvCjPlcujE9GK
         7+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ug/21sYu1auIP5DvnYTXNQcjBVF5VW8r70LbHDK7QcE=;
        b=mn+2xT3AVNiIbwo4yjR8Q0zXduceqzR6Lg7h9vZPNtFWAxAwmcZBJSUww+WeoFayi4
         SFDjXBCklps1x94YaTlU0C7fSWkr0BWd5vPIRJsHz/ryCcUmJPXCzHd4LvDHbOgeWMVW
         5U1v/4Ztlu2S+Cwko8L+NXbDE1YdtHC5xzTGVplqz7JZ/ll5f1BAzl7Cltgyk1Tn6cOA
         0msCRFxAkK0UooKcZ/7fJ2hS+91EJxNvcXZTKfmu+Q802CGW9NHL9GhU9OZC8qsmB1UQ
         LtW9nCEDgYYoz1PvAMWjeE3c95NW1uY99/5Q5XMBjvgDl9V4wiVmCQpTIDFLdrSN+iC6
         +6Eg==
X-Gm-Message-State: AOAM530QwdCm2zqj6u0VofqaNO3c0gmz9YLnplciKN5nxihxd9cYL3Un
        ilXHOvIHIHVQMhmJxNH0/eE=
X-Google-Smtp-Source: ABdhPJzrLhrBeZPrRa18nASul0aIiPBOfDnbtNlGdf7Wv+adqaYZyEsYvyN1mPLc+3R8rp8tgDRl6w==
X-Received: by 2002:a17:906:2788:: with SMTP id j8mr18402118ejc.203.1638487512511;
        Thu, 02 Dec 2021 15:25:12 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id w18sm701898edx.55.2021.12.02.15.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 15:25:12 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v9 0/3] Add AD74413R driver
Date:   Fri,  3 Dec 2021 01:25:04 +0200
Message-Id: <20211202232507.358113-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


V1 -> V2
 * sign off using company email

V2 -> V3
 * replace gpo config firmware flag with flag specifying whether gpo is in
   comparator mode
 * create two separate gpiochips, one output-only gpiochip for GPO pins not
   in comparator mode and one input-only for the value of digital input
   channels
 * wire up all gpo functionalities using pinconf
 * keep number of characters per line under 80
 * rework locking
 * do not invalidate other chip revisions
 * do not set indio device parent
 * print probe error for refin regulator
 * move conversion from range register value to range / offset / raw offset
   into separate function
 * module.h -> mod_devicetable.h
 * use generic firmware interface functions
 * add comment regarding cache alignment
 * add comment regarding ADC channels buffered read setup
 * un-inline comment regarding 100us delay for conversion start
 * inline return statements
 * remove assignments to val2 where not necessary
 * local_channels -> chans
 * index -> i
 * channel_config -> config
 * IIO_ALTVOLTAGE -> IIO_VOLTAGE
 * .info_mask_shared_by_type_available -> .info_mask_separate_available
 * remove unlikely probe error messages
 * use an array indexed by channel function for retrieving iio channels
 * count iio channels while parsing
 * move HART rate rejection outside of setter
 * move channel function validation outside of setter
 * use SPI messages for read and write
 * validate DAC code earlier
 * simplify switches to only handle existing iio channels
 * pass indio_dev into functions needing access to it
 * pass spi into devm_regmap_init
 * dt-bindings: sort compatibles
 * dt-bindings: remove driver word from description
 * dt-bindings: remove refin supply description
 * dt-bindings: specify channel function default value
 * dt-bindings: remove maxItems from scalar value

V3 -> v4
 * remove double gpo from macro name
 * reset at probe
 * config -> chip_info and store chip name inside chip info
 * cacheline align every DMA buffer
 * simplify generation of adc samples message by caching xfer, tx_buf and
   rx_buf
 * use mask itself for writing the value of channel enable and gpo data
 * move reg read and write transfers to the same buffers and use local
   variables for transfers
 * merge the two for loops handling gpio configuration
 * let firmware decide irq edge
 * remove INDIO_BUFFER_SOFTWARE already set by iio framework
 * do not set trigger device parent
 * return dev_err_probe for regulator error case
 * do not set cs_change to 0 when not needed
 * do not set spi device drvdata as it is not needed
 * fix bug regarding wrong channels being created for resistance input,
   digital input, and current input with hart
 * use voltage input channels spec for high impedance mode
 * put () around macro parameters
 * merge AD74413R_CHANNEL macro into its uses
 * remove unused switch case scope
 * inline return IIO_VAL_INT
 * use {get,put}_unaligned_be16
 * use proper types for reg and val
 * move default case handling into switch statements
 * pass driver state into regmap functions
 * use genmask for generating a 16bit max value
 * alphanumeric order for part numbers
 * dt-bindings: remove $ref from ohms value

V4 -> V5
 * dt-bindings: include headers necessary
 * dt-bindings: add IRQ_TYPE_EDGE_FALLING to interrupt flags
 * dt-bindings: ohm -> ohms
 * dt-bindings: spi0 -> spi

V5 -> V6
 * fix warnings regarding overflows

V6 -> V7
 * remove extra cache-line alignment
 * adi,rsense-resistance-ohms -> shunt-resistor-micro-ohms
 * dt-bindings: add product page links

V7 -> V8
 * also check DAC code lower bound
 * fix checkpath --strict complaints
 * add comment regarding mutex lock usage
 * propagate error when converting adc result to resistance

V8 -> V9
 * fix spelling mistake
 * undo propagate error when converting adc result to resistance
 * return void from adc result to resistance function
 * limit max adc value when doing resistance calculation to avoid
   a potential division-by-zero case

Cosmin Tanislav (3):
  iio: add addac subdirectory
  dt-bindings: iio: add AD74413R
  iio: addac: add AD74413R driver

 .../bindings/iio/addac/adi,ad74413r.yaml      |  158 ++
 MAINTAINERS                                   |    9 +
 drivers/iio/Kconfig                           |    1 +
 drivers/iio/Makefile                          |    1 +
 drivers/iio/addac/Kconfig                     |   20 +
 drivers/iio/addac/Makefile                    |    7 +
 drivers/iio/addac/ad74413r.c                  | 1475 +++++++++++++++++
 include/dt-bindings/iio/addac/adi,ad74413r.h  |   21 +
 8 files changed, 1692 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 create mode 100644 drivers/iio/addac/Kconfig
 create mode 100644 drivers/iio/addac/Makefile
 create mode 100644 drivers/iio/addac/ad74413r.c
 create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h

-- 
2.34.1

