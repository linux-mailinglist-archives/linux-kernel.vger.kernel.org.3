Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF724ACE5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344962AbiBHBt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345053AbiBHBnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:43:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91397C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644284627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMDvDoEbO/rD1x32YWplF1Fz9lP4H196sTYmBtGIooA=;
        b=YgQLKQ5WjjCqAfHns21KJgdK8Kxt5d/AUQeUgA7OugM5uZloNzekoetT1LgHO3AYFSYBVf
        pCFbdANoVlBg+egO9QtpsqjtkhucFFCB3+IsKmOKLPhfdH1tFxQjTp9C6iSHvItTSv8bfV
        Dbub6W1nBdK13I+TdthKKabqWiE9RWs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-DRUqT-IqMT6jLWYXW_CfFg-1; Mon, 07 Feb 2022 20:43:44 -0500
X-MC-Unique: DRUqT-IqMT6jLWYXW_CfFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5587C64140;
        Tue,  8 Feb 2022 01:43:40 +0000 (UTC)
Received: from localhost (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 650F65F707;
        Tue,  8 Feb 2022 01:43:10 +0000 (UTC)
Date:   Tue, 8 Feb 2022 09:43:07 +0800
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
Subject: Re: [PATCH v20 1/5] arm64: Use insert_resource() to simplify code
Message-ID: <YgHKq7o2Efb1JK7H@MiWiFi-R3L-srv>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
 <20220124084708.683-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124084708.683-2-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
> insert_resource() traverses the subtree layer by layer from the root node
> until a proper location is found. Compared with request_resource(), the
> parent node does not need to be determined in advance.
> 
> In addition, move the insertion of node 'crashk_res' into function
> reserve_crashkernel() to make the associated code close together.

This is nice cleanup.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm64/kernel/setup.c | 17 +++--------------
>  arch/arm64/mm/init.c      |  1 +
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index f70573928f1bff0..a81efcc359e4e78 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -225,6 +225,8 @@ static void __init request_standard_resources(void)
>  	kernel_code.end     = __pa_symbol(__init_begin - 1);
>  	kernel_data.start   = __pa_symbol(_sdata);
>  	kernel_data.end     = __pa_symbol(_end - 1);
> +	insert_resource(&iomem_resource, &kernel_code);
> +	insert_resource(&iomem_resource, &kernel_data);
>  
>  	num_standard_resources = memblock.memory.cnt;
>  	res_size = num_standard_resources * sizeof(*standard_resources);
> @@ -246,20 +248,7 @@ static void __init request_standard_resources(void)
>  			res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
>  		}
>  
> -		request_resource(&iomem_resource, res);
> -
> -		if (kernel_code.start >= res->start &&
> -		    kernel_code.end <= res->end)
> -			request_resource(res, &kernel_code);
> -		if (kernel_data.start >= res->start &&
> -		    kernel_data.end <= res->end)
> -			request_resource(res, &kernel_data);
> -#ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> -		if (crashk_res.end && crashk_res.start >= res->start &&
> -		    crashk_res.end <= res->end)
> -			request_resource(res, &crashk_res);
> -#endif
> +		insert_resource(&iomem_resource, res);
>  	}
>  }
>  
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index db63cc885771a52..90f276d46b93bc6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -109,6 +109,7 @@ static void __init reserve_crashkernel(void)
>  	kmemleak_ignore_phys(crash_base);
>  	crashk_res.start = crash_base;
>  	crashk_res.end = crash_base + crash_size - 1;
> +	insert_resource(&iomem_resource, &crashk_res);
>  }
>  #else
>  static void __init reserve_crashkernel(void)
> -- 
> 2.25.1
> 

