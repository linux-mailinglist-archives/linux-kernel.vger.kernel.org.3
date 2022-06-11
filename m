Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C08A547782
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 22:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiFKU1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 16:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiFKU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 16:27:38 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9A86A431
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:27:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso2679042wms.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 13:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFNaxUZNCpwtJNNLY7AYmusKJ3kJUrDC+YV49C9O30c=;
        b=xapK7w9Mp0+G8h+Q+vNaAd2AWR7BcAEpYzR8DL/+kEsxbCaf85qQyDgYBgZNCyeblC
         S6XerCCZxg906asAmR3Fh9b2tzqOs/RBiEvevcBmWPiRAbqT02hfODBBQBi3ESm+pVRK
         e1tLhsj1dUJHhRox9XtJXh3zlAY+pZfgEytKHCaNdsS7Zzlxr7JCtNQR7J+ABSv21R19
         pBReugPHq6gGG9MT8IZzsET7UZY8m4mkqq+PU9mMJMfmICwyjj7S5bU8eD10l6znkA85
         fZ4cyxy6Da6jdFJKp1KXcejnoDYR510PkphvLeQmhkn5OA5drmjkFJ4/YpAfMcnVDl0j
         Z+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nFNaxUZNCpwtJNNLY7AYmusKJ3kJUrDC+YV49C9O30c=;
        b=oDgu0HKLVZyiO9ZUGsGf8qli+I+z4MbLHKcPwFuRKoM0e1JsKT8BAFfldhA5Kbxeia
         nw9Z9H0CZ1dw94fhOpvNv8hkphzXT2kw1uMlg7vsEsG7jQoy5WsKuo2GhbolWqugW5FF
         /8XBiUF4aOHi7jvRd6PpS58iQdfx2d1b8ee3bIBJaOu59DfeYSsR7QSW09WSxdYoE4f8
         V3WmvmSaEoV9diCAzNWEkC2ibOMtumUyrXKvPP4P+tbS/pJ7QRb1Lipd0BQrn2xfdE3b
         KZ8cNfZZqQpbnOlG6kkOa3r5I8ayuHOh6FiFCr6JHOt6NW/J6GExtnVlOrQQukg7BDaV
         8meA==
X-Gm-Message-State: AOAM5308s6VpiroyVq0giAkMz5PHf+wf9F1gMDd2jwnIwwlJjo0LFLju
        v1XqW83deTQuoS1zjQemTuCcxg==
X-Google-Smtp-Source: ABdhPJzdHDOInnFkPrwicvPSpk+IUUMH8dbzNdVQe+zzy7teM4yj2g7KQMQBM3gU+9RioHq3G08ENw==
X-Received: by 2002:a7b:c341:0:b0:37b:ed90:7dad with SMTP id l1-20020a7bc341000000b0037bed907dadmr6234923wmj.138.1654979255002;
        Sat, 11 Jun 2022 13:27:35 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f2fe:1d3f:7d24:f28f])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b003973435c517sm3629501wmp.0.2022.06.11.13.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 13:27:34 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.19-rc2
Date:   Sat, 11 Jun 2022 22:27:32 +0200
Message-Id: <20220611202732.6602-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Here's a set of fixes for the upcoming rc. Most address the new warning we
emit at build time when irq chips are not immutable with some additional
tweaks to gpio-crystalcove from Andy and a small tweak to gpio-dwapd.

Please pull!
Bartosz Golaszewski

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc2

for you to fetch changes up to 77006f6edc0e0f58617eb25e53731f78641e820d:

  gpio: dwapb: Don't print error on -EPROBE_DEFER (2022-06-10 14:26:15 +0200)

----------------------------------------------------------------
gpio fixes for v5.19-rc2

- make irq_chip structs immutable in several Diolan and intel drivers to
  get rid of the new warning we emit when fiddling with irq chips
- don't print error messages on probe deferral in gpio-dwapb

----------------------------------------------------------------
Andy Shevchenko (7):
      gpio: crystalcove: make irq_chip immutable
      gpio: crystalcove: Use specific type and API for IRQ number
      gpio: crystalcove: Join function declarations and long lines
      gpio: wcove: make irq_chip immutable
      gpio: merrifield: make irq_chip immutable
      gpio: sch: make irq_chip immutable
      gpio: dln2: make irq_chip immutable

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v5.19-2' of gitolite.kernel.org:pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Serge Semin (1):
      gpio: dwapb: Don't print error on -EPROBE_DEFER

 drivers/gpio/gpio-crystalcove.c | 70 ++++++++++++++++++++++-------------------
 drivers/gpio/gpio-dln2.c        | 23 ++++++++------
 drivers/gpio/gpio-dwapb.c       |  7 ++---
 drivers/gpio/gpio-merrifield.c  | 22 ++++++++-----
 drivers/gpio/gpio-sch.c         | 35 +++++++++++++--------
 drivers/gpio/gpio-wcove.c       | 10 ++++--
 6 files changed, 99 insertions(+), 68 deletions(-)
