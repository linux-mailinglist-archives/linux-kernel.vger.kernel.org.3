Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7134D436D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiCJJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbiCJJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:25:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A86C139830
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:24:32 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso3785947wms.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 01:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elhFlIhG7DN982iz6keo3g4HAUnAWOEfbO01fAD1uDw=;
        b=6ozYf+qB2ivp9woWRItEh348PoOrmWoQ2Mx9vAeiuSGOoEVv+TwRjHMmGG1Nf9kAmv
         HDmAZSC09Y09IeqxOFS70n/osFAjJSwF5queU+sRUtPuSwTaOPH+36sJTWXdRIvKT8xl
         nK7N7zGRU4KuWGwH8TAC5+9uEJtn5DNq829FDCZZ3utbF2mifyR4Pq/XPZxuz5YR5E/v
         vve9r2bKyFMIepEI1yjldmYVWyW7RO4h4VJAVQbDMfXTj/FIv5xiZZVyAYC35WCYmpgZ
         0f3PFrjcLqzRRLK9dBe1Y7ctjK9Z2IGHYf3ty5EsV76sj48ztatUykl6cPX+U7RaaSc0
         T71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=elhFlIhG7DN982iz6keo3g4HAUnAWOEfbO01fAD1uDw=;
        b=ok8fTX1lp+vCOez9QhftBJKFFpDN5qdlnlSPZ1kDoPvFQ45eIhM7ImBj/pRMsfRV4c
         JplUT2cYIxNQLDDx27KfC0e8pFsyWE6x6NO26nABe45CHQktm4166Ho3ZvIm/4IJu8pV
         SpD0gCGyWC505BF3W2S3tZ9qrEFtK8MieiFIORaxYG3cOqhCApHytd2MnmEZMYo95YHP
         UbWsZ5pE8+oLFakg8C9I/vD9lgRsRMwjThOLcbV65Wx60HlBaILfAV4pND5GKK5V4O2o
         9KTYHOy5Pw19rY4CzjbEc8sRYorRYL3PHZStwch3CD16ND9dD+XDyd4OP2HH2GT92Q98
         zTnw==
X-Gm-Message-State: AOAM530KuFuyJqv5g1Ssvj9+D40hNul7u6vysgp+NmMJy7URBAMM/oxf
        hxKZYdvmVfSzV5RuU8lr+IK26A==
X-Google-Smtp-Source: ABdhPJyfqtwU6IsmGEEmG3t8uuHHwVLPrExNRpW+iJWtGsWofdnsag5dMkgtVtsai1R/ZqGovGu37w==
X-Received: by 2002:a05:600c:1c87:b0:389:9dda:af17 with SMTP id k7-20020a05600c1c8700b003899ddaaf17mr10871155wms.27.1646904270870;
        Thu, 10 Mar 2022 01:24:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id r2-20020a5d6942000000b001f0485057c4sm3820775wrw.74.2022.03.10.01.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 01:24:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.17
Date:   Thu, 10 Mar 2022 10:24:27 +0100
Message-Id: <20220310092427.102296-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following set of fixes from the GPIO subsystem. They come
in quite late but there's nothing controversial and they're quite small.

Best Regards,
Bartosz Golaszewski

The following changes since commit ffb217a13a2eaf6d5bd974fc83036a53ca69f1e2:

  Linux 5.17-rc7 (2022-03-06 14:28:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17

for you to fetch changes up to 55d01c98a88b346e217eaa931b32e7baea905c9a:

  gpio: sim: fix a typo (2022-03-10 10:02:19 +0100)

----------------------------------------------------------------
gpio fixes for v5.17

- fix a probe failure for Tegra241 GPIO controller in gpio-tegra186
- revert changes that caused a regression in the sysfs user-space interface
- correct the debounce time conversion in GPIO ACPI
- statify a struct in gpio-sim and fix a typo
- update registers in correct order (hardware quirk) in gpio-ts4900

----------------------------------------------------------------
Akhil R (1):
      gpio: tegra186: Add IRQ per bank for Tegra241

Andy Shevchenko (2):
      gpiolib: acpi: Convert ACPI value of debounce to microseconds
      gpio: sim: Declare gpio_sim_hog_config_item_ops static

Bartosz Golaszewski (1):
      gpio: sim: fix a typo

Marcelo Roberto Jimenez (1):
      gpio: Revert regression in sysfs-gpio (gpiolib.c)

Mark Featherston (1):
      gpio: ts4900: Do not set DAT and OE together

 drivers/gpio/gpio-sim.c      |  4 ++--
 drivers/gpio/gpio-tegra186.c |  2 ++
 drivers/gpio/gpio-ts4900.c   | 24 +++++++++++++++++++-----
 drivers/gpio/gpiolib-acpi.c  |  6 ++++--
 drivers/gpio/gpiolib.c       | 20 ++++++++++----------
 5 files changed, 37 insertions(+), 19 deletions(-)
