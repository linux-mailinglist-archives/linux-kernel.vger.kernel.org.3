Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9303A53B144
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiFBBCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbiFBBCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:02:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B4258DC9;
        Wed,  1 Jun 2022 18:02:13 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LD74C5FsSzjWwG;
        Thu,  2 Jun 2022 09:00:59 +0800 (CST)
Received: from [10.67.111.227] (10.67.111.227) by
 kwepemi500014.china.huawei.com (7.221.188.232) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 09:02:10 +0800
Subject: Re: [PATCH] RISCV: kexec: Fix build error without CONFIG_MODULES
To:     Randy Dunlap <rdunlap@infradead.org>, <palmer@rivosinc.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <liaochang1@huawei.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>, <linux-next@vger.kernel.org>
References: <20220601063924.13037-1-lizhengyu3@huawei.com>
 <b9c831a3-44ab-0374-34f8-8bd8bc311e5c@infradead.org>
From:   "lizhengyu (E)" <lizhengyu3@huawei.com>
Message-ID: <cf78d358-fb43-8366-c648-ae6c0085b51d@huawei.com>
Date:   Thu, 2 Jun 2022 09:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b9c831a3-44ab-0374-34f8-8bd8bc311e5c@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Jun 2022 09:08:16 -0700, Randy Dunlap <rdunlap@infradead.org> 
wrote:
> Hi--
>
> On 5/31/22 23:39, Li Zhengyu wrote:
>> When CONFIG_MODULES is not set/enabled:
>>
>> ../arch/riscv/kernel/elf_kexec.c:353:9: error: unknown type name 'Elf_Rela'; did you mean 'Elf64_Rela'?
>>    353 |         Elf_Rela *relas;
>>        |         ^~~~~~~~
>>        |         Elf64_Rela
>>
>> Replace Elf_Rela by Elf64_Rela to avoid relying on CONFIG_MODULES.
>>
> BTW, does this mean that RISC-V kexec is only available on 64BIT
> and not on 32BIT?

Currently, yes, CONFIG_KEXEC_FILE depends on 64BIT.

Palmer is working on it, see 
https://lore.kernel.org/all/20220520154430.18593-1-palmer@rivosinc.com/ .

>
> thanks.
>
>> Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
>> ---
>>   arch/riscv/kernel/elf_kexec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/elf_kexec.c b/arch/riscv/kernel/elf_kexec.c
>> index 9cb85095fd45..0cb94992c15b 100644
>> --- a/arch/riscv/kernel/elf_kexec.c
>> +++ b/arch/riscv/kernel/elf_kexec.c
>> @@ -349,7 +349,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>   {
>>   	const char *strtab, *name, *shstrtab;
>>   	const Elf_Shdr *sechdrs;
>> -	Elf_Rela *relas;
>> +	Elf64_Rela *relas;
>>   	int i, r_type;
>>   
>>   	/* String & section header string table */
