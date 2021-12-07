Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7B46B7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhLGJrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhLGJrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:47:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103ADC061574;
        Tue,  7 Dec 2021 01:43:51 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so54585907eds.10;
        Tue, 07 Dec 2021 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UU1/t4X8+MQnTRzRZn6r9WXq8E13rlpQ4l+fCMHOnaQ=;
        b=k4R7PX+H/o77fWd2kHJhnzwIhzT+6cH/c825HDwWoy14BEgwxmI42mXx4OqR7Y802m
         UCoYoS3ZM/tne+guovxsPvUire9986Y139Wz2JS5t7X85faWnxT9g8LAonzQOsTAq1YS
         T7C+amxtmzY+/HGsODJcYg1Nr+XrPdkKU2X6II36SWSNBtWsAl7JSqvqvnmdSf/MOSHp
         Eqo970ojY4i7G4ACLBcBGVqvf18vwLFDXdUsOQFGZmyzKO9RLIDLAYaI3/3RZh6Mlt48
         /RzRXuyY/1tqmzmMcbgP1tW0J9spISapei++nhS4aNGntN1ey4s+NSqXleYugVQ5ttBl
         Pp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UU1/t4X8+MQnTRzRZn6r9WXq8E13rlpQ4l+fCMHOnaQ=;
        b=JbHl0cMipk+xnw1bFeClno5sExj5VZi6X6UfSC656bgpMFmkFjHCT0rAkYO90F610D
         4/gqiZy2Pe6lELVGM+Ual64HitMjwHrgXwl1bXDdKR3ozcZju3jKM5rRxZQqU0dAjnXE
         AsFNPQy1xwiCVJNtBQHpDeyc0XOZvdrq8inEOgdnaQwT7Ck2OnBGc+krrosTWN0UD+f6
         WiVagLjZMPhiDf/bkHUJ/BVbZOTKJ6VC5AmpayOraBQzeLiK8ieBYsItQMytclNnYPdn
         HKN6wk47nKmLseoMJjOQMNclZeoTgay/8HJmoK2SzaHtykjkzOEf2dbNf4ffWDExzUbM
         cD/Q==
X-Gm-Message-State: AOAM532dIwdHsfVpu0V99Y/BgY9DUwhBsKRANAQAh8DQUgdNgFAo2jGw
        rE72p4vU+bOWaMnLPcWV0lmB7BWiglxxQxd9
X-Google-Smtp-Source: ABdhPJzXjUZR/Ov3+apGBk57MQehtxqBM3stRssYbklI9JaIUsIR7rjwpTnSMrQmIDOOyel5iDNKrQ==
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr7385669edd.258.1638870229672;
        Tue, 07 Dec 2021 01:43:49 -0800 (PST)
Received: from demon-pc.localdomain ([188.24.96.74])
        by smtp.gmail.com with ESMTPSA id h7sm11336159ede.40.2021.12.07.01.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 01:43:49 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     cosmin.tanislav@analog.com, demonsingur@gmail.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add ADXL367 driver
Date:   Tue,  7 Dec 2021 11:43:35 +0200
Message-Id: <20211207094337.59300-1-cosmin.tanislav@analog.com>
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

I have one question that is not actually specific to this driver but would
help me clear up some issues.

I used mutex_lock and mutex_unlock when accessing anything in driver's
state that could potentially be written by another process in parallel.

I heard mixed opinions about this. Some people said that it is not
necessary to lock everywhere because loads and stores for data with size
smaller or equal than register size would be done in one single atomic
instruction.

On the other hand, I also heard that this is not true unless WRITE_ONCE
and READ_ONCE is used.

It felt weird using WRITE_ONCE and READ_ONCE in this driver, so I kept
using mutexes.

Could I get some opinions on this matter?

Cosmin Tanislav (2):
  dt-bindings: iio: accel: add ADXL367
  iio: accel: add ADXL367 driver

 .../bindings/iio/accel/adi,adxl367.yaml       |   79 +
 MAINTAINERS                                   |   11 +
 drivers/iio/accel/Kconfig                     |   27 +
 drivers/iio/accel/Makefile                    |    3 +
 drivers/iio/accel/adxl367.c                   | 1696 +++++++++++++++++
 drivers/iio/accel/adxl367.h                   |   24 +
 drivers/iio/accel/adxl367_i2c.c               |   89 +
 drivers/iio/accel/adxl367_spi.c               |  151 ++
 8 files changed, 2080 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 create mode 100644 drivers/iio/accel/adxl367.c
 create mode 100644 drivers/iio/accel/adxl367.h
 create mode 100644 drivers/iio/accel/adxl367_i2c.c
 create mode 100644 drivers/iio/accel/adxl367_spi.c

-- 
2.34.1

