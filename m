Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6D57F0AA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238271AbiGWRh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiGWRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:37:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560241900F;
        Sat, 23 Jul 2022 10:37:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id g2so2383849wru.3;
        Sat, 23 Jul 2022 10:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcQGKSaKXVnIEZS89oA5YFbDm7e+XpwdGlWw0dR3m1Q=;
        b=WFZ0JeYLpgMzJ/oggtJRF5uMP33s8eqsoEhmQDGtA2RmNmGrz698MIxm7Tvp0TAgs1
         rUrhYW125fAKVLWDGLymir74rDyq3mgNTE35riNAOhIaWz/7zVl4+zDaSvtc8ATDhvIO
         KdWqEZSZLGm6Rw/ZN4UpvieVjmpCoqE2YFehE5GtU4N2GhrSORHn21Ton7p8yWCWFjkN
         AP7XnagJPVZytnmC30+EAGppVMWD/VwUOuqF7JJlqTPMGcAypWWrrOqnpP9WU8eY8xyV
         9vHhnaHY8HZ91BVwD7gLsZ8ateyPhjf42QAMGgBxo8mhx4G+KnRhWqzJAbtJpxOvykJp
         +0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LcQGKSaKXVnIEZS89oA5YFbDm7e+XpwdGlWw0dR3m1Q=;
        b=HZxrbfTwP5vO9OrblFjl1AWB8AzLiry6NGEuOJxSPVmVbTm9VsaC1QzIMmXcVTeg17
         qdul7FUTLcjEZwAFoEKSLCJqTKjYKoGq3U4sxFaDFKO1cTzsXFwqwo3rsp2yz91uQWmU
         slebV19MQSHzoN3kEopZCDIaix2V8hXvsVOCRYzMXW2nklrNN7hXONPITcEs87FQ7CqD
         KOwiEvGp+SFJYIzhrtZIIJ2HE0DRlp+XiNENs5dMeIvTmtpF+LgZgmARUmVS6bJg0rcG
         r8+W0FXtUWYe7oZhmz2tKlVjlcRfIdcfsOQiQ/C1QUa1M0BTk5MU9kGZxmHVy81X5rKs
         dLFA==
X-Gm-Message-State: AJIora8aLijV1ckkMncES6X0fl87T7I+t/di+46NvoBHyMNnIlAb4fFL
        p1SDQkiTr3eyAN+pdibmj4CwTNzEEdVolQ==
X-Google-Smtp-Source: AGRyM1tMErbvcnp/KSGG1pkpUfPnQ/WZeGSfpH30XrgJUbsTDLbgvXooswAHWvA9MAzK5Q+KTSSvCg==
X-Received: by 2002:a5d:5986:0:b0:21e:811c:f688 with SMTP id n6-20020a5d5986000000b0021e811cf688mr798155wri.8.1658597842445;
        Sat, 23 Jul 2022 10:37:22 -0700 (PDT)
Received: from xps-work.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm21552789wms.3.2022.07.23.10.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 10:37:21 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Add support for pressure sensor Bosch BMP380
Date:   Sat, 23 Jul 2022 19:36:32 +0200
Message-Id: <cover.1658597501.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds BMP380 variant to the already existing drivers for
the Bosch BMP180/280 pressure sensors.

Patch 1 adds references and sensor id to the devicetree bindings docs.
Patch 2 is a minor refactor simplifying driver initialization logic
to facilitate the integration of the new sensor variant extending the
information stored in the "chip_info" struct.
Patch 3 fixes DMA unsafe regmap_bulk_* calls reported by Jonathan Cameron
<jic23@kernel.org>.
Patch 4 adds the basic logic to initialize and read measurements from
the sensor.
Patch 5 adds advanced configurable features such as sampling frequency
and IIR filter through the IIO sysfs ABI.

Changes in v4:
 - Patch 4 and 2: Merged v3 patch 2 (Kconfig refs update) into this patch.
 - Patch 3: Added patch fixing unsafe DMA regmap_bulk_* calls reported by
    Jonathan Cameron <jic23@kernel.org>.
 - Patch 4: Fixed DMA unsafe buffers used on regmap_bulk_* calls reported
    by Jonathan Cameron <jic23@kernel.org>.

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

Angel Iglesias (5):
  dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
  iio: pressure: bmp280: simplify driver initialization logic
  iio: pressure: bmp280: Fix alignment for DMA safety
  iio: pressure: bmp280: Add support for BMP380 sensor family
  iio: pressure: bmp280: Add more tunable config parameters for BMP380

 .../bindings/iio/pressure/bmp085.yaml         |   4 +-
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 884 ++++++++++++++++--
 drivers/iio/pressure/bmp280-i2c.c             |   5 +
 drivers/iio/pressure/bmp280-regmap.c          |  55 ++
 drivers/iio/pressure/bmp280-spi.c             |   5 +
 drivers/iio/pressure/bmp280.h                 |  83 ++
 7 files changed, 937 insertions(+), 105 deletions(-)


base-commit: 180c6cb6b9b79c55b79e8414f4c0208f2463af7d
-- 
2.37.1

