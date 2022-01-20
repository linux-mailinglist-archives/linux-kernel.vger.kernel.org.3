Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C8649502F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348756AbiATOcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbiATOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:32:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4897C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:32:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id v123so12526398wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voV9tUwcW7nggwh4Y3zh2zTjDE2cl1ie6Z0l0K1hTCA=;
        b=eZ6VJwEXkx9+hYAePyeUZUBkBTxDurhGPf7yes93v96F3qAbQ+djfek27GlTi+/y0B
         30jcQqUhSoW4eYol2ftRdipGi0y9GJbMoKQOo6bsidoODlAuvyZomza9DRej81KIozpF
         UgccHBPqKcNJMip6RTzX+DAEJpi8CiMlPKP9XJrvIAO+G4BuMcXayJLIWBTA2BlLgXi7
         oJb+ynilG6aqgYjoyAKekZv8MzWtb9DT0fm3nLhO813hW6UUyvrYA6YAXvUTOQwBdSmg
         uhk5s3HWM1hI6/fFfhxdFbKChHc6mqHnt5dr/XJbA4KcsJaFmo+/ikIq85fKcfe3t6XA
         1NPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=voV9tUwcW7nggwh4Y3zh2zTjDE2cl1ie6Z0l0K1hTCA=;
        b=22W8qbbVcGoxgbkHgg1q7EM37nfTeZu85GyxhVsTtrTzh5Mr+kmp4iPnXiajMmjFGJ
         wN0xTm92Y8w23NFn1qc5bN+pSZ//Qmb+Xa9HF81Q/h1bOd7mZNttlW22AWZaJmM5a3yD
         fs15lh6k6FwlQvuvLHo/XfzF5IROr5xbcyfRcK/6odRrjFUzXaNmpl17gp1UH46q44zv
         5qQDRcEInRZiMn6K9fWi238MUzG+WfDCgFVFJ3NYv9+oa8xLPC8KWQWKMIftXHoifhU8
         TVcGjzQAJpNpPLpx+6oi+hpnqU2BNCeUec1pMRCo+Wx7mFUi9tKC5UdZ3iELOW/E1Ybc
         CGDQ==
X-Gm-Message-State: AOAM533ULZzqbbxuq7M7xAqZpaB2NmNq1jwIpUZ7mewuuJ6BQne/z9cK
        /VuRLBehr43JXQOi8XQ322dLTg==
X-Google-Smtp-Source: ABdhPJx9j0HddK3ForJvKbPMk+lEeKepafT2U9sUHCAXUuWaYL9NhGuJ24YyBmkxRNNxmpdWLLzEHQ==
X-Received: by 2002:a05:600c:3510:: with SMTP id h16mr9242829wmq.122.1642689150322;
        Thu, 20 Jan 2022 06:32:30 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id 8sm3630760wrz.57.2022.01.20.06.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 06:32:30 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.17-rc1
Date:   Thu, 20 Jan 2022 15:32:28 +0100
Message-Id: <20220120143228.444087-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following fixes for the upcoming RC. They fix the same issue
in two drivers and then the drivers are fixed even more because the first
patches were incomplete which I missed.

Bart

The following changes since commit df0cc57e057f18e44dac8e6c18aba47ab53202f9:

  Linux 5.16 (2022-01-09 14:55:34 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc1

for you to fetch changes up to 9f51ce0b9e73f83bab2442b36d5e247a81bd3401:

  gpio: mpc8xxx: Fix an ignored error return from platform_get_irq() (2022-01-20 09:05:57 +0100)

----------------------------------------------------------------
gpio fixes for v5.17-rc1

- fix the error checks of platform_get_irq() in gpio-mpc8xxx and gpio-idt3243x

----------------------------------------------------------------
Miaoqian Lin (2):
      gpio: mpc8xxx: Fix IRQ check in mpc8xxx_probe
      gpio: idt3243x: Fix IRQ check in idt_gpio_probe

Yang Li (2):
      gpio: idt3243x: Fix an ignored error return from platform_get_irq()
      gpio: mpc8xxx: Fix an ignored error return from platform_get_irq()

 drivers/gpio/gpio-idt3243x.c | 6 +++---
 drivers/gpio/gpio-mpc8xxx.c  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)
