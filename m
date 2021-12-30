Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9A4481B4B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbhL3KPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:15:07 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30124 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhL3KPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:15:04 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JPkZk46W1z1DJdD;
        Thu, 30 Dec 2021 18:11:42 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 18:15:01 +0800
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 30 Dec 2021 18:15:00 +0800
Subject: Re: [PATCH v19 01/13] kdump: add helper parse_crashkernel_high_low()
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
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-2-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4878dda9-871d-228d-21ac-3ac7c8a84322@huawei.com>
Date:   Thu, 30 Dec 2021 18:14:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20211228132612.1860-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.55]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Dave, Baoquan, Borislav:
  What do you think about the introduction of parse_crashkernel_high_low()? If everyone
doesn't object, I'll bring it to the next version. But I'll make some adjustments to the
patches, see below. If there's any objection, I still strongly recommend removing the
parameters "system_ram" and "crash_base" of parse_crashkernel_{high,low}().

How about splitting __parse_crashkernel() into two parts? One for parsing
"crashkernel=X[@offset]", another one for parsing "crashkernel=X,{high,low}" and other
suffixes in the future. So the parameter requirements are clear at the lowest level.


On 2021/12/28 21:26, Zhen Lei wrote:
> The bootup command line option crashkernel=Y,low is valid only when
> crashkernel=X,high is specified. Putting their parsing into a separate
> function makes the code logic clearer and easier to understand the strong
> dependencies between them.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/crash_core.h |  3 +++
>  kernel/crash_core.c        | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e7db..2d3a64761d18998 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -83,5 +83,8 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size);
>  
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index eb53f5ec62c900f..8966beaf7c4fd52 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -295,6 +295,41 @@ int __init parse_crashkernel_low(char *cmdline,
>  				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>  }
>  
> +/**
> + * parse_crashkernel_high_low - Parsing "crashkernel=X,high" and possible
> + *				"crashkernel=Y,low".
> + * @cmdline:	The bootup command line.
> + * @high_size:	Save the memory size specified by "crashkernel=X,high".
> + * @low_size:	Save the memory size specified by "crashkernel=Y,low" or "-1"
> + *		if it's not specified.
> + *
> + * Returns 0 on success, else a negative status code.
> + */
> +int __init parse_crashkernel_high_low(char *cmdline,
> +				      unsigned long long *high_size,
> +				      unsigned long long *low_size)
> +{
> +	int ret;
> +	unsigned long long base;
> +
> +	BUG_ON(!high_size || !low_size);
> +
> +	/* crashkernel=X,high */
> +	ret = parse_crashkernel_high(cmdline, 0, high_size, &base);
> +	if (ret)
> +		return ret;
> +
> +	if (*high_size <= 0)
> +		return -EINVAL;
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(cmdline, 0, low_size, &base);
> +	if (ret)
> +		*low_size = -1;
> +
> +	return 0;
> +}
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> 

-- 
Regards,
  Zhen Lei
