Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7A3564ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiGDA0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 20:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGDA0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 20:26:17 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D66257;
        Sun,  3 Jul 2022 17:26:16 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e28so11211056wra.0;
        Sun, 03 Jul 2022 17:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm/wsKHLdoBGUXxkaCIwfReie8Gr/C9tqwvrTejUwhM=;
        b=Mm33WAeOV+jFHDO4K0kKOU2nWhdu2YCzzEbijtALUA8mx+WSfAvLQL4LiA4Sk023lQ
         j9fjVqWUFXOuGYADo/WCrCzps5IGxU97baRI01f6cDMBjj0+1inkxYiK3Qpgz85ecUze
         fLspiRKeb9dQxnGd+mx4mNYt7wHCjY61KjBT4tUaOa33I7brX04jktkqWVUdPJa/VcJP
         /0Ml5NIIsmllx1evMTp+mV9WPknk6y1TZklmh2kiZuVw/KXrZBwSyrLYk36l7flUvsKu
         hZF2Jrn1LDVvBYUhRbjKNRDEToix0QpbIcbnUEllXRCUqj8ZLw5mTWfSYb3/kH7id8YI
         cC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm/wsKHLdoBGUXxkaCIwfReie8Gr/C9tqwvrTejUwhM=;
        b=l6GYvtlyIcxg/x8etpY7XUzNLmbQqmlEscUNu0LvFtSu/EsmBgGIXQziblYLkwGoqN
         47vlWf8RSpGUW+xAnakEsuTVXyMKW9ovJAwM3qJMAAs1UlKquzPaCGEkuiBLrTrsloZ3
         Iu2E0hUk44ks53GzsFyBDRacTwVb4TT+dGam2DFz4HRfNIpnzrmnxdj1ChIcvCQRaZTb
         VWiTkcH1iA1q0UTbNgwAY6LlMOUSpXmmntvWhuirNBGrz72CZl4eblyPIs7XgbakEA/r
         Q/obeRgIEldITVrjUwS8Jvumv4+Ox9B5IL3Fz5h7oLsFfgpl3MPRzOBjZ5yDdyQZZ/5Y
         98sQ==
X-Gm-Message-State: AJIora9+3ACod1C8EyWqsMBlAUOV+RWbrN64KIu167tNcbanDo1iOBEp
        SstTWyAmp8M/bfCacIlnJBjjzEi2kLM=
X-Google-Smtp-Source: AGRyM1ti+zi7j6Hihaeakrpdin/l4yrfgyvV8M5M5Uc4rGKbhfBzYru2AuZITSDXyRNpwnFo0pmjnA==
X-Received: by 2002:a5d:69ca:0:b0:21d:640c:79f6 with SMTP id s10-20020a5d69ca000000b0021d640c79f6mr6672645wrw.309.1656894374180;
        Sun, 03 Jul 2022 17:26:14 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id ay14-20020a5d6f0e000000b0021b91ec8f6esm28722148wrb.67.2022.07.03.17.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 17:26:13 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Add support for pressure sensor Bosch BMP380
Date:   Mon,  4 Jul 2022 02:26:00 +0200
Message-Id: <20220704002602.207024-1-ang.iglesiasg@gmail.com>
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
Patch 3 is a minor refactoring simplifying driver initialization logic
to facilitate the integration of the new sensor variant extending the
information stored in the "chip_info" struct.

Patch 4 adds the basic logic to initialize and read measurements from
the sensor
Patch 5 adds advanced configurable features such as sampling frequency
and IIR filter through the sysfs API

Changes in v2:
 - Added patch 2 updating Kconfig with references to new sensor
 - Patch 3 adds changes proposed by Jonathan Cameron <jic23@kernel.org>
   to declutter and unify configuration logic for the different sensors
   extending "chip_info" struct with default configuration parameters.
 - Patch 4: store temperature and pressure adc values on 3 byte array
   instead of using the type __le32. Uses function get_unaligned_le24
   to convert the little-endian encoded 3 byte value to an integer.
 - Patch 4: drops custom macro le16_from_bytes and use get_unaligned_le16
 - Patch 4: generate masks using GENMASK macro.
 - Patch 4: use FIELD_PREP to generate bitfields for registries
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
  iio: pressure: Kconfig: Add references to BMP380
  iio: pressure: bmp280: simplify driver initialization logic
  iio: pressure: bmp280: Add support for BMP380 sensor family
  iio: pressure: bmp280: Adds more tunable config parameters for BMP380

 .../bindings/iio/pressure/bmp085.yaml         |   4 +-
 drivers/iio/pressure/Kconfig                  |   4 +-
 drivers/iio/pressure/bmp280-core.c            | 732 +++++++++++++++++-
 drivers/iio/pressure/bmp280-i2c.c             |   5 +
 drivers/iio/pressure/bmp280-regmap.c          |  55 ++
 drivers/iio/pressure/bmp280-spi.c             |   5 +
 drivers/iio/pressure/bmp280.h                 |  83 ++
 7 files changed, 845 insertions(+), 43 deletions(-)


base-commit: 69cb6c6556ad89620547318439d6be8bb1629a5a
-- 
2.36.1

