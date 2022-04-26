Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D80B51063C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbiDZSGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353052AbiDZSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:06:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FF527CE6;
        Tue, 26 Apr 2022 11:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3BA90B820F9;
        Tue, 26 Apr 2022 18:02:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B48C385A4;
        Tue, 26 Apr 2022 18:02:49 +0000 (UTC)
Date:   Tue, 26 Apr 2022 19:02:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>
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
Message-ID: <YmgzxsrrMlCDYsWp@arm.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414115720.1887-6-thunder.leizhen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 07:57:16PM +0800, Zhen Lei wrote:
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
>   *
>   * This function reserves memory area given in "crashkernel=" kernel command
>   * line parameter. The memory reserved is used by dump capture kernel when
>   * primary kernel is crashing.
> + *
> + * NOTE: Reservation of crashkernel,low is special since its existence
> + * is not independent, need rely on the existence of crashkernel,high.
> + * Here, four cases of crashkernel low memory reservation are summarized:
> + * 1) crashkernel=Y,low is specified explicitly, the size of crashkernel low
> + *    memory takes Y;
> + * 2) crashkernel=,low is not given, while crashkernel=,high is specified,
> + *    take the default crashkernel low memory size;
> + * 3) crashkernel=X is specified, while fallback to get a memory region
> + *    in high memory, take the default crashkernel low memory size;
> + * 4) crashkernel='invalid value',low is specified, failed the whole
> + *    crashkernel reservation and bail out.

Following the x86 behaviour made sense when we were tried to get that
code generic. Now that we moved the logic under arch/arm64, we can
diverge a bit. I lost track of the original (v1/v2) proposal but I
wonder whether we still need the fallback to high for crashkernel=Y.
Maybe simpler, no fallbacks:

	crashkernel=Y - keep the current behaviour, ignore high,low
	crashkernel=Y,high - allocate above ZONE_DMA
	crashkernel=Y,low - allocate within ZONE_DMA

From your proposal, the difference is that the Y,high option won't
have any default ZONE_DMA fallback, one would have to explicitly pass
the Y,low option if needed.

Just a thought, maybe it makes the code simpler. But I'm open to
discussion if there are good arguments for the proposed (x86-like)
behaviour. One argument could be for crashkernel=Y to fall back to high
if distros don't want to bother with high/low settings.

Another thing I may have asked in the past, what happens if we run a new
kernel with these patches with old kexec user tools. I suspect the
crashkernel=Y with the fallback to high will confuse the tools.

BTW, please separate the NO_BLOCK_MAPPINGS optimisations from the
crashkernel above 4G. Let's get the crashkernel reservations sorted
first, it's been around for too long.

Thanks.

-- 
Catalin
