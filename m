Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412E94AB23B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiBFVN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiBFVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:13:23 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCDEC06173B;
        Sun,  6 Feb 2022 13:13:22 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cz16so7553319edb.8;
        Sun, 06 Feb 2022 13:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/pTTzjKmU0sVZElVn3CWYnegMXvZogWnXicT+EnNi8=;
        b=FNL4AjDI0BERM7eOEu/lFfOvcVUDueJLiwZ8/lS8DF/aBu54TAxVS8mBUu3MGyoLb7
         9TS5Ao7Bdnsbsy29tb8USGRsEpNcoiFylvi1G7GkGfvNnEto+XBfH09bIcU+DFRSTcIk
         LzVIsGJM+dOV4pKfhDRWUn68C/6HdF4FyrigrexnGRVx2vQwlltWSR6fYe9VvO86JHfO
         YCqRAt9iya9qfmM+JjXVcoI8xR4f/gkcvWcYTO5uzcso+Ei5lavACWtY8WRYc616JL5i
         DYBYiQywE75urdxJMocIIzVcxAT2fwzzyGYC3UPhY8eqw6YgqLO2ZecKrZ/TFxUKzJ6r
         j0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p/pTTzjKmU0sVZElVn3CWYnegMXvZogWnXicT+EnNi8=;
        b=VJRu6legcGBS7VH1+TGjx3UHPq6B/g+8xaCVL+kCv8I1z7wKS72oF5SbLNOFq1x9YD
         H0oWk/YFrInm59w5skXb+AZ5CEGLyYUfH37+wGVNYVFPFgXfeRsDCGZlZoR0HlLybxI+
         agxNz5+oLD/a52w5o7FU9N4f19RZaEwoKRc2pVQ/BETEDFwvxyQG9+9EvDcR2Vkoitov
         KdBCpI4gHJzKMLHtxfEUIi8jSRWGF2WFFBdFLcn3XFowlqlzVT5Hn0CMMhpyTj3xOqcw
         eGoDRT7/mSXsX+AkNCWcAePqRbLxlbxIH67suBqfUgkzFbIsLNFyXpsaxlzeTXyuEFnX
         YDzw==
X-Gm-Message-State: AOAM532gcYGHyedNE3LaDAx3ZaoEQ0507oCmICqPE8IOBUaPPhip3Zgp
        LAr0R+pf+4lcvBEJbXxqljY=
X-Google-Smtp-Source: ABdhPJwO95ENcutSFEcnmCdWc7s06emtNT+xN8nk2CoR8JuErNNagt/Y0x2zY7lnad6Pqr4i1FeobQ==
X-Received: by 2002:a05:6402:37a:: with SMTP id s26mr10853611edw.400.1644182000745;
        Sun, 06 Feb 2022 13:13:20 -0800 (PST)
Received: from demon-pc.localdomain ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id a4sm1248598edr.33.2022.02.06.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:13:20 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Add ADXL367 driver
Date:   Sun,  6 Feb 2022 23:13:02 +0200
Message-Id: <20220206211307.1564647-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.0
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

The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.

The ADXL367 does not alias input signals to achieve ultralow power
consumption, it samples the full bandwidth of the sensor at all
data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
with a resolution of 0.25mg/LSB on the +-2 g range.

In addition to its ultralow power consumption, the ADXL367
has many features to enable true system level power reduction.
It includes a deep multimode output FIFO, a built-in micropower
temperature sensor, and an internal ADC for synchronous conversion
of an additional analog input.

V1 -> V2
 * add support for vdd and vddio supplies
 * lock fifo_watermark retrieval
 * fix indentation of sysfs_emit for fifo_mode
 * dt-bindings: add spi-max-frequency: true
 * dt-bindings: remove cs-gpios property
 * dt-bindings: remove status property
 * dt-bindings: add support for vdd

V2 -> V3
 * MAINTAINERS: use wildcard for adxl367
 * dt-bindings: adxl367@addr -> accelerometer@addr
 * put asm include after linux includes
 * drop registers accessed implicitly
 * fifo_full -> fifo_watermark
 * print expected device id
 * remove INDIO_BUFFER_HARDWARE
 * inline ADXL367_EVENT macro
 * inline ADXL367_14BIT_SCAN_INFO
 * inline regulator enum
 * remove of.h in spi driver
 * cast const void * to const u8 * in spi read
 * switch to trigger-less buffer
 * increase reset time as advised by hardware team
 * let iio framework validate available channel masks
 * enable adc or temp channel automatically on single read
 * wait for 100ms after enabling adc or temp for output
   to settle on single read (waiting on hardware team input)
 * enable adc or temp channel automatically on buffered read
 * claim direct mode when setting range
 * claim direct mode when setting odr
 * claim direct mode when setting event config
 * sort status masks in descending bit order
 * hardcode indio_dev name
 * add some comments regarding spi message layout
 * use bulk_write for activity and inactivity threshold
 * use bulk_write for inactivity time
 * use bool as return type of fifo format finding function
 * remove shift from channels scan type

V3 -> V4
 * add a patch that introduces mag_referenced event type
 * add a patch that documents mag_referenced event type
 * add a patch that adds a note to the buffer/enable documentation
   regarding configuration of other attributes during buffer capture
 * remove unused adxl367_time_scale_tbl
 * add static attribute to adxl367_write_raw_get_fmt
 * return IRQ_HANDLED when FIFO read fails and print error message
 * scale temperature value by 1000 to reach milli degrees C
 * merge dev_to_iio_dev into useplace when indio_dev is not needed
 * merge preenable into postenable and postdisable into predisable
 * fix default inactivity threshold
 * export probe symbol to namespace
 * IIO_EV_TYPE_THRESH -> IIO_EV_TYPE_MAG_REFERENCED
 * reset device and then verify dev id for 10ms
 * share events by type so that they show up with iio_accel prefix in the
   events subdirectory
 * use a separate mask for extracting data
   I previously removed the shift fron scan_type since the FIFO data does
   not contain a shift but that broke single channel reads. Add it back
   just for single channel reads.

Cosmin Tanislav (5):
  iio: introduce mag_referenced
  iio: ABI: document mag_referenced
  iio: ABI: add note about configuring other attributes during buffer
    capture
  dt-bindings: iio: accel: add ADXL367
  iio: accel: add ADXL367 driver

 Documentation/ABI/testing/sysfs-bus-iio       |   30 +
 .../bindings/iio/accel/adi,adxl367.yaml       |   79 +
 MAINTAINERS                                   |    8 +
 drivers/iio/accel/Kconfig                     |   27 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/adxl367.c                   | 1585 +++++++++++++++++
 drivers/iio/accel/adxl367.h                   |   23 +
 drivers/iio/accel/adxl367_i2c.c               |   90 +
 drivers/iio/accel/adxl367_spi.c               |  164 ++
 drivers/iio/industrialio-event.c              |    1 +
 include/uapi/linux/iio/types.h                |    1 +
 tools/iio/iio_event_monitor.c                 |    1 +
 12 files changed, 2012 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c

-- 
2.35.0

