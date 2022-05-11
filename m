Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF490522FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiEKJog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbiEKJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:42:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0148DDED5;
        Wed, 11 May 2022 02:41:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id D06A41F43FDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652262066;
        bh=+2usJXmX9v+EVeE5jSEdCqwLDL5071aGc+5kYIF6aq8=;
        h=From:To:Cc:Subject:Date:From;
        b=eCD9cZO350OL4oMGSCPh14Ukp+DQnX4Dz1Xs2PDxNK7HHQBoYeWl6kldHZTtcAmMy
         S8QLpDN6D4aWQlYXXTez3FbaLqE2vuvmr72p3TakhBNIgGUxblCue4OgInDkCyxr3q
         GnUURc/peFkCrFWv6WiywWGb8GIj93GhLPNWayfH4/6+gEvIXAYiBoO3qgHLFruAzW
         lEt69fWLzRqJ0Lidwf817KgciRb/5X4SaJHbLhAhe5Qq3ExXa0xNbs0XQifCvFiPn5
         MhYw40gIxyOPC2Jdh6tC3V3Ehd9O4jIDnRc+2emng0CSUxBbUj5xJ8PL6UmHFTzriy
         g/Of/coNH8nnQ==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v4 0/3] Add LTRF216A Driver
Date:   Wed, 11 May 2022 15:10:21 +0530
Message-Id: <20220511094024.175994-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.


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


Shreeya Patel (3):
  dt-bindings: vendor-prefixes: Add 'ltr' as deprecated vendor prefix
  dt-bindings: Document ltrf216a light sensor bindings
  iio: light: Add support for ltrf216a sensor

 .../bindings/iio/light/liteon,ltrf216a.yaml   |  51 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/ltrf216a.c                  | 346 ++++++++++++++++++
 5 files changed, 411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

