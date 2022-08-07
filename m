Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5758BAB1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiHGLyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiHGLy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:54:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A49BE03;
        Sun,  7 Aug 2022 04:54:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h13so8032778wrf.6;
        Sun, 07 Aug 2022 04:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=9OP7NOyus7W8ZifggmGm/YFxyUHbZKq7CLf//+sw5oA=;
        b=jXcPlgZBSw2voNwnzAzau6rDjekfW/go/JGsnmDZ0lxUTd8KYIIv2N579MFeaqBhEs
         nmZNPy8lWrWCMI+c6O33dtixtmt32rsayMEfzlCpWUPFDfBVcL63OIIbfFsiPUTl/h84
         4W7q2e9DkcaZgHNmHljMkrUG7ENmX1WVer3hECFUDLPQ+J6hUlWbuMt3WFNvP85MABtI
         UiWNwoGEQA0LukPti9hgaYb8gWXaaXpOXaSi0iz9XmJClvCwdM0dtL5/S6+swI26HiYn
         POtN7G1FcWrdNNspWrB+uLn0nXz6Xl95pWEvF032VlsU7Wc+0qCuiP7Kl501PcGevfmK
         bahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=9OP7NOyus7W8ZifggmGm/YFxyUHbZKq7CLf//+sw5oA=;
        b=gA21jZG7Dm5MS4RmlywEwzkoPyEBWeBsFBA9CEnxpXnql9zzO+K64qdcxKf9H1ONK+
         mEpMzqCjMqoXRRXp32ql7Q8Km8TwBmbRaIHcSsceY7EgiX3eX40wzWh1DmZwlm5I0B9S
         869W0+5hqhy5N4xdpZ0oofN2ITGDKLipx1oWiEZVIZD9rHytwhGa7qDNZq1mq5y5xUbU
         1lunA4OX79IkDoXHH5Yk6dweqsSYS6MNW/pAUWtLat4AHlTn2r593At0MOI49k0FfM3m
         6YC1haAiwj7gHsM0i3ucb8GOod4paTOfYnJLO2g9yp+tpnOOooXHsuQIsW8/gNMKN+IY
         UDdA==
X-Gm-Message-State: ACgBeo3HfD1JXeY5UqvPoIa6Qdn8zZAYomDe75P0jSQuoJoCMTF6J17T
        v7Kiia3u0BAz8tmkiznEiPNdJFe3hM0=
X-Google-Smtp-Source: AA6agR7vPz71FVGI2CYu7JOc2y56HDXAAgrO5sWhSJpXDayY0uYvT6PbfG3LgcJMFwHXMkYJgfm8fw==
X-Received: by 2002:adf:cd90:0:b0:21f:ba2:2b20 with SMTP id q16-20020adfcd90000000b0021f0ba22b20mr8642191wrj.162.1659873266760;
        Sun, 07 Aug 2022 04:54:26 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b003a17ab4e7c8sm16929736wmq.39.2022.08.07.04.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 04:54:26 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/5] Add support for pressure sensor Bosch BMP380
Date:   Sun,  7 Aug 2022 13:52:30 +0200
Message-Id: <cover.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
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

Patch 1 is a minor refactor simplifying driver initialization logic
to facilitate the integration of the new sensor variant extending the
information stored in the "chip_info" struct.
Patch 2 fixes DMA unsafe regmap_bulk_* calls reported by Jonathan Cameron
<jic23@kernel.org>.
Patch 3 adds the basic logic to initialize and read measurements from
the sensor.
Patch 4 adds references and sensor id to the devicetree bindings docs.
Patch 5 adds advanced configurable features such as sampling frequency
and IIR filter through the IIO sysfs ABI.

Changes in v5:
 - Moved dt bindings patch (previously patch 2/5) to 4/5 to preserve
    tree coherence as suggested by Jonathan Cameron <jic23@kernel.org>
 - Patch 1: Simplified initial oversampling values assignation.
 - Patch 1: Updated codepaths for bmp180 and bmp280 to use FIELD_GET and
    FIELD_GET helpers. Migrated compatible masks to use GENMASK.
 - Patch 2: Store DMA-safe buffers on the device data struct instead of
    using dynamic allocations for calibration buffers.
    Thanks Jonathan Cameron <jic23@kernel.org>.
 - Patch 3: Fixed small typos
 - Patch 3: Fixed incompatible division on 32-bit machines reported by
    Andy Shevchenko <andy.shevchenko@gmail.com> and kernel test robot
    <lkp@intel.com>.
 - Patch 3: Fixed inconsistent use of "x" and "X" declaring constants.
 - Patch 5: Dropped incorrect reported-by tag on changelog message.
 - Patch 5: Fixed typos on various comments.

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
 - Patch 5: on bmp280_write_* checks if a problem occurred committing new
    configuration and tries to restore previous working configuration
    to keep the sensor in a previous working state.
 - Patch 5: refactored bmp380_chip_config to only check for configuration
    errors when a configuration change is detected.
 - Patch 5: improved invalid configuration detection on BMP380 restarting
    measurement loop to force a new measurement after the configuration is
    updated.

Previous patch version available on:
 https://lore.kernel.org/all/cover.1658597501.git.ang.iglesiasg@gmail.com/

Angel Iglesias (5):
  iio: pressure: bmp280: simplify driver initialization logic
  iio: pressure: bmp280: Fix alignment for DMA safety
  iio: pressure: bmp280: Add support for BMP380 sensor family
  dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
  iio: pressure: bmp280: Add more tunable config parameters for BMP380

 .../bindings/iio/pressure/bmp085.yaml         |   4 +-
 drivers/iio/pressure/Kconfig                  |   6 +-
 drivers/iio/pressure/bmp280-core.c            | 866 +++++++++++++++---
 drivers/iio/pressure/bmp280-i2c.c             |   5 +
 drivers/iio/pressure/bmp280-regmap.c          |  55 ++
 drivers/iio/pressure/bmp280-spi.c             |   5 +
 drivers/iio/pressure/bmp280.h                 | 159 +++-
 7 files changed, 952 insertions(+), 148 deletions(-)


base-commit: 180c6cb6b9b79c55b79e8414f4c0208f2463af7d
-- 
2.37.1

