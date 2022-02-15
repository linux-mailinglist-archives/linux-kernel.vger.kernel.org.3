Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790B4B6ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237563AbiBOOca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:32:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiBOOcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:32:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A298D15F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644935534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kXzMPxpPt6Z4nMk/I9zc5c3jnXkL788GrF8HLGMlet0=;
        b=BFS0g9UrPJJ5vOCzSlcHVvEBYJYRIAqdywgqzj7h5uwiW1rI0ns6gEZlhXxI3F/MM+U0EL
        zMaQJE2oXqRQO/4EvRjjb5tMXVSUguPb7a0wLpFT1WuAnD/XYsAHHhMg/r5Pd64HVoChBQ
        /nh6mylKFs63feBECVx/vMpxMVEEOFQ=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-yWOsotXkN22WxeiZ4J1hWw-1; Tue, 15 Feb 2022 09:32:13 -0500
X-MC-Unique: yWOsotXkN22WxeiZ4J1hWw-1
Received: by mail-oo1-f71.google.com with SMTP id s14-20020a4aa54e000000b002ea553d580eso12738404oom.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kXzMPxpPt6Z4nMk/I9zc5c3jnXkL788GrF8HLGMlet0=;
        b=ox6qVLUMZC29kj3okTN+hECd5QGLwA3sUNPFTd8NNvbHJyBReSXIhYuv+p+Tg5e6yb
         GBHXPV9Fn0TMdW9kqqXJ2ccSVj6zJdbrOOZBxP+8s8VVFWtdw8j0HpB08uU9PeMsafAl
         2NQOrUwMWXffdM4a08HRHOUM+7ymo1xFxr/7ewH8VhoABuJpVatRIN+etBASDWEvnlEy
         cXJFt+CHfmjDpZMMdGeuV3lzmF84UeXRuv0iXYxcvD9CmAj5ZaFt9NCXKJvToQtTUdLb
         Zx2CzBHOQjxprXxTfaVtli56xUbi2e+5yUtAJsCa8kYPoIKPzqL2MKL/tdzZhP5bLLQg
         WIBQ==
X-Gm-Message-State: AOAM5335T/5N3EC3SRZ4a4xO70ShrOAAxNhBKu2S/Kp3J6WtHiF3pX3g
        IhFb28CCEA4lRTqWO+lfo5p0ilHxr26vGRuW9HKk8NUoAEehdXlrCYGNnHqh3E3XYmeSebz45vN
        v5RNq0Vj5huWkmZgu30dut+sa
X-Received: by 2002:a05:6870:2142:b0:d2:c3fe:83c8 with SMTP id g2-20020a056870214200b000d2c3fe83c8mr1499840oae.165.1644935532447;
        Tue, 15 Feb 2022 06:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBW230U8nUtjeldcnU2xd5Fe3oQMJiqQxogDBomj+xWYHSmSduSFxFpEpsLE6Gm1pzSW1u9Q==
X-Received: by 2002:a05:6870:2142:b0:d2:c3fe:83c8 with SMTP id g2-20020a056870214200b000d2c3fe83c8mr1499826oae.165.1644935532136;
        Tue, 15 Feb 2022 06:32:12 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id y1sm16494879oad.38.2022.02.15.06.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:32:11 -0800 (PST)
Subject: Re: [PATCH v1 1/7] Documentation: fpga: dfl: add description of IOFS
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-2-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <882cda83-6b31-83eb-cb88-d5a2fec57332@redhat.com>
Date:   Tue, 15 Feb 2022 06:32:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-2-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>
> This patch adds description about IOFS support for DFL.
>
This needs work.

Several times 'Port Gasket' was mentioned but there is no section 
describing what it is.

It is not clear if iofs supersedes dfl or extends it.

It is not clear how a driver probes to tell the difference between the two.

This document should set up why the other changes in the patchset are 
needed.

Add yourself to authors list.

Tom

> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   Documentation/fpga/dfl.rst | 99 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..6f9eae1c1697 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -58,7 +58,10 @@ interface to FPGA, e.g. the FPGA Management Engine (FME) and Port (more
>   descriptions on FME and Port in later sections).
>   
>   Accelerated Function Unit (AFU) represents an FPGA programmable region and
> -always connects to a FIU (e.g. a Port) as its child as illustrated above.
> +always connects to a FIU (e.g. a Port) as its child as illustrated above, but
> +on IOFS design, it introducing Port Gasket which contains AFUs. For DFL perspective,
> +the Next_AFU pointer on FIU feature header can point to NULL so the AFU is not
> +connects to a FIU(more descriptions on IOFS in later section).
>   
>   Private Features represent sub features of the FIU and AFU. They could be
>   various function blocks with different IDs, but all private features which
> @@ -134,6 +137,9 @@ reconfigurable region containing an AFU. It controls the communication from SW
>   to the accelerator and exposes features such as reset and debug. Each FPGA
>   device may have more than one port, but always one AFU per port.
>   
> +On IOFS, it introducing a new hardware unit, Port Gasket, which contains all
> +the PR specific modules and regions (more descriptions on IOFS in later section).
> +
>   
>   AFU
>   ===
> @@ -143,6 +149,9 @@ used for accelerator-specific control registers.
>   User-space applications can acquire exclusive access to an AFU attached to a
>   port by using open() on the port device node and release it using close().
>   
> +On IOFS, the AFU is embedded in a Port Gasket. The AFU resource can expose via
> +VFs with SRIOV support (more descriptions on IOFS in later section).
> +
>   The following functions are exposed through ioctls:
>   
>   - Get driver API version (DFL_FPGA_GET_API_VERSION)
> @@ -284,7 +293,8 @@ FME is always accessed through the physical function (PF).
>   
>   Ports (and related AFUs) are accessed via PF by default, but could be exposed
>   through virtual function (VF) devices via PCIe SRIOV. Each VF only contains
> -1 Port and 1 AFU for isolation. Users could assign individual VFs (accelerators)
> +1 Port (On IOFS design, the VF is designs without Port) and 1 AFU for isolation.
> +Users could assign individual VFs (accelerators)
>   created via PCIe SRIOV interface, to virtual machines.
>   
>   The driver organization in virtualization case is illustrated below:
> @@ -389,6 +399,91 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>   	/sys/class/fpga_region/<regionX>/<dfl-fme.n>/dev
>   	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>   
> +Intel Open FPGA stack
> +=====================
> +Intel Open FPGA stack aka IOFS, Intel's version of a common core set of
> +RTL to allow customers to easily interface to logic and IP on the FPGA.
> +IOFS leverage the DFL for the implementation of the FPGA RTL design.
> +
> +IOFS designs allow for the arrangement of software interfaces across multiple
> +PCIe endpoints. Some of these interfaces may be PFs defined in the static region
> +that connect to interfaces in an IP that is loaded via Partial Reconfiguration (PR).
> +And some of these interfaces may be VFs defined in the PR region that can be
> +reconfigured by the end-user. Furthermore, these PFs/VFs may also be arranged
> +using a DFL such that features may be discovered and accessed in user space
> +(with the aid of a generic kernel driver like vfio-pci). The diagram below depicts
> +an example design with two PFs and two VFs. In this example, PF1 implements its
> +MMIO space such that it is compatible with the VirtIO framework. The other functions,
> +VF0 and VF1, leverage VFIO to export the MMIO space to an application or a hypervisor.
> +
> +     +-----------------+  +--------------+  +-------------+  +------------+
> +     | FPGA Managerment|  |   VirtIO     |  |  User App   |  | Virtual    |
> +     |      App        |  |     App      |  |             |  | Machine    |
> +     +--------+--------+  +------+-------+  +------+------+  +-----+------+
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +     |     DFL Driver  |  |VirtIO driver |  |    VFIO     |        |
> +     +--------+--------+  +------+-------+  +------+------+        |
> +              |                  |                 |               |
> +              |                  |                 |               |
> +     +--------+--------+  +------+-------+  +------+------+   +----+------+
> +     |     PF0         |  |     PF1      |  |   PF0_VF0   |   |  PF0_VF1  |
> +     +-----------------+  +--------------+  +-------------+   +-----------+
> +
> +On IOFS, it introducing some enhancements compared with original DFL design.
> +1. It introducing Port Gasket in PF0 which is responsible for FPGA management,
> +like FME and Port management. The Port Gasket contains all the PR specific modules
> +and logic, e.g., PR slot reset/freeze control, user clock, remote STP etc.
> +Architecturally, a Port Gasket can have multiple PR slots where user workload can
> +be programmed into.
> +2. To expend the scalable of FPGA, it can support multiple FPs in static region
> +which contain some static functions like VirtIO, diagnostic test, and access over
> +VFIO or assigned to VMs easily. Those PFs will not have a Port Unit which without
> +PR region (AFU) connected to those PFs, and the end-user cannot partial reconfigurate
> +those PFs.
> +3. In our previous DFL design, it can only create one VF based in an AFU. To raise
> +the efficiency usage of AFU, it can create more than one VFs in an AFU via PCIe
> +SRIOV, so those VFs share the PR region and resource.
> +
> +There is one reference architecture design for IOFS as illustrated below:
> +
> +                              +----------------------+
> +                              |   PF/VF mux/demux    |
> +                              +--+--+-----+------+-+-+
> +                                 |  |     |      | |
> +        +------------------------+  |     |      | |
> +  PF0   |                 +---------+   +-+      | |
> +    +---+---+             |         +---+----+   | |
> +    |  DFH  |             |         |   DFH  |   | |
> +    +-------+       +-----+----+    +--------+   | |
> +    |  FME  |       |  VirtIO  |    |  Test  |   | |
> +    +-------+       +----------+    +--------+   | |
> +    | Port  |            PF1            PF2      | |
> +    +---+---+                                    | |
> +        |                             +----------+ |
> +        |                             |           ++
> +        |                             |           |
> +        |                             | PF0_VF0   | PF0_VF1
> +        |           +-----------------+-----------+------------+
> +        |           |           +-----+-----------+--------+   |
> +        |           |           |     |           |        |   |
> +        |           | +------+  |  +--+ -+     +--+---+    |   |
> +        |           | | CSR  |  |  | DFH |     |  DFH |    |   |
> +        +-----------+ +------+  |  +-----+     +------+    |   |
> +                    |           |  | DEV |     |  DEV |    |   |
> +                    |           |  +-----+     +------+    |   |
> +                    |           |            PR Slot       |   |
> +                    |           +--------------------------+   |
> +                    | Port Gasket                              |
> +                    +------------------------------------------+
> +
> +Here are the major changes about DFL structures on IOFS implementation design:
> +1. The Port Gasket connects to FIU Port in DFL, but the Next_AFU pointer in
> +FIU feature header can point to NULL so that it is no AFU connects to a FIU
> +Port.
> +2. The VF which include in PR region can start with AFU feature header without
> +a FIU Port feature header.
>   
>   Performance Counters
>   ====================

