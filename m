Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ED95A40E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 04:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiH2CKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 22:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2CKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 22:10:31 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7B1705C
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 19:10:30 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MGDP02YkQznTd5;
        Mon, 29 Aug 2022 10:08:04 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 10:10:28 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 10:10:27 +0800
Subject: Re: [PATCH -next v3 1/5] frontswap: skip frontswap_ops init if zswap
 init failed.
To:     Vitaly Wool <vitaly.wool@konsulko.com>
References: <20220827104600.1813214-1-liushixin2@huawei.com>
 <20220827104600.1813214-2-liushixin2@huawei.com>
 <CAM4kBB+z6jNKNOv9zK8qxku172abPmQ_XZ7YdyJyf=_NDjRVHA@mail.gmail.com>
CC:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <06a79a47-727f-fae2-4620-dcf6703efacb@huawei.com>
Date:   Mon, 29 Aug 2022 10:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAM4kBB+z6jNKNOv9zK8qxku172abPmQ_XZ7YdyJyf=_NDjRVHA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/29 4:44, Vitaly Wool wrote:
> On Sat, Aug 27, 2022 at 12:12 PM Liu Shixin <liushixin2@huawei.com> wrote:
>> If zswap initial failed or has not been initial, frontswap_ops will be
>> NULL. In such situation, swap device would enable failed with following
>> stack trace:
>>
>>   Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
>>   Mem abort info:
>>     ESR = 0x0000000096000004
>>     EC = 0x25: DABT (current EL), IL = 32 bits
>>     SET = 0, FnV = 0
>>     EA = 0, S1PTW = 0
>>     FSC = 0x04: level 0 translation fault
>>   Data abort info:
>>     ISV = 0, ISS = 0x00000004
>>     CM = 0, WnR = 0
>>   user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4fab000
>>   [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
>>   Internal error: Oops: 96000004 [#1] SMP
>>   Modules linked in: zram fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme lm90 nvme_core at803x xhci_plat_hcd rtc_fsl_ftm_alarm xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables fuse
>>   Unloaded tainted modules: cppc_cpufreq():1
>>   CPU: 10 PID: 761 Comm: swapon Not tainted 6.0.0-rc2-00454-g22100432cf14 #1
>>   Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
>>   pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>   pc : frontswap_init+0x38/0x60
>>   lr : __do_sys_swapon+0x8a8/0x9f4
>>   sp : ffff80000969bcf0
>>   x29: ffff80000969bcf0 x28: ffff37bee0d8fc00 x27: ffff80000a7f5000
>>   x26: fffffcdefb971e80 x25: ffffaba797453b90 x24: 0000000000000064
>>   x23: ffff37c1f209d1a8 x22: ffff37bee880e000 x21: ffffaba797748560
>>   x20: ffff37bee0d8fce4 x19: ffffaba797748488 x18: 0000000000000014
>>   x17: 0000000030ec029a x16: ffffaba795a479b0 x15: 0000000000000000
>>   x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000001
>>   x11: ffff37c63c0aba18 x10: 0000000000000000 x9 : ffffaba7956b8c88
>>   x8 : ffff80000969bcd0 x7 : 0000000000000000 x6 : 0000000000000000
>>   x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffaba79730f000
>>   x2 : ffff37bee0d8fc00 x1 : 0000000000000000 x0 : 0000000000000000
>>   Call trace:
>>   frontswap_init+0x38/0x60
>>   __do_sys_swapon+0x8a8/0x9f4
>>   __arm64_sys_swapon+0x28/0x3c
>>   invoke_syscall+0x78/0x100
>>   el0_svc_common.constprop.0+0xd4/0xf4
>>   do_el0_svc+0x38/0x4c
>>   el0_svc+0x34/0x10c
>>   el0t_64_sync_handler+0x11c/0x150
>>   el0t_64_sync+0x190/0x194
>>   Code: d000e283 910003fd f9006c41 f946d461 (f9400021)
>>   ---[ end trace 0000000000000000 ]---
>>
> Well, this issue you are seeing is in fact introduced by the following patch:
>
> author Christoph Hellwig <hch@lst.de> 2022-01-21 22:15:10 -0800
> frontswap: remove support for multiple ops
>
> So I would rather see that one reverted and fixed.
>
> Thanks,
> Vitaly
It is surely introduced by the previous patch ,but is it need to revert that patch? Do we have
any plans to add new backend in the future?

Thanks,
>
>> Reported-by: Nathan Chancellor <nathan@kernel.org>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
>>  mm/frontswap.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/frontswap.c b/mm/frontswap.c
>> index 1a97610308cb..620f95af81dd 100644
>> --- a/mm/frontswap.c
>> +++ b/mm/frontswap.c
>> @@ -125,7 +125,8 @@ void frontswap_init(unsigned type, unsigned long *map)
>>          * p->frontswap set to something valid to work properly.
>>          */
>>         frontswap_map_set(sis, map);
>> -       frontswap_ops->init(type);
>> +       if (frontswap_ops)
>> +               frontswap_ops->init(type);
>>  }
>>
>>  static bool __frontswap_test(struct swap_info_struct *sis,
>> --
>> 2.25.1
>>
> .
>

