Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6698048E29C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiANCqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236066AbiANCqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:46:18 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03356C061574;
        Thu, 13 Jan 2022 18:46:18 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id y16-20020a17090a6c9000b001b13ffaa625so20726284pjj.2;
        Thu, 13 Jan 2022 18:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3WL0Jp4JOJF6QanZ+FIOpBGRLoyKcJ9OjZ4QgrGTi+c=;
        b=OPxiRGrvmLyTaojVUsMgiwbPvtC/kQLaBa0UohF1KKo32PLDX55OJyPSFYXhiygU7p
         EFFQ4/n2O6CzlunjBjuFvOuDhmP8Ei4B2CRTF5VzSbusuCcH0aiviPMdR8sN5PxkIoXe
         uNI/jpRdFMY/hbCN8sk1H1K+/2izzdEMNJgpz3tWYAIMu4XyZm8R8uRcbaRnJZSyOf7f
         m41SmzgEt4J20RbaOnfDUfoxPnaUKfBAz8l96OWHkx2ROlGYh/e1NJ1V9H9RxNMDYswL
         dHur1q5a1l8yYVHssz4T1c7HfqBUiMkABd3hhdyWRq3VL52dBCrKe3+tgmZhSmy0mXD0
         D7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WL0Jp4JOJF6QanZ+FIOpBGRLoyKcJ9OjZ4QgrGTi+c=;
        b=eoDi22wXIOwLqiT68YslIZJcEySLIF4bW2tPp1ac26YxKYBRYHnmWJHRhKTOD3kCDv
         DjgHC4GESjftNyJm9nCyVc0TsZ1dMGli82Tj8pMAKhDjapvdw2lsrGVax/XmyNP1TkJy
         savDW1OWllcVOXMzXHwNVFyUOo3vVdFb4dph3xbIQzzWUgAY+ArTtagraru6XQNDQ2kL
         FPBs4HiqfyfzRW0a4o8Fo5P+DSxzI9iXUk1dE8al5dU2ozJgLyy6NO6J7CVHSHMT5G+T
         ZggiyxvsR/J+Krv8oJqBruMOehJBFZE6j2lVw/SA9ezo1gMGkKjGDiEFSayZvaC+4BBO
         nM/g==
X-Gm-Message-State: AOAM5307fNO0X3kiaM6zLQMZBoKHOsCaIW9HPk8OxTOBye+JfmgWOzcu
        +hZs6986mQOvOBxVG2w+FUs=
X-Google-Smtp-Source: ABdhPJxLP6DWPxUFiiKgkT5fyu1Kc+F9otg05yThJOVH/NipaD3J2oV2j7I525UZCWeUedZahFh7Jg==
X-Received: by 2002:a17:902:d505:b0:14a:77ac:1e8b with SMTP id b5-20020a170902d50500b0014a77ac1e8bmr7204254plg.1.1642128377275;
        Thu, 13 Jan 2022 18:46:17 -0800 (PST)
Received: from scdiu3.sunplus.com ([113.196.136.192])
        by smtp.googlemail.com with ESMTPSA id u11sm3939149pfi.10.2022.01.13.18.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jan 2022 18:46:17 -0800 (PST)
From:   Li-hao Kuo <lhjeff911@gmail.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com,
        Li-hao Kuo <lhjeff911@gmail.com>
Subject: [PATCH v4 0/2] Add thermal control driver for Sunplus SP7021 SoC
Date:   Fri, 14 Jan 2022 10:46:25 +0800
Message-Id: <cover.1642127137.git.lhjeff911@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch series for thermal driver for Sunplus SP7021 SoC.

Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates
many peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and
etc.) into a single chip. It is designed for industrial control.

Refer to:
https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
https://tibbo.com/store/plus1.html

Li-hao Kuo (2):
  thermal: Add thermal driver for Sunplus SP7021
  dt-bindings:thermal: Add Sunplus SP7021 schema

 .../bindings/thermal/sunplus_thermal.yaml          |  49 +++++++
 MAINTAINERS                                        |   7 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/sunplus_thermal.c                  | 157 +++++++++++++++++++++
 5 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sunplus_thermal.yaml
 create mode 100644 drivers/thermal/sunplus_thermal.c

-- 
2.7.4

