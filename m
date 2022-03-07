Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941E84D02D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbiCGP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbiCGP2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:28:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD9630D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:27:33 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e24so10904805wrc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jaYKUyHTSA7NJB35LAiYvBbaB9ao0d9w011LT+nuUm4=;
        b=I24QTCqFvFoh7ihUG6Nrnh0U6I7FrXodb2oPjmTPrG+TsmBEC5V9FhCJxfr9cWkIKO
         1T/clYRnUgJeytYtdBqRLwJJrcK9Br37wh8lLef8hEECFb9WIg25klf374BTbpusGGyG
         qLcMl3eEcA9SZpaT06fqSQ+3ZrAmK0QSVknTvss1FNBLeIsLSH+hWapV+mOqWPVwz+g0
         NjPm9suyQf2EfBx1u95grF7ENkM3KMXv9Wh5UEjPdPgJcX4zZcpzWsA64q7eALo98dbu
         XbvYMPSWfiviEflexKrFN3iJKtnoCuOyc4NfQs0x7+RYuyTo8rVqOyNlANSUyg5x5RKz
         vMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jaYKUyHTSA7NJB35LAiYvBbaB9ao0d9w011LT+nuUm4=;
        b=7BVLWKCVAGyKl/KxPoQ4fjSHNkDquOSB5Vl5dmGUmi9Etqv5atCYYQBp7q9Z13Jf2d
         1ar9x2cP0tiJT7Nc5m4MCBEqEiyi/5J9e2wAbzVo/rBD4L6hspa1k+sYYo1SV0FOeonG
         HBH0vdaDR9Eo2KhrbELE4T5MhVg6yhTSom32IrWkptOl1bWyUFOmRJHF8Xc1haMhzCVO
         LwN0jPanfLOTeuiaRS6lD+7FFHcaNz8JDjJJI14l5xh8Vv+aizjfS2rgegpc2e6OVixn
         WQoxM1W7TNJssVyKd2cRoctbXaZp3pc/N7sWp6lcAwEMcmgXWqFNWIeK+3yT4VS4ekMl
         DQuA==
X-Gm-Message-State: AOAM5334VRHGSD5nkna/9tz1fOZyeKfsYY2ggNwdGztE7Cm0CY6ahd37
        hYKg/0NfO3FeiNud+iBLtYDapA==
X-Google-Smtp-Source: ABdhPJwxDd5egt0DySXxFusLdNc/Aj/TuHpfZ+WsZIIHRSt4kpBS45As0tN5J1pfwjSW3/ajE3hgXA==
X-Received: by 2002:a05:6000:1446:b0:1e9:e378:71c5 with SMTP id v6-20020a056000144600b001e9e37871c5mr8561036wrx.128.1646666851656;
        Mon, 07 Mar 2022 07:27:31 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k12-20020adfb34c000000b001f1e13df54dsm6210417wrd.89.2022.03.07.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:27:31 -0800 (PST)
Date:   Mon, 7 Mar 2022 15:27:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, RTC and Watchdog due for
 the v5.18 merge window
Message-ID: <YiYkYZjGsRIeklfh@google.com>
References: <20220223175908.191618-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220223175908.191618-1-luca@lucaceresoli.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-rtc-watchdog-v5.18

for you to fetch changes up to c58e496311a50c087eeeaaae81083cd643fe5128:

  rtc: max77686: Add MAX77714 support (2022-03-07 13:55:04 +0000)

----------------------------------------------------------------
Immutable branch between MFD, RTC and Watchdog due for the v5.18 merge window

----------------------------------------------------------------
Luca Ceresoli (8):
      rtc: max77686: Convert comments to kernel-doc format
      rtc: max77686: Rename day-of-month defines
      rtc: max77686: Remove unused code to read in 12-hour mode
      dt-bindings: mfd: Add Maxim MAX77714 PMIC
      mfd: max77714: Add driver for Maxim MAX77714 PMIC
      watchdog: max77620: Add support for the max77714 variant
      watchdog: max77620: Add comment to clarify set_timeout procedure
      rtc: max77686: Add MAX77714 support

 .../devicetree/bindings/mfd/maxim,max77714.yaml    |  68 +++++++++
 MAINTAINERS                                        |   7 +
 drivers/mfd/Kconfig                                |  14 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77686.c                             |   2 +-
 drivers/mfd/max77714.c                             | 152 +++++++++++++++++++++
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/rtc-max77686.c                         |  75 ++++++----
 drivers/watchdog/Kconfig                           |   2 +-
 drivers/watchdog/max77620_wdt.c                    |  85 +++++++++---
 include/linux/mfd/max77686-private.h               |   4 +-
 include/linux/mfd/max77714.h                       |  60 ++++++++
 12 files changed, 421 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 create mode 100644 drivers/mfd/max77714.c
 create mode 100644 include/linux/mfd/max77714.h

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
