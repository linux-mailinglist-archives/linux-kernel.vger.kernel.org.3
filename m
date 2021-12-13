Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C78B473458
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 19:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235742AbhLMSvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhLMSvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D9C061574;
        Mon, 13 Dec 2021 10:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B203611CB;
        Mon, 13 Dec 2021 18:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D74C34600;
        Mon, 13 Dec 2021 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639421462;
        bh=kTogJC7jN0dV1AV8N6q4V6WfxDiLOYk49cCUUpKJa9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggKuRJPCDvSwcMfZVINNujnIfNAbGTRYryTvvLtYRF3RuOtE7qh2EwfomkOtSd+pE
         BdW14lwvU+O5hTIsP+Svl6fQWqU+WN1KE61tRa4vAOQwxUSpuW94BrmS+5n4fOGyBJ
         TwyxLqYtrLyNgvr4LR9iizp6cqoqgSiGys/OWI+uhYPfxToqXDY3tlBQNksRcOe0ze
         UylTLnGuPxFuvkngkNennMF1aQLnm3L+sXvnwcyv2MwpxcwBGhf2N2qEHtXvg2JWIG
         K1gSJbX8kkAvRcEnt+6Yod6TraE+Cgo4/nxmp2rlFm3it5tGFzKADeSSk+jmSl5f9s
         17tEuOOQ9zAGA==
Date:   Mon, 13 Dec 2021 18:50:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>, gregkh@linuxfoundation.org
Subject: Re: [PATCH v17 00/10] support reserving crashkernel above 4G on
 arm64 kdump
Message-ID: <20211213185054.GH12405@willie-the-truck>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <afde1574-23b6-a36a-445e-5fb03873fe86@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afde1574-23b6-a36a-445e-5fb03873fe86@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:15:00PM +0800, Kefeng Wang wrote:
> 
> On 2021/12/10 14:55, Zhen Lei wrote:
> > There are following issues in arm64 kdump:
> > 1. We use crashkernel=X to reserve crashkernel below 4G, which
> > will fail when there is no enough low memory.
> > 2. If reserving crashkernel above 4G, in this case, crash dump
> > kernel will boot failure because there is no low memory available
> > for allocation.
> > 
> > To solve these issues, change the behavior of crashkernel=X.
> > crashkernel=X tries low allocation in DMA zone and fall back to high
> > allocation if it fails.
> > 
> > We can also use "crashkernel=X,high" to select a high region above
> > DMA zone, which also tries to allocate at least 256M low memory in
> > DMA zone automatically and "crashkernel=Y,low" can be used to allocate
> > specified size low memory.
> > 
> > When reserving crashkernel in high memory, some low memory is reserved
> > for crash dump kernel devices. So there may be two regions reserved for
> > crash dump kernel.
> > In order to distinct from the high region and make no effect to the use
> > of existing kexec-tools, rename the low region as "Crash kernel (low)",
> > and pass the low region by reusing DT property
> > "linux,usable-memory-range". We made the low memory region as the last
> > range of "linux,usable-memory-range" to keep compatibility with existing
> > user-space and older kdump kernels.
> > 
> > Besides, we need to modify kexec-tools:
> > arm64: support more than one crash kernel regions(see [1])
> > 
> > Another update is document about DT property 'linux,usable-memory-range':
> > schemas: update 'linux,usable-memory-range' node schema(see [2])
> > 
> > This patchset contains the following 10 patches:
> > 
> > 0001-0004 are some x86 cleanups which prepares for making functionsreserve_crashkernel[_low]() generic.
> > 0005 makes functions reserve_crashkernel[_low]() generic.
> > 0006-0007 reimplements arm64 crashkernel=X.
> > 0008-0009 adds memory for devices by DT property linux,usable-memory-range.
> > 0010 updates the doc.
> > 
> > Changes since [v16]
> > - Because no functional changes in this version, so add
> >    "Tested-by: Dave Kleikamp <dave.kleikamp@oracle.com>" for patch 1-9
> > - Add "Reviewed-by: Rob Herring <robh@kernel.org>" for patch 8
> > - Update patch 9 based on the review comments of Rob Herring
> > - As Catalin Marinas's suggestion, merge the implementation of
> >    ARCH_WANT_RESERVE_CRASH_KERNEL into patch 5. Ensure that the
> >    contents of X86 and ARM64 do not overlap, and reduce unnecessary
> >    temporary differences.
> 
> An Internal review has been done, so for this series,
> 
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

That's good, but it would be _much_ better if you could do these reviews
on the public mailing list in future. Is that possible? Otherwise, it's
hard for maintainers to know what the reviews actually covered.

Thanks,

Will
