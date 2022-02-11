Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4400C4B2398
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbiBKKma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:42:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiBKKm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:42:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3653BD4B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644576146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ek0uj/LUTnOMOsFu8yGHGsh602NG0Sgtj4vJHccYII=;
        b=DlhuXp9bw2I4nn3gFE2IFd4E45xCsPCUkMKOAOhoqaaA3h+S+5Y0wLGhkgpNFlmd+gLvdx
        AQj6GhICEC/7Q9v/ZKogdYlbSuGO7mO5ngz2NuFC90CBQDAl7sYpoOJMGrPP2aaQcXxBeD
        rBq/t9F5H4FUTmKtkVOEmj0b0HJKLfo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-302-Ov67G1aIMZW6XEOG22BK_Q-1; Fri, 11 Feb 2022 05:42:23 -0500
X-MC-Unique: Ov67G1aIMZW6XEOG22BK_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D1CF8D0689;
        Fri, 11 Feb 2022 10:39:53 +0000 (UTC)
Received: from localhost (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0B345452F;
        Fri, 11 Feb 2022 10:39:51 +0000 (UTC)
Date:   Fri, 11 Feb 2022 18:39:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH v20 2/5] arm64: kdump: introduce some macros for crash
 kernel reservation
Message-ID: <YgY89RxkAl12n/dd@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124084708.683-3-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/22 at 04:47pm, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> Introduce macro CRASH_ALIGN for alignment, macro CRASH_ADDR_LOW_MAX
> for upper bound of low crash memory, macro CRASH_ADDR_HIGH_MAX for
> upper bound of high crash memory, use macros instead.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> ---
>  arch/arm64/mm/init.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 90f276d46b93bc6..6c653a2c7cff052 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -65,6 +65,12 @@ EXPORT_SYMBOL(memstart_addr);
>  phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  
>  #ifdef CONFIG_KEXEC_CORE
> +/* Current arm64 boot protocol requires 2MB alignment */
> +#define CRASH_ALIGN		SZ_2M
> +
> +#define CRASH_ADDR_LOW_MAX	arm64_dma_phys_limit
> +#define CRASH_ADDR_HIGH_MAX	MEMBLOCK_ALLOC_ACCESSIBLE

MEMBLOCK_ALLOC_ACCESSIBLE is obvoiously a alloc flag for memblock
allocator, I don't think it's appropriate to make HIGH_MAX get its value.
You can make it as memblock.current_limit, or do not define it, but using
MEMBLOCK_ALLOC_ACCESSIBLE direclty in memblock_phys_alloc_range() with
a code comment. 


> +
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
> @@ -75,7 +81,7 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
> -	unsigned long long crash_max = arm64_dma_phys_limit;
> +	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
>  	int ret;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> @@ -90,8 +96,7 @@ static void __init reserve_crashkernel(void)
>  	if (crash_base)
>  		crash_max = crash_base + crash_size;
>  
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> -- 
> 2.25.1
> 

