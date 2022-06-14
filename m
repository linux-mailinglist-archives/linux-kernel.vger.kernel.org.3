Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D542B54A3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 03:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349669AbiFNBxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 21:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349445AbiFNBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 21:53:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282602F035;
        Mon, 13 Jun 2022 18:53:19 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LMWfX57tpzDrDH;
        Tue, 14 Jun 2022 09:52:52 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 09:53:16 +0800
Subject: Re: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking
 readers from consuming CPU) cause qemu boot slow
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <rcu@vger.kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
References: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <14b775d2-7b7e-02e2-51ee-f7408dd98a62@hisilicon.com>
Date:   Tue, 14 Jun 2022 09:53:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I also encounter a similar issue , and i reported it 
here(https://www.spinics.net/lists/kernel/msg4396974.html).

I tried the change Paul provides on the thread, but the issue is still.


在 2022/6/12 0:32, Zhangfei Gao 写道:
> Hi, Paul
>
> When verifying qemu with acpi rmr feature on v5.19-rc1, the guest 
> kernel stuck for several minutes.
> And on 5.18, there is no such problem.
>
> After revert this patch, the issue solved.
> Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers 
> from  consuming CPU)
>
>
> qemu cmd:
> build/aarch64-softmmu/qemu-system-aarch64 -machine 
> virt,gic-version=3,iommu=smmuv3 \
> -enable-kvm -cpu host -m 1024 \
> -kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
> "rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off 
> acpi=force" \
> -bios QEMU_EFI.fd
>
> log:
> InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
> add-symbol-file 
> /home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll 
> 0x75459000
> Loading driver at 0x00075458000 EntryPoint=0x00075459058 IScsiDxe.efi
> InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 7AA4DE98
> ProtectUefiImageCommon - 0x7AA4D040
>   - 0x0000000075458000 - 0x000000000003F000
> SetUefiImageMemoryAttributes - 0x0000000075458000 - 0x0000000000001000 
> (0x0000000000004008)
> SetUefiImageMemoryAttributes - 0x0000000075459000 - 0x000000000003B000 
> (0x0000000000020008)
> SetUefiImageMemoryAttributes - 0x0000000075494000 - 0x0000000000003000 
> (0x0000000000004008)
> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952C8
> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952F8
> InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
> InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
> InstallProtocolInterface: 59324945-EC44-4C0D-B1CD-9DB139DF070C 75495348
> InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 754953E8
> InstallProtocolInterface: 330D4706-F2A0-4E4F-A369-B66FA8D54385 7AA4D728
>
>
> Not sure it is either reported or solved.
>
> Thanks
>
>
>
>
>
>
>
> .
>

