Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3910854EFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 05:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379552AbiFQCk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 22:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379530AbiFQCky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 22:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8BCE64D1D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 19:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655433652;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O8SRq5MAXxm7CRGT0kP/ZVq+pjZMt/JpCdXhScXH7cM=;
        b=V3q5nWo1M5XEKWGD2En04w+DjUkEZoFv1lcqs2fNxrgjkfV6Xt9ml47zhf9/scWfAiwfu2
        tyaTPqqm/Dyi5TEZ9eOEqqVJWCPOrjyJ7SjE/0oxWKJox2KoTLGeXhsxHu3GKnzTEgAJke
        Y1RbdA54nZ2m+SCj11QuM8Ts3ItNU8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-HNw1UsnqOpWWm1I1ODtVew-1; Thu, 16 Jun 2022 22:40:49 -0400
X-MC-Unique: HNw1UsnqOpWWm1I1ODtVew-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D4BC382ECCB;
        Fri, 17 Jun 2022 02:40:48 +0000 (UTC)
Received: from localhost (ovpn-12-144.pek2.redhat.com [10.72.12.144])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D13D7C08081;
        Fri, 17 Jun 2022 02:40:45 +0000 (UTC)
Date:   Fri, 17 Jun 2022 10:40:42 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH 1/5] arm64: kdump: Provide default size when
 crashkernel=Y,low is not specified
Message-ID: <20220617024042.GC234358@MiWiFi-R3L-srv>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613080932.663-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/22 at 04:09pm, Zhen Lei wrote:
> To be consistent with the implementation of x86 and improve cross-platform
> user experience. Try to allocate at least 256 MiB low memory automatically
> when crashkernel=Y,low is not specified.

This should correspond to the case that crashkernel=,high is explicitly
specified, while crashkenrel=,low is omitted. It could be better to
mention these.

Otherwise, this looks good to me.

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  8 +-------
>  arch/arm64/mm/init.c                            | 12 +++++++++++-
>  2 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 8090130b544b070..61b179232b68001 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -843,7 +843,7 @@
>  			available.
>  			It will be ignored if crashkernel=X is specified.
>  	crashkernel=size[KMG],low
> -			[KNL, X86-64] range under 4G. When crashkernel=X,high
> +			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
                        ~~~~ exceeds 80 characters, it should be OK.

>  			is passed, kernel could allocate physical memory region
>  			above 4G, that cause second kernel crash on system
>  			that require some amount of low memory, e.g. swiotlb
> @@ -857,12 +857,6 @@
>  			It will be ignored when crashkernel=X,high is not used
>  			or memory reserved is below 4G.
>  
> -			[KNL, ARM64] range in low memory.
> -			This one lets the user specify a low range in the
> -			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used
> -			or memory reserved is located in the DMA zones.
> -
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
>  
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 339ee84e5a61a0b..5390f361208ccf7 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -96,6 +96,14 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit = PHYS_MASK + 1;
>  #define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
>  #define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
>  
> +/*
> + * This is an empirical value in x86_64 and taken here directly. Please
> + * refer to the code comment in reserve_crashkernel_low() of x86_64 for more
> + * details.
> + */
> +#define DEFAULT_CRASH_KERNEL_LOW_SIZE	\
> +	max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20)
> +
>  static int __init reserve_crashkernel_low(unsigned long long low_size)
>  {
>  	unsigned long long low_base;
> @@ -147,7 +155,9 @@ static void __init reserve_crashkernel(void)
>  		 * is not allowed.
>  		 */
>  		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
> -		if (ret && (ret != -ENOENT))
> +		if (ret == -ENOENT)
> +			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
> +		else if (ret)
>  			return;
>  
>  		crash_max = CRASH_ADDR_HIGH_MAX;
> -- 
> 2.25.1
> 

