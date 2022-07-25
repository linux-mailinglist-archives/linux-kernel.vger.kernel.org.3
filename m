Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C389457FDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbiGYKlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbiGYKl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:41:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A36917A81;
        Mon, 25 Jul 2022 03:41:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:389d:42df:ae4c:c047:294c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AE74666015E7;
        Mon, 25 Jul 2022 11:41:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658745681;
        bh=OIJqwsYXi8pLmEf2wCQHVghNtrzF+4UM3EjjU6Dcvqw=;
        h=From:To:Cc:Subject:Date:From;
        b=QIZvxYjEAmsA1Ew1SudcFsVFGDyXboHXWcEpsiihPbRjO2YTfwzwcPhCuFifH4+6G
         +sHAkKX+qYQKgE8MC9rDpeetmdON8TbwYQdP5elmt680L9Fbd0OzVbjty5Mhqomp0F
         VV1Mc3vHnctaeU9Kibn4cvHevfpHE5SwwmunbGocyOOU6imU9MzfE/iBKz/0qjoRpx
         ULnBd0cYuFmz4Fynmd5TQP+UEuAdGkhOq5Lb8EQNFZdS+W2Qpeag6lO0h+I1Ui2tFD
         y2Jmyjo5I9wa234oxWgRw/IsABTdgQwokosxDynqyR/Kqtcp/lXXk4Z4J0f5Ow6mOM
         ijFEIgacg5ohQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, dmitry.osipenko@collabora.com
Cc:     krisman@collabora.com, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v10 0/2] Add LTRF216A Driver
Date:   Mon, 25 Jul 2022 16:10:48 +0530
Message-Id: <20220725104050.491396-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.

Changes in v10
  - Handle !CONFIG_PM scenario similar to how other IIO drivers
    do it.
  - Fix kernel test robot warning.

Changes in v9
  - Add LTRF216A_MAIN_STATUS register in volatile function.
  - Update the datasheet link.

Changes in v8
  - Add caching mechanism to restore register state after h/w resume.
  - Add callback functions and disable locking in regmap config.
  - Update mutex comment as per it's current scope in the driver.
  - Add Shreeya as author of the driver.
  - Make some minor cleanups.

Changes in v7
  - Add regmap support.
  - Fix runtime power management implementation.
  - Fix the ordering of devm and non-devm functions.
  - Use DEFINE_RUNTIME_DEV_PM_OPS macro
  - Fix the error reported by kernel test robot for bindings.

Changes in v6
  - Fix some errors reported by kernel test robot.
  - Add protocol details for the datasheet link.
  - Remove useless assignments.
  - Add unit details for read data delay macro.
  - Use pm_sleep_ptr().

Changes in v5
  - Add power management support.
  - Add reset functionality.
  - Use readx_poll_timeout() to get data.
  - Cleanup some of the redundant code.
  - Update int_time_fac after I2C write is successful.
  - Rename mutex to lock.
  - Use Reverse Xmas tree pattern for all variable definitions.
  - Improve error handling messages and add error codes.
  - Add one more MODULE_AUTHOR.
  - Remove cleardata which was reading data for infrared light.
  - Remove patch for deprecated vendor prefix [PATCH v4 3/3].
  - Remove deprecated string from DT binding document.

Changes in v4
  - Add more descriptive comment for mutex lock
  - Fix mutex locking in read_raw()
  - Use i2c_smbus_read_i2c_block_data()

Changes in v3
  - Use u16 instead of u8 for int_time_fac
  - Reorder headers in ltrf216a.c file
  - Remove int_time_mapping table and use int_time_available
  - Fix indentation in the bindings file.

Changes in v2
  - Add support for 25ms and 50ms integration time.
  - Rename some of the macros as per names given in datasheet
  - Add a comment for the mutex lock
  - Use read_avail callback instead of attributes and set the
    appropriate _available bit.
  - Use FIELD_PREP() at appropriate places.
  - Add a constant lookup table for integration time and reg val
  - Use BIT() macro for magic numbers.
  - Improve error handling at few places.
  - Use get_unaligned_le24() and div_u64()
  - Use probe_new() callback and devm functions
  - Return errors in probe using dev_err_probe()
  - Use DEFINE_SIMPLE_DEV_PM_OPS()
  - Correct the formula for lux to use 0.45 instead of 0.8
  - Add interrupt and power supply property in DT bindings
  - Add vendor prefix name as per the alphabetical order.


Shreeya Patel (2):
  dt-bindings: Document ltrf216a light sensor bindings
  iio: light: Add support for ltrf216a sensor

 .../bindings/iio/light/liteon,ltrf216a.yaml   |  49 ++
 drivers/iio/light/Kconfig                     |  11 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/ltrf216a.c                  | 537 ++++++++++++++++++
 4 files changed, 598 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

