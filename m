Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D64F51D89D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392298AbiEFNUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392292AbiEFNUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:20:02 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F7B663516
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651842978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8wPDA2gsA8PtLts/9kHE8ZGbzgkULXlMPGcav5wmzQU=;
        b=ccuXqQD7UwzYVucc3HfNsIr3iL+qEtX2ZOAYbQaO8WltyJqaTdgr+mrbpr1scJuLRBVbm4
        GUm5dyIWNKscaIgulXPPuIsM8WUJhEBUUUfLM6LgG2T61QxmmVbd7CZMpHZl37cl58emE9
        T6DlmUIzpKjuAA/VvMhC1xCuUxp5QsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-j9olosgBNA2Z3YsZN10Vzw-1; Fri, 06 May 2022 09:16:14 -0400
X-MC-Unique: j9olosgBNA2Z3YsZN10Vzw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D9F8803E2E;
        Fri,  6 May 2022 13:16:13 +0000 (UTC)
Received: from localhost (ovpn-13-105.pek2.redhat.com [10.72.13.105])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3EAD463EDC;
        Fri,  6 May 2022 13:16:11 +0000 (UTC)
Date:   Fri, 6 May 2022 21:16:08 +0800
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
Subject: Re: [PATCH v23 3/6] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YnUfmMmON2c1FZrx@MiWiFi-R3L-srv>
References: <20220505091845.167-1-thunder.leizhen@huawei.com>
 <20220505091845.167-4-thunder.leizhen@huawei.com>
 <YnQC44KVKirH0vyB@arm.com>
 <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <189f24a8-9e9b-b3e9-7ac5-935433ea575b@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/22 at 11:22am, Leizhen (ThunderTown) wrote:
......  
> >> @@ -118,8 +159,7 @@ static void __init reserve_crashkernel(void)
> >>  	if (crash_base)
> >>  		crash_max = crash_base + crash_size;
> >>  
> >> -	/* Current arm64 boot protocol requires 2MB alignment */
> >> -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> >> +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >>  					       crash_base, crash_max);
> >>  	if (!crash_base) {
> >>  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > 
> > I personally like this but let's see how the other thread goes. I guess
> 
> Me too. This fallback complicates code logic more than just a little.
> I'm not sure why someone would rather add fallback than change the bootup
> options to crashkernel=X,[high|low]. Perhaps fallback to high/low is a better
> compatible and extended mode when crashkernel=X fails to reserve memory. And
> the code logic will be much clearer.

The fallback does complicates code, while it was not made at the
beginning, but added later. The original crahskernel=xM can only reserve
low memory under 896M on x86 to be back compatible with the case in which
normal kernel is x86_64, while kdump kernel could be i386. Then customer
complained why crashkernel=xM can't be put anywhere so that they don't
need to know the details of limited low memory and huge high memory fact 
in system.

The implementation of fallback is truly complicated, but its use is
quite simple. And it makes crashkernel reservation setting simple.
Most of users don't need to know crashkernel=,high, ,low things, unless
the crashkernel region is too big. Nobody wants to take away 1G or more
from low memory for kdump just in case bad thing happens, while normal
kernel itself is seriously impacted by limited low memory.

> 
> //parse crashkernel=X		//To simplify the discussion, Ignore [@offset]
> crash_base = memblock_phys_alloc_range()
> if (!crash_base || /* crashkernel=X is not specified */) {
> 	//parse crashkernel=X,[high,low]
> 	//reserve high/low memory
> }
> 
> So that, the following three modes are supported:
> 1) crashkernel=X[@offset]
> 2) crashkernel=X,high crashkernel=X,low
> 3) crashkernel=X[@offset] crashkernel=X,high [crashkernel=Y,low]
> 
> For case 3), try "crashkernel=X[@offset]" first, if it can not work, fallback
> to "crashkernel=X,high crashkernel=X,low". This looks better than the old "crashkernel=X"
> fallback ---- Select a region under 4G first, and fall back to reserve region above 4G.

Don't get it. Aren't they the same?

> 
> Note: when the X of crashkernel=X and crashkernel=X,high are the same, It's equivalent
> to the old "crashkernel=X" fallback.
> 
> > if we want a fallback, it would come just before the check the above:
> > 
> > 	if (!crash_base && crash_max != CRASH_ADDR_HIGH_MAX) {
> > 		/* attempt high allocation with default low */
> > 		if (!crash_low_size)
> > 			crash_low_size = some default;
> > 		crash_max = CRASH_ADDR_LOW_MAX;
> 
> crash_max = CRASH_ADDR_HIGH_MAX; We should fallback to high memory now.
> 
> > 		crash_base = memblock_phys_alloc_range();
> > 	}
> > 
> > Well, I guess we end up with your earlier proposal but I think I
> > understand it better now ;).
> > 
> 
> -- 
> Regards,
>   Zhen Lei
> 

