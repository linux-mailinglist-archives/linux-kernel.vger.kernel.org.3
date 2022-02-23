Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833294C177F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242338AbiBWPpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242318AbiBWPox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:44:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFCBF970;
        Wed, 23 Feb 2022 07:44:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17EE36174C;
        Wed, 23 Feb 2022 15:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739EFC340E7;
        Wed, 23 Feb 2022 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645631063;
        bh=PVgeRt4LHCp9CTieLVRpqy0rj4cCYLX/Dq99wsHMmPU=;
        h=From:To:Cc:Subject:Date:From;
        b=tlZZm79gjjtiP8+zk3/zOOLSkEoC4f6peYZ6h0GfuWhfOU9WR19HvhIKFX9AfC36K
         V69iwNnjpt56KnRRNZDoip11T58CLJZvHM8b3sMkw+ixcWjTFw8A3+GCvAKL7lPBgu
         8V0KTwVLhkxlsyOMim11/HsU34l7bhs55snoAApFW1Et1mr4Ae7Pd6TlnifbBCgmOu
         u7x7PQZM2kkUfABVRUTzGB75JZmPmoEBEvmLQeVH2HfI4M1Y1mlAAvJF09mCPig1sy
         YSvpspIxbb6gKOBC/iCKFFyKQIkIOMsrfquTLNGptMvk7mtTxXJVLvkAJ6GDuR9mw4
         UixT8ABNV0afg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nMtoT-009wgt-7P; Wed, 23 Feb 2022 15:44:21 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 0/5] gpiolib: Handle immutable irq_chip structures
Date:   Wed, 23 Feb 2022 15:44:00 +0000
Message-Id: <20220223154405.54912-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently realised that the gpiolib play ugly tricks on the
unsuspecting irq_chip structures by patching the callbacks.

Not only this breaks when an irq_chip structure is made const (which
really should be the default case), but it also forces this structure
to be copied at nauseam for each instance of the GPIO block, which is
a waste of memory.

My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
which does what it says on the tin: don't you dare writing there.
Gpiolib is further updated not to install its own callbacks, and it
becomes the responsibility of the driver to call into the gpiolib when
required. This is similar to what we do for other subsystems such as
PCI-MSI.

3 drivers are updated to this new model: M1, QC and Tegra, as I
actively use them (though Tegra is hosed at the moment), keeping a
single irq_chip structure, marking it const, and exposing the new
flag.

Nothing breaks, the volume of change is small, the memory usage goes
down and we have fewer callbacks that can be used as attack vectors.

Another approach was to let gpiolib provide its own irq_chip structure
and stack it, but:
- only a few drivers are hierarchy aware
- the diversity of interrupt flows makes it impractical

I'd welcome comments on the approach. If deemed acceptable, there are
another 300+ drivers to update! Not to mention the documentation. I
appreciate that this is a lot of potential changes, but the current
situation is messy.

Note that these patches are on top of irqchip-next, which contains
more constifying work.

	M.

Marc Zyngier (5):
  gpio: Don't fiddle with irqchips marked as immutable
  gpio: Expose the gpiochip_irq_re[ql]res helpers
  pinctrl: apple-gpio: Make the irqchip immutable
  pinctrl: msmgpio: Make the irqchip immutable
  gpio: tegra186: Make the irqchip immutable

 drivers/gpio/gpio-tegra186.c         | 33 ++++++++++++-----
 drivers/gpio/gpiolib.c               | 13 +++++--
 drivers/pinctrl/pinctrl-apple-gpio.c | 30 +++++++++-------
 drivers/pinctrl/qcom/pinctrl-msm.c   | 53 +++++++++++++++++-----------
 include/linux/gpio/driver.h          |  4 +++
 include/linux/irq.h                  |  2 ++
 kernel/irq/debugfs.c                 |  1 +
 7 files changed, 91 insertions(+), 45 deletions(-)

-- 
2.30.2

