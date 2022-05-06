Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43B51E287
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444920AbiEFXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444892AbiEFXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:14:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20A125F25D
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651878641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QDEUBZQi2gkd5vGN65bG0cDs8TDhy97WSz0PhVlgRoE=;
        b=QehyvxK9vxssxcAaeIMW4ZqUmBjfWfq2Avxxo0n4VXqexANly7NPcqWmhrym3YmpoiMCOi
        u72ukTxVDj0Pap1JVmP/D1bvz0UoZPNmkrFuYCP3v4WUAhJ54cJuf9H5geYrdO2wWk2/eq
        YxaCku6uESjbMcvmavgWAOnfc1mZuco=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-TAhXEYwDNG2uu1lmYE4cTA-1; Fri, 06 May 2022 19:10:38 -0400
X-MC-Unique: TAhXEYwDNG2uu1lmYE4cTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0110F3C01C00;
        Fri,  6 May 2022 23:10:37 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3ABC40CF8E8;
        Fri,  6 May 2022 23:10:35 +0000 (UTC)
Date:   Sat, 7 May 2022 07:10:32 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <20220506231032.GA122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506114402.365-4-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 07:43pm, Zhen Lei wrote:
......  
> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
>  	if (crash_base)
>  		crash_max = crash_base + crash_size;
>  
> -	/* Current arm64 boot protocol requires 2MB alignment */
> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>  					       crash_base, crash_max);
>  	if (!crash_base) {
>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  

There's corner case missed, e.g
1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
2) ,high and ,low are specified, the whole system memory is under 4G.

Below judgement can filter them away:
        
	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
	    reserve_crashkernel_low(crash_low_size)) {

What's your opinion? Leave it and add document to notice user, or fix it
with code change?

I would suggest merging this series, Lei can add this corner case
handling on top. Since this is a newly added support, we don't have
to make it one step. Doing step by step can make reviewing easier.

> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +		memblock_phys_free(crash_base, crash_size);
> +		return;
> +	}
> +
>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
>  		crash_base, crash_base + crash_size, crash_size >> 20);
>  
> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
>  	 * map. Inform kmemleak so that it won't try to access it.
>  	 */
>  	kmemleak_ignore_phys(crash_base);
> +	if (crashk_low_res.end)
> +		kmemleak_ignore_phys(crashk_low_res.start);
> +
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
>  	insert_resource(&iomem_resource, &crashk_res);
> -- 
> 2.25.1
> 

