Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106CF54CA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiFONwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbiFONv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:51:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521E53C717;
        Wed, 15 Jun 2022 06:51:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:10:3153:7fbd:8a7b:29b6:89fb])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B37D6601701;
        Wed, 15 Jun 2022 14:51:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655301114;
        bh=izgURzLTy40gnm0phiG12h3sKNra6Vhk2TKfrtJGjtw=;
        h=From:To:Cc:Subject:Date:From;
        b=LpYtRhqr1HskmYyVVVlRdDuc84lU1+qwAyYlPHRFYCxj8tWaIyaP2tcUf23f+oVxS
         Tg4hSCDBbkprsaxujxhuzRI2KfWr7zBlI1ZMPq2A2fWS/jNsof8IQbqOynB9OQTk+d
         BU9TALaDqNYcGWnGR+Uhq47gqcrbC7iAfW0LIJbpgpq5QfSR3M4XTPmiZllTW0xy48
         jA+WHNNfh55w3dlykVcHjNl3vk9oJjBjETetDjaaXvlIiA26BII0NbhlKl05Nb1sEy
         FM+NTZiTr3Wm+ghzhs+v47LBQzPcfx37HVrZMChNrsQ0UjqRiv7BPNcM98TOqC/M7U
         ecaeM7632wRYg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v6 0/2] Add LTRF216A Driver
Date:   Wed, 15 Jun 2022 19:21:28 +0530
Message-Id: <20220615135130.227236-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.

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

 .../bindings/iio/light/liteon,ltrf216a.yaml   |  50 ++
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/ltrf216a.c                  | 429 ++++++++++++++++++
 4 files changed, 490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

