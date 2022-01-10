Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3133848A009
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 20:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbiAJTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 14:20:12 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:42797 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 14:20:11 -0500
Received: by mail-qk1-f176.google.com with SMTP id r139so16011377qke.9;
        Mon, 10 Jan 2022 11:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jUoXBd6z9wk2qe8u5czH7CyiQQ+GhCQjBmZrqwoF4XU=;
        b=p3HwsmwRxxEMzGjz9M54ctxGTAlt0cexLNc66wu44wyNMn8cetSEyM2L0drVulUL8c
         f1JjSo1Wthq11BBdva5gI34JEi9ym3mlL+7B/7eVMn//olSHTdP2O9PVC06+Cbwd691M
         H+tsFLbkfBIkl0KNehg/NkHZuJU5kjJ3nLHAJmT9ByjtdwJGao228W7IEWwATaI4WI4x
         dAtIBg8UP25Ld8kyzvL0YsNuhx58wkafzcBOwYcncW4RvOpTSZ2GQjdhjvaWezde3C0I
         FHyaLKaUhwhC8P97KSkecsGRrrnWcejvZDraSlFPE5EQMnmGL4pKOnFSRK/s/84gBpeQ
         bZxw==
X-Gm-Message-State: AOAM533+Pj9vjSqoUgB3YngB9n1VEsp/Rp1Cb7Ujp4UA/KeabDVaSEk3
        DBHI8Eag0bJ6yvvTmZhSF7x03ron7PkWCZqoPiCrWltT0a4=
X-Google-Smtp-Source: ABdhPJxe2HhGRJK0Qtq+8L2smLhXaYFNGLLQS7atQO8Wp9gtytLpd7FVdrCSal4rUN5h+cXbioSf+ir8ebknuoWsXtE=
X-Received: by 2002:a37:b702:: with SMTP id h2mr887819qkf.135.1641842410354;
 Mon, 10 Jan 2022 11:20:10 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jan 2022 20:19:59 +0100
Message-ID: <CAJZ5v0ipPn6up69zcR9RAS-=pPFwjpmEri680jgh8EtOP_A1+g@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v5.17-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-5.17-rc1

with top-most commit fff489ff0722bec127a05667bec00ea45cf9f77e

 Merge branch 'thermal-int340x'

on top of commit f872f73601b92c86f3da8bdf3e19abd0f1780eb9

 thermal: int340x: Fix VCoRefLow MMIO bit offset for TGL

to receive thermal control updates for 5.17-rc1.

These add a new driver for Renesas RZ/G2L TSU, update a few existing
thermal control drivers and clean up the tmon utility.

Specifics:

 - Add new TSU driver and DT bindings for the Renesas RZ/G2L platform
   (Biju Das).

 - Fix missing check when calling reset_control_deassert() in the
   rz2gl thermal driver (Biju Das).

 - In preparation for FORTIFY_SOURCE performing compile-time and
   run-time field bounds checking for memcpy(), avoid intentionally
   writing across neighboring fields in the int340x thermal control
   driver (Kees Cook).

 - Fix RFIM mailbox write commands handling in the int340x thermal
   control driver (Sumeet Pawnikar).

 - Fix PM issue occurring in the iMX thermal control driver during
   suspend/resume by implementing PM runtime support in it (Oleksij
   Rempel).

 - Add 'const' annotation to thermal_cooling_ops in the Intel
   powerclamp driver (Rikard Falkeborn).

 - Fix missing ADC bit set in the iMX8MP thermal driver to enable the
   sensor (Paul Gerber).

 - Drop unused local variable definition from tmon (ran jianping).

Thanks!


---------------

Biju Das (3):
      dt-bindings: thermal: Document Renesas RZ/G2L TSU
      thermal/drivers: Add TSU driver for RZ/G2L
      thermal/drivers/rz2gl: Add error check for reset_control_deassert()

Kees Cook (1):
      thermal: int340x: Use struct_group() for memcpy() region

Oleksij Rempel (1):
      thermal/drivers/imx: Implement runtime PM support

Paul Gerber (1):
      thermal/drivers/imx8mm: Enable ADC when enabling monitor

Rikard Falkeborn (1):
      thermal/drivers/intel_powerclamp: Constify static
thermal_cooling_device_ops

Sumeet Pawnikar (1):
      thermal/drivers/int340x: Fix RFIM mailbox write commands

ran jianping (1):
      thermal: tools: tmon: remove unneeded local variable

---------------

 .../devicetree/bindings/thermal/rzg2l-thermal.yaml |  76 +++++++
 drivers/thermal/Kconfig                            |   9 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/imx8mm_thermal.c                   |   3 +
 drivers/thermal/imx_thermal.c                      | 145 +++++++-----
 .../intel/int340x_thermal/acpi_thermal_rel.c       |   5 +-
 .../intel/int340x_thermal/acpi_thermal_rel.h       |  48 ++--
 .../int340x_thermal/processor_thermal_device.h     |   3 +-
 .../intel/int340x_thermal/processor_thermal_mbox.c | 100 +++++----
 .../intel/int340x_thermal/processor_thermal_rfim.c |  23 +-
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/thermal/rzg2l_thermal.c                    | 242 +++++++++++++++++++++
 tools/thermal/tmon/pid.c                           |   3 +-
 13 files changed, 526 insertions(+), 134 deletions(-)
