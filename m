Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C04B26CE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350429AbiBKNIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 08:08:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiBKNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 08:08:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F6F43
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:08:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id m14so15116107wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 05:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+k2v7vnbgMhSaU57JWk13mn9hMYpBDkI2h6mlnSApw=;
        b=QCTfdGUKhNUL0g7+17DFABMk2Fal7ltvf/O5v7hKbvy6X0h4rvk81T2fhM0dCeVdGM
         IleZArGD5lA5+3npeBX2yf0qzrPnAfO4g2w+hKsxcexcyJrHcejkY2cXi+8961MWn/XX
         PJsT78uUZWuDP2vguIbVyWb+nCgWq48iOUaF9SDQiFtrobnLTfZmjAKofAIAAgnn2+CM
         /Cjpyy2Ol3tgdFyC7+NC16AlWNLmiLhoQaH0jmsOkpWh82GGlH2vTqwZYySUPS7o/2Mx
         mVZBVA/j+dkhEgqvf63Y58L2JUzWZm6A1bv6T5QpmJ0crzuBRQtIGTqLDOp3wlyn/m0J
         og+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I+k2v7vnbgMhSaU57JWk13mn9hMYpBDkI2h6mlnSApw=;
        b=raX+dFQ6WwmP1YXVPd1Oz1cM5ZhTsTOUUUnAkZoTXk8/Wa6w4JzheeDIPa4bXQZgwa
         I255qySGyPaOTxTo2JYN2kvfcXBGKAmigtmiClSc9Es6TSYBk+k+Rq8Na8QILA/7JfI5
         MCANvS6fqrwlxIO2FbU/4q0BITcooifyEr3ZEp6mLdmPYMicvGHsj8dlhk/ypRMcpK2r
         2YQVxfyMA+MMY0OKxQGAFkK6fwvTmCry0HGyDokZZj8Oi2nv/ODmjXzTHgRMgvHWIzEg
         4kY6G0C6SI/ajPQ7Knea18hksc0RhnH3BxdHjbgXwNDG2p6nMzfyhP5aJoiF/UmHeYr+
         o+pg==
X-Gm-Message-State: AOAM530zvZ4/oLuZfZqveRQOvZM3dnyuiEz7GLc95IIp4SjJETb+0sGT
        kYvubeM1WKXiIjbQMQ6vxrvQuA==
X-Google-Smtp-Source: ABdhPJyNGbjyagJVMCs0GpGGHe8iuMQr/P3hbA5LSCnv1B0i+lUtSDpTvOEX0k/zAOETavkpDQBdmA==
X-Received: by 2002:adf:e886:: with SMTP id d6mr1433078wrm.656.1644584884979;
        Fri, 11 Feb 2022 05:08:04 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id p27sm4161351wms.39.2022.02.11.05.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 05:08:04 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.17-rc4
Date:   Fri, 11 Feb 2022 14:08:01 +0100
Message-Id: <20220211130801.280029-1-brgl@bgdev.pl>
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

Please pull the following set of fixes from the GPIO subsystem for the next
release candidate.

Best Regards,
Bartosz Golaszewski

The following changes since commit 26291c54e111ff6ba87a164d85d4a4e134b7315c:

  Linux 5.17-rc2 (2022-01-30 15:37:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc4

for you to fetch changes up to c162ca0bcbfb39308c4dff4157e27c751af7032a:

  gpio: sim: fix hogs with custom chip labels (2022-02-09 11:41:29 +0100)

----------------------------------------------------------------
gpio fixes for v5.17-rc4

- use sleeping variants of GPIO accessors where needed in gpio-aggregator
- never return kernel's internal error codes to user-space in gpiolib core
- use the correct register for reading output values in gpio-sifive
- fix line hogging in gpio-sim

----------------------------------------------------------------
Andy Shevchenko (1):
      gpiolib: Never return internal error codes to user space

Bartosz Golaszewski (1):
      gpio: sim: fix hogs with custom chip labels

Geert Uytterhoeven (1):
      gpio: aggregator: Fix calling into sleeping GPIO controllers

Niklas Cassel (1):
      gpio: sifive: use the correct register to read output values

 drivers/gpio/gpio-aggregator.c | 18 ++++++++++++++----
 drivers/gpio/gpio-sifive.c     |  2 +-
 drivers/gpio/gpio-sim.c        | 19 +++++++++++++++----
 drivers/gpio/gpiolib-cdev.c    |  6 +++---
 drivers/gpio/gpiolib-sysfs.c   |  7 ++-----
 drivers/gpio/gpiolib.h         | 12 ++++++++++++
 6 files changed, 47 insertions(+), 17 deletions(-)
