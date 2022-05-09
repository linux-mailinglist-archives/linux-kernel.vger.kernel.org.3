Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8934451F336
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiEIELe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 00:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiEIEIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 00:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12D3AD5CF9
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 21:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652069097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h5YXC8yQ1bsRoJU0nyu/b+oJN5MCJQkd8AXSZI7jF8Q=;
        b=fepuYmzMjhlkIE8W8RLEfOsxQxmUY+XECljkpfh6cet7Q1tYQnZSUVBklRQorNg1MX1ith
        hGGfB0j6lLIgt1oeo4ncfY6CRH42+F7sB6eLQ+31YiC1wBOpKywePqjFduFf9cj/FM3WYm
        pSnLxDWgTXjwVKz+AmTuK4f5d0tNNlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-8GgaCYj_MqK_rmUOTlh5Cg-1; Mon, 09 May 2022 00:04:50 -0400
X-MC-Unique: 8GgaCYj_MqK_rmUOTlh5Cg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F12480B717;
        Mon,  9 May 2022 04:04:49 +0000 (UTC)
Received: from localhost (ovpn-13-212.pek2.redhat.com [10.72.13.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 781DDC27EB3;
        Mon,  9 May 2022 04:04:46 +0000 (UTC)
Date:   Mon, 9 May 2022 12:04:43 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <YniS29/Mjabnbs2E@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
 <Yna/bc2nDb7PT40r@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yna/bc2nDb7PT40r@arm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/22 at 07:50pm, Catalin Marinas wrote:
> On Sat, May 07, 2022 at 07:10:32AM +0800, Baoquan He wrote:
> > On 05/06/22 at 07:43pm, Zhen Lei wrote:
> > ......  
> > > @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
> > >  	if (crash_base)
> > >  		crash_max = crash_base + crash_size;
> > >  
> > > -	/* Current arm64 boot protocol requires 2MB alignment */
> > > -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > > +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> > >  					       crash_base, crash_max);
> > >  	if (!crash_base) {
> > >  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > > @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
> > >  		return;
> > >  	}
> > >  
> > 
> > There's corner case missed, e.g
> > 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> > 2) ,high and ,low are specified, the whole system memory is under 4G.
> 
> My view of ,low is that it should only used to override the default
> ZONE_DMA allocation if that one is not suitable. If no ZONE_DMA exists
> or everything is ZONE_DMA, ignore it altogether. That's a specialist
> case for people that know more about the memory layout, otherwise
> crashkernel=X works in most case with crashkernel=X,high as an
> alternative to allow high allocation.

Totally agree with the conclusion.

