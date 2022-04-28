Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F2C512A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbiD1Do0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbiD1DoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27334814A0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651117257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6a45cRhNTdyTWeV51hCajpfm2v3DEUl9/Oa/LlePIyo=;
        b=Xw1AgB43qCGvNAE6TyxLDKdNe+TeRvLdoW+JfofZ8zIqRzv1r5/lBugjLS8fGeoobVT5FR
        hKL3xw+roS/voyIzdr7ccrIP/tH9kbGn0akaZzciNIkszcfKS9/s+NNxNjbIFlL2AEUg+l
        IXtusfw3NJcysEVMq9JRfE85TJySlNY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-1oYT8W6vO1uRN0Dr2-nsXQ-1; Wed, 27 Apr 2022 23:40:50 -0400
X-MC-Unique: 1oYT8W6vO1uRN0Dr2-nsXQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ACD1380670B;
        Thu, 28 Apr 2022 03:40:49 +0000 (UTC)
Received: from localhost (ovpn-13-110.pek2.redhat.com [10.72.13.110])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ED604553D7A;
        Thu, 28 Apr 2022 03:40:47 +0000 (UTC)
Date:   Thu, 28 Apr 2022 11:40:45 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
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
Subject: Re: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
Message-ID: <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlphvZVMsGfFksp@arm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, Zhen Lei,

On 04/27/22 at 05:04pm, Catalin Marinas wrote:
> On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
> > On 2022/4/27 20:32, Catalin Marinas wrote:
> > > I think one could always pass a default command line like:
> > > 
> > > 	crashkernel=1G,high crashkernel=128M,low
> > > 
> > > without much knowledge of the SoC memory layout.
> > 
> > Yes, that's what the end result is. The user specify crashkernel=128M,low
> > and the implementation ensure the 128M low memory is allocated from DMA zone.
> > We use arm64_dma_phys_limit as the upper limit for crash low memory.
> > 
> > +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
> > +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >                                                crash_base, crash_max);
> > 
> > > Another option is to only introduce crashkernel=Y,low and, when that is
> > > passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
> > > 'high' option at all:
> > > 
> > > 	crashkernel=1G				- all within ZONE_DMA
> > > 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
> > > 						  1G above ZONE_DMA
> > > 
> > > If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
> > > the 'low' option.
> > 
> > I think although the code is hard to make generic, the interface is better to
> > be relatively uniform. A user might have to maintain both x86 and arm64, and
> > so on. It's not a good thing that the difference is too big.
> 
> There will be some difference as the 4G limit doesn't always hold for
> arm64 (though it's true in most cases). Anyway, we can probably simplify
> things a bit while following the documented behaviour:
> 
> 	crashkernel=Y		- current behaviour within ZONE_DMA
> 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
> There is no fallback from crashkernel=Y.
> 
> The question is whether we still want a default low allocation if
> crashkernel=Y,low is missing but 'high' is present. If we add this, I
> think we'd be consistent with kernel-parameters.txt for the 'low'
> description. A default 'low' is probably not that bad but I'm tempted to
> always mandate both 'high' and 'low'.

Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
about this version. And I have the same concerns about them which comes
from below points:
1) we may need to take best effort to keep ,high, ,low behaviour
consistent on all ARCHes. Otherwise user/admin may be confused when they
deploy/configure kdump on different machines of different ARCHes in the
same LAB. I think we should try to avoid the confusion.
2) Fallback behaviour is important to our distros. The reason is we will
provide default value with crashkernel=xxxM along kernel of distros. In
this case, we hope the reservation will succeed by all means. The ,high
and ,low is an option if customer likes to take with expertise.

After going through arm64 memory init code, I got below summary about
arm64_dma_phys_limit which is the first zone's upper limit. I think we
can make use of it to facilitate to simplify code.
================================================================================
                        DMA                      DMA32                    NORMAL
1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
2)Normal machine        0~4G                     0                        (above 4G)
3)Special machine       (above 4G)~MAX
4)No DMA|DMA32                                                            (above 4G)~MAX

-------------------------------------------
                      arm64_dma_phys_limit
1)Raspberry Pi4         1G                     
2)Normal machine        4G                     
3)Special machine       MAX
4)No DMA|DMA32          MAX

Note: 3)Special machine means the machine's starting physical address is above 4G.
WHile 4)No DMA|DMA32 means kernel w/o CONFIG_ZONE_DMA|DMA32, and has
IOMMU hardware supporting.
===================================================================================

I made a draft patch based on this patchset, please feel free to check and
see if it's OK, or anything missing or wrongly understood. I removed
reserve_crashkernel_high() and only keep reserve_crashkernel() and
reserve_crashkernel_low() as the v21 did.

Thanks
Baoquan

