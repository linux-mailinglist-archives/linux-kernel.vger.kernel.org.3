Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C0451E794
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385333AbiEGN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385316AbiEGN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 09:56:39 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062C247047
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 06:52:53 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so13562169wrg.3
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xN2OV8hD+tKLatOko/+mvAfDivXabKIhKKgO5mYO6w=;
        b=AYI+1EXSn5jNkkc86OlgGDSAdJDpQyYSSi6l9vP4Vovqd2o4olH8Asqltspea1kDUj
         2IBcWS7G6LxB+sDsUNNPOGZ06ftybYpnMRNhNhDyP/5yqoWdB67QM5+eKDlWSeVJFwm5
         0TwISdEYBV86JUkjEGct9vt2fX2Fs6QyGtK4NVJidFFfZ51y7xNWCEgjf1wksrl16A0/
         FcesCPjwkxZUN+QyylCDUUOuzkijCdI4r3X12iB3yhLyFAYR7mYJXF0pXPHBk541iIFJ
         pbYbE6wlv+4vnceoVTBS8zB5Y6pSCYFhUH1rjuoSOKmMIPdMU0Op+ulV4cR19Wuwb8X7
         UFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5xN2OV8hD+tKLatOko/+mvAfDivXabKIhKKgO5mYO6w=;
        b=bW8KZNL0E+gVQgHr0cgLLp+BgjPalmCvlS1RQMNUT4hgkDnd3z0+IiGRyv2i0v4YIW
         UN92NqotEekO1/oHaK7TYPXDStXg+BYscO2Le6MvoMIzMmsJVNADIIcZFwdg+M2NM3/r
         oysq22SnLoRWREJvngP1jsFLG216o7YL1eh/pNeeKgkSIu8CO5Dwidj9M5RBbl909r2q
         OioW4jVc4CXkGu3pBK625zgKHRu9a34WP/wsXnfMvSRwMWRti2zbw7gjGEpvBaHYoBQH
         ve7pLIK9Xm4KSBGJ0H/F1ZvJwsVBLMKbtTuM0wr4kJameOVihIMEWM2jHvCTM7qMfi2Q
         sztg==
X-Gm-Message-State: AOAM533L2GpVR6juP+oiGwz7bDXK+kGegtKKN8eso+R2N0iV4+hz6/9F
        Mhd5zWmmYFWEc/Mu6XuLgr7GOtOc9wGM0cC6
X-Google-Smtp-Source: ABdhPJzNHaRmcPVmm5V99OFx6vWhMlhk+8lOyBCnowRJZwE7g+Uhr3vmfWf+1lX9jEEQ/adM6SEdwQ==
X-Received: by 2002:adf:f38a:0:b0:20a:bc71:fe3f with SMTP id m10-20020adff38a000000b0020abc71fe3fmr6764368wro.47.1651931571541;
        Sat, 07 May 2022 06:52:51 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8c19:498c:46b8:803c])
        by smtp.gmail.com with ESMTPSA id bw26-20020a0560001f9a00b0020ac8c19ecfsm5854116wrb.3.2022.05.07.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:52:51 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.18-rc6
Date:   Sat,  7 May 2022 15:52:47 +0200
Message-Id: <20220507135247.17566-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
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

Please pull the following set of small fixes for the next rc. Details are in
the signed tag.

Best Regards,
Bartosz Golaszewski

The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc6

for you to fetch changes up to dba785798526a3282cc4d0f0ea751883715dbbb4:

  gpio: pca953x: fix irq_stat not updated when irq is disabled (irq_mask not set) (2022-05-06 16:59:29 +0200)

----------------------------------------------------------------
gpio fixes for v5.18-rc6

- fix the bounds check for the 'gpio-reserved-ranges' device property in
  gpiolib-of
- drop the assignment of the pwm base number in gpio-mvebu (this was missed
  by the patch doing it globally for all pwm drivers)
- fix the fwnode assignment (use own fwnode, not the parent's one) for the
  GPIO irqchip in gpio-visconti
- update the irq_stat field before checking the trigger field in gpio-pca953x
- update GPIO entry in MAINTAINERS

----------------------------------------------------------------
Andrei Lalaev (1):
      gpiolib: of: fix bounds check for 'gpio-reserved-ranges'

Bartosz Golaszewski (1):
      MAINTAINERS: update the GPIO git tree entry

Baruch Siach (1):
      gpio: mvebu: drop pwm base assignment

Nobuhiro Iwamatsu (1):
      gpio: visconti: Fix fwnode of GPIO IRQ

Puyou Lu (1):
      gpio: pca953x: fix irq_stat not updated when irq is disabled (irq_mask not set)

 MAINTAINERS                  | 2 +-
 drivers/gpio/gpio-mvebu.c    | 7 -------
 drivers/gpio/gpio-pca953x.c  | 4 ++--
 drivers/gpio/gpio-visconti.c | 7 ++-----
 drivers/gpio/gpiolib-of.c    | 2 +-
 5 files changed, 6 insertions(+), 16 deletions(-)
