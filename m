Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140BA47F1AC
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 02:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhLYB7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 20:59:02 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33910 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhLYB7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 20:59:01 -0500
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JLRt15xQxzcc3c;
        Sat, 25 Dec 2021 09:58:33 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 09:58:58 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 09:58:57 +0800
Subject: Re: [PATCH v18 04/17] x86/setup: Add helper
 parse_crashkernel_in_order()
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        <linux-kernel@vger.kernel.org>, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        <kexec@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <devicetree@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Chen Zhou" <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-5-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9291bf01-d295-583c-399c-ea5b544be474@huawei.com>
Date:   Sat, 25 Dec 2021 09:58:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211222130820.1754-5-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/12/22 21:08, Zhen Lei wrote:
> Currently, there are two possible combinations of configurations.
> (1) crashkernel=X[@offset]
> (2) crashkernel=X,high, with or without crashkernel=X,low
> 
> (1) has the highest priority, if it is configured correctly, (2) will be
> ignored. Similarly, in combination (2), crashkernel=X,low is valid only
> when crashkernel=X,high is valid.
> 
> Putting the operations of parsing all "crashkernel=" configurations in one
> function helps to sort out the strong dependency.
> 
> So add helper parse_crashkernel_in_order(). The "__maybe_unused" will be
> removed in the next patch.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/x86/kernel/setup.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index d9080bfa131a654..f997074d36f2484 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -439,6 +439,57 @@ static int __init reserve_crashkernel_low(void)
>  }
>  #endif
>  
> +#define CRASHKERNEL_MEM_NONE		0x0	/* crashkernel= is not exist or invalid */
> +#define CRASHKERNEL_MEM_CLASSIC		0x1	/* crashkernel=X[@offset] is valid */
> +#define CRASHKERNEL_MEM_HIGH		0x2	/* crashkernel=X,high is valid */
> +#define CRASHKERNEL_MEM_LOW		0x4	/* crashkernel=X,low is valid */
> +
> +/**
> + * parse_crashkernel_in_order - Parse all "crashkernel=" configurations in
> + *				priority order until a valid combination is found.
> + * @cmdline:	The bootup command line.
> + * @system_ram: Total system memory size.
> + * @crash_size: Save the memory size specified by "crashkernel=X[@offset]" or
> + *		"crashkernel=X,high".
> + * @crash_base: Save the base address specified by "crashkernel=X@offset"
> + * @low_size:	Save the memory size specified by "crashkernel=X,low"
> + *
> + * Returns the status flag of the parsing result of "crashkernel=", such as
> + * CRASHKERNEL_MEM_NONE, CRASHKERNEL_MEM_HIGH.
> + */
> +__maybe_unused
> +static int __init parse_crashkernel_in_order(char *cmdline,
> +					     unsigned long long system_ram,
> +					     unsigned long long *crash_size,
> +					     unsigned long long *crash_base,
> +					     unsigned long long *low_size)

I rethought yesterday that this function name is not self-annotated. In addition,
the meaning of the return value is not mainstream. It would be better to change it
to parse_crashkernel_high_low().

> +{
> +	int ret, flag = CRASHKERNEL_MEM_NONE;
> +
> +	BUG_ON(!crash_size || !crash_base || !low_size);
> +
> +	/* crashkernel=X[@offset] */
> +	ret = parse_crashkernel(cmdline, system_ram, crash_size, crash_base);
> +	if (!ret && crash_size > 0)
> +		return CRASHKERNEL_MEM_CLASSIC;
> +
> +#ifdef CONFIG_X86_64
> +	/* crashkernel=X,high */
> +	ret = parse_crashkernel_high(cmdline, system_ram, crash_size, crash_base);
> +	if (ret || crash_size <= 0)
> +		return CRASHKERNEL_MEM_NONE;
> +
> +	flag = CRASHKERNEL_MEM_HIGH;
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(cmdline, system_ram, low_size, crash_base);
> +	if (!ret)
> +		flag |= CRASHKERNEL_MEM_LOW;
> +#endif
> +
> +	return flag;
> +}
> +
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_size, crash_base, total_mem;
> 
