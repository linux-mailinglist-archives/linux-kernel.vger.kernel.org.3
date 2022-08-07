Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD658BB58
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 16:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbiHGOxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiHGOxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 10:53:02 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AEF6418
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1659883980; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=hY95gQ17rldQVVinQ3uweDBIYeHD3hM2ZncCjYZYkck=;
        b=NTVbcndKxRz0DCI5vAEbCVetCMgU7Ydv//LulLTskQF/pN9sZywzmIdOHIZJgLFjdmQKXl
        XC3oEog3PMmUFtLdW7QTLuvdMSnGVFTAx9Xu2iJVSMWxQWWr7Y83+Fr1SH4imQ3JCHTnHz
        oEMB8ZziCa8mnYzXb9TRWdoLtmk3qdM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 00/28] mfd: Remove #ifdef guards for PM functions
Date:   Sun,  7 Aug 2022 16:52:19 +0200
Message-Id: <20220807145247.46107-1-paul@crapouillou.net>
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

Here is a set of 28 patches that should convert all MFD drivers to use
the proper PM macros introduced recently.

These macros allow the PM related functions to be automatically dropped
by the compiler when CONFIG_SUSPEND or CONFIG_PM is disabled, without
having to use #ifdef guards.

The rationale behind this change, is that these functions are now
always compiled independently of any Kconfig option, and thanks to that
bugs and regressions are easier to catch.

Most of the changes are trivial. Some patches come with a caveat:
- patch 06/28 moves the PM functions to pcf50633-irq.c, and uses
  EXPORT_GPL_SIMPLE_DEV_PM_OPS(). This means that we're now exporting a
  symbol that wasn't exported before. This is the only solution I found
  in order to have all PM related functions dropped in case PM is
  disabled.
- patch 12/28 was not compile-tested (all other were) since it doesn't
  build on x86. The change is trivial though, so there's no reason why
  it wouldn't compile.
- patch 14, 15, 19 and 28 use (platform_driver.suspend) instead of
  (platform_driver.driver.pm.suspend). Is the former deprecated?
  The scope of this patchset is just to convert to the new PM macros,
  but it left me wondering if this should be using the standard
  dev_pm_ops structure instead.
- patch 17/28 could probably use DEFINE_RUNTIME_DEV_PM_OPS(), which
  registers pm_runtime_force_suspend() and pm_runtime_force_resume() as
  the .suspend/.resume callbacks. I didn't know if the callbacks were
  missing on purpose, so I chose not to use this macro.
- patch 20/28 is a bit messy, because the EXPORT_GPL_SIMPLE_DEV_PM_OPS()
  does not support noirq callbacks. If you think it looks too bad, we
  can maybe add a new PM macro to handle this case.
- patch 26/28 exports the "stmpe_dev_pm_ops", which wasn't exported
  before. If you think this is a problem, we can export the symbol to a
  stmpe namespace.

Cheers,
-Paul

Paul Cercueil (28):
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

 drivers/mfd/88pm800.c              |  2 +-
 drivers/mfd/88pm805.c              |  2 +-
 drivers/mfd/88pm80x.c              |  5 +----
 drivers/mfd/88pm860x-core.c        |  6 ++----
 drivers/mfd/aat2870-core.c         |  8 +++-----
 drivers/mfd/adp5520.c              |  6 ++----
 drivers/mfd/arizona-core.c         | 21 +++++++++++----------
 drivers/mfd/arizona-i2c.c          |  2 +-
 drivers/mfd/arizona-spi.c          |  2 +-
 drivers/mfd/intel_soc_pmic_bxtwc.c |  7 +++----
 drivers/mfd/intel_soc_pmic_core.c  |  8 +++-----
 drivers/mfd/max14577.c             |  6 ++----
 drivers/mfd/max77620.c             |  9 +++------
 drivers/mfd/max77686.c             |  6 ++----
 drivers/mfd/max8925-i2c.c          |  7 +++----
 drivers/mfd/mcp-sa11x0.c           |  6 +-----
 drivers/mfd/motorola-cpcap.c       |  6 ++----
 drivers/mfd/mt6397-irq.c           |  6 +-----
 drivers/mfd/pcf50633-core.c        | 22 +---------------------
 drivers/mfd/pcf50633-irq.c         | 13 ++++++++-----
 drivers/mfd/rc5t583-irq.c          |  7 ++-----
 drivers/mfd/sec-core.c             |  7 +++----
 drivers/mfd/sm501.c                | 10 ++--------
 drivers/mfd/sprd-sc27xx-spi.c      |  7 +++----
 drivers/mfd/stmfx.c                |  6 ++----
 drivers/mfd/stmpe-i2c.c            |  4 +---
 drivers/mfd/stmpe-spi.c            |  4 +---
 drivers/mfd/stmpe.c                |  8 ++------
 drivers/mfd/stpmic1.c              |  6 ++----
 drivers/mfd/t7l66xb.c              |  9 ++-------
 drivers/mfd/tc3589x.c              |  7 +++----
 drivers/mfd/tc6387xb.c             |  9 ++-------
 drivers/mfd/tc6393xb.c             |  9 ++-------
 drivers/mfd/tps6586x.c             |  6 +-----
 drivers/mfd/ucb1x00-core.c         |  7 +++----
 drivers/mfd/wm8994-core.c          |  6 ++----
 include/linux/mfd/pcf50633/core.h  |  6 ++----
 37 files changed, 87 insertions(+), 181 deletions(-)

-- 
2.35.1

