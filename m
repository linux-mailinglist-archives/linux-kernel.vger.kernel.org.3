Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F215E4C4FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiBYUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiBYUmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:42:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437142177E8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:42:07 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j22so6119765wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmSYa3kkJ/ViPa9xmpfA0cWei7k8n4ZCOH7gEssAD/I=;
        b=EGk7/LDlXcRBEnL/ciXk8b6dZE+SwmeKuZyRM51k9wovsnq2pgZ2Q1eSm9WlPDgLju
         cRN2w6KZVLyeXBYOar9Xz2aUxVaJxlqaMQzhi5usHRRoUlcvKQolgf8gC/pY8hgt9jag
         JIedgUI6aIsL3t9JfHcYGiAyNyjxKZ4xgqzV+w8vF03ze8CJBfFvOYzoOVgOS3Ux2p4e
         XB6KcgZqtVP4kZvOJy1dBrxiPMh92R/Z93Y0QUpAvKrGAAUbmauJLlK4IwkFA7XTfDV/
         7KikjjM8axTlqCVf/idIwlunEUiJPtmJNpobcVK0znOnPgyKn9H2KP+zSrPPtOXeNZ1P
         F3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CmSYa3kkJ/ViPa9xmpfA0cWei7k8n4ZCOH7gEssAD/I=;
        b=hkNRzfWaj/Wk3a5FcGd/9YUecrBXcfCQplOYymrB8wkmtVrWq2TNQ+V5F5TNxTYr1u
         Nw5xYtWR2WBI4oYA59k7kYn+5ojELURUi8WMEusDUVKJhXlLFn+UiTq40Nv7de8bqVAw
         DQ6ds9/+PZ+cheHdX406oQTxT4HXOoPIRwznwTVVmAPeHH/eszeHPQOUfAWWCQmLMxa8
         +kbLPDuWrflp59NwVoaQtDqt1XVpZrzjpYycOiHMIGakatvDA+KitwPTaSl+8pFhFb7V
         ovQD2KqyEY++YNZXggh9/yTbKWLxAq2yHlqCIY4P91Hytfxr+v3lDBit8druVtsySl1T
         yqUg==
X-Gm-Message-State: AOAM531okTC5jMY0s81ysH78+ghCIemOZsuYU9ptYSbLbl+ssGK2KUg5
        l/SqoQ9OSCMSBlmKnN5JTaA6ecj2LZ1YoQ==
X-Google-Smtp-Source: ABdhPJzR6KQ8n+yaCjgQutAdmLIinpHWmtD2vyqj+2z2MYnh4tl2xMFLcWengEbUfhc948/YVE7zug==
X-Received: by 2002:a05:6000:8b:b0:1ee:1c9d:92a0 with SMTP id m11-20020a056000008b00b001ee1c9d92a0mr6352426wrx.677.1645821725706;
        Fri, 25 Feb 2022 12:42:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm960201wms.38.2022.02.25.12.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:42:05 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.17-rc6
Date:   Fri, 25 Feb 2022 21:42:02 +0100
Message-Id: <20220225204202.53415-1-brgl@bgdev.pl>
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

Please pull the following two fixes for the next release cycle.

Best Regards,
Bartosz Golaszewski

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.17-rc6

for you to fetch changes up to ae42f9288846353982e2eab181fb41e7fd8bf60f:

  gpio: Return EPROBE_DEFER if gc->to_irq is NULL (2022-02-23 22:30:56 +0100)

----------------------------------------------------------------
gpio: fixes for v5.17-rc6

- fix an bug generating spurious interrupts in gpio-rockchip
- fix a race condition in gpiod_to_irq() called by GPIO consumers

----------------------------------------------------------------
Samuel Holland (1):
      gpio: rockchip: Reset int_bothedge when changing trigger

Shreeya Patel (1):
      gpio: Return EPROBE_DEFER if gc->to_irq is NULL

 drivers/gpio/gpio-rockchip.c | 56 +++++++++++++++++++++++---------------------
 drivers/gpio/gpiolib.c       | 10 ++++++++
 2 files changed, 39 insertions(+), 27 deletions(-)
