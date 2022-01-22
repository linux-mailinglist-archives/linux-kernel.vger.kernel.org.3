Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460994969EA
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 04:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbiAVDy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 22:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiAVDy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 22:54:56 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0FFC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:56 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d15-20020a17090a110f00b001b4e7d27474so10752422pja.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 19:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssu5g04UQjA/IU3u2iGLonkbxXssqKTt/cYNXXqSILs=;
        b=MsKqCPpbPeFBFL7DlTbUSZO3GrCH87yMw7PDog8TQdHqsi5o7ydOfUVfWyBlsq1VI4
         t6hrYVV6a1nEPZKwyFKpT6cT43zyI4YPgZV5wkJnNuN/atPRUH6XLI81/6UYC/dwnaGL
         0MaA4t4stcBHJaqKAF9U6u9eHY3QkPobhTbYrnivep9PDFwOazl2W5IrN/nBdIF1AQGa
         xAlUI4AQBq/BrcK4cz/Wdizj2Qqe9FEQtNZF9w9gdbOt7+BKm/2yXj8cB+mJm3f38Oe0
         WEFfwDTEmU//2QofyYiKAYGEIR5Rgoex85BdHFCrRrtUE3KbpFQb0OSL8AwW4J7ryv2D
         l5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ssu5g04UQjA/IU3u2iGLonkbxXssqKTt/cYNXXqSILs=;
        b=efJqGH3WjMJplDLCSRpbV/oxjv7H/8BZiKT/reUOzMtL5DSh2+0L2nIXTw0Z7Ajlri
         YTfFfzOUsmrXiDawqhYykeojN6uI1N3oCeAlx+LdSFogIhvVW//+MSwjDW0Rt+OFA1hA
         Bt3Ucy6yfBdPbQ71OGwAWn0DaMvBPjjUCHXGQVgAJne4bXy2iR2PSyQzSmgbLZMtmCUu
         piRQIQWVIyL98BtpOajQ3EOx0Cm4uGt10upwvkbWziLvB146DBAoRggS5bTXGfSV3dD5
         vvAAeoaddyXeGwNVEBmaKtZNbj4RiYFAsZM8PPXYFhnE0z1UPQCqGT+fxYgg6ynkALwA
         nBKg==
X-Gm-Message-State: AOAM533kRYGBIbNCjPFMrXigflCOhTrtSVkjnQBnLsLMFSeUZc1e1jQk
        kCuniVfwrrA0q/J6bkqoWkw=
X-Google-Smtp-Source: ABdhPJzwcNqAt3Qy1dja+I/0LzUyTnd84NbKHFPc0DwpkXevZWLsQuv3mRuz+gOILmB1HlBL135lzg==
X-Received: by 2002:a17:902:7603:b0:148:daa7:ed7e with SMTP id k3-20020a170902760300b00148daa7ed7emr6199490pll.150.1642823695941;
        Fri, 21 Jan 2022 19:54:55 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a1sm667255pjm.1.2022.01.21.19.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 19:54:55 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/4] Broadcom STB PM PSCI extensions
Date:   Fri, 21 Jan 2022 19:54:17 -0800
Message-Id: <20220122035421.4086618-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series contains the Broadcom STB PSCI extensions which adds
some additional functions on top of the existing standard PSCI interface
which is the reason for having the driver implement a custom
suspend_ops.

These platforms have traditionally supported a mode that is akin to
ACPI's S2 with the CPU in WFI and all of the chip being clock gated
which is entered with "echo standby > /sys/power/state". Additional a
true suspend to DRAM as defined in ACPI by S3 is implemented with "echo
mem > /sys/power/state".

These platforms also may have an external Broadcom PMIC chip which can
cause the SoC to be powercycled assuming that we communicate that intent
via a vendor specific PSCI SYSTEM_RESET2.

Since it is desirable to get any new functionality added to the kernel
to be loadable as a module as part of shipping said products in a Google
Kernel Image (GKI) environment, we need to export a couple of symbols from
drivers/firmware/psci/psci.c.

Thanks for your feedback.

Florian Fainelli (4):
  firmware: psci: Export a couple of suspend symbols
  soc: bcm: brcmstb: Make legacy PM code depend on !ARM_PSCI_FW
  soc: bcm: brcmstb: Added support for PSCI system suspend operations
  Documentation: ABI: Document Broadcom STB PSCI firmware files

 .../ABI/testing/sysfs-firmware-brcmstb        |  16 +
 drivers/firmware/psci/psci.c                  |   9 +-
 drivers/soc/bcm/brcmstb/Kconfig               |   4 +-
 drivers/soc/bcm/brcmstb/pm/Makefile           |   3 +
 drivers/soc/bcm/brcmstb/pm/pm-psci.c          | 315 ++++++++++++++++++
 include/linux/psci.h                          |   2 +
 include/linux/soc/brcmstb/brcmstb-smccc.h     |  84 +++++
 7 files changed, 430 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-brcmstb
 create mode 100644 drivers/soc/bcm/brcmstb/pm/pm-psci.c
 create mode 100644 include/linux/soc/brcmstb/brcmstb-smccc.h

-- 
2.25.1

