Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F975337DF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiEYH7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiEYH7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:59:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52E7CB4B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:59:17 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L7NkR2m1jzDqS5;
        Wed, 25 May 2022 15:59:11 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 15:59:14 +0800
Message-ID: <cd9a856b-ed8a-88f1-da69-4fb628c28f34@huawei.com>
Date:   Wed, 25 May 2022 15:59:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2] riscv/kprobe: reclaim insn_slot on kprobe
 unregistration
To:     Guo Ren <guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        <jszhang@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220525014424.20717-1-liaochang1@huawei.com>
 <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <CAJF2gTS9_1D+K-ok2vxQpbq6B7zxv1K-t8cfcu1hFjF=7a5yxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/25 14:23, Guo Ren 写道:
> On Wed, May 25, 2022 at 9:46 AM Liao Chang <liaochang1@huawei.com> wrote:
>>
>> On kprobe registration kernel allocate one insn_slot for new kprobe,
>> but it forget to reclaim the insn_slot on unregistration, leading to a
>> potential leakage.
>>
>> Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>> v2:
>>   Add Reported-by tag
>>
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
>> +       if (p->ainsn.api.insn) {
>> +               free_insn_slot(p->ainsn.api.insn, 0);
>> +               p->ainsn.api.insn = NULL;
>> +       }
> Thx reviewed-by: Guo Ren <guoren@kernel.org>
> 
> You also could give a fixup patch to csky, thx:
> 
> diff --git a/arch/csky/kernel/probes/kprobes.c
> b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..661da54b418f 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
> 
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +       if (p->ainsn.api.insn) {
> +               free_insn_slot(p->ainsn.api.insn, 0);
> +               p->ainsn.api.insn = NULL;
> +       }
>  }

Sure, I will, thanks.
> 
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
> 
>>  }
>>
>>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
>> --
>> 2.17.1
>>
> 
> 

-- 
BR,
Liao, Chang
