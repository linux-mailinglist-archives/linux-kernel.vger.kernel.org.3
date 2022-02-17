Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD54B9AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiBQIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:20:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiBQIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:20:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D0D297226
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 00:20:11 -0800 (PST)
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JznlV5lmXz9sm2;
        Thu, 17 Feb 2022 16:18:30 +0800 (CST)
Received: from [10.67.110.136] (10.67.110.136) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Thu, 17 Feb 2022 16:20:08 +0800
Subject: Re: [PATCH -v2] powerpc/process, kasan: Silence KASAN warnings in
 __get_wchan()
To:     <catalin.marinas@arm.com>, <mpe@ellerman.id.au>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <sxwjean@gmail.com>, <peterz@infradead.org>,
        <keescook@chromium.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <huwanming@huaweil.com>, <chenjingwen6@huawei.com>
References: <20220119015025.136902-1-heying24@huawei.com>
 <20220121014418.155675-1-heying24@huawei.com>
From:   He Ying <heying24@huawei.com>
Message-ID: <06c5f730-c383-34f9-778f-6845ca36c718@huawei.com>
Date:   Thu, 17 Feb 2022 16:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220121014418.155675-1-heying24@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.136]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,


Kindly ping. This patch may be missed. Would you please pick it? Or does 
it need more review?


ÔÚ 2022/1/21 9:44, He Ying Ð´µÀ:
> The following KASAN warning was reported in our kernel.
>
>    BUG: KASAN: stack-out-of-bounds in get_wchan+0x188/0x250
>    Read of size 4 at addr d216f958 by task ps/14437
>
>    CPU: 3 PID: 14437 Comm: ps Tainted: G           O      5.10.0 #1
>    Call Trace:
>    [daa63858] [c0654348] dump_stack+0x9c/0xe4 (unreliable)
>    [daa63888] [c035cf0c] print_address_description.constprop.3+0x8c/0x570
>    [daa63908] [c035d6bc] kasan_report+0x1ac/0x218
>    [daa63948] [c00496e8] get_wchan+0x188/0x250
>    [daa63978] [c0461ec8] do_task_stat+0xce8/0xe60
>    [daa63b98] [c0455ac8] proc_single_show+0x98/0x170
>    [daa63bc8] [c03cab8c] seq_read_iter+0x1ec/0x900
>    [daa63c38] [c03cb47c] seq_read+0x1dc/0x290
>    [daa63d68] [c037fc94] vfs_read+0x164/0x510
>    [daa63ea8] [c03808e4] ksys_read+0x144/0x1d0
>    [daa63f38] [c005b1dc] ret_from_syscall+0x0/0x38
>    --- interrupt: c00 at 0x8fa8f4
>        LR = 0x8fa8cc
>
>    The buggy address belongs to the page:
>    page:98ebcdd2 refcount:0 mapcount:0 mapping:00000000 index:0x2 pfn:0x1216f
>    flags: 0x0()
>    raw: 00000000 00000000 01010122 00000000 00000002 00000000 ffffffff 00000000
>    raw: 00000000
>    page dumped because: kasan: bad access detected
>
>    Memory state around the buggy address:
>     d216f800: 00 00 00 00 00 f1 f1 f1 f1 00 00 00 00 00 00 00
>     d216f880: f2 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>    >d216f900: 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00
>                                              ^
>     d216f980: f2 f2 f2 f2 f2 f2 f2 00 00 00 00 00 00 00 00 00
>     d216fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> After looking into this issue, I find the buggy address belongs
> to the task stack region. It seems KASAN has something wrong.
> I look into the code of __get_wchan in x86 architecture and
> find the same issue has been resolved by the commit
> f7d27c35ddff ("x86/mm, kasan: Silence KASAN warnings in get_wchan()").
> The solution could be applied to powerpc architecture too.
>
> As Andrey Ryabinin said, get_wchan() is racy by design, it may
> access volatile stack of running task, thus it may access
> redzone in a stack frame and cause KASAN to warn about this.
>
> Use READ_ONCE_NOCHECK() to silence these warnings.
>
> Reported-by: Wanming Hu <huwanming@huaweil.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> Signed-off-by: Chen Jingwen <chenjingwen6@huawei.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
> Changelog:
>
> v2:
> * Add missing Reported-by and SoB tags
> ---
>   arch/powerpc/kernel/process.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 984813a4d5dc..a75d20f23dac 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2160,12 +2160,12 @@ static unsigned long ___get_wchan(struct task_struct *p)
>   		return 0;
>   
>   	do {
> -		sp = *(unsigned long *)sp;
> +		sp = READ_ONCE_NOCHECK(*(unsigned long *)sp);
>   		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD) ||
>   		    task_is_running(p))
>   			return 0;
>   		if (count > 0) {
> -			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
> +			ip = READ_ONCE_NOCHECK(((unsigned long *)sp)[STACK_FRAME_LR_SAVE]);
>   			if (!in_sched_functions(ip))
>   				return ip;
>   		}
