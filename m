Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843654AEEE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 11:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbiBIKF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 05:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiBIKFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 05:05:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9849CDF498BD
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:05:23 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d9-20020a17090a498900b001b8bb1d00e7so1741536pjh.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 02:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sq37MaYZovWHPQWKVIdOZC1Re8Lf/1V40i2xFH2uM5w=;
        b=L06DCW/1L1RTvIloDsyXiioyZvOnwFkLRWfC/WzeWwSIgc/RjJPcnraGbS/OJqt1wY
         qbeytg9m9kUqkZWjfbJccoc3f/Mg/QsEGzX0JrSC67AhU5ClSEgiBib/8D3h4bVUmcCz
         Eg7i4v/DAH7Vtu0y/PfvelK4kgk/JoGNudaNkCsLB8mPfwJzYFRCr/k9pkXliUOIA8Ct
         RbHGnAAVn4L8BazWS3Q7WzkMflz9KL42PWlHlJQ97X6n+Qidmkq/remFmG+axqPYJBHr
         jp00eL3qGKrfHqpCf1ZmaVg3Wn/jJEZvgiAjetj2aWcNjhkl7KdpTtrmywQETn0M2VHL
         jFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sq37MaYZovWHPQWKVIdOZC1Re8Lf/1V40i2xFH2uM5w=;
        b=MC/cvEQMA14P7q4V4RBGinJRBR1vqM8GJm09AMxsx2eb5RWtZMXaSUXMkc/eUKS4Fe
         F7TDZzr95yE18IFXzSAl51Qs31aoJoqVGk7Ue201XRsS9VJiaAkoSjGT1jsw3rhDlzkM
         2BgPMZO7rOMzpFFavz7rNLlnyU3WhUKsUEJ6EySPATptfdcQj7I6TGZPH/EfDcuSj9/h
         PIlHC+4i4Ga00AsJ2CYrEQiQWIID2pB3ojDixhTLqE/18zz+RSyp0tpLXBwRHgJMUbx2
         I/nE3HOoTm90bc5UxQlY4L+IJqRGEaSygq+aAnSoP1LxMAzquv7L7z0vrmO3GAfr1no/
         hRew==
X-Gm-Message-State: AOAM530YZhc9effTogUHqHsPRr4KBRvROyX5toOERlQ/FTVhgpTwy85i
        IuiS+ysJt9t+gSHavv+xeCcA
X-Google-Smtp-Source: ABdhPJwQSCYyz/Zdd1DwVYmbf9xfpx0/LXjSkKmDWuVrn3LDVwDmDRehJV7Sf8wTkZLhyKtwCCjVmg==
X-Received: by 2002:a17:90b:351:: with SMTP id fh17mr2610719pjb.28.1644401106499;
        Wed, 09 Feb 2022 02:05:06 -0800 (PST)
Received: from localhost.localdomain ([117.217.179.178])
        by smtp.gmail.com with ESMTPSA id p2sm6722024pfo.125.2022.02.09.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 02:05:06 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        vbadigan@codeaurora.org, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 00/23] Add initial support for MHI endpoint stack
Date:   Wed,  9 Feb 2022 15:26:01 +0530
Message-Id: <20220209095624.26389-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for the Qualcomm specific Modem Host Interface
(MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
communicates with the MHI bus in host machines like x86 over any physical bus
like PCIe. The MHI host support is already in mainline [1] and been used by PCIe
based modems and WLAN devices running vendor code (downstream).

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
(a.k.a X55 modem) and Qualcomm SM8450 based dev board.

For testing the stability and performance, networking tools such as iperf, ssh
and ping are used.

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

Changes in v2:

v2 mostly addresses the issues seen while testing the stack on SM8450 that is a
SMP platform and also incorporates the review comments from Alex.

Major changes are:

* Added a cleanup patch for getting rid of SHIFT macros and used the bitfield
  operations.
* Added the endianess patches that were submitted to MHI list and used the
  endianess conversion in EP patches also.
* Added support for multiple event rings.
* Fixed the MSI generation based on the event ring index.
* Fixed the doorbell list handling by making use of list splice and not locking
  the entire list manipulation.
* Added new APIs for wrapping the reading and writing to host memory (Dmitry).
* Optimized the read_channel and queue_skb function logics.
* Added Hemant's R-o-b tag.

Manivannan Sadhasivam (21):
  bus: mhi: Move host MHI code to "host" directory
  bus: mhi: Move common MHI definitions out of host directory
  bus: mhi: Make mhi_state_str[] array static inline and move to
    common.h
  bus: mhi: Cleanup the register definitions used in headers
  bus: mhi: Get rid of SHIFT macros and use bitfield operations
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

Paul Davey (2):
  bus: mhi: Fix pm_state conversion to string
  bus: mhi: Fix MHI DMA structure endianness

 drivers/bus/Makefile                      |    2 +-
 drivers/bus/mhi/Kconfig                   |   28 +-
 drivers/bus/mhi/Makefile                  |    9 +-
 drivers/bus/mhi/common.h                  |  319 ++++
 drivers/bus/mhi/ep/Kconfig                |   10 +
 drivers/bus/mhi/ep/Makefile               |    2 +
 drivers/bus/mhi/ep/internal.h             |  254 ++++
 drivers/bus/mhi/ep/main.c                 | 1602 +++++++++++++++++++++
 drivers/bus/mhi/ep/mmio.c                 |  274 ++++
 drivers/bus/mhi/ep/ring.c                 |  267 ++++
 drivers/bus/mhi/ep/sm.c                   |  174 +++
 drivers/bus/mhi/host/Kconfig              |   31 +
 drivers/bus/mhi/{core => host}/Makefile   |    4 +-
 drivers/bus/mhi/{core => host}/boot.c     |   17 +-
 drivers/bus/mhi/{core => host}/debugfs.c  |   40 +-
 drivers/bus/mhi/{core => host}/init.c     |  124 +-
 drivers/bus/mhi/{core => host}/internal.h |  427 +-----
 drivers/bus/mhi/{core => host}/main.c     |   46 +-
 drivers/bus/mhi/{ => host}/pci_generic.c  |    0
 drivers/bus/mhi/{core => host}/pm.c       |   36 +-
 include/linux/mhi_ep.h                    |  293 ++++
 include/linux/mod_devicetable.h           |    2 +
 scripts/mod/file2alias.c                  |   10 +
 23 files changed, 3443 insertions(+), 528 deletions(-)
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
 rename drivers/bus/mhi/{core => host}/boot.c (96%)
 rename drivers/bus/mhi/{core => host}/debugfs.c (90%)
 rename drivers/bus/mhi/{core => host}/init.c (93%)
 rename drivers/bus/mhi/{core => host}/internal.h (50%)
 rename drivers/bus/mhi/{core => host}/main.c (98%)
 rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
 rename drivers/bus/mhi/{core => host}/pm.c (97%)
 create mode 100644 include/linux/mhi_ep.h

-- 
2.25.1

