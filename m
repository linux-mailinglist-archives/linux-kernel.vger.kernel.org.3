Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBC4B371D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbiBLSVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:21:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiBLSVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:21:46 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6939453B56
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:21:42 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id u12so7229253plf.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNJouDFC9SDFBdiALXK3vF3U2LCfEq9tgM00VfZjezI=;
        b=qlS3W6Yfd1EKX+tTPjscR96Uge7Cd2o+tv+0w7wn8IO6AyAly1qvv61AMsnjTKvHgk
         FFjkuasTcBV8g9ZpoMUT2W4rEQCJN0MfGobrTCwUc38Zm6oBSZBq9U3m329XJWfdzgQo
         P9wEYk7OQfnNJ4QNlTDmHHBfLU2lmiVGW/l7SICINPln5KS2wnEYyNklxycf0y621i9V
         OObEC2dSI5cnz2cW4InWJ/nbjbh5MQqA1UhsIjdzHAuYd4cv9vxSZHJc7NDSDEl4Udwf
         K7bmIwD/CDZvZTxuce92cn2+dgAbetknocHJ3oWhDnQolmeLHpImhJkexAsZjUAANUYY
         T+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sNJouDFC9SDFBdiALXK3vF3U2LCfEq9tgM00VfZjezI=;
        b=oiynEaN/LsFxjqWEflNfZwIbyJa4/soKtme9zc9a1Q24ERmj5aKs+Ut+LzEvnkJo4+
         XI6VTl89ptnz8mPz9B2t2OGYPqVqlKZVX5T5TMST2hfcuoFd9w/hVVxOtr2H6cDHX+ak
         TyhzzssjLlBpRBDrEn3ZNCbjfC4uCcW1yG3Ed8FizrYzu+JFrpKbtgNDE0yIobaPxeIA
         V+O8yekckL4jsdrFShugFN4zT+XNTdim5otKvUmPwwABh4EHzvWr8E6Hy14dCnFj8cf/
         uHmCyYM5SRT5GeeAvyx5R8cCC5g2E8ckch5BkhSNnDRxPbfmeM5dtAfi3C9+0yfHHSG5
         +rBg==
X-Gm-Message-State: AOAM5305b+q6kb8yCkRPDryUNfrC/60Gs41DwtzzsHnAN1VCJUJulT0j
        R5Xs0wO5GBizWaUfKUk1PbUf
X-Google-Smtp-Source: ABdhPJxsr/pGGmSiWyM7KxkHsvgEXr4O05DL13LtmYjGc6YvZF/8LDBlImtlCCOOdp1XZN0hqCu4qA==
X-Received: by 2002:a17:902:eb8c:: with SMTP id q12mr7008607plg.131.1644690101772;
        Sat, 12 Feb 2022 10:21:41 -0800 (PST)
Received: from localhost.localdomain ([27.111.75.57])
        by smtp.gmail.com with ESMTPSA id g12sm14961987pfj.148.2022.02.12.10.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:21:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 00/25] Add initial support for MHI endpoint stack
Date:   Sat, 12 Feb 2022 23:50:52 +0530
Message-Id: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
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

Manivannan Sadhasivam (23):
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
  bus: mhi: ep: Add support for processing command ring
  bus: mhi: ep: Add support for reading from the host
  bus: mhi: ep: Add support for processing transfer ring
  bus: mhi: ep: Add support for queueing SKBs to the host
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
 drivers/bus/mhi/ep/main.c                 | 1601 +++++++++++++++++++++
 drivers/bus/mhi/ep/mmio.c                 |  274 ++++
 drivers/bus/mhi/ep/ring.c                 |  267 ++++
 drivers/bus/mhi/ep/sm.c                   |  174 +++
 drivers/bus/mhi/host/Kconfig              |   31 +
 drivers/bus/mhi/{core => host}/Makefile   |    4 +-
 drivers/bus/mhi/{core => host}/boot.c     |   17 +-
 drivers/bus/mhi/{core => host}/debugfs.c  |   40 +-
 drivers/bus/mhi/{core => host}/init.c     |  123 +-
 drivers/bus/mhi/{core => host}/internal.h |  427 +-----
 drivers/bus/mhi/{core => host}/main.c     |   46 +-
 drivers/bus/mhi/{ => host}/pci_generic.c  |    0
 drivers/bus/mhi/{core => host}/pm.c       |   36 +-
 include/linux/mhi_ep.h                    |  293 ++++
 include/linux/mod_devicetable.h           |    2 +
 scripts/mod/file2alias.c                  |   10 +
 23 files changed, 3442 insertions(+), 527 deletions(-)
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

