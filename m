Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC44C3ACB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiBYBVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiBYBVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:21:10 -0500
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Feb 2022 17:20:38 PST
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9AB720D538;
        Thu, 24 Feb 2022 17:20:38 -0800 (PST)
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxKMoGLRhih7AGAA--.12265S3;
        Fri, 25 Feb 2022 09:12:39 +0800 (CST)
Subject: Re: [PATCH] MIPS: Refactor early_parse_mem() to fix mem= parameter
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
References: <1645707132-10121-1-git-send-email-yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Xuefeng Li <lixuefeng@loongson.cn>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <20d9c6d4-7df4-8a26-4b0f-a5a192cae78d@loongson.cn>
Date:   Fri, 25 Feb 2022 09:12:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1645707132-10121-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxKMoGLRhih7AGAA--.12265S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1UKw47Jry7Kr4Utw18Xwb_yoW5Xw4kpw
        4Iv34SkrsrJF97ZayxtFn8urWrZw1vkFy0qa4Ikwn5A3Wqkr18Gr1IgF45ZryIgrW8A3W0
        qF1qyasY939Fy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07Al
        zVAYIcxG8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjfU5kucDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tiezhu

On 02/24/2022 08:52 PM, Tiezhu Yang wrote:
> According to Documentation/admin-guide/kernel-parameters.txt,
> the kernel command-line parameter mem= means "Force usage of
> a specific amount of memory", but when add "mem=3G" to the
> command-line, kernel boot hangs in sparse_init().
>
> This commit is similar with the implementation of the other
> archs such as arm64, powerpc and riscv, refactor the function
> early_parse_mem() and then use memblock_enforce_memory_limit()
> to limit the memory size.
>
> With this patch, when add "mem=3G" to the command-line, the
> kernel boots successfully, we can see the following messages:
>
>    [    0.000000] Memory limited to 3072MB
>    ...
>    [    0.000000] Memory: 2991952K/3145728K available (...)
>
> After login, the output of free command is consistent with the
> above log.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/kernel/setup.c | 25 ++++++++-----------------
>   1 file changed, 8 insertions(+), 17 deletions(-)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index f979adf..2917412 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -339,27 +339,15 @@ static void __init bootmem_init(void)
>   #endif	/* CONFIG_SGI_IP27 */
>   
>   static int usermem __initdata;
> +static phys_addr_t memory_limit;
>   
>   static int __init early_parse_mem(char *p)
>   {
> -	phys_addr_t start, size;
> -
> -	/*
> -	 * If a user specifies memory size, we
> -	 * blow away any automatically generated
> -	 * size.
> -	 */
> -	if (usermem == 0) {
> -		usermem = 1;
> -		memblock_remove(memblock_start_of_DRAM(),
> -			memblock_end_of_DRAM() - memblock_start_of_DRAM());
> -	}
> -	start = 0;
> -	size = memparse(p, &p);
> -	if (*p == '@')
> -		start = memparse(p + 1, &p);
> +	if (!p)
> +		return 1;
>   
> -	memblock_add(start, size);
> +	memory_limit = memparse(p, &p) & PAGE_MASK;
> +	pr_notice("Memory limited to %lldMB\n", memory_limit >> 20);
>   
>   	return 0;

After applying this patch, my guess is that the kdump operation will fail.

In the MIPS architecture, when the kdump operation is performed, a
"mem=YM@XM" parameter will be added to the capture kernel (added by
kexec-tools), indicating that the available memory range of the
capture kernel is [X, X+Y).

After the "mem" parameter is changed to the above, there will be only
a similar parsing function like "mem=3G", and the type like
"mem=128M@64M" cannot be correctly parsed.

Thanks,
Youling.
>   }
> @@ -633,6 +621,9 @@ static void __init arch_mem_init(char **cmdline_p)
>   
>   	parse_early_param();
>   
> +	/* Limit the memory size via mem= command-line parameter */
> +	memblock_enforce_memory_limit(memory_limit);
> +
>   	if (usermem)
>   		pr_info("User-defined physical RAM map overwrite\n");
>   

