Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3E5334AB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiEYBYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbiEYBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:24:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D8A6A071
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 18:24:37 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L7Cvg4y4WzQkDn;
        Wed, 25 May 2022 09:21:35 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 09:24:35 +0800
Message-ID: <6c692ace-9902-e11f-21c2-ef464be4d3c6@huawei.com>
Date:   Wed, 25 May 2022 09:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] riscv/kprobe: reclaim insn_slot on kprobe unregistration
To:     Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <peterz@infradead.org>,
        <naveen.n.rao@linux.vnet.ibm.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20220523015124.98743-1-liaochang1@huawei.com>
 <Yoz16RUZvfyxmywT@xhacker>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <Yoz16RUZvfyxmywT@xhacker>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/24 23:12, Jisheng Zhang 写道:
> On Mon, May 23, 2022 at 09:51:24AM +0800, Liao Chang wrote:
>> On kprobe registration kernel allocate one insn_slot for new kprobe,
>> but it forget to reclaim the insn_slot on unregistration, leading to a
>> potential leakage.
> 
> + Guo Ren
> 
> Nice catch! I think csky needs the fix as well.
> 
>>
>> This bug reported by Chen Guokai <chenguokai17@mails.ucas.ac.cn>.
> 
> This needs a "Reported-by: ..." tag

Thanks for comment.

> 
>>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
>> index e6e950b7cf32..f12eb1fbb52c 100644
>> --- a/arch/riscv/kernel/probes/kprobes.c
>> +++ b/arch/riscv/kernel/probes/kprobes.c
>> @@ -110,6 +110,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
>>  
>>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>>  {
>> +	if (p->ainsn.api.insn) {
>> +		free_insn_slot(p->ainsn.api.insn, 0);
>> +		p->ainsn.api.insn = NULL;
>> +	}
>>  }
>>  
>>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>> -- 
>> 2.17.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> .

-- 
BR,
Liao, Chang
