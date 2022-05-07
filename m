Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2151E945
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348075AbiEGSyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 14:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241402AbiEGSyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 14:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2798DF06;
        Sat,  7 May 2022 11:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A4CE6142F;
        Sat,  7 May 2022 18:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE0BC385A5;
        Sat,  7 May 2022 18:50:25 +0000 (UTC)
Date:   Sat, 7 May 2022 19:50:21 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
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
Message-ID: <Yna/bc2nDb7PT40r@arm.com>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506231032.GA122876@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2022 at 07:10:32AM +0800, Baoquan He wrote:
> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> ......  
> > @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
> >  	if (crash_base)
> >  		crash_max = crash_base + crash_size;
> >  
> > -	/* Current arm64 boot protocol requires 2MB alignment */
> > -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >  					       crash_base, crash_max);
> >  	if (!crash_base) {
> >  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
> >  		return;
> >  	}
> >  
> 
> There's corner case missed, e.g
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> 2) ,high and ,low are specified, the whole system memory is under 4G.

My view of ,low is that it should only used to override the default
ZONE_DMA allocation if that one is not suitable. If no ZONE_DMA exists
or everything is ZONE_DMA, ignore it altogether. That's a specialist
case for people that know more about the memory layout, otherwise
crashkernel=X works in most case with crashkernel=X,high as an
alternative to allow high allocation.

> I would suggest merging this series, Lei can add this corner case
> handling on top. Since this is a newly added support, we don't have
> to make it one step. Doing step by step can make reviewing easier.

I agree.

-- 
Catalin
