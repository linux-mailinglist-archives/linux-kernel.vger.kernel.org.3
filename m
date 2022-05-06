Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E625551E244
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444936AbiEFXVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 19:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377390AbiEFXVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 19:21:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C6B07090B
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651879073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wslZBJewjz4hJp3e76dVIXzGvwXKoz3kxZZ5099+eDo=;
        b=VmlSAAgMx/TvLnE50b3C5wWKZ1Jyq6VPr78DDJvsv95VeCeXS/P2MypkW2E95x6WI3bkLV
        i1UmIJAyzMxkSFqdSCwCf+h7Cj9onDjJ61FJSxkbFqGybp7St85IYxOxY1zemOIhrgbWY2
        Xy7WDI2sHcwIHPEN8ephZWFT/NfCr1I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-RR9lHokKPZuzyx5pu4Jd9Q-1; Fri, 06 May 2022 19:17:46 -0400
X-MC-Unique: RR9lHokKPZuzyx5pu4Jd9Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 342FF101AA45;
        Fri,  6 May 2022 23:17:45 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A3BE2026614;
        Fri,  6 May 2022 23:17:41 +0000 (UTC)
Date:   Sat, 7 May 2022 07:17:37 +0800
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
Subject: Re: [PATCH v24 5/6] of: Support more than one crash kernel regions
 for kexec -s
Message-ID: <20220506231737.GD122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506114402.365-6-thunder.leizhen@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 07:44pm, Zhen Lei wrote:
> When "crashkernel=X,high" is used, there may be two crash regions:
> high=crashk_res and low=crashk_low_res. But now the syscall
> kexec_file_load() only add crashk_res into "linux,usable-memory-range",
> this may cause the second kernel to have no available dma memory.
> 
> Fix it like kexec tool do for option -c, add both 'high' and 'low' regions
              ~~~~~~~~~~~~ 
              kexec-tools does

Other than this, LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> into the dtb.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/kexec.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index b9bd1cff179388c..8d374cc552be5f2 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -386,6 +386,15 @@ void *of_kexec_alloc_and_setup_fdt(const struct kimage *image,
>  				crashk_res.end - crashk_res.start + 1);
>  		if (ret)
>  			goto out;
> +
> +		if (crashk_low_res.end) {
> +			ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
> +					"linux,usable-memory-range",
> +					crashk_low_res.start,
> +					crashk_low_res.end - crashk_low_res.start + 1);
> +			if (ret)
> +				goto out;
> +		}
>  	}
>  
>  	/* add bootargs */
> -- 
> 2.25.1
> 

