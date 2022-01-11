Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863DA48BA00
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 22:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245616AbiAKVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 16:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbiAKVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 16:54:20 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F7CC06173F;
        Tue, 11 Jan 2022 13:54:20 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id h4so810868qth.11;
        Tue, 11 Jan 2022 13:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9soPHD2iWMuBaxqS0P8Wb7tdZ1W/Iv2iXvfYHF2vO4U=;
        b=Htv9QaycmIrZyYLvrW4T/C6D63rMwP1n8e82pkZpviv/g9EwzlhwUeerJpyxEV7Cwq
         gY/Vx1F/fLOXtYV2+22FBbO80f64Xs/vddJJMeo74buxCH/G4t/3QvGs2SRgd/zAw8Mp
         DsPFIvQYWieJe725LVyKqnl8X6XFQZE9BllQYTREu6VrdtwvcLsCR7zm6XObd+h9b+Nk
         4r9RcAEgv0dl94VTVYbF9WD6nOWH9gnr+YZbalDbVZW2xKGOn+ASYp4z4sopPdQC27bA
         f2djyfqE8g6qedEQQiUGlEpf0mO8qaOGj/PJZYYl3SlRx12OBpON1twRmSd+sKtrGpne
         BUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9soPHD2iWMuBaxqS0P8Wb7tdZ1W/Iv2iXvfYHF2vO4U=;
        b=Y6lMBvomkUOsD+cI3g0/T2rcJRTUe/lnX9Ni9ONlA/91yP7r0g8KOkEh1EvrvH3s0r
         fDpqnXDBMmHlMl+WkPNtuVAML4UJdJwjRfvhBp/iAs3MmX2+RHGtiJNuDQBMedFfl/1/
         3191AWssnLsB+T+kaH8f3kKeQ2TaZ61UZDSZdWEgh8S+iuy3JdnlKzaQ4ViLTik9EPRv
         7+Z2Vxduz0JtGeIJfRBWF+TNUNmAHZtTAwpatb+ulbaut6Wdm60sIhSv8k9ueE+JF3cr
         9EIekWw2iCYHJeODdjXC4VPsKjcjK/kt1DHU+0r7SA5Vizt0pVPS2dc4EiOFx2lU5UUE
         0YIw==
X-Gm-Message-State: AOAM5317AFYjfzbGXurihK0mvPNGD9JN/2urTMlPnL+NDfxl2qYwccEN
        hymNJpkGHJG9kPDQMRhXvN8=
X-Google-Smtp-Source: ABdhPJzXFeAeJpTU5SuG9ktkmcmd438xUMesQQPIy15zS8fEnSjLRVJFkPy40jVDlmRx6CAHemm6WQ==
X-Received: by 2002:a05:622a:92:: with SMTP id o18mr5461722qtw.570.1641938059341;
        Tue, 11 Jan 2022 13:54:19 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l10sm7591020qtk.18.2022.01.11.13.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:54:19 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v8 0/7] Add initial support for the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
Date:   Tue, 11 Jan 2022 16:54:08 -0500
Message-Id: <20220111215415.2075257-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
References: <20220111212606.2072669-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains:
- i.MXRT10xx family infrastructure
- i.MXRT1050 pinctrl driver adaption
- i.MXRT1050 clock driver adaption
- i.MXRT1050 sd-card driver adaption
- i.MXRT1050 uart driver adaption
- i.MXRT1050-evk basic support

The i.MXRTxxxx family that could have support by Linux actually spreads
from i.MXRT1020 to i.MXRT1170 with the first one supporting 1 USB OTG &
100M ethernet with a cortex-M7@500Mhz up to the latter with i.MXRT1170
with cortex-M7@1Ghz and cortex-M4@400Mhz, 2MB of internal SRAM, 2D GPU,
2x 1Gb and 1x 100Mb ENET. The i.MXRT family is NXP's answer to
STM32F7XX, as it uses only simple SDRAM, it gives the chance of a 4 or
less layer PCBs. Seeing that these chips are comparable to the
STM32F7XXs which have linux ported to them it seems reasonable to add
support for them.

Giving Linux support to this family should ease the development process,
instead of using a RTOS they could use Embedded Linux allowing for more
portability, ease of design and will broaden the scope of people using
embedded linux.

The EVK has very little SDRAM, generally 32MB starting from
i.MXRT1020(the lowest P/N), although the i.MXRT1160/70 provide instead
64MB of SDRAM for more functionality.

At the moment we do not support XIP for either u-boot or Linux but it
should be done in the future. XIP will also save SDRAM.

Another interesting fact is the amount of internal SRAM, as the P/N
increases the SRAM will reach up to 2MB(some could be for cache and
some would be for video).

Also, some parts have embed flash of 4MB that can be used for
u-boot/Linux, if both correctly sized it will leave the SDRAM free.

External flash can be Quad SPI and HyperFlash, so throughput would be
decent.

The i.MXRT11xx series supports MIPI interface too.

The family in general provide CAN bus, audio I/O, 1 or more
USB(otg/host), 1 or more 100Mb/1Gb ethernet, camera interface, sd-card.

All this can be used for simple GUIs, web-servers, point-of-sale
stations, etc.


Giulio Benetti (4):
  ARM: imx: Add initial support for i.MXRT10xx family
  dt-bindings: imx: Add clock binding for i.MXRT1050
  ARM: dts: imx: Add i.MXRT1050-EVK support
  ARM: imxrt_defconfig: Add i.MXRT family defconfig

Jesse Taube (3):
  ARM: dts: imxrt1050-pinfunc: Add pinctrl binding header
  dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
  clk: imx: Add initial support for i.MXRT1050 clock driver

 .../bindings/clock/imxrt1050-clock.yaml       |  67 ++
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imxrt1050-evk.dts           |  72 ++
 arch/arm/boot/dts/imxrt1050-pinfunc.h         | 993 ++++++++++++++++++
 arch/arm/boot/dts/imxrt1050.dtsi              | 160 +++
 arch/arm/configs/imxrt_defconfig              |  35 +
 arch/arm/mach-imx/Kconfig                     |   7 +
 arch/arm/mach-imx/Makefile                    |   2 +
 arch/arm/mach-imx/mach-imxrt.c                |  19 +
 drivers/clk/imx/Kconfig                       |   7 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imxrt1050.c               | 168 +++
 include/dt-bindings/clock/imxrt1050-clock.h   |  72 ++
 13 files changed, 1605 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1050-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1050-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1050.dtsi
 create mode 100644 arch/arm/configs/imxrt_defconfig
 create mode 100644 arch/arm/mach-imx/mach-imxrt.c
 create mode 100644 drivers/clk/imx/clk-imxrt1050.c
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h

-- 
2.34.1

