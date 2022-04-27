Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940455120C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiD0QKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbiD0QJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A2B3E4FBA;
        Wed, 27 Apr 2022 09:05:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3663661BE9;
        Wed, 27 Apr 2022 16:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C52C385A9;
        Wed, 27 Apr 2022 16:04:25 +0000 (UTC)
Date:   Wed, 27 Apr 2022 17:04:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
Message-ID: <YmlphvZVMsGfFksp@arm.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/27 20:32, Catalin Marinas wrote:
> > I think one could always pass a default command line like:
> > 
> > 	crashkernel=1G,high crashkernel=128M,low
> > 
> > without much knowledge of the SoC memory layout.
> 
> Yes, that's what the end result is. The user specify crashkernel=128M,low
> and the implementation ensure the 128M low memory is allocated from DMA zone.
> We use arm64_dma_phys_limit as the upper limit for crash low memory.
> 
> +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
> +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>                                                crash_base, crash_max);
> 
> > Another option is to only introduce crashkernel=Y,low and, when that is
> > passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
> > 'high' option at all:
> > 
> > 	crashkernel=1G				- all within ZONE_DMA
> > 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
> > 						  1G above ZONE_DMA
> > 
> > If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
> > the 'low' option.
> 
> I think although the code is hard to make generic, the interface is better to
> be relatively uniform. A user might have to maintain both x86 and arm64, and
> so on. It's not a good thing that the difference is too big.

There will be some difference as the 4G limit doesn't always hold for
arm64 (though it's true in most cases). Anyway, we can probably simplify
things a bit while following the documented behaviour:

	crashkernel=Y		- current behaviour within ZONE_DMA
	crashkernel=Y,high	- allocate from above ZONE_DMA
	crashkernel=Y,low	- allocate within ZONE_DMA

There is no fallback from crashkernel=Y.

The question is whether we still want a default low allocation if
crashkernel=Y,low is missing but 'high' is present. If we add this, I
think we'd be consistent with kernel-parameters.txt for the 'low'
description. A default 'low' is probably not that bad but I'm tempted to
always mandate both 'high' and 'low'.

-- 
Catalin
