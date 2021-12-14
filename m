Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E802D4746A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 16:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhLNPjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 10:39:01 -0500
Received: from foss.arm.com ([217.140.110.172]:59110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234762AbhLNPi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 10:38:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40EBBD6E;
        Tue, 14 Dec 2021 07:38:59 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 549423F774;
        Tue, 14 Dec 2021 07:38:54 -0800 (PST)
Message-ID: <a1c8c438-72e6-0938-1b05-09694983164d@arm.com>
Date:   Tue, 14 Dec 2021 15:38:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 0/8] Host1x context isolation support
Content-Language: en-GB
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robh+dt@kernel.org
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20210916143302.2024933-1-mperttunen@nvidia.com>
 <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <10de82cf-27a5-8890-93a5-0e58c74e5bcc@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-08 10:36, Mikko Perttunen wrote:
> On 9/16/21 5:32 PM, Mikko Perttunen wrote:
>> Hi all,
>>
>> ***
>> New in v2:
>>
>> Added support for Tegra194
>> Use standard iommu-map property instead of custom mechanism
>> ***
>>
>> this series adds support for Host1x 'context isolation'. Since
>> when programming engines through Host1x, userspace can program in
>> any addresses it wants, we need some way to isolate the engines'
>> memory spaces. Traditionally this has either been done imperfectly
>> with a single shared IOMMU domain, or by copying and verifying the
>> programming command stream at submit time (Host1x firewall).
>>
>> Since Tegra186 there is a privileged (only usable by kernel)
>> Host1x opcode that allows setting the stream ID sent by the engine
>> to the SMMU. So, by allocating a number of context banks and stream
>> IDs for this purpose, and using this opcode at the beginning of
>> each job, we can implement isolation. Due to the limited number of
>> context banks only each process gets its own context, and not
>> each channel.
>>
>> This feature also allows sharing engines among multiple VMs when
>> used with Host1x's hardware virtualization support - up to 8 VMs
>> can be configured with a subset of allowed stream IDs, enforced
>> at hardware level.
>>
>> To implement this, this series adds a new host1x context bus, which
>> will contain the 'struct device's corresponding to each context
>> bank / stream ID, changes to device tree and SMMU code to allow
>> registering the devices and using the bus, as well as the Host1x
>> stream ID programming code and support in TegraDRM.
>>
>> Device tree bindings are not updated yet pending consensus that the
>> proposed changes make sense.
>>
>> Thanks,
>> Mikko
>>
>> Mikko Perttunen (8):
>>    gpu: host1x: Add context bus
>>    gpu: host1x: Add context device management code
>>    gpu: host1x: Program context stream ID on submission
>>    iommu/arm-smmu: Attach to host1x context device bus
>>    arm64: tegra: Add Host1x context stream IDs on Tegra186+
>>    drm/tegra: falcon: Set DMACTX field on DMA transactions
>>    drm/tegra: vic: Implement get_streamid_offset
>>    drm/tegra: Support context isolation
>>
>>   arch/arm64/boot/dts/nvidia/tegra186.dtsi  |  12 ++
>>   arch/arm64/boot/dts/nvidia/tegra194.dtsi  |  12 ++
>>   drivers/gpu/Makefile                      |   3 +-
>>   drivers/gpu/drm/tegra/drm.h               |   2 +
>>   drivers/gpu/drm/tegra/falcon.c            |   8 +
>>   drivers/gpu/drm/tegra/falcon.h            |   1 +
>>   drivers/gpu/drm/tegra/submit.c            |  13 ++
>>   drivers/gpu/drm/tegra/uapi.c              |  34 ++++-
>>   drivers/gpu/drm/tegra/vic.c               |  38 +++++
>>   drivers/gpu/host1x/Kconfig                |   5 +
>>   drivers/gpu/host1x/Makefile               |   2 +
>>   drivers/gpu/host1x/context.c              | 174 ++++++++++++++++++++++
>>   drivers/gpu/host1x/context.h              |  27 ++++
>>   drivers/gpu/host1x/context_bus.c          |  31 ++++
>>   drivers/gpu/host1x/dev.c                  |  12 +-
>>   drivers/gpu/host1x/dev.h                  |   2 +
>>   drivers/gpu/host1x/hw/channel_hw.c        |  52 ++++++-
>>   drivers/gpu/host1x/hw/host1x06_hardware.h |  10 ++
>>   drivers/gpu/host1x/hw/host1x07_hardware.h |  10 ++
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c     |  13 ++
>>   include/linux/host1x.h                    |  21 +++
>>   include/linux/host1x_context_bus.h        |  15 ++
>>   22 files changed, 488 insertions(+), 9 deletions(-)
>>   create mode 100644 drivers/gpu/host1x/context.c
>>   create mode 100644 drivers/gpu/host1x/context.h
>>   create mode 100644 drivers/gpu/host1x/context_bus.c
>>   create mode 100644 include/linux/host1x_context_bus.h
>>
> 
> IOMMU/DT folks, any thoughts about this approach? The patches that are 
> of interest outside of Host1x/TegraDRM specifics are patches 1, 2, 4, 
> and 5.

FWIW it looks fairly innocuous to me. I don't understand host1x - 
neither hardware nor driver abstractions - well enough to meaningfully 
review it all (e.g. maybe it's deliberate that the bus .dma_configure 
method isn't used?), but the SMMU patch seems fine given the Kconfig 
solution to avoid module linkage problems.

Cheers,
Robin.
