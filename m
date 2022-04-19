Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D76950702C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353171AbiDSOWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353049AbiDSOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:21:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4708E13CDB;
        Tue, 19 Apr 2022 07:19:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12BDDB81975;
        Tue, 19 Apr 2022 14:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FBAC385A7;
        Tue, 19 Apr 2022 14:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650377940;
        bh=ICxBTHVyBx6oDFSBR7idG6LwygjkNNNg6dcWhiAqEwM=;
        h=From:To:Cc:Subject:Date:From;
        b=dA/ol6Zv5VYf/rCFYzrbyG6Y3fu84tC5xBn5pdPsdGnMjamFoLJLVfdzcbs66Hm2s
         k46I1jk0NK1j12eN6otnWKIL8C1uKLABidL1P86wVA/GgcNZpXv+uSIoHYA8fL2OZq
         PbZjYsgOq8/KjjGbxSHy49hesZ0e5jYBGFUk8qPCK4sVYQmlG0vrO8lv+z80Sr0Fpg
         k8QtuJ7r7kPR8kRaTehbX4I4A5Fi8pcX+/5T6Hm6L6S9IncMizZIRpCKTLALB9eTo9
         PmiTSngCO6n882Vcba2t61O3B5tbr1z+A8Pmh0sRLjGzq0RG7Utt2ljiTL0d1sVnTa
         +AuN3x5dEEikA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ngoh0-005MFS-BI; Tue, 19 Apr 2022 15:18:58 +0100
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
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
Date:   Tue, 19 Apr 2022 15:18:36 +0100
Message-Id: <20220419141846.598305-1-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a followup from [2].

I recently realised that the gpiolib play ugly tricks on the
unsuspecting irq_chip structures by patching the callbacks.

Not only this breaks when an irq_chip structure is made const (which
really should be the default case), but it also forces this structure
to be copied at nauseam for each instance of the GPIO block, which is
a waste of memory.

My current approach is to add a new irq_chip flag (IRQCHIP_IMMUTABLE)
which does what it says on the tin: don't you dare writing to them.
Gpiolib is further updated not to install its own callbacks, and it
becomes the responsibility of the driver to call into the gpiolib when
required. This is similar to what we do for other subsystems such as
PCI-MSI.

5 drivers are updated to this new model: M1, QC, Tegra, pl061 and AMD
(as I actively use them) keeping a single irq_chip structure, marking
it const, and exposing the new flag.

Nothing breaks, the volume of change is small, the memory usage goes
down and we have fewer callbacks that can be used as attack vectors.
What's not to love?

Since there wasn't any objection in the previous round of review, I'm
going to take this series into -next to see if anything breaks at
scale.

Thanks,

	M.

* From v2 [2]:
  - Fixed documentation
  - Collected RBs, with thanks

* From v1 [1]:
  - pl061 and AMD drivers converted
  - New helpers to keep the changes small
  - New warning for non-converted drivers
  - Documentation and TODO updates

[1] https://lore.kernel.org/r/20220223154405.54912-1-maz@kernel.org
[2] https://lore.kernel.org/r/20220405135444.199295-1-maz@kernel.org

Marc Zyngier (10):
  gpio: Don't fiddle with irqchips marked as immutable
  gpio: Expose the gpiochip_irq_re[ql]res helpers
  gpio: Add helpers to ease the transition towards immutable irq_chip
  gpio: tegra186: Make the irqchip immutable
  gpio: pl061: Make the irqchip immutable
  pinctrl: apple-gpio: Make the irqchip immutable
  pinctrl: msmgpio: Make the irqchip immutable
  pinctrl: amd: Make the irqchip immutable
  gpio: Update TODO to mention immutable irq_chip structures
  Documentation: Update the recommended pattern for GPIO irqchips

 Documentation/driver-api/gpio/driver.rst | 175 ++++++++++++++++++-----
 drivers/gpio/TODO                        |  19 +++
 drivers/gpio/gpio-pl061.c                |  32 +++--
 drivers/gpio/gpio-tegra186.c             |  32 +++--
 drivers/gpio/gpiolib.c                   |  13 +-
 drivers/pinctrl/pinctrl-amd.c            |  11 +-
 drivers/pinctrl/pinctrl-apple-gpio.c     |  29 ++--
 drivers/pinctrl/qcom/pinctrl-msm.c       |  53 ++++---
 include/linux/gpio/driver.h              |  16 +++
 include/linux/irq.h                      |   2 +
 kernel/irq/debugfs.c                     |   1 +
 11 files changed, 293 insertions(+), 90 deletions(-)

-- 
2.34.1

