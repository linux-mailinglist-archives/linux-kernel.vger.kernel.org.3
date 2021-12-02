Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335BE466D2C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349448AbhLBWui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbhLBWug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:50:36 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37CAC06174A;
        Thu,  2 Dec 2021 14:47:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id y13so3799617edd.13;
        Thu, 02 Dec 2021 14:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6+q0Hg/m5U8mIuV24BSe1tPkUU69WsPj3ofaDA0+Yk=;
        b=YQRSF/9u//dujNdzC8ktaeM7YNOQOPlC589N6bY15bQkBP0uhxmm3xrvy03o/BiT4Y
         qn11IypaGsO4Va/zZgYleOFkHkWLJW+yIDIw5Dfm8CHxHdc30crOlqg9cwg4mHXoUZXK
         9r5ZI70n21hb5DwvJZ7+PBfxRShu7BpDTDVguQe3EmUA+8FNQQ7LSTz33J6jPprw/NPm
         ciitC7qtfdOZUrOdAdUwuV8gzfwrF6biIYPUZYegKVzTahvFFPpc97BglLtgBmRZxArg
         4xsCHzEBEW57z+ptOy4jYgU8bZM2RTkYUSQpvGdpgho+//p1Tu68XnfTWXq4hZN9vcvR
         3HJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w6+q0Hg/m5U8mIuV24BSe1tPkUU69WsPj3ofaDA0+Yk=;
        b=dDz/ZrGgALFWeslCO9UCodETQwE+5D9KxSqPVZzmxqxobFu+j38BqK9ZKW5/+MD+NR
         5S97XzUjkd/vYQqLMhhC8T8bW+ONfqkxosQQ+4hKJTzwJTdVr1DYAzDY2aPz5qKCHNoM
         oR7db6KQ5I/8wp1zO0740eXMAKX0CQXahq+9Rc+1wcp8Wzy5O/QdF4LyuJmeok9TzOhZ
         ln/7d3yh88ss7NM+cKycrfbuemhjW2JQcx4ZNTleL0TbvSJ9qYVeuacpf1i0iv2IEbaj
         IaTGsdzWHAaHFv7pUvDdOcJsHoIYMn+8YF8XOMakHEgB8aQXEX0+w/3sViBpxD0FDhpP
         OekA==
X-Gm-Message-State: AOAM530QY/NLKkmX/4l5XFEY8t4x/+WpjQmKSn0QcPWgAaU1ckgJVjjc
        WOMZD68ZIJumyr/PYw6L6QCLXgUdLOA=
X-Google-Smtp-Source: ABdhPJw67YeBa0XpCI4LD8GTWf01vgp/fO8UQE6/lbZbhjAekhNHY7VrhY4LOEKKXt1OdEzhybJbwg==
X-Received: by 2002:a17:906:3157:: with SMTP id e23mr18255451eje.359.1638485232238;
        Thu, 02 Dec 2021 14:47:12 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id gn16sm641360ejc.67.2021.12.02.14.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:47:11 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Subject: [PATCH v8 0/3] Add AD74413R driver
Date:   Fri,  3 Dec 2021 00:41:00 +0200
Message-Id: <20211202224103.218278-1-cosmin.tanislav@analog.com>
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
 * remove INDIO_BUFFER_SOFTWARE already set by iio framwork
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
 * author using company email
 * also check DAC code lower bound
 * fix checkpath --strict complaints
 * add comment regarding mutex lock usage
 * propagate error when converting adc result to resistance

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

