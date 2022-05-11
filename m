Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E44D522EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiEKJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiEKJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA0133EB97
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652260020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+6aR4G5bhHxoYCpwQyfjz1xkmAc7kDl/rLkC6zVA3qk=;
        b=YePXmrxTcx2kMgVusx7fVz+Cu/JY3jl0FudaSjua4ZSLqpA5ctDdg5dzg19ExMNaX7sBNQ
        uAKStNtWcyNEl4pmEqdcAxF1BwQ/Um1+JNWwudUfdO+ANrswHe/Jk30jvJpTOEkNYj+ALs
        imMB2dhQhldONp/9u0G9IwptGEE0XP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-228-WkHv9DnJMvaF9c7uYKNQ9g-1; Wed, 11 May 2022 05:06:57 -0400
X-MC-Unique: WkHv9DnJMvaF9c7uYKNQ9g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C124804195;
        Wed, 11 May 2022 09:06:57 +0000 (UTC)
Received: from localhost (ovpn-12-154.pek2.redhat.com [10.72.12.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CD872416539;
        Wed, 11 May 2022 09:06:55 +0000 (UTC)
Date:   Wed, 11 May 2022 17:06:51 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: [PATCH] arm64: kdump: Do not allocate crash low memory if not
 needed
Message-ID: <Ynt8qwG9WoiW4L+o@MiWiFi-R3L-srv>
References: <20220511032033.426-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511032033.426-1-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/22 at 11:20am, Zhen Lei wrote:
> When "crashkernel=X,high" is specified, the specified "crashkernel=Y,low"
> memory is not required in the following corner cases:
> 1. If both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, it means
>    that the devices can access any memory.
> 2. If the system memory is small, the crash high memory may be allocated
>    from the DMA zones. If that happens, there's no need to allocate
>    another crash low memory because there's already one.
> 
> Add condition '(crash_base >= CRASH_ADDR_LOW_MAX)' to determine whether
> the 'high' memory is allocated above DMA zones. Note: when both
> CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, the entire physical
> memory is DMA accessible, CRASH_ADDR_LOW_MAX equals 'PHYS_MASK + 1'.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  arch/arm64/mm/init.c                            | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f6ff55840751a78..1b543c3109f4851 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -823,7 +823,7 @@
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate
>  			at least 256M below 4G automatically.
> -			This one let user to specify own low range under 4G
> +			This one lets the user specify own low range under 4G
                        ~ This one let users specify own low range ...

Other than this nitpick, LGTM

Acked-by: Baoquan He <bhe@redhat.com>

>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
> @@ -832,7 +832,8 @@
>  			[KNL, ARM64] range in low memory.
>  			This one lets the user specify a low range in the
>  			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used.
> +			It will be ignored when crashkernel=X,high is not used
> +			or memory reserved is located in the DMA zones.
>  
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 18ba66c90991ea0..ac510fb6a2c0189 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -170,7 +170,8 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.25.1
> 

