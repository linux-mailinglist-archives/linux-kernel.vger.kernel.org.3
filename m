Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5F5A33A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 04:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239982AbiH0CBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 22:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345226AbiH0CBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:01:22 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1303A26117
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:01:19 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MF0J72SNdzGpnw;
        Sat, 27 Aug 2022 09:59:35 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:01:18 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 10:01:17 +0800
Message-ID: <c1c22a8b-bc27-41e0-e709-c2d9fb9bc11c@huawei.com>
Date:   Sat, 27 Aug 2022 10:01:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next 2/3] mm/zswap: delay the initializaton of zswap
 until the first enablement
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220825142037.3214152-1-liushixin2@huawei.com>
 <20220825142037.3214152-3-liushixin2@huawei.com>
 <YwksRZPIfXmlOmHR@dev-arch.thelio-3990X>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <YwksRZPIfXmlOmHR@dev-arch.thelio-3990X>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/27 4:25, Nathan Chancellor wrote:
> Hi Liu,
>
> On Thu, Aug 25, 2022 at 10:20:36PM +0800, Liu Shixin wrote:
>> In the initialization of zswap, about 18MB memory will be allocated for
>> zswap_pool in my machine. Since not all users use zswap, the memory may be
>> wasted. Save the memory for these users by delaying the initialization of
>> zswap to first enablement.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
...
>> This change is in -next as commit 22100432cf14 ("mm/zswap: delay the
>> initializaton of zswap until the first enablement"). I just bisected my
>> arm64 test system running Fedora failing to boot due to that commit,
>> with the following stack trace:
>>
>>    Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
>>    Mem abort info:
>>      ESR = 0x0000000096000004
>>      EC = 0x25: DABT (current EL), IL = 32 bits
>>      SET = 0, FnV = 0
>>      EA = 0, S1PTW = 0
>>      FSC = 0x04: level 0 translation fault
>>    Data abort info:
>>      ISV = 0, ISS = 0x00000004
>>      CM = 0, WnR = 0
>>    user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4fab000
>>    [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>>    Internal error: Oops: 96000004 [#1] SMP
>>    Modules linked in: zram fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme lm90 nvme_core at803x xhci_plat_hcd rtc_fsl_ftm_alarm xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables fuse
>>    Unloaded tainted modules: cppc_cpufreq():1
>>    CPU: 10 PID: 761 Comm: swapon Not tainted 6.0.0-rc2-00454-g22100432cf14 #1
>>    Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
>>    pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>    pc : frontswap_init+0x38/0x60
>>    lr : __do_sys_swapon+0x8a8/0x9f4
>>    sp : ffff80000969bcf0
>>    x29: ffff80000969bcf0 x28: ffff37bee0d8fc00 x27: ffff80000a7f5000
>>    x26: fffffcdefb971e80 x25: ffffaba797453b90 x24: 0000000000000064
>>    x23: ffff37c1f209d1a8 x22: ffff37bee880e000 x21: ffffaba797748560
>>    x20: ffff37bee0d8fce4 x19: ffffaba797748488 x18: 0000000000000014
>>    x17: 0000000030ec029a x16: ffffaba795a479b0 x15: 0000000000000000
>>    x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000001
>>    x11: ffff37c63c0aba18 x10: 0000000000000000 x9 : ffffaba7956b8c88
>>    x8 : ffff80000969bcd0 x7 : 0000000000000000 x6 : 0000000000000000
>>    x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffaba79730f000
>>    x2 : ffff37bee0d8fc00 x1 : 0000000000000000 x0 : 0000000000000000
>>    Call trace:
>>    frontswap_init+0x38/0x60
>>    __do_sys_swapon+0x8a8/0x9f4
>>    __arm64_sys_swapon+0x28/0x3c
>>    invoke_syscall+0x78/0x100
>>    el0_svc_common.constprop.0+0xd4/0xf4
>>    do_el0_svc+0x38/0x4c
>>    el0_svc+0x34/0x10c
>>    el0t_64_sync_handler+0x11c/0x150
>>    el0t_64_sync+0x190/0x194
>>    Code: d000e283 910003fd f9006c41 f946d461 (f9400021)
>>    ---[ end trace 0000000000000000 ]---
>>
>> This is with Fedora's configuration:
>>
>> https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
>>
>> If there is any more information I can provide or patches I can test, I
>> am more than happy to do so!
Thanks for your reporting，we will check it.
>
> Cheers,
> Nathan
>
> .
