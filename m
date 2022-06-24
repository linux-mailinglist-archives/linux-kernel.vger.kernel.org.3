Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3155A4BE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiFXXSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiFXXSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:18:20 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ACD6DB02
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:18:19 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-101ab23ff3fso5775743fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc5VjbSeIO9kRIMOracq0GMGGBRs29d0aSqXajp/hwI=;
        b=wm9N2bR1JIiQdKKktfSBITzvgbQHdwBvVRL8ET8EBdGecfjXp/dodT4tvny5AV497v
         5ziPjGXtwE7hq7JX+YdHetwCQMygxyKmriMYifft7ZZCztRs6WAk7WiG9tkx23pVvTvC
         oDVPwfrYhZvOkQPOQc0UaaGe2nOqhgfWMprH7VRVFwB+WeeupGMv+7Eq406aOPOncHq3
         Xc/w0TFqwFiIDQoJtDx0tmybFEm7PgzSloWtA/ytXjWDJMEOWKGjApufwnf1J43/SPL6
         v2UdW9408S1xKljwFZMOVsT4r2lxiJnh5EVCfjCwz8e7XIBh3HgC1Rxnsjw47JYisNK/
         DcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bc5VjbSeIO9kRIMOracq0GMGGBRs29d0aSqXajp/hwI=;
        b=cM0TYWjLIi3VwYNN60AHlHOlkC/Mkrvb984Y/nOmijrF94eRJs2b5KucnmMbkV2TKb
         7RsRhwxw+AaSDhL7a+iOuH3/5zpcfg8K04XXBy27aqPgmtA5M3GjFlGFy3ZDdMJDGQ6o
         GBi0LB04MGpOa6z96E3u1D1su4Lmhvv9iaulmvzwC36d5ODVaMR5DGxlPDfNGoXpOQ9X
         H9rz68MSe+16Z+8e6R7EHVKhhTUqWVDIIfuhvjq05APRqDIiKFkPT2WEyrCOEb2maWdD
         vc7PAnDIreXfc18be57MjnjlD32TozRs1KV/zs8ukqXQ9yA8k6BgRZ1I/bx1lbs4vRrD
         A2CQ==
X-Gm-Message-State: AJIora/QA/wGp70YyoLwMv8C/x5FcTa+R6RxbERvPJQNALS07oSNUrxQ
        LKdpF80+4YtiWiN2CO5jfVb14w==
X-Google-Smtp-Source: AGRyM1uLz0gWniUEDN4ZcL/LDrNA7m3FzlWIm4VwXNf8DoTvOpG9tIggdpE80lxk+jA4rPKoLcXrWw==
X-Received: by 2002:a05:6870:5895:b0:fe:489c:d9d3 with SMTP id be21-20020a056870589500b000fe489cd9d3mr3442131oab.149.1656112698919;
        Fri, 24 Jun 2022 16:18:18 -0700 (PDT)
Received: from brgl-uxlite.. (BOINGO-WIRE.bear2.Houston1.Level3.net. [4.2.233.242])
        by smtp.gmail.com with ESMTPSA id v6-20020a4ac906000000b0035eb4e5a6c7sm2110859ooq.29.2022.06.24.16.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 16:18:18 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.19-rc4
Date:   Sat, 25 Jun 2022 01:18:12 +0200
Message-Id: <20220624231812.5878-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Please pull the following set of fixes for the next rc. Details are
in the signed tag as usual.

Thanks!
Bartosz Golaszewski

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc4

for you to fetch changes up to b0d473185ba887c798ed0cd6f5abf4075363baa4:

  gpio: mxs: Fix header comment (2022-06-23 23:18:13 +0200)

----------------------------------------------------------------
gpio fixes for v5.19-rc4

- make the irqchip immutable in gpio-realtek-otto
- fix error code propagation in gpio-winbond
- fix device removing in gpio-grgpio
- fix a typo in gpio-mxs which indicates the driver is for a different model
- documentation fixes
- MAINTAINERS file updates

----------------------------------------------------------------
Akira Yokosawa (1):
      gpio: Fix kernel-doc comments to nested union

Dan Carpenter (1):
      gpio: winbond: Fix error code in winbond_gpio_get()

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/gpio to GPIO SUBSYSTEM

Sander Vanheule (1):
      gpio: realtek-otto: Make the irqchip immutable

Stefan Wahren (1):
      gpio: mxs: Fix header comment

Tom Schwindl (1):
      docs: driver-api: gpio: Fix filename mismatch

Uwe Kleine-König (1):
      gpio: grgpio: Fix device removing

 Documentation/driver-api/gpio/board.rst    |  2 +-
 Documentation/driver-api/gpio/consumer.rst |  6 +++---
 Documentation/driver-api/gpio/intro.rst    |  6 +++---
 MAINTAINERS                                |  1 +
 drivers/gpio/gpio-grgpio.c                 | 14 +-------------
 drivers/gpio/gpio-mxs.c                    |  2 +-
 drivers/gpio/gpio-realtek-otto.c           | 10 ++++++++--
 drivers/gpio/gpio-winbond.c                |  7 ++++---
 include/linux/gpio/driver.h                | 29 ++++++++++++++++-------------
 9 files changed, 38 insertions(+), 39 deletions(-)
