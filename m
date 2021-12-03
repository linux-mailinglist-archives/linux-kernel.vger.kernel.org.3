Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73BDD4674CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351489AbhLCKck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235349AbhLCKce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638527349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SXSYEyTFExfkT+47FFAoVWPySgULFdvjPMdkzFGphKU=;
        b=QtknGQsldW0rBKNPOrGjd78oayKDMqfBr8xiIDbhw6xFgNu2vzZwvdozRnyQuw6R7zUHuk
        WUJlxNkXR6iTq9wdC6waAsfXMxTfcEYTtGJkgcL0a1ZrZLePNGXpmf8OxEmVwF7YYwvWDy
        NUvb8XfoQtAqRQRgtfwKm+WCGfCszwU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-vqzkYx5_MIyrfVN2DLzfOw-1; Fri, 03 Dec 2021 05:29:06 -0500
X-MC-Unique: vqzkYx5_MIyrfVN2DLzfOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0B981CCB5;
        Fri,  3 Dec 2021 10:29:03 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 592E7694BF;
        Fri,  3 Dec 2021 10:28:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v7 00/14] Add support for X86/ACPI camera sensor/PMIC setup with clk and regulator platform data
Date:   Fri,  3 Dec 2021 11:28:43 +0100
Message-Id: <20211203102857.44539-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v7 of my patch-set adding support for camera sensor connected to a
TPS68470 PMIC on x86/ACPI devices.

Changes in v7:
- Drop "platform/x86: int3472: Enable I2c daisy chain" this workaround is
  no longer necessary (the regulator code now takes care of this)
- Fix using PTR_ERR(data->clk) instead of PTR_ERR(rdev) to log an error
  code in "regulator: Introduce tps68470-regulator driver"

Changes in v6:
- Add support for the VCM (Voice Coil Motor) controlling the focus of
  the back/main sensor camera lens:
  - Patch 3 and patches 13-15 are new patches for this
  - While working on this I learned that the VIO regulator is an always on
    regulator and must be configured at the same voltage as VSIO, the
    tps68470-regulator driver and the constraints have been updated for this
- Addressed clk-tps68470 driver review-remarks
- Some minor tweaks based on review-remarks from Andy
- Add Andy's Reviewed-by to all patches which were also in v5

I'm quite happy with how this works now, so from my pov this is ready
for merging now.

Patch 2 and 3 already have acks for merging through another tree.

I believe the best way to merge this is that I create an IM branch with
patches 1-4 + 7-11 (with Rafael's ack for 1) and then the clk / regulator /
media maintainers merge my IM branch + their resp. patches

This assumes that Rafael does not foresee any conflicts caused by the few
small ACPI changes in patch 1. Rafael is this ok with you ? You did already
Ack patch 1 but IIRC that was not specifically for merging it through
another tree, may I have your ack for moving forward with this plan ?

Regards,

Hans


Hans de Goede (14):
  ACPI: delay enumeration of devices with a _DEP pointing to an INT3472
    device
  i2c: acpi: Use acpi_dev_ready_for_enumeration() helper
  i2c: acpi: Add i2c_acpi_new_device_by_fwnode() function
  platform_data: Add linux/platform_data/tps68470.h file
  regulator: Introduce tps68470-regulator driver
  clk: Introduce clk-tps68470 driver
  platform/x86: int3472: Split into 2 drivers
  platform/x86: int3472: Add get_sensor_adev_and_name() helper
  platform/x86: int3472: Pass tps68470_clk_platform_data to the
    tps68470-regulator MFD-cell
  platform/x86: int3472: Pass tps68470_regulator_platform_data to the
    tps68470-regulator MFD-cell
  platform/x86: int3472: Deal with probe ordering issues
  media: ipu3-cio2: Defer probing until the PMIC is fully setup
  media: ipu3-cio2: Call cio2_bridge_init() before anything else
  media: ipu3-cio2: Add support for instantiating i2c-clients for VCMs

 drivers/acpi/scan.c                           |  37 ++-
 drivers/clk/Kconfig                           |   8 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-tps68470.c                    | 261 ++++++++++++++++++
 drivers/i2c/i2c-core-acpi.c                   |  22 +-
 drivers/media/pci/intel/ipu3/cio2-bridge.c    |  92 ++++++
 drivers/media/pci/intel/ipu3/cio2-bridge.h    |  16 +-
 drivers/media/pci/intel/ipu3/ipu3-cio2-main.c |  10 +-
 drivers/platform/x86/intel/int3472/Makefile   |   9 +-
 ...lk_and_regulator.c => clk_and_regulator.c} |   2 +-
 drivers/platform/x86/intel/int3472/common.c   |  82 ++++++
 .../{intel_skl_int3472_common.h => common.h}  |   6 +-
 ...ntel_skl_int3472_discrete.c => discrete.c} |  51 ++--
 .../intel/int3472/intel_skl_int3472_common.c  | 106 -------
 ...ntel_skl_int3472_tps68470.c => tps68470.c} |  92 +++++-
 drivers/platform/x86/intel/int3472/tps68470.h |  25 ++
 .../x86/intel/int3472/tps68470_board_data.c   | 145 ++++++++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/tps68470-regulator.c        | 201 ++++++++++++++
 include/acpi/acpi_bus.h                       |   5 +-
 include/linux/i2c.h                           |  17 +-
 include/linux/mfd/tps68470.h                  |  11 +
 include/linux/platform_data/tps68470.h        |  35 +++
 24 files changed, 1076 insertions(+), 168 deletions(-)
 create mode 100644 drivers/clk/clk-tps68470.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_clk_and_regulator.c => clk_and_regulator.c} (99%)
 create mode 100644 drivers/platform/x86/intel/int3472/common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_common.h => common.h} (94%)
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_discrete.c => discrete.c} (91%)
 delete mode 100644 drivers/platform/x86/intel/int3472/intel_skl_int3472_common.c
 rename drivers/platform/x86/intel/int3472/{intel_skl_int3472_tps68470.c => tps68470.c} (56%)
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470.h
 create mode 100644 drivers/platform/x86/intel/int3472/tps68470_board_data.c
 create mode 100644 drivers/regulator/tps68470-regulator.c
 create mode 100644 include/linux/platform_data/tps68470.h

-- 
2.33.1

