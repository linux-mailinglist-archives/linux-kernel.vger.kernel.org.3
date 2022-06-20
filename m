Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFE551F32
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242283AbiFTOkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351227AbiFTOi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:38:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA62720
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:57:37 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9E51D41012
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1655733452;
        bh=UjWWV2JsQCgy6zDEj9EuL2ro4g8nwmVgSxv7l8VWHJA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=JbSIEKsx8hxUgxvWM+O1ApRYJnKveeVoo883DnZtc1eOZ+2MomaXZwMQqnxJuh6pH
         hUvLR3UuWEK7CHIq1WGrZ5MztYQ9PqSZto5euy5Bdkmd4V+wXkpPW4u+nJCpoKzBiy
         qu1AF0Oi7sra0nbsuVFIJ0fq0bS7Rat2NPXGrnvmcF/ErKxXDCDRt1sSqeH7rqZUS6
         hfRPz7Bb1PATOzWmmI4UuoIW6+86zUG0wWmh6CM4GAOwlRbR4r3CZiToGGmWDEaWuM
         s/9ZuZs8TtKA2+cxqwgzVC+F4srP3yTlfdS6E5t2KNZAXpyXyCzMshiyVgiTwahjCW
         ht++lW0be3pDw==
Received: by mail-ed1-f70.google.com with SMTP id q18-20020a056402519200b004358ce90d97so1067147edd.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UjWWV2JsQCgy6zDEj9EuL2ro4g8nwmVgSxv7l8VWHJA=;
        b=dv06UJXo1U4xO5hqEORmnoG6CJWX2xeI2o4OeJpY2cfCRKqhiXLVqtw/IG7FY0LBt8
         rHcQAb+yr3pKrK0WjyPzJK260mIrId8MdVbeED4O3s/JQm6+PlSOWPXijRu2XnSYWQI+
         h6L5NpT3rHQKIi3ktTQIDd2gAIUuVWutyAnfBCCZ0l9FvJKXqt2DWeDYGMAbTJQk0vmp
         1duL78cUhBn06COo3ghyeHV9pWybcId4LxfTM6I0RaeaArD3QxvWcouwwExdiZBc+CoW
         ErUedkkYm7ra3nO7rMREfrdiufuQfyhvGbls2oa156B8w6zKpNGhJuCdLAKgD+TnpvsD
         VI/A==
X-Gm-Message-State: AJIora9U1bSchnQ1vJLjQUH/V/giuEha1taT9sYUG2d6HpfrOdBpPkMB
        pd2TKwQN8a9dp8NaXENxnUXpyQAcr7ehFH0wcW9jxghWFggfuci+TQjLNKul6BkQAMFC1DYXIlf
        7tO/Gil12qP6bT3tSHOMyAANopVq44Vaq62hb8yWufQ==
X-Received: by 2002:a17:906:d82:b0:70d:84d3:b6df with SMTP id m2-20020a1709060d8200b0070d84d3b6dfmr21352634eji.464.1655733450894;
        Mon, 20 Jun 2022 06:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vVS97kAx9306dyv65/TAKsm/97ata58xufvRiuoec6Rp1o9D2PtkTQHDVegiTy6jZAGRw5SQ==
X-Received: by 2002:a17:906:d82:b0:70d:84d3:b6df with SMTP id m2-20020a1709060d8200b0070d84d3b6dfmr21352616eji.464.1655733450597;
        Mon, 20 Jun 2022 06:57:30 -0700 (PDT)
Received: from [172.18.241.121] ([46.183.103.8])
        by smtp.gmail.com with ESMTPSA id x6-20020aa7d386000000b004355998ec1asm8930019edq.14.2022.06.20.06.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:57:30 -0700 (PDT)
Message-ID: <dfaa54b3-0ffa-7e75-93d1-15e4e0316dac@canonical.com>
Date:   Mon, 20 Jun 2022 15:57:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] RISC-V: Add mvendorid, marchid, and mimpid to
 /proc/cpuinfo output
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Atish Patra <atishp@atishpatra.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20220620115549.1529597-1-apatel@ventanamicro.com>
From:   Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20220620115549.1529597-1-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/22 13:55, Anup Patel wrote:
> Identifying the underlying RISC-V implementation can be important
> for some of the user space applications. For example, the perf tool
> uses arch specific CPU implementation id (i.e. CPUID) to select a
> JSON file describing custom perf events on a CPU.
> 
> Currently, there is no way to identify RISC-V implementation so we
> add mvendorid, marchid, and mimpid to /proc/cpuinfo output.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Looks good to me. I only tested on QEMU where all values default to 0.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   arch/riscv/kernel/cpu.c | 51 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index fba9e9f46a8c..c037b8691bbb 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -3,10 +3,13 @@
>    * Copyright (C) 2012 Regents of the University of California
>    */
>   
> +#include <linux/cpu.h>
>   #include <linux/init.h>
>   #include <linux/seq_file.h>
>   #include <linux/of.h>
> +#include <asm/csr.h>
>   #include <asm/hwcap.h>
> +#include <asm/sbi.h>
>   #include <asm/smp.h>
>   #include <asm/pgtable.h>
>   
> @@ -64,6 +67,50 @@ int riscv_of_parent_hartid(struct device_node *node)
>   }
>   
>   #ifdef CONFIG_PROC_FS
> +
> +struct riscv_cpuinfo {
> +	unsigned long mvendorid;
> +	unsigned long marchid;
> +	unsigned long mimpid;
> +};
> +static DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
> +
> +static int riscv_cpuinfo_starting(unsigned int cpu)
> +{
> +	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
> +
> +#if defined(CONFIG_RISCV_SBI)
> +	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
> +	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
> +	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
> +#elif defined(CONFIG_RISCV_M_MODE)
> +	ci->mvendorid = csr_read(CSR_MVENDORID);
> +	ci->marchid = csr_read(CSR_MARCHID);
> +	ci->mimpid = csr_read(CSR_MIMPID);
> +#else
> +	ci->mvendorid = 0;
> +	ci->marchid = 0;
> +	ci->mimpid = 0;
> +#endif
> +
> +	return 0;
> +}
> +
> +static int __init riscv_cpuinfo_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/cpuinfo:starting",
> +				riscv_cpuinfo_starting, NULL);
> +	if (ret < 0) {
> +		pr_err("cpuinfo: failed to register hotplug callbacks.\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +device_initcall(riscv_cpuinfo_init);
> +
>   #define __RISCV_ISA_EXT_DATA(UPROP, EXTID) \
>   	{							\
>   		.uprop = #UPROP,				\
> @@ -178,6 +225,7 @@ static int c_show(struct seq_file *m, void *v)
>   {
>   	unsigned long cpu_id = (unsigned long)v - 1;
>   	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> +	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
>   	const char *compat, *isa;
>   
>   	seq_printf(m, "processor\t: %lu\n", cpu_id);
> @@ -188,6 +236,9 @@ static int c_show(struct seq_file *m, void *v)
>   	if (!of_property_read_string(node, "compatible", &compat)
>   	    && strcmp(compat, "riscv"))
>   		seq_printf(m, "uarch\t\t: %s\n", compat);
> +	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
> +	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
> +	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
>   	seq_puts(m, "\n");
>   	of_node_put(node);
>   
