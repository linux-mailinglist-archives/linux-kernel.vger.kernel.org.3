Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637C4C6CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236601AbiB1Moo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbiB1Mof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:44:35 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0872546B1F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:43:57 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u16so11023015pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jD1phax98UJcXV+Cv3FDbMAtH0P4W4DpNusHGjo2btE=;
        b=hXCLIv+AYqZHsRWPB3o1M732OqgGYyBuuhQtNFLtJNe2NjrpA2ApYEoOBd23mEPp39
         fDKH1PYs1FBcWt8nI4OGcjkk4qIeQK28EB7wEmJcHH/An+qOmAiaAtC7WjYMoQxymg1M
         n2jRI171Kp6Rcp5JhPis/9hqMyZt1WBYdPUgOBnzqUX+uofLMU4pqkqn7pDHaDJ6CVqy
         OUVZEbvJOIPnqBOVUpTQAjpSiz+seCjPR/VixXAUI5oSp1bzNRjHjCoVh6wN4FKgl3ad
         WgSs/YvBFl2Db0q0Rd0mVgVP92rmJtPwhyIzOSHJDeU98rzaas4LS/0XPL2ctzOnuLXX
         GhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jD1phax98UJcXV+Cv3FDbMAtH0P4W4DpNusHGjo2btE=;
        b=c6qPl3IE6iE41uG4PbUk91r2HE5COeIjDJjHCoA1/D/V1q19ycgreOPX9kDjAFv1wn
         6Cad4ZQEh9M80UW9mKIq0UNfM5VWhVkjp7IDuohKffvjsOURYou2G0G8hhp62le1zRDP
         Vv9YKiNwJFmi5m/Wc7iTiSB0Gue6l6EHUhXbaKxYWQRfx29JIdfIakHIAWPPJHKpjHLA
         dKJf8nmJZIterocu6Ze+zIveUChQ0VXSUDUfcA+oQep5XRpKCROMpU9W9pqKOpNo3vmW
         R0E9fWADtOd2uxlWBuxslK0cfFyU0tPeJpKwW+rTJd9AH1DkkFHktqa3tMISMZ/mnA/q
         lRtQ==
X-Gm-Message-State: AOAM531nNLYLSMwqREYJ2E3yiQ5U5Rsr2kU6Is2vha/CU7BeS+3lwNHa
        3IoIwZuy5eH3DNw8OTKqVwnm
X-Google-Smtp-Source: ABdhPJwr1lOE00uxSdPsRm09kPG1wmM9WecZHnBggeV72LxP/LVc4w8ONwUyKvLx+r74DSaIdXbzvg==
X-Received: by 2002:a05:6a00:10d0:b0:4e1:7504:25c7 with SMTP id d16-20020a056a0010d000b004e1750425c7mr21419683pfu.77.1646052236371;
        Mon, 28 Feb 2022 04:43:56 -0800 (PST)
Received: from localhost.localdomain ([117.207.25.37])
        by smtp.gmail.com with ESMTPSA id y12-20020a056a00190c00b004f39e28fb87sm14256737pfi.98.2022.02.28.04.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:43:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 00/27] Add initial support for MHI endpoint stack
Date:   Mon, 28 Feb 2022 18:13:17 +0530
Message-Id: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes in v4:

* Collected reviews from Hemant and Alex.
* Removed the A7 suffix from register names and functions.
* Added a couple of cleanup patches.
* Reworked the mhi_ep_queue_skb() API.
* Switched to separate workers for command and transfer rings.
* Used a common workqueue for state and ring management.
* Reworked the channel ring management.
* Other misc changes as per review from Alex.

Changes in v3:

* Splitted the patch 20/23 into two.
* Fixed the error handling in patch 21/23.
* Removed spurious change in patch 01/23.
* Added check for xfer callbacks in client driver probe.

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

Manivannan Sadhasivam (25):
  bus: mhi: Move host MHI code to "host" directory
  bus: mhi: Use bitfield operations for register read and write
  bus: mhi: Use bitfield operations for handling DWORDs of ring elements
  bus: mhi: Cleanup the register definitions used in headers
  bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"
  bus: mhi: Move common MHI definitions out of host directory
  bus: mhi: Make mhi_state_str[] array static inline and move to
    common.h
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
  bus: mhi: ep: Add support for processing command rings
  bus: mhi: ep: Add support for reading from the host
  bus: mhi: ep: Add support for processing channel rings
  bus: mhi: ep: Add support for queueing SKBs to the host
  bus: mhi: ep: Add support for suspending and resuming channels
  bus: mhi: ep: Add uevent support for module autoloading

Paul Davey (2):
  bus: mhi: Fix pm_state conversion to string
  bus: mhi: Fix MHI DMA structure endianness

 drivers/bus/Makefile                     |    2 +-
 drivers/bus/mhi/Kconfig                  |   28 +-
 drivers/bus/mhi/Makefile                 |    9 +-
 drivers/bus/mhi/common.h                 |  326 +++++
 drivers/bus/mhi/core/internal.h          |  722 ----------
 drivers/bus/mhi/ep/Kconfig               |   10 +
 drivers/bus/mhi/ep/Makefile              |    2 +
 drivers/bus/mhi/ep/internal.h            |  222 +++
 drivers/bus/mhi/ep/main.c                | 1623 ++++++++++++++++++++++
 drivers/bus/mhi/ep/mmio.c                |  272 ++++
 drivers/bus/mhi/ep/ring.c                |  197 +++
 drivers/bus/mhi/ep/sm.c                  |  148 ++
 drivers/bus/mhi/host/Kconfig             |   31 +
 drivers/bus/mhi/{core => host}/Makefile  |    4 +-
 drivers/bus/mhi/{core => host}/boot.c    |   17 +-
 drivers/bus/mhi/{core => host}/debugfs.c |   40 +-
 drivers/bus/mhi/{core => host}/init.c    |  131 +-
 drivers/bus/mhi/host/internal.h          |  382 +++++
 drivers/bus/mhi/{core => host}/main.c    |   66 +-
 drivers/bus/mhi/{ => host}/pci_generic.c |    0
 drivers/bus/mhi/{core => host}/pm.c      |   36 +-
 include/linux/mhi_ep.h                   |  284 ++++
 include/linux/mod_devicetable.h          |    2 +
 scripts/mod/file2alias.c                 |   10 +
 24 files changed, 3649 insertions(+), 915 deletions(-)
 create mode 100644 drivers/bus/mhi/common.h
 delete mode 100644 drivers/bus/mhi/core/internal.h
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
 rename drivers/bus/mhi/{core => host}/init.c (92%)
 create mode 100644 drivers/bus/mhi/host/internal.h
 rename drivers/bus/mhi/{core => host}/main.c (97%)
 rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
 rename drivers/bus/mhi/{core => host}/pm.c (97%)
 create mode 100644 include/linux/mhi_ep.h

-- 
2.25.1

