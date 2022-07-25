Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD58580057
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbiGYODc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiGYOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:03:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D112815812
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:03:27 -0700 (PDT)
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ls1q93bTgz67NvB;
        Mon, 25 Jul 2022 21:58:45 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 25 Jul 2022 16:03:25 +0200
Received: from [10.126.173.156] (10.126.173.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 15:03:24 +0100
Message-ID: <4d5c9bfc-dc10-7019-cad4-751e21f02a18@huawei.com>
Date:   Mon, 25 Jul 2022 15:03:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/2] arm64 defconfig: Get faddr2line working
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        <jpoimboe@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
 <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
 <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CAK8P3a2+0EwSJ=fRBL2JCGypJRL-qE4rEiXYnJbqhZ=weethdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.173.156]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 13:51, Arnd Bergmann wrote:
>>   From commit fdf4632aa834, we enable config ATH11K_PCI, which selects

That should have been 231a136fdf4632a - I chopped off the leading 
characters by accident.

>> config QRTR, so no need to explicitly enable in the defconfig.
> Something is wrong here, as qrtr is used the same way in both ath10k and
> ath11k, but only one of them selects the symbol. My guess is that there is
> no actual hard requirement to enable it.

I'm not sure. From commit 1399fb87ea3e ("ath11k: register MHI controller 
device for QCA6390"), QRTR/MHI bus seems to be used for ath11k only:

Extract from that commit:

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig 
b/drivers/net/wireless/ath/ath11k/Kconfig
index 2a792ddd6fea..7e5094e0e7bb 100644
--- a/drivers/net/wireless/ath/ath11k/Kconfig
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -21,6 +21,9 @@ config ATH11K_AHB
config ATH11K_PCI
        tristate "Atheros ath11k PCI support"
        depends on ATH11K && PCI
+       select MHI_BUS
+       select QRTR
+       select QRTR_MHI


> 
>>> CONFIG_PINCTRL_MSM=y
>>   From commit c807a335d3b1, config PINCTRL_SM8450 is enabled, which
>> selects PINCTRL_MSM, so no need to explicitly enable in the defconfig.
> This looks like a bug, where the driver should have used 'depends on'
> rather than 'select'.

ok, I see that this is the odd one out in that kconfig as the other 
configs "depends on", like you say

> 
>>> CONFIG_SND_SOC_TEGRA210_OPE=m
>> There is no issue on next-20220722.
>>
>> On arm-soc arm/defconfig, config SND_SOC_TEGRA210_OPE just does not yet
>> exist, so that's why it get removed from the sync of the defconfig.
> Ok
> 
>>> CONFIG_MAILBOX=y
>> In commit fc739069aa92, config MAILBOX was enabled in the defconfig but
>> it was already being enabled from elsewhere. There was definitely no
>> sync of the savedefconfig going on there:)
> I see it's selected by a couple of drivers using mailboxes, and I
> agree we shouldn't
> need it here. It might be good to just hide the symbol in this case
> and select it
> consistently from all drivers using it.

Uhh, we have ~15x "select" and ~18x "depends on"...

> 
>>> CONFIG_QCOM_ICC_BWMON=m
>> Commit 76f11e77f919 enabled config QCOM_ICC_BWMON, but like config
>> ARCH_BCMBCA, that config does not exist on arm-soc arm/defconfig branch
>>
>> On next-20220722, no sync is required
> ok
> 
>>> CONFIG_SLIMBUS=m
>> Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from
>> config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly
>> require config SLIMBUS enabled in the defconfig.
> That 'imply' looks like it was added to solve a problem using the old 'imply'
> semantics that are not what this keyword does today.

I didn't even know it existed.

> I suspect it's still
> broken when CONFIG=SOUNDWIRE_QCOM=y and CONFIG_SLIBMUS=m,
> and the correct fix is to use a dependency like
> 
>        depends on SLIMBUS || !SLIMBUS
> 
> so the defconfig symbol should stay.

Let me see if I can break it and then fix it.

> 
>>> CONFIG_INTERCONNECT=y
>> Since commit 06f079816d4c, config TEGRA_MC added a kconfig select on
>> config INTERCONNECT, so no need to explicitly enable from the kconfig
> We have one driver using 'depends on INTERCONNECT' and two drivers
> using 'select INTERCONNECT', so at least one of them is wrong.

INTERCONNECT has no dependencies, so "select" - like for MAILBOX - 
should be fine, I suppose

> 
> There are also a couple of drivers that use neither and instead rely on the
> IS_ENABLED() check in include/linux/interconnect.h, but this is potentially
> wrong in the same way as the SLIMBUS dependency above.
> 
> This clearly needs some more discussion. I would suggest removing the
> #iff check in the header and forcing all users to use 'depends on', leaving
> the defconfig symbol.
> 
>>> CONFIG_CONFIGFS_FS=y
>>   From commit cd8bc7d4eb66, config PCI_ENDPOINT_CONFIGFS is enabled in
>> the defconfig, and this selects CONFIG_CONFIGFS_FS, so no need to have
>> explicit enabling in the defconfig.
> Again, half the users of CONFIGFS_FS use 'depends on', the other half use
> 'select'. We should be consistent here and always use the same method,
> probably 'depends on' if we want to keep it as user-visible.

I don't know ....

> 
>> We still have issues on next-22072022:
>> CONFIG_ARM_CPUIDE
>> CONFIG_DEBUG_INFO
>> CONFIG_DEBUG_INFO_REDUCED
>>
>> The latter two are not an issue on the arm-soc arm/defconfig.
> Ok.
> 
>> So let me know if any comments or how to proceed.
>>
>> And would each config item deletion merit a separate patch?
> You send a combined patch for the obvious ones (secccomp
> and mailbox AFAICT) or send them separately. For the other ones I think
> we should try fixing the Kconfig files first, otherwise we just end up
> putting them back afterwards.

ok, fine. I'll deal with the obvious changes first plus 
CONFIG_DEBUG_INFO and then the non-obvious, non-trivial ones. I'll base 
on your arm/defconfig branch (for defconfig changes).

Thanks,
John
