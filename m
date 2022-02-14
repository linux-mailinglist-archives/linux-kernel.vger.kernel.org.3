Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5217B4B4303
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiBNHi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:38:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiBNHi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:38:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B384F9C3;
        Sun, 13 Feb 2022 23:38:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m17so762261edc.13;
        Sun, 13 Feb 2022 23:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdaUECiSD7pVSM2fISl5Rxs94dyG5TC8L23UXY/6iuk=;
        b=FW1QEdoI2l08fSqbzMfyYrTOD5P7Zn40j6mFjrN3mDrhL/tweuyDDnUzFOS5bAplGl
         WkA8zC/rIowjWX7m9TMhu28zcAMLhVI1wtf175DJM6XSDyHe6F6bNFGK+PCXy3H0Go89
         h8RxWVJuvUgNZv4PCR/As3boSRLUnm0KpswCG7zhE7ArR+TRbUA362y1gtgxCWPTwIo2
         ioURwCFn/Yo+JLGfak2tVgTJu3IpJiuHRTs7xtYPcVMffM0/VkO3TkauoLrKpWx8q6Hp
         wIgJxX4VU0NbXRI5048MDkKGKlxu4eULPcvIzAV24MeOk0iIHU8ut9Tzcup8T9gvC/xB
         0gIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EdaUECiSD7pVSM2fISl5Rxs94dyG5TC8L23UXY/6iuk=;
        b=zWWvbfjJaBDhcgbNOrPpjvofPCtXJtY0ljOUCcHyjfWLfRC3gVl9Seg3T/0unJunuw
         bSp3RbMMHA7CAfyQbMAnOG1RY7nfl35sbAPGPFs6AYosuEeXXb9yqvoDnlB0xnfzdkYg
         KMsj1aK0SH0ebX5QI6VqbZfJHQsaufUFxmrOUE7gsrXAL4it9ELw+QUKxrP6lJ06xbn4
         ABCcLdBh1y9tW6furJ9iPBNn9B6ZpCpWPhueaItw1ksR3WPT5PAksJ0BsNwFEXuk1Jfu
         wZtzmUi7cf9c8zYIAC6ESFFN4kWpWNZPXk5DO45rVDOSsEbE06nLTFxfQ4fvL+k9mRle
         fhgA==
X-Gm-Message-State: AOAM5339bFJJzrJ4uBbw0CW49Rsh3LUZcOKjmQcJmz4HMZI160JxVjI0
        Ay/WzEHhUBbxRZLGTEztX9I=
X-Google-Smtp-Source: ABdhPJzRzdeYdjn7aOOaEw2NAcaw56khJMr0cTT7yUEM5aaiaFQntV83Pz5+01WCXSfq06IBT+MKIg==
X-Received: by 2002:aa7:c892:: with SMTP id p18mr5922206eds.454.1644824298539;
        Sun, 13 Feb 2022 23:38:18 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.58.131])
        by smtp.gmail.com with ESMTPSA id 9sm2480065ejd.184.2022.02.13.23.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:38:18 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Add ADXL367 driver
Date:   Mon, 14 Feb 2022 09:38:05 +0200
Message-Id: <20220214073810.781016-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.35.1
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

V4 -> V5
 * linux/module.h -> linux/mod_devicetable.h
 * extract fifo_formats into separate array to allow arbitrary scan mask
   order
 * reorder channel_masks and fifo_formats
 * prepend IIO_ to ADXL367 namespace
 * use adxl367_fifo_formats array size to iterate over channel_masks table

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
 drivers/iio/accel/adxl367.c                   | 1588 +++++++++++++++++
 drivers/iio/accel/adxl367.h                   |   23 +
 drivers/iio/accel/adxl367_i2c.c               |   90 +
 drivers/iio/accel/adxl367_spi.c               |  164 ++
 drivers/iio/industrialio-event.c              |    1 +
 include/uapi/linux/iio/types.h                |    1 +
 tools/iio/iio_event_monitor.c                 |    1 +
 12 files changed, 2015 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c

-- 
2.35.1

