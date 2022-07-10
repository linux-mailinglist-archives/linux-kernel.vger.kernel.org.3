Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093A556CE55
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiGJJOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:14:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF60C22;
        Sun, 10 Jul 2022 02:14:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so3534241wrg.1;
        Sun, 10 Jul 2022 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYknjzSgfWyPWFlSCA9AKi75ZVUb+k975pWuijFAjNQ=;
        b=QU95pMggxLyEbC3mrGq+FXUgf1AREHXL+IgHdJoNhgwTfQmJCn8S0HTCKIv0PZVqLd
         bT8awglH5fvaw5lQXBYfY2lCiymtOPSZ36wc6YnKIXphtIFOlUpRHlA9KRy16fITkEO0
         /ubuPs4ApUEdfmdHOd113U6UClyZ7zpg19+4XxDmpgOEgKtVVBGRFXsb+xr0RegfWBwY
         WtMVSs3EojDxwP4WbLg6X/ieXcmqzdz/shi0QUDd8jb7lup+t+OzAidI54DjOUr+8OSC
         eZRpoyMo6kwOwzuGa+kdy6kuPLFoqwoWyatywCex/VimS/mB9EZag5r/Rllj0XAeL2Wy
         XtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SYknjzSgfWyPWFlSCA9AKi75ZVUb+k975pWuijFAjNQ=;
        b=MQ/E9D6OqnDoZnH4CeDmGsUDUcZPuztZix4GNuZ7Qne0V5tmthXFN5/NLkSRaAoP1X
         Ze08syyrfzn7BM0YHzozQiNvolJX16wfo8gw4/QI0/OafPPvNBusypp9AgjsQfKnFQ+h
         oQBVkJ0v8bMdDoF6g7FpX+vL5cMg1qAVNyYBWJXWqJdVtvzukMSiX7bT0JRQk+FfwziS
         NsKbty54LmFbQmUOnpKKxeJ3WiNY++bovNwK95dfofJMV58m3p6LJLgT6747mOGOtI/6
         8UHz232FmBExTfC2/BejV2HdGknSFZHwQcbbVHVRmCxjvuDgTTUNBdyyZPm30SPLevok
         FHvg==
X-Gm-Message-State: AJIora9FtCb92uqmkpFf4ErGZM6hPnQLluXUP/bYAdvw8R4H01G5URBF
        H+nVItZg29yPnG6PwQSDWD2+obUiKlo=
X-Google-Smtp-Source: AGRyM1skE+6kXkIIj6asAt8kleKs5cfz59/YIZ5QGOEjEaFs+VFGkA021VnlkvB8y+l1pYUAGdZ89A==
X-Received: by 2002:a5d:4447:0:b0:21d:6b84:4678 with SMTP id x7-20020a5d4447000000b0021d6b844678mr11426393wrr.668.1657444463560;
        Sun, 10 Jul 2022 02:14:23 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id f16-20020a056000129000b0021d74906683sm3187707wrx.28.2022.07.10.02.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:14:22 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Add support for pressure sensor Bosch BMP380
Date:   Sun, 10 Jul 2022 11:13:45 +0200
Message-Id: <20220710091346.15661-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
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

This patchset adds BMP380 variant to the already existing drivers for
the Bosch BMP180/280 pressure sensors.

Patch 1 adds references and sensor id to the devicetree bindings docs.
Patch 2 adds references to the new sensors on the Kconfig file.
Patch 3 is a minor refactor simplifying driver initialization logic
to facilitate the integration of the new sensor variant extending the
information stored in the "chip_info" struct.

Patch 4 adds the basic logic to initialize and read measurements from
the sensor.
Patch 5 adds advanced configurable features such as sampling frequency
and IIR filter through the IIO sysfs ABI.

Changes in v3:
 - Patch 2: Fixed incorrect abbreviation.
 - Patch 3: use dev_err_probe helper to handle error initializing sensor.
 - Patch 4: Fixed kernel test robot warning provoked by missing include.
 - Patch 4: Fixed bug reported by Dan Carpenter <dan.carpenter@oracle.com>.
 - Patch 5: Fixed formatting and typos on multiple comments.
 - Patch 5: Fixed missing boolean initialization reported by
    Andy Shevchenko <andy.shevchenko@gmail.com>.
 - Patch 5: Replaced duplicated comments with a single comment containing
    a brief explantation in a shared location.
 - Patch 5: Dropped incorrect use of unlikely macro.

Changes in v2:
 - Added patch 2 updating Kconfig with references to new sensor.
 - Patch 3 adds changes proposed by Jonathan Cameron <jic23@kernel.org>
    to declutter and unify configuration logic for the different sensors
    extending "chip_info" struct with default configuration parameters.
 - Patch 4: store temperature and pressure adc values on 3 byte array
    instead of using the type __le32. Uses function get_unaligned_le24
    to convert the little-endian encoded 3 byte value to an integer.
 - Patch 4: drops custom macro le16_from_bytes and use get_unaligned_le16.
 - Patch 4: generate masks using GENMASK macro.
 - Patch 4: use FIELD_PREP to generate bitfields for registries.
 - Patch 4: dropped stray formatting change.
 - Patch 5: adds sanity checks in bmp280_read_raw for channel properties
   only available in the BMP380.
 - Patch 5: on bmp280_write_* checks if a problem ocurred committing new
    configuration and tries to restore previous working configuration
    to keep the sensor in a previous working state.
 - Patch 5: refactored bmp380_chip_config to only check for configuration
    errors when a configuration change is detected.
 - Patch 5: improved invalid configuration detection on BMP380 restarting
    measurement loop to force a new measurement after the configuration is
    updated.

Previous versions:
  v2: https://patchwork.kernel.org/project/linux-iio/list/?series=656144
  v1: https://patchwork.kernel.org/project/linux-iio/list/?series=653822

Angel Iglesias (5):
  dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
  iio: pressure: Kconfig: Add references to BMP380
  iio: pressure: bmp280: simplify driver initialization logic
  iio: pressure: bmp280: Add support for BMP380 sensor family
  iio: pressure: bmp280: Add more tunable config parameters for BMP380

 .../bindings/iio/pressure/bmp085.yaml         |   4 +-
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 718 +++++++++++++++++-
 drivers/iio/pressure/bmp280-i2c.c             |   5 +
 drivers/iio/pressure/bmp280-regmap.c          |  55 ++
 drivers/iio/pressure/bmp280-spi.c             |   5 +
 drivers/iio/pressure/bmp280.h                 |  83 ++
 7 files changed, 831 insertions(+), 45 deletions(-)


base-commit: e5524c2a1fc4002a52e16236659e779767617a4f
-- 
2.36.1

