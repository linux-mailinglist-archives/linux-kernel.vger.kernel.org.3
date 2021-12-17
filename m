Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0052478A51
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhLQLpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 06:45:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhLQLpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 06:45:51 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3B2C061574;
        Fri, 17 Dec 2021 03:45:50 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z29so6711739edl.7;
        Fri, 17 Dec 2021 03:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Apv33f8CeP+v3Q4IBt73EAFtV6m4mVAZZ5ncRZ9Iy8=;
        b=JN6YJYr/mNLhAqmvBm1HP/HIN+CsrQ+JXEEDfrR+99XvgLOwLsVU6kgc3CRm7uKF9P
         gDi5ISLdmmDZwbm5qoR1O1B5M7P4mAeaz3rzaLyhIDOUQFy2C+UItPfQgjV6HcvJAD2c
         LaXLgqFx+zpJtZ18oqbrwtLUGgsoTn/PzS/xRSte6XwSi7BU1zttgmLvX+pR4yOWFZDh
         Jfbx1w4Q9iSBQhMvo+t5U+ihuHRQ3n/p6JSLLeAmJlUZ29VpY1V0gOGsZvhQoEQJSOsj
         FTfpQWqphKdDEwZLx51zA4zoZJPIOtYc+LAbOdlH9/KmBN/e28YcW9LkSHwX+gAogwtj
         HqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Apv33f8CeP+v3Q4IBt73EAFtV6m4mVAZZ5ncRZ9Iy8=;
        b=Y4bWyY2JbirXoGoYKVe0sUxzIcV0IE7fkTOxl0Ey0jUybVGX/YNQAGwvlIV5Q5WMdy
         Pq2GLbZJQsfDAo9hkxo5MP2BIUbBXjzt4RLee6ssZDK4Z8SYhFbRJDx4Z61KBjmEYZRj
         upAp+g3siKAgezMjkYN5NeNvHzwvpNgSkL6TQXeTdIJYD14ajxmYPjwMaKpljewK+Jlw
         BCLcLNL3EXog2c+eM+cchLpi0p2EX20NDJFi524R0bC+34wzpQiymPDNu44RDdTyUQOT
         U9yNtaN3dqmRK4eTme9lMadMLI5i5FXTEVqyivuKujlGxIDYwS8N75CCvG4hqdncB7pJ
         kZ+g==
X-Gm-Message-State: AOAM530uJ/4G+v9tbi2WOesM3qiYpNPw9RfMtkbH+QcLOKOmeJV71a2L
        5V2j3l7m9iuOn71Hh7OTjcw=
X-Google-Smtp-Source: ABdhPJwWbCuCqfZw0ZeX19bp2oQ98Q/jdnwz+N5FBXzQHwH7/pKSxKaERPrdVNXrzDoe8AMYJ7/aPw==
X-Received: by 2002:a50:bae2:: with SMTP id x89mr2488341ede.337.1639741549449;
        Fri, 17 Dec 2021 03:45:49 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.42.157])
        by smtp.gmail.com with ESMTPSA id 12sm2748410eja.187.2021.12.17.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 03:45:49 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add ADXL367 driver
Date:   Fri, 17 Dec 2021 13:45:46 +0200
Message-Id: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Cosmin Tanislav (2):
  dt-bindings: iio: accel: add ADXL367
  iio: accel: add ADXL367 driver

 .../bindings/iio/accel/adi,adxl367.yaml       |   79 +
 MAINTAINERS                                   |    8 +
 drivers/iio/accel/Kconfig                     |   27 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/adxl367.c                   | 1617 +++++++++++++++++
 drivers/iio/accel/adxl367.h                   |   23 +
 drivers/iio/accel/adxl367_i2c.c               |   89 +
 drivers/iio/accel/adxl367_spi.c               |  163 ++
 8 files changed, 2009 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c

-- 
2.34.1

