Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680350A17B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387768AbiDUOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386591AbiDUOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:06:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F843981E;
        Thu, 21 Apr 2022 07:03:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: shreeya)
        with ESMTPSA id 3E3E51F44D87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650549761;
        bh=ArSK0XPQphXlFdSa1AUStb79K0fJdl464mogrdyEK+I=;
        h=From:To:Cc:Subject:Date:From;
        b=Cw5mO+y272o8w7brCUpjWVzuzJG6QunIgxNqk3DODnjXlHopNT9mRolToPZ0NaXbO
         jQGbBbIbCuOmSDQTtQ46QvqDYY9BIKNcmSzYCzR/WkHyE3gFArsQLRTZEsEswo2Ykg
         7XhECACuJzwXOtkEsway3v0dPOM+nIRU4mkjF88/kqJjYG7oSUUHWGzt1P3/SwAUOa
         GSaIncfyTTueJWhN0P8CBT7JPoT1ZG2wfTrEtzyaoqw4O0Q2TisvSZgDltmvXgKhz8
         iRQldRyNVv3zaH5aAtkbIoGQIP/uBF12oEFqfAdPRf2S8l7qbhkDUmQp+JpfXOSdYm
         1oW9u8GFBrgTg==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        Zhigang.Shi@liteon.com, krzk@kernel.org, krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 0/3] Add LTRF216A Driver
Date:   Thu, 21 Apr 2022 19:31:30 +0530
Message-Id: <20220421140133.354498-1-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for ltrf216a Ambient Light Sensor
and documents the DT bindings for the same.

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

 .../bindings/iio/light/liteon,ltrf216a.yaml   |  52 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   3 +
 drivers/iio/light/Kconfig                     |  10 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/ltrf216a.c                  | 349 ++++++++++++++++++
 5 files changed, 415 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
 create mode 100644 drivers/iio/light/ltrf216a.c

-- 
2.30.2

