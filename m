Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7915B1237
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiIHByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiIHByd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:54:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139D095AD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:54:32 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MNMXJ5fkWzkWv0;
        Thu,  8 Sep 2022 09:50:40 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 8 Sep 2022 09:54:30 +0800
Message-ID: <819b4964-0f81-74d4-1dd5-e836326447ec@huawei.com>
Date:   Thu, 8 Sep 2022 09:54:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] riscv: kprobes: Free instruction in arch_remove_kprobe()
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1662601156-25802-1-git-send-email-yangtiezhu@loongson.cn>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <1662601156-25802-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu,

This bug is fixed already, see https://lore.kernel.org/all/cd9a856b-ed8a-88f1-da69-4fb628c28f34@huawei.com/T/

在 2022/9/8 9:39, Tiezhu Yang 写道:
> Call free_insn_slot() to free instruction in arch_remove_kprobe()
> as other arches do.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/riscv/kernel/probes/kprobes.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
> index e6e950b..f12eb1f 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -110,6 +110,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
>  
>  void __kprobes arch_remove_kprobe(struct kprobe *p)
>  {
> +	if (p->ainsn.api.insn) {
> +		free_insn_slot(p->ainsn.api.insn, 0);
> +		p->ainsn.api.insn = NULL;
> +	}
>  }
>  
>  static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)

-- 
BR,
Liao, Chang
