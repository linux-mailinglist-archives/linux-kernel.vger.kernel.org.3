Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3F58CCDB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbiHHRmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244255AbiHHRlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:41:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D874D1BB;
        Mon,  8 Aug 2022 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659980486; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=JdBshlFJ3d7ifkgGEXQVWypQ27imwxkVkTEfz2tsRxc=;
        b=RQD8De9bgWJmgvrdvKz45fcP/i3RbZAbsjMn7ZFnaaZd/2rbX6h+Ry5CceSy2hu8gEpHRT
        +1qqJzAhdK/KUFLr1nQpm1oMHf2RMhfDeAZ93CrPDdoLfiIfAO6+WFNMRqrd2zXsKyiUiw
        tv0ZO/IZL5tfwAAOFAmQCOuisBYkIpo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-pm <linux-pm@vger.kernel.org>
Subject: [PATCH v2 00/30] mfd: Remove #ifdef guards for PM functions
Date:   Mon,  8 Aug 2022 19:40:37 +0200
Message-Id: <20220808174107.38676-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Here's my revised patchset updated from the feedback I got in V1.
This one is based on the current mfd-next-5.20.

I updated the PM macros in <linux/pm.h> and <linux/pm_runtime.h>, to
make them more versatile. They now allow to conditionally export
arbitrary dev_pm_ops structures. This is used in the "arizona" driver
for instance, which has "noirq" callbacks.

I Cc'd Jonathan, whom might be interested by the PM patch to convert the
IIO drivers to the new PM macros. Lee, if this patchset gets merged to
the MFD tree, could you then create an immutable branch for Jonathan?

Changes:
- [01/30] is new and adds the reworked PM macros.
- [12/30] now only modifies intel_soc_pmic_core.c since Andy updated
          the other file.
- [21/30] uses the new EXPORT_GPL_DEV_PM_OPS() macro instead of the
          trickery that was used before.
- [26/30] removes a CONFIG_PM wrapper around fields in private struct
- [27/30] removes a duplicated "const".
- [30/30] is new, and updates the intel-lpss driver.
- All patches: Reworded the last paragraph, hide the Cc's, remove
               the Cc to Bartlomiej's email address.

Cheers,
-Paul

Paul Cercueil (30):
  pm: Improve EXPORT_*_DEV_PM_OPS macros
  mfd: 88pm80x: Remove #ifdef guards for PM related functions
  mfd: aat2870: Remove #ifdef guards for PM related functions
  mfd: adp5520: Remove #ifdef guards for PM related functions
  mfd: max8925-i2c: Remove #ifdef guards for PM related functions
  mfd: mt6397-irq: Remove #ifdef guards for PM related functions
  mfd: pcf50633: Remove #ifdef guards for PM related functions
  mfd: rc5t583-irq: Remove #ifdef guards for PM related functions
  mfd: stpmic1: Remove #ifdef guards for PM related functions
  mfd: ucb1x00: Remove #ifdef guards for PM related functions
  mfd: 88pm860x: Remove #ifdef guards for PM related functions
  mfd: intel_soc_pmic: Remove #ifdef guards for PM related functions
  mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
  mfd: sec: Remove #ifdef guards for PM related functions
  mfd: sm501: Remove #ifdef guards for PM related functions
  mfd: tc6387xb: Remove #ifdef guards for PM related functions
  mfd: tps6586x: Remove #ifdef guards for PM related functions
  mfd: wm8994: Remove #ifdef guards for PM related functions
  mfd: max77620: Remove #ifdef guards for PM related functions
  mfd: t7l66xb: Remove #ifdef guards for PM related functions
  mfd: arizona: Remove #ifdef guards for PM related functions
  mfd: max14577: Remove #ifdef guards for PM related functions
  mfd: max77686: Remove #ifdef guards for PM related functions
  mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
  mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions
  mfd: stmfx: Remove #ifdef guards for PM related functions
  mfd: stmpe: Remove #ifdef guards for PM related functions
  mfd: tc3589x: Remove #ifdef guards for PM related functions
  mfd: tc6393xb: Remove #ifdef guards for PM related functions
  mfd: intel-lpss: Remove #ifdef guards for PM related functions

 drivers/mfd/88pm800.c             |  2 +-
 drivers/mfd/88pm805.c             |  2 +-
 drivers/mfd/88pm80x.c             |  5 +----
 drivers/mfd/88pm860x-core.c       |  6 ++---
 drivers/mfd/aat2870-core.c        |  8 +++----
 drivers/mfd/adp5520.c             |  6 ++---
 drivers/mfd/arizona-core.c        | 19 ++++++----------
 drivers/mfd/arizona-i2c.c         |  2 +-
 drivers/mfd/arizona-spi.c         |  2 +-
 drivers/mfd/intel-lpss-acpi.c     |  4 +---
 drivers/mfd/intel-lpss-pci.c      |  4 +---
 drivers/mfd/intel-lpss.c          | 15 ++++++++-----
 drivers/mfd/intel-lpss.h          | 28 +----------------------
 drivers/mfd/intel_soc_pmic_core.c |  8 +++----
 drivers/mfd/max14577.c            |  6 ++---
 drivers/mfd/max77620.c            |  9 +++-----
 drivers/mfd/max77686.c            |  6 ++---
 drivers/mfd/max8925-i2c.c         |  7 +++---
 drivers/mfd/mcp-sa11x0.c          |  6 +----
 drivers/mfd/motorola-cpcap.c      |  6 ++---
 drivers/mfd/mt6397-irq.c          |  6 +----
 drivers/mfd/pcf50633-core.c       | 22 +-----------------
 drivers/mfd/pcf50633-irq.c        | 13 ++++++-----
 drivers/mfd/rc5t583-irq.c         |  7 ++----
 drivers/mfd/sec-core.c            |  7 +++---
 drivers/mfd/sm501.c               | 10 ++-------
 drivers/mfd/sprd-sc27xx-spi.c     |  7 +++---
 drivers/mfd/stmfx.c               |  6 ++---
 drivers/mfd/stmpe-i2c.c           |  4 +---
 drivers/mfd/stmpe-spi.c           |  4 +---
 drivers/mfd/stmpe.c               |  8 ++-----
 drivers/mfd/stpmic1.c             |  6 ++---
 drivers/mfd/t7l66xb.c             |  9 ++------
 drivers/mfd/tc3589x.c             |  7 +++---
 drivers/mfd/tc6387xb.c            |  9 ++------
 drivers/mfd/tc6393xb.c            |  9 ++------
 drivers/mfd/tps6586x.c            |  6 +----
 drivers/mfd/ucb1x00-core.c        |  7 +++---
 drivers/mfd/wm8994-core.c         |  6 ++---
 include/linux/mfd/pcf50633/core.h |  6 ++---
 include/linux/mfd/stmfx.h         |  2 --
 include/linux/pm.h                | 37 +++++++++++++++++++------------
 include/linux/pm_runtime.h        | 20 ++++++++++-------
 43 files changed, 127 insertions(+), 242 deletions(-)

---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: linux-pm <linux-pm@vger.kernel.org>
-- 
2.35.1

