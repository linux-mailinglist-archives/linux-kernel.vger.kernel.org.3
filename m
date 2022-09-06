Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1465AE61D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 13:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiIFLAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239828AbiIFLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 07:00:19 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48C6576752
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 04:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=2O36e
        ECB5BuZ0d6JGjlpKqyVLf4hom/1qxnJ/phFFe0=; b=ZB6xj1t0TxGh5nWoee937
        +fav66yp0tyaoIrGTHB9CKScYrTssJdZDzLnApzGZcXQtwQ5y+mQ30l1CSckvV+E
        X9QuGtvIy9Juw486axkOZqU+ZRIDR0lLvZMcxRTJdNputQxvgyqe+2YdBnqPMDZD
        c2Ti2wRf07qvzTQPP0b3Y8=
Received: from whoami-VirtualBox.. (unknown [223.72.91.155])
        by smtp11 (Coremail) with SMTP id D8CowAAngYjFJxdjoZMDAQ--.5323S2;
        Tue, 06 Sep 2022 18:58:13 +0800 (CST)
From:   Jinyu Tang <tjytimi@163.com>
To:     conor.dooley@microchip.com
Cc:     akpm@linux-foundation.org, alexandre.ghiti@canonical.com,
        anshuman.khandual@arm.com, anup@brainfault.org,
        aou@eecs.berkeley.edu, atishp@rivosinc.com, falcon@tinylab.org,
        guoren@kernel.org, heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        panqinglin2020@iscas.ac.cn, paul.walmsley@sifive.com,
        sunnanyong@huawei.com, tjytimi@163.com, tongtiangen@huawei.com
Subject: Re:Re: [PATCH v2] riscv: make update_mmu_cache to support asid
Date:   Tue,  6 Sep 2022 18:57:56 +0800
Message-Id: <20220906105756.6082-1-tjytimi@163.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7e17ceaf-6648-e099-d526-8b698eaa5a04@microchip.com>
References: <7e17ceaf-6648-e099-d526-8b698eaa5a04@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAngYjFJxdjoZMDAQ--.5323S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF48Gr4fXrWUKFyUXrWUArb_yoWrJrW7pF
        srGan5KayfGr97Gry2qrnI9r17Xw4kK3WayrWSvrW5twsIgF1UKF9xKry09r1rJFy8WrWI
        kayjyr13u3yYywUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRRwZrUUUUU=
X-Originating-IP: [223.72.91.155]
X-CM-SenderInfo: xwm13xlpl6il2tof0z/1tbiTgV0eFUDRgewlQAAs1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your guidance.^ ^

Sincerely yours,
Jinyu

At 2022-09-04 21:49:31, Conor.Dooley@microchip.com wrote:
>On 04/09/2022 14:37, Jinyu Tang wrote:
>> The `update_mmu_cache` function in riscv flush tlb cache without asid
>
>FWIW, when referring to functions please put the () at the end.
>Makes the changelog more natural to read. You do not need to make
>a v3 for that though.
>
>Thanks,
>Conor.
>
>> information now, which will flush tlbs in other tasks' address space
>> even if processor supports asid. So add a new function
>> `flush_tlb_local_one_page` to flush local one page whether processor
>> supports asid or not,for cases that need to flush local one page like
>> function `update_mmu_cache`.
>> 
>> Signed-off-by: Jinyu Tang <tjytimi@163.com>
>> ---
>> RFC V1 -> V2 : 
>> 1.Rebased on PATCH9 of IPI imporvement series as Anup Patel
>> suggestion. 
>> 2.Make commit log more clear.
>> 
>>  arch/riscv/include/asm/pgtable.h  |  2 +-
>>  arch/riscv/include/asm/tlbflush.h |  2 ++
>>  arch/riscv/mm/tlbflush.c          | 11 +++++++++++
>>  3 files changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 7ec936910a96..09ccefa6b6c7 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -415,7 +415,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>>  	 * Relying on flush_tlb_fix_spurious_fault would suffice, but
>>  	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
>>  	 */
>> -	local_flush_tlb_page(address);
>> +	flush_tlb_local_one_page(vma, address);
>>  }
>>  
>>  static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> index 801019381dea..120aeb1c6ecf 100644
>> --- a/arch/riscv/include/asm/tlbflush.h
>> +++ b/arch/riscv/include/asm/tlbflush.h
>> @@ -30,6 +30,7 @@ static inline void local_flush_tlb_page(unsigned long addr)
>>  #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>>  void flush_tlb_all(void);
>>  void flush_tlb_mm(struct mm_struct *mm);
>> +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr);
>>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>  		     unsigned long end);
>> @@ -42,6 +43,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>  
>>  #define flush_tlb_all() local_flush_tlb_all()
>>  #define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
>> +#define flush_tlb_local_one_page(vma, addr) local_flush_tlb_page(addr)
>>  
>>  static inline void flush_tlb_range(struct vm_area_struct *vma,
>>  		unsigned long start, unsigned long end)
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 27a7db8eb2c4..0843e1baaf34 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -41,6 +41,17 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>>  		local_flush_tlb_all_asid(asid);
>>  }
>>  
>> +void flush_tlb_local_one_page(struct vm_area_struct *vma, unsigned long addr)
>> +{
>> +	if (static_branch_unlikely(&use_asid_allocator)) {
>> +		unsigned long asid = atomic_long_read(&vma->vm_mm->context.id);
>> +
>> +		local_flush_tlb_page_asid(addr, asid);
>> +	} else {
>> +		local_flush_tlb_page(addr);
>> +	}
>> +}
>> +
>>  static void __ipi_flush_tlb_all(void *info)
>>  {
>>  	local_flush_tlb_all();

