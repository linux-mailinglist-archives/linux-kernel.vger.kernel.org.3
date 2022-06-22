Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA6554DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358693AbiFVOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358184AbiFVOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:49:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1323DDE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:49:08 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LSmV00NqVz689nQ;
        Wed, 22 Jun 2022 22:48:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 16:49:06 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 15:49:05 +0100
Message-ID: <fbfbb793-78ce-2b5a-307f-c6e78a926db3@huawei.com>
Date:   Wed, 22 Jun 2022 15:49:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [aarch64] INFO: rcu_sched detected expedited stalls on CPUs/tasks
To:     Bruno Goncalves <bgoncalv@redhat.com>
CC:     Pierre Gondois <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Ionela Voinescu <Ionela.Voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <CA+QYu4qTWaDzep2GGxm-63r-xJOFf2rFCCNhWupAgZdKE7HV6w@mail.gmail.com>
 <99a207dc-93cd-1bea-2ffc-404a9f6587bf@arm.com>
 <CA+QYu4o0OqdwZYFCgCzm2CMHA7pM3nQ+j0_VbHtpFcdJmkMbhw@mail.gmail.com>
 <fe20591a-96bf-2ac5-c97f-442c2b36c455@arm.com>
 <CA+QYu4rFB0-no98R0jfzDi2z1Q-aXsEyj1+j-G7RNBi1=3SLkQ@mail.gmail.com>
 <90175f7e-0a2f-c83d-6fb5-916f885bbe81@huawei.com>
 <CA+QYu4r9Z1X3b-PxqcQx3OkdASkon9OvPAVWJcqHLtc2uPkFtA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <CA+QYu4r9Z1X3b-PxqcQx3OkdASkon9OvPAVWJcqHLtc2uPkFtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/2022 15:40, Bruno Goncalves wrote:

Hi Bruno,

> With the config change that does not set
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT the problem seems to be fixed for us.
> The newer Fedora kernels already have the config fixed.
> 

OK, thanks for the info. Well those debug options I enabled didn't cause 
problems previously. I'll see if it is one in particular and go from there.

> 
>> On v5.19-rc3 I just enabled some debug configs on a vanilla kernel and
>> can easily reproduce a RCU stall on boot, as below.
>>
>> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=0 for me, that being the default.
>>
>>    Table To iBMC Success.
>> GetVariable Status : Not Found.
>> [    0.000000] Booting Linux on physical CPU 0x0000010000 [0x410fd082]
>> [    0.000000] Linux version 5.19.0-rc3-00001-gd8610c1c16e8
>> (john@debian) (gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
>> Binutils for Debian) 2.37) #187 SMP PREEMPT Wed Jun 22 14:08:56 BST 2022
>> [    0.000000] Machine model: Hisilicon PhosphorV660 Development Board
>> [    0.000000] efi: EFI v2.60 by EDK II
>> [    0.000000] efi: SMBIOS=0x3eff0000 SMBIOS 3.0=0x39aa0000
>> ACPI=0x39b70000 ACPI 2.0=0x39b70014 MEMATTR=0x3b8d0018
>> MEMRESERVE=0x3a002d18

Thanks!
