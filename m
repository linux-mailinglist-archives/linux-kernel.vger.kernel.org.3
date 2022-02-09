Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858054AF235
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiBIM7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBIM7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:59:53 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F8C05CB96
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 04:59:56 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w1so2127254plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w3Ln6Ucnpi92OfXLrf4hwooYop/MioxN2/8qo7NAJ0Y=;
        b=HwyVuYtnz3dS0pvXs6lcx6WUzK8pL3MCFQYbm3W04SVFtMV3smXsCp3+F627iDxYoA
         xTDBnIvNpSmFVz0GGGdpGFM3WJxOLtddnSkZ2NCj+Mb8+LZ/mJDDtYC8hMyxlh/83L/L
         UjZkkrfKk15gXzC8Fkv4Npu0MUNg1xIr4Nhsds5idqxFGZE01x87sgMv+JBFocsOoj83
         OJNre6CI8ka4QFBGsqYzMuvoXd+CM+SQkLhjpDMFKgzLADbHMRurZWCOH4PTAOu17CSM
         bdn4544FAi6Wavq4gCsFHYpCKIXfIN1rylXgj+a8JI+LvRzdIF++0qI8jZVKWqFH+YH7
         Fl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w3Ln6Ucnpi92OfXLrf4hwooYop/MioxN2/8qo7NAJ0Y=;
        b=4cZlWjICtHtsEPjcZhTx+QQnpTIXEcrrVtuyOf0aCGqSbn6Adn+uzOSXqL7ZnWNlUj
         dAkrSVblZRBRSvazHM+jTzupFEHOEUsA+r+ZvVca3H3QiqKZBgn6hLb9tK52rAOMuHg0
         6l40QYDm07fkDWcyVsndOhy+BSgI/oRTk4XliRtnDqDVCZtXXMq63PSPm6V+2yRFwKoO
         F3RT6do8hIG/MszLquAeBDEb7MuL4v1sYSt/StyF2Yddtb4sR0pfBpeWaacZCttz1MuO
         76NivIMljNa6KbnQgEaXZEJS/o1sXDvfCFAAXd7QJ62VszkNbO6YgPHKyAF1q2r3DvVk
         lpIA==
X-Gm-Message-State: AOAM533vq4/lTUdYua0Ad2QnAIFOqCrWE38Y7C6byl8beJdVTzVKW9uN
        /yUhlsVRozCR/OuX/ZZktiZo93g4gWjh79g=
X-Google-Smtp-Source: ABdhPJw9Dn4Pq9tPyNXXG/X3Hw4PfWtyX7Ozck5q9fVIrx8mBtrx68UtJwn9Os+8qsVObhkW1+A2Fg==
X-Received: by 2002:a17:902:ef49:: with SMTP id e9mr1985988plx.56.1644411595891;
        Wed, 09 Feb 2022 04:59:55 -0800 (PST)
Received: from workstation ([117.202.188.219])
        by smtp.gmail.com with ESMTPSA id 16sm20314839pfl.99.2022.02.09.04.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Feb 2022 04:59:55 -0800 (PST)
Date:   Wed, 9 Feb 2022 18:29:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org
Subject: Re: [PATCH 00/23] Add initial support for MHI endpoint stack
Message-ID: <20220209125950.GB10700@workstation>
References: <20220209094601.26131-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209094601.26131-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:15:38PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds initial support for the Qualcomm specific Modem Host Interface
> (MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
> communicates with the MHI bus in host machines like x86 over any physical bus
> like PCIe. The MHI host support is already in mainline [1] and been used by PCIe
> based modems and WLAN devices running vendor code (downstream).
> 
> Overview
> ========
> 
> This series aims at adding the MHI support in the endpoint devices with the goal
> of getting data connectivity using the mainline kernel running on the modems.
> Modems here refer to the combination of an APPS processor (Cortex A grade) and
> a baseband processor (DSP). The MHI bus is located in the APPS processor and it
> transfers data packets from the baseband processor to the host machine.
> 
> The MHI Endpoint (MHI EP) stack proposed here is inspired by the downstream
> code written by Qualcomm. But the complete stack is mostly re-written to adapt
> to the "bus" framework and made it modular so that it can work with the upstream
> subsystems like "PCI Endpoint". The code structure of the MHI endpoint stack
> follows the MHI host stack to maintain uniformity.
> 
> With this initial MHI EP stack (along with few other drivers), we can establish
> the network interface between host and endpoint over the MHI software channels
> (IP_SW0) and can do things like IP forwarding, SSH, etc...
> 
> Stack Organization
> ==================
> 
> The MHI EP stack has the concept of controller and device drivers as like the
> MHI host stack. The MHI EP controller driver can be a PCI Endpoint Function
> driver and the MHI device driver can be a MHI EP Networking driver or QRTR
> driver. The MHI EP controller driver is tied to the PCI Endpoint subsystem and
> handles all bus related activities like mapping the host memory, raising IRQ,
> passing link specific events etc... The MHI EP networking driver is tied to the
> Networking stack and handles all networking related activities like
> sending/receiving the SKBs from netdev, statistics collection etc...
> 
> This series only contains the MHI EP code, whereas the PCIe EPF driver and MHI
> EP Networking drivers are not yet submitted and can be found here [2]. Though
> the MHI EP stack doesn't have the build time dependency, it cannot function
> without them.
> 
> Test setup
> ==========
> 
> This series has been tested on Telit FN980 TLB board powered by Qualcomm SDX55
> (a.k.a X55 modem) and Qualcomm SM8450 based dev board.
> 
> For testing the stability and performance, networking tools such as iperf, ssh
> and ping are used.
> 
> Limitations
> ===========
> 
> We are not _yet_ there to get the data packets from the modem as that involves
> the Qualcomm IP Accelerator (IPA) integration with MHI endpoint stack. But we
> are planning to add support for it in the coming days.
> 
> References
> ==========
> 
> MHI bus: https://www.kernel.org/doc/html/latest/mhi/mhi.html
> Linaro connect presentation around this topic: https://connect.linaro.org/resources/lvc21f/lvc21f-222/
> 
> Thanks,
> Mani
> 

Please ignore this patch. It is missing the v2 prefix.

Thanks,
Mani

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi
> [2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-sdx55-drivers
> 
> Changes in v2:
> 
> v2 mostly addresses the issues seen while testing the stack on SM8450 that is a
> SMP platform and also incorporates the review comments from Alex.
> 
> Major changes are:
> 
> * Added a cleanup patch for getting rid of SHIFT macros and used the bitfield
>   operations.
> * Added the endianess patches that were submitted to MHI list and used the
>   endianess conversion in EP patches also.
> * Added support for multiple event rings.
> * Fixed the MSI generation based on the event ring index.
> * Fixed the doorbell list handling by making use of list splice and not locking
>   the entire list manipulation.
> * Added new APIs for wrapping the reading and writing to host memory (Dmitry).
> * Optimized the read_channel and queue_skb function logics.
> * Added Hemant's R-o-b tag.
> 
> Manivannan Sadhasivam (21):
>   bus: mhi: Move host MHI code to "host" directory
>   bus: mhi: Move common MHI definitions out of host directory
>   bus: mhi: Make mhi_state_str[] array static inline and move to
>     common.h
>   bus: mhi: Cleanup the register definitions used in headers
>   bus: mhi: Get rid of SHIFT macros and use bitfield operations
>   bus: mhi: ep: Add support for registering MHI endpoint controllers
>   bus: mhi: ep: Add support for registering MHI endpoint client drivers
>   bus: mhi: ep: Add support for creating and destroying MHI EP devices
>   bus: mhi: ep: Add support for managing MMIO registers
>   bus: mhi: ep: Add support for ring management
>   bus: mhi: ep: Add support for sending events to the host
>   bus: mhi: ep: Add support for managing MHI state machine
>   bus: mhi: ep: Add support for processing MHI endpoint interrupts
>   bus: mhi: ep: Add support for powering up the MHI endpoint stack
>   bus: mhi: ep: Add support for powering down the MHI endpoint stack
>   bus: mhi: ep: Add support for handling MHI_RESET
>   bus: mhi: ep: Add support for handling SYS_ERR condition
>   bus: mhi: ep: Add support for processing command and TRE rings
>   bus: mhi: ep: Add support for queueing SKBs over MHI bus
>   bus: mhi: ep: Add support for suspending and resuming channels
>   bus: mhi: ep: Add uevent support for module autoloading
> 
> Paul Davey (2):
>   bus: mhi: Fix pm_state conversion to string
>   bus: mhi: Fix MHI DMA structure endianness
> 
>  drivers/bus/Makefile                      |    2 +-
>  drivers/bus/mhi/Kconfig                   |   28 +-
>  drivers/bus/mhi/Makefile                  |    9 +-
>  drivers/bus/mhi/common.h                  |  319 ++++
>  drivers/bus/mhi/ep/Kconfig                |   10 +
>  drivers/bus/mhi/ep/Makefile               |    2 +
>  drivers/bus/mhi/ep/internal.h             |  254 ++++
>  drivers/bus/mhi/ep/main.c                 | 1602 +++++++++++++++++++++
>  drivers/bus/mhi/ep/mmio.c                 |  274 ++++
>  drivers/bus/mhi/ep/ring.c                 |  267 ++++
>  drivers/bus/mhi/ep/sm.c                   |  174 +++
>  drivers/bus/mhi/host/Kconfig              |   31 +
>  drivers/bus/mhi/{core => host}/Makefile   |    4 +-
>  drivers/bus/mhi/{core => host}/boot.c     |   17 +-
>  drivers/bus/mhi/{core => host}/debugfs.c  |   40 +-
>  drivers/bus/mhi/{core => host}/init.c     |  124 +-
>  drivers/bus/mhi/{core => host}/internal.h |  427 +-----
>  drivers/bus/mhi/{core => host}/main.c     |   46 +-
>  drivers/bus/mhi/{ => host}/pci_generic.c  |    0
>  drivers/bus/mhi/{core => host}/pm.c       |   36 +-
>  include/linux/mhi_ep.h                    |  293 ++++
>  include/linux/mod_devicetable.h           |    2 +
>  scripts/mod/file2alias.c                  |   10 +
>  23 files changed, 3443 insertions(+), 528 deletions(-)
>  create mode 100644 drivers/bus/mhi/common.h
>  create mode 100644 drivers/bus/mhi/ep/Kconfig
>  create mode 100644 drivers/bus/mhi/ep/Makefile
>  create mode 100644 drivers/bus/mhi/ep/internal.h
>  create mode 100644 drivers/bus/mhi/ep/main.c
>  create mode 100644 drivers/bus/mhi/ep/mmio.c
>  create mode 100644 drivers/bus/mhi/ep/ring.c
>  create mode 100644 drivers/bus/mhi/ep/sm.c
>  create mode 100644 drivers/bus/mhi/host/Kconfig
>  rename drivers/bus/mhi/{core => host}/Makefile (54%)
>  rename drivers/bus/mhi/{core => host}/boot.c (96%)
>  rename drivers/bus/mhi/{core => host}/debugfs.c (90%)
>  rename drivers/bus/mhi/{core => host}/init.c (93%)
>  rename drivers/bus/mhi/{core => host}/internal.h (50%)
>  rename drivers/bus/mhi/{core => host}/main.c (98%)
>  rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
>  rename drivers/bus/mhi/{core => host}/pm.c (97%)
>  create mode 100644 include/linux/mhi_ep.h
> 
> -- 
> 2.25.1
> 
