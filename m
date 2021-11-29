Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7F8461637
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 14:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhK2N2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377765AbhK2N0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 08:26:17 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D328C06139C
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:06:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j3so36286013wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 04:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r7u55d5JFnfFp6c/l6+nGa0Vwea0Zs3QOYstLDbBOQE=;
        b=GqN4pz3d2akzrhB/wOpvEkqg0lrRA2BduIUlJcSf134toz9VcvGLDEQbSKbnBAxg6q
         ucm7GFf7GjZ0/wkhfcSFsbY9mDNOBFyaPcN5HSXrnhPTT8iYUQ3U63Gg6HDEQMgodpEV
         PJKnIrS7djYC3jRgglQK77Lz6UGck9xl7iqmrK/AVhHbv6owZJC1RgeFK2oom96kGFcL
         YPgzt4qLPzxHg+EIwVyN4h4hVdUVsMFRzCPcmBV8MWqT/7lJth4V+kYJ73Hv6Bqd/MJB
         E+UDLak0kJMGFsypAKv5JnsGHo99KKujfupKzhZ8fRvkmu6xLyiOKhpnGeHqMCMYmD0K
         2HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r7u55d5JFnfFp6c/l6+nGa0Vwea0Zs3QOYstLDbBOQE=;
        b=VqT5v55e7fOqJCRr9GTCAQbawfWq6wvxlHFuuBkw59u89y6n2kl4JzZd4CwopTu/vd
         9ODQgpYtqKjUKUTJ08uUVUC24U8dJnl9S9EnAUSld0gd+yOgKxiinyo+bTG2sPjhEHYE
         svLIkN86B1eqDMxwXT1Lw7fQfZDfA6xtwXvkM6b2MAmT+EB4z3VXXYZkbaOvZdDK0+YY
         HpP4rD6/oR2khqgpDElquYCd3d3idxMkMr3VRgoUf1B0aeZGCQve7YQcHRbBjIZUpW/4
         QzXnnei1qA7242mE4R1LrwBiJbaZjYo+vhxhtu2e/Y0SABBSwIi6Eh59dE8a4MuKv7mB
         U0LQ==
X-Gm-Message-State: AOAM530UW7mJ0vP1JsVLeN3BfRmfDr/2eshufh9AZpyYg+V0v53Fo/1C
        lrXYKUX5PkDWGqyuUdcSAKdzMQ==
X-Google-Smtp-Source: ABdhPJyoYmVDmT0HI/4DD7ZamTD1t+mvV0dDgv9H58nQ+0B5Q1G+PNFO3zmG1ovl+ETorG/37YAcQg==
X-Received: by 2002:adf:f1cc:: with SMTP id z12mr24941616wro.395.1638187562744;
        Mon, 29 Nov 2021 04:06:02 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id f7sm16389698wri.74.2021.11.29.04.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 04:06:02 -0800 (PST)
Date:   Mon, 29 Nov 2021 12:06:00 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        lukas.bulwahn@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [GIT PULL] Immutable branch between MFD, GPIO and Regulator due for
 the v5.17 merge window
Message-ID: <YaTCKHGd8MHQ/BaF@google.com>
References: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1637066805.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-regulator-v5.17

for you to fetch changes up to 2f746ea6e6a9036b2f33d80d776ac2464f4cea18:

  MAINTAINERS: bd70528: Drop ROHM BD70528 drivers (2021-11-29 12:04:32 +0000)

----------------------------------------------------------------
Immutable branch between MFD, GPIO and Regulator due for the v5.17 merge window

----------------------------------------------------------------
Matti Vaittinen (4):
      dt-bindings: mfd: regulator: Drop BD70528 support
      gpio: bd70528 Drop BD70528 support
      mfd: bd70528: Drop BD70528 support
      MAINTAINERS: bd70528: Drop ROHM BD70528 drivers

 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt            | 102 ---------
 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt |  68 ------
 MAINTAINERS                                                            |   8 -
 drivers/gpio/Kconfig                                                   |  11 -
 drivers/gpio/Makefile                                                  |   1 -
 drivers/gpio/gpio-bd70528.c                                            | 230 --------------------
 drivers/mfd/Kconfig                                                    |  17 --
 drivers/mfd/Makefile                                                   |   1 -
 drivers/mfd/rohm-bd70528.c                                             | 314 ---------------------------
 include/linux/mfd/rohm-bd70528.h                                       | 389 ----------------------------------
 include/linux/mfd/rohm-generic.h                                       |   1 -
 11 files changed, 1142 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
 delete mode 100644 drivers/gpio/gpio-bd70528.c
 delete mode 100644 drivers/mfd/rohm-bd70528.c
 delete mode 100644 include/linux/mfd/rohm-bd70528.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
