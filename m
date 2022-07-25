Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD8957FEAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiGYL5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbiGYL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:57:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F89FD0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:57:34 -0700 (PDT)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lrz510NF2z67sTc;
        Mon, 25 Jul 2022 19:55:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 13:57:32 +0200
Received: from [10.126.173.156] (10.126.173.156) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 12:57:31 +0100
Message-ID: <25237c44-ebc4-fc9a-7c6f-3e990f968038@huawei.com>
Date:   Mon, 25 Jul 2022 12:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   John Garry <john.garry@huawei.com>
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
In-Reply-To: <CAK8P3a0umWWic6LAzxXJ7BACYVE--m-wbynh7Z8F+pGoUBxGTA@mail.gmail.com>
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

On 24/07/2022 21:35, Arnd Bergmann wrote:

Here's a brief'ish summary for why it's ok to delete these mentioned 
configs:

> CONFIG_ARCH_BCMBCA=y

On next-20220722, config ARCH_BCMBCA is selected by config ARCH_BCM4908 
from arch/arm64/Kconfig.platforms and the latter is enabled in the 
defconfig, so no need to explicitly enable in the defconfig.

On arm-soc arm/defconfig, config ARCH_BCMBCA does not exist for arm64 
platforms yet, so this is why we see this config deleted for the sync.
> CONFIG_SECCOMP=y

Since commit 282a181b1a0d, config SECCOMP was changed to def_bool y, so 
no need to explicitly enable in the defconfig.

> CONFIG_QRTR=m

 From commit fdf4632aa834, we enable config ATH11K_PCI, which selects 
config QRTR, so no need to explicitly enable in the defconfig.

> CONFIG_PINCTRL_MSM=y

 From commit c807a335d3b1, config PINCTRL_SM8450 is enabled, which 
selects PINCTRL_MSM, so no need to explicitly enable in the defconfig.

> CONFIG_SND_SOC_TEGRA210_OPE=m

There is no issue on next-20220722.

On arm-soc arm/defconfig, config SND_SOC_TEGRA210_OPE just does not yet 
exist, so that's why it get removed from the sync of the defconfig.

> CONFIG_MAILBOX=y

In commit fc739069aa92, config MAILBOX was enabled in the defconfig but 
it was already being enabled from elsewhere. There was definitely no 
sync of the savedefconfig going on there :)

> CONFIG_QCOM_ICC_BWMON=m

Commit 76f11e77f919 enabled config QCOM_ICC_BWMON, but like config 
ARCH_BCMBCA, that config does not exist on arm-soc arm/defconfig branch

On next-20220722, no sync is required

> CONFIG_SLIMBUS=m

Config 5bd773242f75 added a kconfig "imply" on config SLIMBUS from 
config SOUNDWIRE_QCOM, and this happens to mean that we don't explicitly 
require config SLIMBUS enabled in the defconfig.

> CONFIG_INTERCONNECT=y

Since commit 06f079816d4c, config TEGRA_MC added a kconfig select on 
config INTERCONNECT, so no need to explicitly enable from the kconfig

> CONFIG_CONFIGFS_FS=y

 From commit cd8bc7d4eb66, config PCI_ENDPOINT_CONFIGFS is enabled in 
the defconfig, and this selects CONFIG_CONFIGFS_FS, so no need to have 
explicit enabling in the defconfig.

We still have issues on next-22072022:
CONFIG_ARM_CPUIDE
CONFIG_DEBUG_INFO
CONFIG_DEBUG_INFO_REDUCED

The latter two are not an issue on the arm-soc arm/defconfig.

So let me know if any comments or how to proceed.

And would each config item deletion merit a separate patch?

Thanks,
John
