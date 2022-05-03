Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B75A51870E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiECOsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiECOsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:48:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341A39145;
        Tue,  3 May 2022 07:44:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 947631F44133
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651589073;
        bh=75NegSEi4JVsJ/gNG3N8gRZQnLpfASm6YuDM+8dxgto=;
        h=From:To:Cc:Subject:Date:From;
        b=Fuf/2dowe32OR3RhkINdSzl/L24mNTcqsoRgd1sTgms+Uyp0hCVq0RO5/g0v7KjGT
         IjkH7H7GlA54f9t8ayNHX7MGUwvTOZJX66ZO7m1Ceehiv/yxFpEKFAzA++3MwF6VTQ
         Qa8La7FDijykYK98NIM6tEg9g2K9qNFGCbCs5vigQtV6iUjOxHk5XUOGrjB+bVKJZh
         shAMN1TTFmz4QFqUGkCiaARCbEDg3NvYpDXzaPSbvyoUzePc0gGgGqysXnz83fllX2
         qfpGL6T5nSacHpLUA0fSzWSVT2H6Qm5mcrQjB/B94FIqDwJM7p9LaPeBAgX/Q7OkdC
         m5GVwVHQ1dByA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 0/3] Add LTRF216A Driver
Date:   Tue,  3 May 2022 20:13:51 +0530
Message-Id: <20220503144354.75438-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.


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
 drivers/iio/light/ltrf216a.c                  | 343 ++++++++++++++++++
 5 files changed, 408 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

