Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A4C5445B3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiFII35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiFII3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:29:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0BF152BA8;
        Thu,  9 Jun 2022 01:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763393; x=1686299393;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1vSCdy4AX87UxHEd7W0RPqZe/n4JHEihhwn5uhx7GEM=;
  b=pczd1i2/DMKfc3AC05khheW0SjQ7RM6CCPd+P9gMfNpiW8DMNzq3uYE9
   TaqngiyX4Vm9iaUGsSwWX62xLxKf2TiqP/lZIvgfHMIEX882icdAb76f0
   +lsPxTKij0gf5mXbZ13G9LijPFm9yD1Wgk3uXjBhI8kxeYahCCUFBoTcM
   sgVnlnoPkKF35rYT2iga0041f+OdD7VgO/59a5gQkXB3Pa2cQheVFtsmP
   9+m+DQ3q5HvBW97Iei2kaW1VXGgJFdUD+4a/jH/VuwoO3wiTn1GzMQG65
   mF2/eT8TyRboq7xQtziev0z3KVhRuLLF8Ri+BdICOD0t0KdOC/tzOGtGY
   g==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167722478"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:29:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:29:52 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:29:48 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>, <ludovic.desroches@atmel.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 00/16] iio: adc: at91-sama5d2_adc: add support for temperature sensor
Date:   Thu, 9 Jun 2022 11:31:57 +0300
Message-ID: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Patches 1/16-3/16 provides some fixes.
Patches 3/16-12/16 prepares for the addition of temperature sensor
support.
Patch 13/16 adds the temperature sensor support.

Along with temperature sensor support I took the chance and added
runtime PM support in this series, too (handled in patch 15/16).

The rest of patches in this series are minor cleanups.

Thank you,
Claudiu Beznea

Claudiu Beznea (16):
  iio: adc: at91-sama5d2_adc: fix AT91_SAMA5D2_MR_TRACKTIM_MAX
  iio: adc: at91-sama5d2_adc: lock around oversampling and sample freq
  iio: adc: at91-sama5d2_adc: exit from write_raw() when buffers are
    enabled
  iio: adc: at91-sama5d2_adc: handle different EMR.OSR for different hw
    versions
  iio: adc: at91-sama5d2_adc: adjust osr based on specific platform data
  iio: adc: at91-sama5d2_adc: add 64 and 256 oversampling ratio
  iio: adc: at91-sama5d2_adc: simplify the code in
    at91_adc_read_info_raw()
  iio: adc: at91-sama5d2_adc: move oversampling storage in its function
  iio: adc: at91-sama5d2_adc: update trackx on emr
  iio: adc: at91-sama5d2_adc: add startup and tracktim as parameter for
    at91_adc_setup_samp_freq()
  iio: adc: at91-sama5d2_adc: add locking parameter to
    at91_adc_read_info_raw()
  dt-bindings: iio: adc: at91-sama5d2_adc: add id for temperature
    channel
  iio: adc: at91-sama5d2_adc: add support for temperature sensor
  iio: adc: at91-sama5d2_adc: add empty line after functions
  iio: adc: at91-sama5d2_adc: add runtime pm support
  iio: adc: at91-sama5d2_adc: use pm_ptr()

 drivers/iio/adc/at91-sama5d2_adc.c            | 633 +++++++++++++++---
 .../dt-bindings/iio/adc/at91-sama5d2_adc.h    |   3 +
 2 files changed, 548 insertions(+), 88 deletions(-)

-- 
2.34.1

