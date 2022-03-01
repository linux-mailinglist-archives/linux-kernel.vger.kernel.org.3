Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235F64C8715
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 09:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiCAIut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 03:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiCAIur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:50:47 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D669588B37
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:50:06 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v5-20020a17090ac90500b001bc40b548f9so1521723pjt.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 00:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DkTK8gVHWL8qsd16TWmJoF1cbtwHJML/XZeqRClMbk8=;
        b=mmmsBw8dB2oiy2U7aN3KxhmqngVDn2eB2usNgrCqnQmhE8IXlo8dzeeYBmFRAY/CZl
         XPwpKsP6e1Ai1jybkxUClGaDTbs0GZxTjz0RDWy6T40cTtrDPCAOA+Ath4yarDM7gpzb
         s39z/delgsZ+Pqq+s86XPYb5obnPieyrFB316fGev2Ggq/SF+PIjBsy6ukGrcRRjUBN5
         FmLQ+oCb+7qUBY6BCYKtSqYoe4U5uJOUhflOytn6T9/YiOyrgv8O8tYCmR1bENfKe8KH
         JAyEDv1niIeAkttPHiKdaZZoBl4YfqiFcbQx/bpgYkKvl7eodpKdDae4fZebthVAiHQ5
         9e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DkTK8gVHWL8qsd16TWmJoF1cbtwHJML/XZeqRClMbk8=;
        b=q8Y0pqIfuiNdkoH/LbOle+1YQgcyDbextOigWk+COkbo1pa3PcEISn/YGYRNr1oECd
         P0Ja1Ck90r98zNfA6l7fChnq5n7Ee6eoep8pxmCtD/OUAd6Lel/ZKkYmI2vGP1A0TGWE
         /gGU3lFtzxp+yhiUA4yQaDK3L/Y7STW+GH5Rd2ATUAitJEgqoy678aPj9JKaO4062+N/
         4UU35dqaS7PCHGo23pG6BgU5IEfdMrbbclM6A1+DVXkAu27bJUL/acMqtqmrvql7BP+3
         slhb/6dZKu2HjxxOzMM49vEBhQZ19Wf3ov84v4jH2ECHM7eTFRKQZIuW69JlguXRjEG2
         Iu2Q==
X-Gm-Message-State: AOAM530a5TwwW5OGiZVjzYaVxYsAYDqF3ZgOkmRtU/77v+ARL/AIYAmP
        v2Kj12PiN43K4LRXmozgPXBq
X-Google-Smtp-Source: ABdhPJyrIc3vsITaq/51wSscHNbIUMMQnW7z/dgWvukMVsqnJMTqz5V6mjzcM4ksXpDNQFx7tmT0+A==
X-Received: by 2002:a17:903:41cd:b0:151:5c70:4181 with SMTP id u13-20020a17090341cd00b001515c704181mr11873115ple.23.1646124606208;
        Tue, 01 Mar 2022 00:50:06 -0800 (PST)
Received: from workstation ([117.207.25.80])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00174200b004e132cba37bsm17492335pfc.45.2022.03.01.00.50.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Mar 2022 00:50:05 -0800 (PST)
Date:   Tue, 1 Mar 2022 14:20:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, elder@linaro.org
Subject: Re: [PATCH v4 00/27] Add initial support for MHI endpoint stack
Message-ID: <20220301085001.GE12451@workstation>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 06:13:17PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> This series adds initial support for the Qualcomm specific Modem Host Interface
> (MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
> communicates with the MHI bus in host machines like x86 over any physical bus
> like PCIe. The MHI host support is already in mainline [1] and been used by PCIe
> based modems and WLAN devices running vendor code (downstream).
> 

Series applied to mhi-next with Alex's Reviewed-by tag. Also incorporated few
suggestions by Alex.

Thanks,
Mani

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
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi
> [2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-sdx55-drivers
> 
> Changes in v4:
> 
> * Collected reviews from Hemant and Alex.
> * Removed the A7 suffix from register names and functions.
> * Added a couple of cleanup patches.
> * Reworked the mhi_ep_queue_skb() API.
> * Switched to separate workers for command and transfer rings.
> * Used a common workqueue for state and ring management.
> * Reworked the channel ring management.
> * Other misc changes as per review from Alex.
> 
> Changes in v3:
> 
> * Splitted the patch 20/23 into two.
> * Fixed the error handling in patch 21/23.
> * Removed spurious change in patch 01/23.
> * Added check for xfer callbacks in client driver probe.
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
> Manivannan Sadhasivam (25):
>   bus: mhi: Move host MHI code to "host" directory
>   bus: mhi: Use bitfield operations for register read and write
>   bus: mhi: Use bitfield operations for handling DWORDs of ring elements
>   bus: mhi: Cleanup the register definitions used in headers
>   bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"
>   bus: mhi: Move common MHI definitions out of host directory
>   bus: mhi: Make mhi_state_str[] array static inline and move to
>     common.h
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
>   bus: mhi: ep: Add support for processing command rings
>   bus: mhi: ep: Add support for reading from the host
>   bus: mhi: ep: Add support for processing channel rings
>   bus: mhi: ep: Add support for queueing SKBs to the host
>   bus: mhi: ep: Add support for suspending and resuming channels
>   bus: mhi: ep: Add uevent support for module autoloading
> 
> Paul Davey (2):
>   bus: mhi: Fix pm_state conversion to string
>   bus: mhi: Fix MHI DMA structure endianness
> 
>  drivers/bus/Makefile                     |    2 +-
>  drivers/bus/mhi/Kconfig                  |   28 +-
>  drivers/bus/mhi/Makefile                 |    9 +-
>  drivers/bus/mhi/common.h                 |  326 +++++
>  drivers/bus/mhi/core/internal.h          |  722 ----------
>  drivers/bus/mhi/ep/Kconfig               |   10 +
>  drivers/bus/mhi/ep/Makefile              |    2 +
>  drivers/bus/mhi/ep/internal.h            |  222 +++
>  drivers/bus/mhi/ep/main.c                | 1623 ++++++++++++++++++++++
>  drivers/bus/mhi/ep/mmio.c                |  272 ++++
>  drivers/bus/mhi/ep/ring.c                |  197 +++
>  drivers/bus/mhi/ep/sm.c                  |  148 ++
>  drivers/bus/mhi/host/Kconfig             |   31 +
>  drivers/bus/mhi/{core => host}/Makefile  |    4 +-
>  drivers/bus/mhi/{core => host}/boot.c    |   17 +-
>  drivers/bus/mhi/{core => host}/debugfs.c |   40 +-
>  drivers/bus/mhi/{core => host}/init.c    |  131 +-
>  drivers/bus/mhi/host/internal.h          |  382 +++++
>  drivers/bus/mhi/{core => host}/main.c    |   66 +-
>  drivers/bus/mhi/{ => host}/pci_generic.c |    0
>  drivers/bus/mhi/{core => host}/pm.c      |   36 +-
>  include/linux/mhi_ep.h                   |  284 ++++
>  include/linux/mod_devicetable.h          |    2 +
>  scripts/mod/file2alias.c                 |   10 +
>  24 files changed, 3649 insertions(+), 915 deletions(-)
>  create mode 100644 drivers/bus/mhi/common.h
>  delete mode 100644 drivers/bus/mhi/core/internal.h
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
>  rename drivers/bus/mhi/{core => host}/init.c (92%)
>  create mode 100644 drivers/bus/mhi/host/internal.h
>  rename drivers/bus/mhi/{core => host}/main.c (97%)
>  rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
>  rename drivers/bus/mhi/{core => host}/pm.c (97%)
>  create mode 100644 include/linux/mhi_ep.h
> 
> -- 
> 2.25.1
> 
