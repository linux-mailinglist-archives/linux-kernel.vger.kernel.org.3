Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18325588A52
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbiHCK0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbiHCK0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:26:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3741F2DB;
        Wed,  3 Aug 2022 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659522399; x=1691058399;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9bP0d3qqmjGzLGVmWvrgp4/m2jcaKZ09NEpkHpIYWQU=;
  b=c2AQIhbD5Cllsqu+K885QS/hSAW+lQnosszO3RsQ70UtJ3eNSPfU4yng
   /XEABgR8vUu9Cj1Vc8ryQmtlGz/ma1Z6ULr3xllgK41Toz+zeW1tKmG8l
   aoM7zrTZmft6trZu5orNvUz14mGc1/03A2EF4hOQVIzGcPthniTpAzIL0
   1llBFkOZBnupEF7+Jj9VrvILnjiENc7nJbHTUJCeUhdoMB2ozd00kB/1c
   AFpiGAAC9AL21t2q7eEWbvkXzTHQFlLDIh/FuVyfyiFoeBJ6JvCVIyeVd
   hU2Cp5RRWjfpeiE+HpciDcBGgXQmJqu5Bbt5RvbIakrIbnJEw2mnqJK+Z
   g==;
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="174716534"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2022 03:26:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 03:26:38 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 03:26:35 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <robh+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 00/19] iio: adc: at91-sama5d2_adc: add support for temperature sensor
Date:   Wed, 3 Aug 2022 13:28:36 +0300
Message-ID: <20220803102855.2191070-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series add support for temperature sensor available on
SAMA7G5.

Temperature sensor available on SAMA7G5 provides 2 outputs VTEMP and VBG.
VTEMP is proportional to the absolute temperature voltage and VBG is a
quasi-temperature independent voltage. Both are necessary in computing
the temperature (for better accuracy). Also, for better accuracy the
following settings were imposed when measusing the temperature:
oversampling rate of 256, sampling frequency of 10MHz, a startup time of
512 ticks, MR.tracktim=0xf, EMR.trackx=0x3.

For computing the temperature measured by ADC calibration data is
necessary. This is provided via OTP memory available on SAMA7G5.

Patches 1/19-4/19 provides some fixes.
Patches 5/19-16/19 prepares for the addition of temperature sensor
support.
Patch 17/16 adds the temperature sensor support.

Along with temperature sensor support I took the chance and added
runtime PM support in this series, too (handled in patch 19/19).

The rest of patches in this series are minor cleanups.

Thank you,
Claudiu Beznea

Changes in v3:
- fixed compilation warning by adjusting patches 10/19, 11/19

Changes in v2:
- addressed review comments
- with this, new patches were intruced in this series: 2/19, 4/19,
  8/19, 9,19
- runtime pm support has been adapted to work also when CONFIG_PM
  is not enabled
- collected tags

Claudiu Beznea (19):
  iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
  iio: adc: at91-sama5d2_adc: check return status for pressure and touch
  iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
  iio: adc: at91-sama5d2_adc: disable/prepare buffer on suspend/resume
  iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are
    enabled
  iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw
    versions
  iio: adc: at91-sama5d2_adc: move the check of oversampling in its
    function
  iio: adc: at91-sama5d2_adc: drop AT91_OSR_XSAMPLES defines
  iio: adc: at91-sama5d2_adc: add .read_avail() chan_info ops
  iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
  iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
  iio: adc: at91-sama5d2_adc: move oversampling storage in its function
  iio: adc: at91-sama5d2_adc: update trackx on emr
  iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for
    at91_adc_setup_samp_freq()
  iio: adc: at91-sama5d2_adc: lock around at91_adc_read_info_raw()
  dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature
    channel
  iio: adc: at91-sama5d2_adc: add support for temperature sensor
  iio: adc: at91-sama5d2_adc: add empty line after functions
  iio: adc: at91-sama5d2_adc: add runtime pm support

 drivers/iio/adc/at91-sama5d2_adc.c            | 684 +++++++++++++++---
 .../dt-bindings/iio/adc/at91-sama5d2_adc.h    |   3 +
 2 files changed, 568 insertions(+), 119 deletions(-)

-- 
2.34.1

