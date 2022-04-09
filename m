Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4640B4FAADC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiDIUx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDIUxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:53:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B30B7D4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:51:43 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r13so17639609wrr.9
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cACyB2KNmobopctUHQpdd+tFeJQNIy3DwPag/D99BI4=;
        b=Pi5nfqmwfnoDPHUVXy4zqXah8SOmPr2bLwSkRcnrQ4qey1mMIcm26mImpnOn29rzMC
         9nueOoyN/0DUT+5PfxvuI8p50hIXo65bsDKoypTqTcmWcPeUY1UJ05p+5arDcK9UmMsr
         XvHq65jQVOVI8LdeOwVU/2SzVR6ooahjRcctxJP6CQ3uxEDlK7pWEDZD51G3WnN61JqG
         G9giazd2ph1Fv9iJyF54ds8Xaf0gm3Wa7NaF/4VTKO2L8bUlI3Ba4fevMNCU8nrQlY1U
         ogiOwPNABcZNoI7+Iu2rQ7O+jkng6A7cDBlN8ikiN6wsvh/8ihELW97FmyrNEmWqEBh/
         8ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cACyB2KNmobopctUHQpdd+tFeJQNIy3DwPag/D99BI4=;
        b=sZOCjUg+YtMU70gmtCp/gagM5HKPjGxY0Httui3VCLXrL+q4kRBRVM7Htax0wzxTPr
         tSPUoHxjFVv9j+TloGKrg91ngum+QUhP0HEACUAleOY7vLqSYEwGduxba8Citb/qB8bj
         WW0s1kZNZlCoOOrMd0GdiEPdyCCXO4SuSs7y/UreKgHDb+KUAgDM6ny4NEZ8z0OE/fdo
         I02lyNRHPASY3NJ42Bxh54WP76ewM4Vnyl58Yml3WqIEqNGDufqHu9tQ3HWB1OpDf8La
         5edhm9I02WduTQ2pXZfwoFa/OyWISkrN1/OcdSRpjVUbXXqgJAxSg1BNc4IDPaZwFUy8
         b2Wg==
X-Gm-Message-State: AOAM530qo5MIV3kP3lPOVyu3jDNImgyZhpplLY+VrUJeFDuYQ71cq1Kp
        qwrDuQ952nFqhR/cY167wMs0ZQ==
X-Google-Smtp-Source: ABdhPJw4zQjdlK+KBXiDNyxJmxQ6RnD5VnrMcW7DsB40E2sjHmmPOSmG/b3SK8QiSq6hl+feTjkw8w==
X-Received: by 2002:a5d:6e87:0:b0:206:452:5b87 with SMTP id k7-20020a5d6e87000000b0020604525b87mr19200557wrz.473.1649537502193;
        Sat, 09 Apr 2022 13:51:42 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:4dc6:8d6a:4095:700e])
        by smtp.gmail.com with ESMTPSA id t4-20020adfe104000000b00205b50f04f0sm22223279wrz.86.2022.04.09.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 13:51:41 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.18-rc2
Date:   Sat,  9 Apr 2022 22:51:34 +0200
Message-Id: <20220409205134.13070-1-brgl@bgdev.pl>
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

Here's a single fix for a race condition between the GPIO core and consumers of
GPIO IRQ chips.

Please pull,
Bartosz Golaszewski

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.18-rc2

for you to fetch changes up to 5467801f1fcbdc46bc7298a84dbf3ca1ff2a7320:

  gpio: Restrict usage of GPIO chip irq members before initialization (2022-04-04 14:41:34 +0200)

----------------------------------------------------------------
gpio fixes for v5.18-rc2

- fix a race condition with consumers accessing the fields of GPIO IRQ chips
  before they're fully initialized

----------------------------------------------------------------
Shreeya Patel (1):
      gpio: Restrict usage of GPIO chip irq members before initialization

 drivers/gpio/gpiolib.c      | 19 +++++++++++++++++++
 include/linux/gpio/driver.h |  9 +++++++++
 2 files changed, 28 insertions(+)
