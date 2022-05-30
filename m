Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F9253735E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiE3Bng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiE3Bnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:43:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64664DEAB
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:43:30 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LBJ7K4K7JzjX0y;
        Mon, 30 May 2022 09:42:21 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 30 May 2022 09:43:27 +0800
Message-ID: <59e8faec-05fd-805d-7de0-4b0508f8467f@huawei.com>
Date:   Mon, 30 May 2022 09:43:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] kexec_file: Drop weak attribute from
 arch_kexec_apply_relocations[_add]
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20220519091237.676736-1-naveen.n.rao@linux.vnet.ibm.com>
 <20220529065637.xgapqjp2342flbuj@pengutronix.de>
 <264786d9-7756-19e0-2742-8b8d17f5ace5@csgroup.eu>
 <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <20220529140655.bnd4fgggccrorj4t@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/29 22:06, Uwe Kleine-König 写道:
> Hello,
> 
> On Sun, May 29, 2022 at 09:46:47AM +0000, Christophe Leroy wrote:
>> Le 29/05/2022 à 08:56, Uwe Kleine-König a écrit :
>>> Hello,
>>>
>>> on current linux-next ARCH=riscv allmodconfig breaks with:
>>>
>>>    CC      arch/riscv/kernel/elf_kexec.o
>>> arch/riscv/kernel/elf_kexec.c:345:5: error: redefinition of ‘arch_kexec_apply_relocations_add’
>>>    345 | int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from arch/riscv/kernel/elf_kexec.c:16:
>>> include/linux/kexec.h:236:1: note: previous definition of ‘arch_kexec_apply_relocations_add’ with type ‘int(struct purgatory_info *, Elf64_Shdr *, const Elf64_Shdr *, const Elf64_Shdr *)’ {aka ‘int(struct purgatory_info *, struct elf64_shdr *, const struct elf64_shdr *, const struct elf64_shdr *)’}
>>>    236 | arch_kexec_apply_relocations_add(struct purgatory_info *pi, Elf_Shdr *section,
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> (I think) because there is a conflict between the two commits:
>>>
>>> 233c1e6c319c kexec_file: drop weak attribute from arch_kexec_apply_relocations[_add]
>>> 838b3e28488f RISC-V: Load purgatory in kexec_file
>>>
>>> And so next is broken starting from
>>> 164a9037b1d33f28ba27671c16ec1c23d4a11acf which merges the riscv tree.
>>>
>>
>> In arch/riscv/include/asm/kexec.h, do the same as s390 did in commit 
>> 233c1e6c319c:
>>
>> diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
>> index 7f3c9ac34bd8..540dd469b088 100644
>> --- a/arch/s390/include/asm/kexec.h
>> +++ b/arch/s390/include/asm/kexec.h
>> @@ -83,4 +83,12 @@ struct kimage_arch {
>>   extern const struct kexec_file_ops s390_kexec_image_ops;
>>   extern const struct kexec_file_ops s390_kexec_elf_ops;
>>
>> +#ifdef CONFIG_KEXEC_FILE
>> +struct purgatory_info;
>> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
>> +				     Elf_Shdr *section,
>> +				     const Elf_Shdr *relsec,
>> +				     const Elf_Shdr *symtab);
>> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>> +#endif
>>   #endif /*_S390_KEXEC_H */
> 
> I can confirm that doing
> 
> diff --git a/arch/riscv/include/asm/kexec.h b/arch/riscv/include/asm/kexec.h
> index 206217b23301..eee260e8ab30 100644
> --- a/arch/riscv/include/asm/kexec.h
> +++ b/arch/riscv/include/asm/kexec.h
> @@ -55,6 +55,13 @@ extern riscv_kexec_method riscv_kexec_norelocate;
>  
>  #ifdef CONFIG_KEXEC_FILE
>  extern const struct kexec_file_ops elf_kexec_ops;
> +
> +struct purgatory_info;
> +int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
> +				     Elf_Shdr *section,
> +				     const Elf_Shdr *relsec,
> +				     const Elf_Shdr *symtab);
> +#define arch_kexec_apply_relocations_add arch_kexec_apply_relocations_add
>  #endif
>  
>  #endif

LGTM, you could send a fixup patch to riscv, thanks.

> 
> on top of 838b3e28488f results in a compilable tree. And when merging
> 233c1e6c319c into this, it is still building.
> 
> I'm not enough into kexec (and riscv) to judge if this is sensible, or
> create a useful commit log but the obvious way forward is to apply the
> above patch to the riscv tree before it hits Linus' tree.
> 
> Best regards
> Uwe
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
BR,
Liao, Chang
