Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CAB542F4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbiFHLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238102AbiFHLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:37:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE593BBFC;
        Wed,  8 Jun 2022 04:37:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [103.15.253.108])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 561CD66017E5;
        Wed,  8 Jun 2022 12:37:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654688230;
        bh=Sirt+uLFS1Q/aJAoqeMCgbjoXjgaef+e/EKDmiOX09s=;
        h=From:To:Cc:Subject:Date:From;
        b=RNod0FU21qvG1HhUblIJ8Q/SmSLx3iBjxEv/xBEprOaSsJSTQDKsFh0ERzkGbOTfA
         1fq0PPEyTXORScsUSj2UM4OGjy7aH6DYWfzSoXlNbJRfZ6rrbj/ZShFeAvOLQVJ/a0
         DRKUYfDKowm1WJJBej/YfrK2/KGojt0agYGBVnaxjdSRQySDMHhAvxI7dK7j1gd74E
         kbPsaeIjhu0v/5snB+0XuT/McDW+VwfXGy2MB1wjIpSgiSB4dSnGNyNEmHXNU+g69K
         uThprhod42gGJr3z4tU64b1ZkYpH7fyXdx6S0Z6m0nXWES71SKH4wOzMY1IwqrzC7q
         KDHY5VJ3q45oQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com, andy.shevchenko@gmail.com,
        digetx@gmail.com, Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v5 0/2] Add LTRF216A Driver
Date:   Wed,  8 Jun 2022 17:05:51 +0530
Message-Id: <20220608113553.32083-1-shreeya.patel@collabora.com>
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
 drivers/iio/light/ltrf216a.c                  | 441 ++++++++++++++++++
 4 files changed, 502 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

