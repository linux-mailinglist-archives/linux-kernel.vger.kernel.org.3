Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03F2511790
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiD0Mf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiD0Mfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:35:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD04C7A2;
        Wed, 27 Apr 2022 05:32:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7B3EB82666;
        Wed, 27 Apr 2022 12:32:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19409C385A9;
        Wed, 27 Apr 2022 12:32:35 +0000 (UTC)
Date:   Wed, 27 Apr 2022 13:32:32 +0100
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
Message-ID: <Ymk34NsIFqUgfk3b@arm.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 02:54:52PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/27 2:02, Catalin Marinas wrote:
> > On Thu, Apr 14, 2022 at 07:57:16PM +0800, Zhen Lei wrote:
> >>  /*
> >>   * reserve_crashkernel() - reserves memory for crash kernel
> >>   *
> >>   * This function reserves memory area given in "crashkernel=" kernel command
> >>   * line parameter. The memory reserved is used by dump capture kernel when
> >>   * primary kernel is crashing.
> >> + *
> >> + * NOTE: Reservation of crashkernel,low is special since its existence
> >> + * is not independent, need rely on the existence of crashkernel,high.
> >> + * Here, four cases of crashkernel low memory reservation are summarized:
> >> + * 1) crashkernel=Y,low is specified explicitly, the size of crashkernel low
> >> + *    memory takes Y;
> >> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
> >> + *    take the default crashkernel low memory size;
> >> + * 3) crashkernel=X is specified, while fallback to get a memory region
> >> + *    in high memory, take the default crashkernel low memory size;
> >> + * 4) crashkernel='invalid value',low is specified, failed the whole
> >> + *    crashkernel reservation and bail out.
> > 
> > Following the x86 behaviour made sense when we were tried to get that
> > code generic. Now that we moved the logic under arch/arm64, we can
> > diverge a bit. I lost track of the original (v1/v2) proposal but I
> > wonder whether we still need the fallback to high for crashkernel=Y.
> 
> I don't think anyone has raised this demand yet! If it weren't for the
> fact that crashkernel=X appeared earlier, it would probably have been
> enough for a combination of crashkernel=X,high and crashkernel=Y,low.
> 
> In fact, I also tend not to support "fallback to high for crashkernel=Y".
> I took over this from Chen Zhou. In the absence of any objection, I had
> to inherit. Now that you've brought it up, I'm happy to delete it.
> Supporting this feature complicates the code logic a lot. The point is,
> it's not fully backwards compatible yet. For example, someone may want
> crashkernel=3G to report failure, but the the new support make it work.

BTW, prior to v20, this patch had this line:

	crashk_low_res.name = "Crash kernel (low)";

I can't find it anymore. Do the kexec tools need to distinguish between
low and high or they can cope with multiple "Crash kernel" entries?

> > Maybe simpler, no fallbacks:
> > 
> > 	crashkernel=Y - keep the current behaviour, ignore high,low
> > 	crashkernel=Y,high - allocate above ZONE_DMA
> > 	crashkernel=Y,low - allocate within ZONE_DMA
> > 
> > From your proposal, the difference is that the Y,high option won't
> > have any default ZONE_DMA fallback, one would have to explicitly pass
> > the Y,low option if needed.
> 
> I agree with you. Now we don't need code generic, so there is no need to
> carry the historical burden of other ARCHs. arm64 does not need to delve
> into that empirical value(the default size of crash low memory).
> 
> > Just a thought, maybe it makes the code simpler. But I'm open to
> > discussion if there are good arguments for the proposed (x86-like)
> > behaviour. One argument could be for crashkernel=Y to fall back to high
> > if distros don't want to bother with high/low settings.
> 
> I think distros should take precedence over "crashkernel=Y,high". After all,
> ZONE_DMA memory is more valuable than high memory.

My point is whether an admin configuring the kernel command line needs
to know the layout of ZONE_DMA etc. to figure out how much to pass in
high and low. The fallbacks in this case have some value but they also
complicate the code logic. The 4GB limit does not always make sense
either for some platforms (RPi4 has a ZONE_DMA limit of 1GB).

I think one could always pass a default command line like:

	crashkernel=1G,high crashkernel=128M,low

without much knowledge of the SoC memory layout.

Another option is to only introduce crashkernel=Y,low and, when that is
passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
'high' option at all:

	crashkernel=1G				- all within ZONE_DMA
	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
						  1G above ZONE_DMA

If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
the 'low' option.

-- 
Catalin
