Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB84C83D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 07:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiCAGQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 01:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbiCAGQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 01:16:15 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD7F6660C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:15:33 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id o8so13572665pgf.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 22:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+xfB4gNTbCq291EVkNnRbRLnZWucWmXliw/qvwxMWYg=;
        b=lDZD/p+clPsiQvcoU7xjudaWbCk6DIPDgYyiVOj6bVOe20MwxiDM4yoc8KhieP+hBS
         I4doDrNX50gS7vodjdaoFb43s2Z4kumXD7CZJgoLnmo6zFMXxT5csv0NeSN0WixD1Upb
         9pDb0Cl1lrIsm7awCzCMia9ULlegwlUqDxDUdtseCH3KE6GIeC4t/+ysmHFGUIxQU9ic
         WLREgWemv4r9/KKrGZKQ1GzOQEeEDhBoBvPpQNGjrafLqFhsyGUiyD0qlFkwH95Y/h7i
         u7rmrvbwwPzmjHDdTcN5bEykAWVM4C9KoAFtQrk+ucZ6cFcMkDgGvZwrOlX68PxWm8nr
         tx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+xfB4gNTbCq291EVkNnRbRLnZWucWmXliw/qvwxMWYg=;
        b=KmYcGMh435l3LWJ4gaV9WCp87yWTeH5WC4nyi9R6XK4igoIElvfpf/VFh3Sj4dfRJH
         qriGKJuvJ0ctnUBDLyhoudNc6EE7utRw5iRAufXixLFdNn12Qls4XSPDPgfl7DKbKVTW
         SgfKMqux/bJ4szqdiiFYvz/EvMQxPyYLAEnPP4N82lF4ji6zFFQ2lpQYCAjcoJEcahrr
         4JX/av4hDlK/BIVH4fUjbQUVYFybSzyQmIi+90vmwkMSFgKOHDcA9y1BmUHMh6a2M+13
         Ga9s9jOK4LYhd00VWs3V+V4TU9XP9h66hN246Yh57DRr+XnKoCb9T3YdJfuXQxPVzdjD
         XPfg==
X-Gm-Message-State: AOAM5300ukWKVuLgXnmR1F/LXvrI0HlTrU7a3HHIXxCpM4WM1oAol8MC
        r1cXZfngRdHJ61Z2L+PLxWW0
X-Google-Smtp-Source: ABdhPJxtbodzYU9eR4BdjrscPXILinjVURDiK96NyUzPhYadLn0YWNHwx3AsJr8URPJtFlihMmIOBQ==
X-Received: by 2002:a05:6a00:1a09:b0:4e1:67a7:2c87 with SMTP id g9-20020a056a001a0900b004e167a72c87mr25703780pfv.37.1646115332111;
        Mon, 28 Feb 2022 22:15:32 -0800 (PST)
Received: from workstation ([117.207.25.80])
        by smtp.gmail.com with ESMTPSA id r4-20020a17090a438400b001bc6d52de70sm993992pjg.24.2022.02.28.22.15.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Feb 2022 22:15:31 -0800 (PST)
Date:   Tue, 1 Mar 2022 11:45:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     mhi@lists.linux.dev, quic_hemantk@quicinc.com,
        quic_bbhatt@quicinc.com, quic_jhugo@quicinc.com,
        vinod.koul@linaro.org, bjorn.andersson@linaro.org,
        dmitry.baryshkov@linaro.org, quic_vbadigan@quicinc.com,
        quic_cang@quicinc.com, quic_skananth@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/27] Add initial support for MHI endpoint stack
Message-ID: <20220301061526.GC12451@workstation>
References: <20220228124344.77359-1-manivannan.sadhasivam@linaro.org>
 <8bb7a184-d186-fa1f-d8b0-be1c326e385d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb7a184-d186-fa1f-d8b0-be1c326e385d@linaro.org>
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

On Mon, Feb 28, 2022 at 10:57:48AM -0600, Alex Elder wrote:
> On 2/28/22 6:43 AM, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds initial support for the Qualcomm specific Modem Host Interface
> > (MHI) bus in endpoint devices like SDX55 modems. The MHI bus in endpoint devices
> > communicates with the MHI bus in host machines like x86 over any physical bus
> > like PCIe. The MHI host support is already in mainline [1] and been used by PCIe
> > based modems and WLAN devices running vendor code (downstream).
> 
> I believe I have provided a "Reviewed-by" tag for all patches in
> this series.  I've made a few minor suggestions, but nothing I
> saw deserves issuing a new version of the series.

Thanks a lot for your time, Alex! Much appreciated.

> The only "big thing" is whether you want to rework the stuff that David
> Laight commented on in patch 5 (and 15 too).  I agree with him
> that the code there isn't very pretty and could be improved,
> but as I said in my review, my preference would be to get this
> accepted with a promise from you to revisit that.  Improving
> that would improve readability and maintainability, and that's
> important.  But there's too much *other* code in this series
> and I hate to see its acceptance delayed further.
> 

As I replied to you during v3 review, the ring element structure changes
between command, transfer and event rings. Even with command ring, we
got different structure for each command. This makes the definition
a bit hard.

Anyway, I'll take another look once this series gets merged.

> So anyway, I'm done reviewing this, and in general I trust that
> you will tell me (and drop my Reviewed-by tag) if you change
> anything substantive in a new version of the series.
> 

Sure.

Thanks,
Mani

> 					-Alex
> 
> > 
> > Overview
> > ========
> > 
> > This series aims at adding the MHI support in the endpoint devices with the goal
> > of getting data connectivity using the mainline kernel running on the modems.
> > Modems here refer to the combination of an APPS processor (Cortex A grade) and
> > a baseband processor (DSP). The MHI bus is located in the APPS processor and it
> > transfers data packets from the baseband processor to the host machine.
> > 
> > The MHI Endpoint (MHI EP) stack proposed here is inspired by the downstream
> > code written by Qualcomm. But the complete stack is mostly re-written to adapt
> > to the "bus" framework and made it modular so that it can work with the upstream
> > subsystems like "PCI Endpoint". The code structure of the MHI endpoint stack
> > follows the MHI host stack to maintain uniformity.
> > 
> > With this initial MHI EP stack (along with few other drivers), we can establish
> > the network interface between host and endpoint over the MHI software channels
> > (IP_SW0) and can do things like IP forwarding, SSH, etc...
> > 
> > Stack Organization
> > ==================
> > 
> > The MHI EP stack has the concept of controller and device drivers as like the
> > MHI host stack. The MHI EP controller driver can be a PCI Endpoint Function
> > driver and the MHI device driver can be a MHI EP Networking driver or QRTR
> > driver. The MHI EP controller driver is tied to the PCI Endpoint subsystem and
> > handles all bus related activities like mapping the host memory, raising IRQ,
> > passing link specific events etc... The MHI EP networking driver is tied to the
> > Networking stack and handles all networking related activities like
> > sending/receiving the SKBs from netdev, statistics collection etc...
> > 
> > This series only contains the MHI EP code, whereas the PCIe EPF driver and MHI
> > EP Networking drivers are not yet submitted and can be found here [2]. Though
> > the MHI EP stack doesn't have the build time dependency, it cannot function
> > without them.
> > 
> > Test setup
> > ==========
> > 
> > This series has been tested on Telit FN980 TLB board powered by Qualcomm SDX55
> > (a.k.a X55 modem) and Qualcomm SM8450 based dev board.
> > 
> > For testing the stability and performance, networking tools such as iperf, ssh
> > and ping are used.
> > 
> > Limitations
> > ===========
> > 
> > We are not _yet_ there to get the data packets from the modem as that involves
> > the Qualcomm IP Accelerator (IPA) integration with MHI endpoint stack. But we
> > are planning to add support for it in the coming days.
> > 
> > References
> > ==========
> > 
> > MHI bus: https://www.kernel.org/doc/html/latest/mhi/mhi.html
> > Linaro connect presentation around this topic: https://connect.linaro.org/resources/lvc21f/lvc21f-222/
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/bus/mhi
> > [2] https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/log/?h=tracking-qcomlt-sdx55-drivers
> > 
> > Changes in v4:
> > 
> > * Collected reviews from Hemant and Alex.
> > * Removed the A7 suffix from register names and functions.
> > * Added a couple of cleanup patches.
> > * Reworked the mhi_ep_queue_skb() API.
> > * Switched to separate workers for command and transfer rings.
> > * Used a common workqueue for state and ring management.
> > * Reworked the channel ring management.
> > * Other misc changes as per review from Alex.
> > 
> > Changes in v3:
> > 
> > * Splitted the patch 20/23 into two.
> > * Fixed the error handling in patch 21/23.
> > * Removed spurious change in patch 01/23.
> > * Added check for xfer callbacks in client driver probe.
> > 
> > Changes in v2:
> > 
> > v2 mostly addresses the issues seen while testing the stack on SM8450 that is a
> > SMP platform and also incorporates the review comments from Alex.
> > 
> > Major changes are:
> > 
> > * Added a cleanup patch for getting rid of SHIFT macros and used the bitfield
> >    operations.
> > * Added the endianess patches that were submitted to MHI list and used the
> >    endianess conversion in EP patches also.
> > * Added support for multiple event rings.
> > * Fixed the MSI generation based on the event ring index.
> > * Fixed the doorbell list handling by making use of list splice and not locking
> >    the entire list manipulation.
> > * Added new APIs for wrapping the reading and writing to host memory (Dmitry).
> > * Optimized the read_channel and queue_skb function logics.
> > * Added Hemant's R-o-b tag.
> > 
> > Manivannan Sadhasivam (25):
> >    bus: mhi: Move host MHI code to "host" directory
> >    bus: mhi: Use bitfield operations for register read and write
> >    bus: mhi: Use bitfield operations for handling DWORDs of ring elements
> >    bus: mhi: Cleanup the register definitions used in headers
> >    bus: mhi: host: Rename "struct mhi_tre" to "struct mhi_ring_element"
> >    bus: mhi: Move common MHI definitions out of host directory
> >    bus: mhi: Make mhi_state_str[] array static inline and move to
> >      common.h
> >    bus: mhi: ep: Add support for registering MHI endpoint controllers
> >    bus: mhi: ep: Add support for registering MHI endpoint client drivers
> >    bus: mhi: ep: Add support for creating and destroying MHI EP devices
> >    bus: mhi: ep: Add support for managing MMIO registers
> >    bus: mhi: ep: Add support for ring management
> >    bus: mhi: ep: Add support for sending events to the host
> >    bus: mhi: ep: Add support for managing MHI state machine
> >    bus: mhi: ep: Add support for processing MHI endpoint interrupts
> >    bus: mhi: ep: Add support for powering up the MHI endpoint stack
> >    bus: mhi: ep: Add support for powering down the MHI endpoint stack
> >    bus: mhi: ep: Add support for handling MHI_RESET
> >    bus: mhi: ep: Add support for handling SYS_ERR condition
> >    bus: mhi: ep: Add support for processing command rings
> >    bus: mhi: ep: Add support for reading from the host
> >    bus: mhi: ep: Add support for processing channel rings
> >    bus: mhi: ep: Add support for queueing SKBs to the host
> >    bus: mhi: ep: Add support for suspending and resuming channels
> >    bus: mhi: ep: Add uevent support for module autoloading
> > 
> > Paul Davey (2):
> >    bus: mhi: Fix pm_state conversion to string
> >    bus: mhi: Fix MHI DMA structure endianness
> > 
> >   drivers/bus/Makefile                     |    2 +-
> >   drivers/bus/mhi/Kconfig                  |   28 +-
> >   drivers/bus/mhi/Makefile                 |    9 +-
> >   drivers/bus/mhi/common.h                 |  326 +++++
> >   drivers/bus/mhi/core/internal.h          |  722 ----------
> >   drivers/bus/mhi/ep/Kconfig               |   10 +
> >   drivers/bus/mhi/ep/Makefile              |    2 +
> >   drivers/bus/mhi/ep/internal.h            |  222 +++
> >   drivers/bus/mhi/ep/main.c                | 1623 ++++++++++++++++++++++
> >   drivers/bus/mhi/ep/mmio.c                |  272 ++++
> >   drivers/bus/mhi/ep/ring.c                |  197 +++
> >   drivers/bus/mhi/ep/sm.c                  |  148 ++
> >   drivers/bus/mhi/host/Kconfig             |   31 +
> >   drivers/bus/mhi/{core => host}/Makefile  |    4 +-
> >   drivers/bus/mhi/{core => host}/boot.c    |   17 +-
> >   drivers/bus/mhi/{core => host}/debugfs.c |   40 +-
> >   drivers/bus/mhi/{core => host}/init.c    |  131 +-
> >   drivers/bus/mhi/host/internal.h          |  382 +++++
> >   drivers/bus/mhi/{core => host}/main.c    |   66 +-
> >   drivers/bus/mhi/{ => host}/pci_generic.c |    0
> >   drivers/bus/mhi/{core => host}/pm.c      |   36 +-
> >   include/linux/mhi_ep.h                   |  284 ++++
> >   include/linux/mod_devicetable.h          |    2 +
> >   scripts/mod/file2alias.c                 |   10 +
> >   24 files changed, 3649 insertions(+), 915 deletions(-)
> >   create mode 100644 drivers/bus/mhi/common.h
> >   delete mode 100644 drivers/bus/mhi/core/internal.h
> >   create mode 100644 drivers/bus/mhi/ep/Kconfig
> >   create mode 100644 drivers/bus/mhi/ep/Makefile
> >   create mode 100644 drivers/bus/mhi/ep/internal.h
> >   create mode 100644 drivers/bus/mhi/ep/main.c
> >   create mode 100644 drivers/bus/mhi/ep/mmio.c
> >   create mode 100644 drivers/bus/mhi/ep/ring.c
> >   create mode 100644 drivers/bus/mhi/ep/sm.c
> >   create mode 100644 drivers/bus/mhi/host/Kconfig
> >   rename drivers/bus/mhi/{core => host}/Makefile (54%)
> >   rename drivers/bus/mhi/{core => host}/boot.c (96%)
> >   rename drivers/bus/mhi/{core => host}/debugfs.c (90%)
> >   rename drivers/bus/mhi/{core => host}/init.c (92%)
> >   create mode 100644 drivers/bus/mhi/host/internal.h
> >   rename drivers/bus/mhi/{core => host}/main.c (97%)
> >   rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
> >   rename drivers/bus/mhi/{core => host}/pm.c (97%)
> >   create mode 100644 include/linux/mhi_ep.h
> > 
> 
