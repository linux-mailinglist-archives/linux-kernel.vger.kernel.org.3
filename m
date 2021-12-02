Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0293646626D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346396AbhLBLkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357384AbhLBLk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:40:26 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA07C061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:37:01 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z6so20032441plk.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIMj35mEWO+wOa2JAV2FSBiJWvqdeYjn+C6j99cMUwA=;
        b=ODbgq4DT3+FpiLJMLcZUy7tM6hNCNhupWr/6pDcDcHJYdTdQcHvK+KrcHxN2SEt9Bq
         EGtuhfyBa9YT8EssQb/uTVf045C4fYYvM2X3J4J9jkz36YzGYdlByg8zVqicQEPcM5Ul
         LIUpWYe5rW8vhDJz0GlvaYVWvJ8UX0ihuYCYgWEnU6z5UbPk6+It43qsaOPlO4s6SYPQ
         DcQK5CpR1whoY/eza7+C0RJB5DKDaUgKm8ESPhhPmKDolBsmoBdWu+hMsfHErWDW5oPI
         0ujZ9ujxMSzHdXC7SsTmVCS7U0wyKHf+bRIMsom2WXXkyYheE/CT6WdbKQvNqKtyHkuC
         akfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SIMj35mEWO+wOa2JAV2FSBiJWvqdeYjn+C6j99cMUwA=;
        b=NwrYHnGRUHF2p3pjVx0SczmKneO2wk4dmsFf9HcG5nENhD8gRjX3208cqoaeD1prFr
         JlSX1XhXgXxlnRU+oU9X6fgXnXnNk5rEcVB0YxY/K0y8YjAVS20tpxnGXDDjDrTf4oyX
         /nJQb1D1Fh2dmGlWPlMlDH8LnNnbUYetArEi55mJFUz0Y41ymAlE/vlAcqPzX+8OrVjb
         FjN8M+ioQWwKtCVKKelzNJgfE6hHxBkmoqQmwVTBVA8q7aDMCABEgb4JfNRyP3L/NeLv
         QQcCIWJESpOHdvyoccJB0CnJLUdfWOFYI/VMhx57dxNqNwa+ruHiWQD98CDQJxnUT8MX
         a/Dw==
X-Gm-Message-State: AOAM5304tQV6yWC69ELa9Vsxn95az0W0arJjcxPFfJmF4kasjsB4C2ba
        VZm8//cmYdHyUJZbJbtPKZa/
X-Google-Smtp-Source: ABdhPJwJu+G43NQKUCMzIjjZs9DXBHyWTuwZQzFOBAXtqVyrDTeyEpn25tt4B2ScX3xzQQUMruCrDA==
X-Received: by 2002:a17:90a:af94:: with SMTP id w20mr5225019pjq.223.1638445020603;
        Thu, 02 Dec 2021 03:37:00 -0800 (PST)
Received: from localhost.localdomain ([117.202.184.5])
        by smtp.gmail.com with ESMTPSA id h5sm3602552pfi.46.2021.12.02.03.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 03:36:59 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 00/20] Add initial support for MHI endpoint stack
Date:   Thu,  2 Dec 2021 17:05:32 +0530
Message-Id: <20211202113553.238011-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for the Qualcomm specific Modem Host Interface
(MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
communicates with the MHI bus in host machines like x86 over any physical bus
like PCIe for data connectivity. The MHI host support is already in mainline [1]
and been used by PCIe based modems and WLAN devices running vendor code
(downstream).

Overview
========

This series aims at adding the MHI support in the endpoint devices with the goal
of getting data connectivity using the mainline kernel running on the modems.
Modems here refer to the combination of an APPS processor (Cortex A grade) and
a baseband processor (DSP). The MHI bus is located in the APPS processor and it
transfers data packets from the baseband processor to the host machine.

The MHI Endpoint (MHI EP) stack proposed here is inspired by the downstream
code written by Qualcomm. But the complete stack is mostly re-written to adapt
to the "bus" framework and made it modular so that it can work with the upstream
subsystems like "PCI Endpoint". The code structure of the MHI endpoint stack
follows the MHI host stack to maintain uniformity.

With this initial MHI EP stack (along with few other drivers), we can establish
the network interface between host and endpoint over the MHI software channels
(IP_SW0) and can do things like IP forwarding, SSH, etc...

Stack Organization
==================

The MHI EP stack has the concept of controller and device drivers as like the
MHI host stack. The MHI EP controller driver can be a PCI Endpoint Function
driver and the MHI device driver can be a MHI EP Networking driver or QRTR
driver. The MHI EP controller driver is tied to the PCI Endpoint subsystem and
handles all bus related activities like mapping the host memory, raising IRQ,
passing link specific events etc... The MHI EP networking driver is tied to the
Networking stack and handles all networking related activities like
sending/receiving the SKBs from netdev, statistics collection etc...

This series only contains the MHI EP code, whereas the PCIe EPF driver and MHI
EP Networking drivers are not yet submitted and can be found here [2]. Though
the MHI EP stack doesn't have the build time dependency, it cannot function
without them.

Test setup
==========

This series has been tested on Telit FN980 TLB board powered by Qualcomm SDX55
(a.k.a X55 modem) interfaced to the 96Boards Poplar board (ARM64 host) over
PCIe.

Limitations
===========

We are not _yet_ there to get the data packets from the modem as that involves
the Qualcomm IP Accelerator (IPA) integration with MHI endpoint stack. But we
are planning to add support for it in the coming days.

References
==========

MHI bus: https://www.kernel.org/doc/html/latest/mhi/mhi.html
Linaro connect presentation around this topic: https://connect.linaro.org/resources/lvc21f/lvc21f-222/

Thanks,
Mani

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi
[2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-sdx55-drivers

Manivannan Sadhasivam (20):
  bus: mhi: Move host MHI code to "host" directory
  bus: mhi: Move common MHI definitions out of host directory
  bus: mhi: Make mhi_state_str[] array static const and move to common.h
  bus: mhi: Cleanup the register definitions used in headers
  bus: mhi: ep: Add support for registering MHI endpoint controllers
  bus: mhi: ep: Add support for registering MHI endpoint client drivers
  bus: mhi: ep: Add support for creating and destroying MHI EP devices
  bus: mhi: ep: Add support for managing MMIO registers
  bus: mhi: ep: Add support for ring management
  bus: mhi: ep: Add support for sending events to the host
  bus: mhi: ep: Add support for managing MHI state machine
  bus: mhi: ep: Add support for processing MHI endpoint interrupts
  bus: mhi: ep: Add support for powering up the MHI endpoint stack
  bus: mhi: ep: Add support for powering down the MHI endpoint stack
  bus: mhi: ep: Add support for handling MHI_RESET
  bus: mhi: ep: Add support for handling SYS_ERR condition
  bus: mhi: ep: Add support for processing command and TRE rings
  bus: mhi: ep: Add support for queueing SKBs over MHI bus
  bus: mhi: ep: Add support for suspending and resuming channels
  bus: mhi: ep: Add uevent support for module autoloading

 drivers/bus/Makefile                      |    2 +-
 drivers/bus/mhi/Kconfig                   |   28 +-
 drivers/bus/mhi/Makefile                  |    9 +-
 drivers/bus/mhi/common.h                  |  284 ++++
 drivers/bus/mhi/ep/Kconfig                |   10 +
 drivers/bus/mhi/ep/Makefile               |    2 +
 drivers/bus/mhi/ep/internal.h             |  237 +++
 drivers/bus/mhi/ep/main.c                 | 1674 +++++++++++++++++++++
 drivers/bus/mhi/ep/mmio.c                 |  303 ++++
 drivers/bus/mhi/ep/ring.c                 |  316 ++++
 drivers/bus/mhi/ep/sm.c                   |  181 +++
 drivers/bus/mhi/host/Kconfig              |   31 +
 drivers/bus/mhi/{core => host}/Makefile   |    4 +-
 drivers/bus/mhi/{core => host}/boot.c     |    0
 drivers/bus/mhi/{core => host}/debugfs.c  |    0
 drivers/bus/mhi/{core => host}/init.c     |   12 -
 drivers/bus/mhi/{core => host}/internal.h |  436 ++----
 drivers/bus/mhi/{core => host}/main.c     |    0
 drivers/bus/mhi/{ => host}/pci_generic.c  |    0
 drivers/bus/mhi/{core => host}/pm.c       |    0
 include/linux/mhi_ep.h                    |  289 ++++
 include/linux/mod_devicetable.h           |    2 +
 scripts/mod/file2alias.c                  |   10 +
 23 files changed, 3448 insertions(+), 382 deletions(-)
 create mode 100644 drivers/bus/mhi/common.h
 create mode 100644 drivers/bus/mhi/ep/Kconfig
 create mode 100644 drivers/bus/mhi/ep/Makefile
 create mode 100644 drivers/bus/mhi/ep/internal.h
 create mode 100644 drivers/bus/mhi/ep/main.c
 create mode 100644 drivers/bus/mhi/ep/mmio.c
 create mode 100644 drivers/bus/mhi/ep/ring.c
 create mode 100644 drivers/bus/mhi/ep/sm.c
 create mode 100644 drivers/bus/mhi/host/Kconfig
 rename drivers/bus/mhi/{core => host}/Makefile (54%)
 rename drivers/bus/mhi/{core => host}/boot.c (100%)
 rename drivers/bus/mhi/{core => host}/debugfs.c (100%)
 rename drivers/bus/mhi/{core => host}/init.c (99%)
 rename drivers/bus/mhi/{core => host}/internal.h (51%)
 rename drivers/bus/mhi/{core => host}/main.c (100%)
 rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
 rename drivers/bus/mhi/{core => host}/pm.c (100%)
 create mode 100644 include/linux/mhi_ep.h

-- 
2.25.1

