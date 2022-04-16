Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF6503829
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiDPUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiDPUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 16:20:09 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8517F3BA4E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:17:35 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k22so14313303wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z66QlPMe1E4mhpzdiUDc+KempZ+cZum6Johy/Wm+dz8=;
        b=F7CFMw281hzymPBtjrss84+JsX6BAJqkSr527Ok5eqTlHOxvIZuzxNA+xtHzmkGFWJ
         7ne6uqMSH6gpzqitEcqZRFb/RtjC0Dbn12wxWxY6y0p1VDR7Sh0/SlfWX5WUpsRKf0zl
         NYQbQ6ZvwBLkokDJ7LPfALXNvwR79Wvf3F8oQV4kXnlikRnVMOeoutxcJMVs3KcTykEP
         W5SR1ECuk4/EN9Z9ar3flbf3enCkVTzvDfEU8RpW5K5eEmeDhqdTDO33pUHq0QtV/LML
         vCPORAV249HLHJSiMCfk+db2iX7Oc2u7yRw0Cy9Xnrz65OTHGgW7DxyKP+jJYX0qMxc9
         XWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z66QlPMe1E4mhpzdiUDc+KempZ+cZum6Johy/Wm+dz8=;
        b=Sv6vbfq5aUyacQbBvARpcjijspbndp5J6X7rEiC2pxE5lh5Nk9ICv3uCfYeH/JmMdi
         3JR9XR3oRa0OQFdAzMkoinSAeKFX+o+Ve5ma8RjWLCbJpd6vbSBgP3gt6qJzSZy27/SU
         9foOfv1h8nUMEoq+FTsEwkqja6bVT7iqby1X2yVpY55IPzucF75ofZt3VvP6Q39msFG9
         EGQ6EuuXr3srX38rkkylFHlokGGyFn6zUTCCxdf0/wjWUCMtdUCihxBsjBwuN9oXKtlq
         Bs8+5dMjnXVBSfBjxjBODwqw+AODXS4QS0WRUOV7jpTZCnCNITEJzN0II5HvcMd5tCQ2
         YLmQ==
X-Gm-Message-State: AOAM532UKexgVyv+bB1AF4DCSjBeVsaTaJ+i1zqhfChb/4KERRONgB3z
        LdVtcNgl1X+/aFAmLD3IHznWPQ==
X-Google-Smtp-Source: ABdhPJwamGE2+m2jdo/YzkPiZgqG+C3MGgsJKmH8dGNvySsvShgjB7taz2I++EjQ109pl63YINS/Bw==
X-Received: by 2002:a5d:595f:0:b0:20a:88cf:c047 with SMTP id e31-20020a5d595f000000b0020a88cfc047mr2502977wri.63.1650140254112;
        Sat, 16 Apr 2022 13:17:34 -0700 (PDT)
Received: from brgl-uxlite.. (199.153.205.77.rev.sfr.net. [77.205.153.199])
        by smtp.gmail.com with ESMTPSA id ay41-20020a05600c1e2900b0038e75fda4edsm7859968wmb.47.2022.04.16.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 13:17:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.18-rc3
Date:   Sat, 16 Apr 2022 22:17:27 +0200
Message-Id: <20220416201727.3017-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.32.0
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

Please pull the following set of fixes for the next rc. There's a single fix
for gpio-sim and two patches for GPIO ACPI pulled from Andy.

Thanks!
Bart

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc3

for you to fetch changes up to 0ebb4fbe31343a42370a2897ea9424fe78f3a88f:

  Merge tag 'intel-gpio-v5.18-2' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current (2022-04-16 21:57:00 +0200)

----------------------------------------------------------------
gpio fixes for v5.18-rc3

- fix the set/get_multiple() callbacks in gpio-sim
- use correct format characters in gpiolib-acpi
- use an unsigned type for pins in gpiolib-acpi

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: acpi: Convert type for pin to be unsigned

Bartosz Golaszewski (2):
      gpio: sim: fix setting and getting multiple lines
      Merge tag 'intel-gpio-v5.18-2' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Linus Torvalds (1):
      gpiolib: acpi: use correct format characters

 drivers/gpio/gpio-sim.c       |  4 ++--
 drivers/gpio/gpiolib-acpi.c   | 22 ++++++++++++----------
 include/linux/gpio/consumer.h |  8 +++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)
