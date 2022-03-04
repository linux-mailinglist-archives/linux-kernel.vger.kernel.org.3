Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC92C4CCDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238111AbiCDGUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbiCDGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:20:44 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69810B3;
        Thu,  3 Mar 2022 22:19:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so6860238pfl.0;
        Thu, 03 Mar 2022 22:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=slYJJjZa65wV0213u3JkKCTRFOm7CYIZQlf8tisrtTQ=;
        b=eieDXLJeJlqE6jh6acTrj0VCE7gowsIMnnSDJhQb922bG7ACg86lK7opi4oEc7rpoP
         llT3R8nUcf/eLCYV0EZgYRkVp4Ax9HPRY8fIluRlock8c9J1Yc4rAERSGRwuUAyn3/de
         FlOjW/ly36pHznk4bKJ7Gp6s2ezP1Q7MJGqG0WfBdh7f9Q9YE0iQYgb8qbYCho3cTDxx
         N+Lrn/VbX8CP+Tr442oyAY2ErD1K/4es4hM/FgZKqXL/2p4C2qhvcSdCvc0ga3SsEYcb
         D1Z4/H03SaPI8UNhz2sV/rD4rQydEUQFmIJX6x98+lNnqmvLwAhXBmBL8Ak3r0tM7p0e
         WWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=slYJJjZa65wV0213u3JkKCTRFOm7CYIZQlf8tisrtTQ=;
        b=JoD0MN8eu91wq8wlOSeN86JOBmwiF1a0AsjyBc/Viz0M7da0Mq+VsBrQ7ky4tG9p9l
         m+re4YzcigLcus5rA+c7KmAgHqJ8IsYiczfUmQ4AM9DtVFK4I8mqG6HWG8SwtyOISAyF
         SsE1oyQ/mFLePoHnoT2yL90lgH3ansWrwj3ZX/O0YZLziJ3OxKoVGgep/F+H1UCUvgHy
         b8jBRWbkfAxogYvYW4T1k0iHjEz35T6nMkfaJUoPWhiMtczBoFxiBRaztOZ4YMDAxgn8
         +ucco71+jgEu0Skag2hGUmcrTpF5Z/9vaAg79ZzISPLmwrNUDYGhkkNdBBuLH4SPSVR/
         xtCQ==
X-Gm-Message-State: AOAM530nFtv7zY2dE9MWU/LYhsURmHBGrLXNzOJwYYjg5YyDQKfen5/j
        KXbTm6kfMRRPcEuqYHdMKUU=
X-Google-Smtp-Source: ABdhPJxAZETKa7Os6w5VOrlGWaC0W7sM/a3XTCj00mriKSYu5grJWBvqD+g9NY5kHeDDbqs1q2xlvQ==
X-Received: by 2002:a05:6a00:8d3:b0:4f6:76a1:4890 with SMTP id s19-20020a056a0008d300b004f676a14890mr5568086pfu.55.1646374797062;
        Thu, 03 Mar 2022 22:19:57 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id kb6-20020a17090ae7c600b001bee8664d82sm8749471pjb.35.2022.03.03.22.19.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Mar 2022 22:19:56 -0800 (PST)
From:   Hammer Hsieh <hammerh0314@gmail.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, robh+dt@kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, hammer.hsieh@sunplus.com,
        Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH v2 0/2] Add PWM driver for Suplus SP7021 SoC
Date:   Fri,  4 Mar 2022 14:20:10 +0800
Message-Id: <1646374812-2988-1-git-send-email-hammerh0314@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for PWM driver for Suplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART. I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Hammer Hsieh (2):
  dt-bindings:pwm:Add bindings doc for Sunplus SoC PWM Driver
  pwm:sunplus-pwm:Add Sunplus SoC PWM Driver

 .../devicetree/bindings/pwm/pwm-sunplus.yaml       |  40 ++++
 MAINTAINERS                                        |   6 +
 drivers/pwm/Kconfig                                |  11 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sunplus.c                          | 229 +++++++++++++++++++++
 5 files changed, 287 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunplus.yaml
 create mode 100644 drivers/pwm/pwm-sunplus.c

-- 
2.7.4

