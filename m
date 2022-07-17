Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC75774FA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 09:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiGQHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGQHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 03:36:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E065E1A39E
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:36:07 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so12672694wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 00:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7w9i54EGf9yZrZAfY6N7mI7xz0lXHUja3CmKUzTVCns=;
        b=VhunYHCAjPP2T+WTf1ZP44QgKs4Zf60fq5Kr4dY1/6NRwJEuV7fVU1o39vmfbIsErz
         NyKDs6qFdEpp2tY504xEi43zIcEi8K+0r8OjP/xTEhPr4d+n6Nl7PfGKw092uCUr9pAH
         IeRZWeVCxBGXn3RYz9gNwdVTa/hYsmZQgiIB+mXTeRQ0nLmRXmzNjUq8KgI5HYNSQEC3
         XfygVJ4U/zb8BlVJEEIeM+5/rhnM6gBl4ppPNLIuh8UQbQ8tT2Lwk+cQxxoEHfGw2RV/
         xeyudrp1uixo0vQkzitKKY4FRDB46/djmWaGHv+MwB29DA0QKux8TcXL7mWLJM14P4Dx
         mGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7w9i54EGf9yZrZAfY6N7mI7xz0lXHUja3CmKUzTVCns=;
        b=iT2ngMDk/ZdnkD8eOKXf2P0fjSD9HrBnEVnOkSn9jL5r6kqhrCiDet553BemjUoiKn
         wOEDJC7SrReCbRYz4WBx9M7YjMmDZG/RKqyiiAVoqOFP4oWADrl9EE/tliYB5yVnmfrM
         ypOTaOM2F92xU3qy5pKwlQUmZnY30OKCcOShaxFFOA+zSZLUwJLzrAGeH4q4amIKfVNV
         fKHYH1sj6TKaEyf4TlKFIMxleTW3vifKqYa4mjtQj+3sMdKBDEnTo7/fKPrqQk4Kzypk
         u0l5QlPICUU7ZQm7yrAgFuKXFokXkotDWUkFesbRScABRUyGKexsGuyR+lEd+8Kh3ZjS
         aVRA==
X-Gm-Message-State: AJIora+tc4KyaeucxR25vJwmiTORGVXLLlgOz6FjhEeJ3lm9rseU21Gz
        E50tQoJvYJtEKrLMUf2Zo6xC5w==
X-Google-Smtp-Source: AGRyM1sX6tuRJLMH9vemB/T67Mb7se6fqe4Qy4Xq4gSW4x6bij0QVnr4gIHOAs09sq+PKtv5QGLstA==
X-Received: by 2002:adf:ea50:0:b0:21d:6547:1154 with SMTP id j16-20020adfea50000000b0021d65471154mr17676760wrn.186.1658043366393;
        Sun, 17 Jul 2022 00:36:06 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:6051:99a2:ab7f:63ce])
        by smtp.gmail.com with ESMTPSA id i16-20020a5d5230000000b0021d9d13bf6csm7653757wra.97.2022.07.17.00.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 00:36:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.19-rc7
Date:   Sun, 17 Jul 2022 09:36:02 +0200
Message-Id: <20220717073602.4801-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the following fix for the gpio simulator for the next rc.

Thanks!
Bartosz Golaszewski

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v5.19-rc7

for you to fetch changes up to 7329b071729645e243b6207e76bca2f4951c991b:

  gpio: sim: fix the chip_name configfs item (2022-07-12 13:41:25 +0200)

----------------------------------------------------------------
gpio fixes for v5.19-rc7

- fix a configfs attribute of the gpio-sim module

----------------------------------------------------------------
Bartosz Golaszewski (1):
      gpio: sim: fix the chip_name configfs item

 drivers/gpio/gpio-sim.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)
