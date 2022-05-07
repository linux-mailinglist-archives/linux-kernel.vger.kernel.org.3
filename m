Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23951E373
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 04:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445320AbiEGCLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 22:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445311AbiEGCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 22:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01E77712EC
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651889244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUXwbLpTLxZYFyP+27myBTI1GHkm6PSXiROEx/k8PH0=;
        b=dLdCLdME7/lMTWl75QKKqSmcj8BUMA7lCGPYIxAwCSIhZH+eKiYB28K5VaLvJI49kxV8/m
        3nkDvF72j2KmdDd9ZSAynQ+9A2nUqcKWyfpfnwHhmSXudB8PQXSmkP24/hLYxYJVokyxdi
        yApPnGL3HX9UXKflv516oC2VfDj8T/w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-rd5RSUnmNcC8E3e8MXqAjQ-1; Fri, 06 May 2022 22:07:20 -0400
X-MC-Unique: rd5RSUnmNcC8E3e8MXqAjQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FE79101AA42;
        Sat,  7 May 2022 02:07:19 +0000 (UTC)
Received: from localhost (ovpn-13-18.pek2.redhat.com [10.72.13.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC0AF111E3EB;
        Sat,  7 May 2022 02:07:12 +0000 (UTC)
Date:   Sat, 7 May 2022 10:07:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YnXUSBcFmEpxaqBf@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
 <d9b21f31-6fd2-a898-9a70-c63ff4f36212@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9b21f31-6fd2-a898-9a70-c63ff4f36212@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 at 09:34am, Leizhen (ThunderTown) wrote:
> 
> 
> On 2022/5/7 7:10, Baoquan He wrote:
> > On 05/06/22 at 07:43pm, Zhen Lei wrote:
> > ......  
> >> @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
> >>  	if (crash_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >> -	/* Current arm64 boot protocol requires 2MB alignment */
> >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> >> @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
> >>  		return;
> >>  	}
> >>  
> > 
> > There's corner case missed, e.g
> > 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> > 2) ,high and ,low are specified, the whole system memory is under 4G.
> > 
> > Below judgement can filter them away:
> >         
> > 	if (crash_base > arm64_dma_phys_limit && crash_low_size &&
> > 	    reserve_crashkernel_low(crash_low_size)) {
> > 
> > What's your opinion? Leave it and add document to notice user, or fix it
> > with code change?
> 
> I think maybe we can leave it unchanged. If the user configures two memory ranges,
> we'd better apply for two. Otherwise, he'll be confused when he inquires. Currently,
> crash_low_size is non-zero only when 'crashkernel=Y,low' is explicitly configured.

Then user need know the system information, e.g how much is the high
memory, low memory, if CONFIG_ZONE_DMA|DMA32 is enabled. And we need
describe these cases in document. Any corner case or exception need
be noted if we don't handle it in code.

Caring about this very much because we have CI with existed test cases
to run on the system, and QA will check these manually too. Support
engineer need detailed document if anything special but happened.
Anything unclear or uncovered will be reported as bug to our kernel dev.
Guess your company do the similar thing like this.

This crashkerne,high and crashkernel,low reservation is special if we
allow ,high, ,low existing in the same zone. Imagine on system with
CONFIG_ZONE_DMA|DMA32 disabled, people copy the crashkernel=512M,high
and crashkernel=128M,low from other system, and he could get
crash_res at [5G, 5G+512M], while crash_low_res at [6G, 6G+128M]. Guess
how they will judge us.

> 
> > 
> > I would suggest merging this series, Lei can add this corner case
> > handling on top. Since this is a newly added support, we don't have
> > to make it one step. Doing step by step can make reviewing easier.
> > 
> >> +	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> >> +		memblock_phys_free(crash_base, crash_size);
> >> +		return;
> >> +	}
> >> +
> >>  	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
> >>  		crash_base, crash_base + crash_size, crash_size >> 20);
> >>  
> >> @@ -135,6 +183,9 @@ static void __init reserve_crashkernel(void)
> >>  	 * map. Inform kmemleak so that it won't try to access it.
> >>  	 */
> >>  	kmemleak_ignore_phys(crash_base);
> >> +	if (crashk_low_res.end)
> >> +		kmemleak_ignore_phys(crashk_low_res.start);
> >> +
> >>  	crashk_res.start = crash_base;
> >>  	crashk_res.end = crash_base + crash_size - 1;
> >>  	insert_resource(&iomem_resource, &crashk_res);
> >> -- 
> >> 2.25.1
> >>
> > 
> > .
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

