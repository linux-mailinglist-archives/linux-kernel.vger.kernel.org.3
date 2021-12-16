Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5A476F48
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 11:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbhLPKz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 05:55:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhLPKz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 05:55:58 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0932B1EC01FC;
        Thu, 16 Dec 2021 11:55:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639652153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QuJ+5R6db1fiDExetCde8WgEzLmMC9GPFO7ooWuFUoc=;
        b=ABphLkGBVLji3yXgCnlhYPLoL/Kb44kkyTebp+C9k0SZC3hpRa920k2N8+J6ST2rMAabCA
        PN6F+YmOUBbI48i03dnWEAEWRo3xLHRg0JL+NRYfxJDx4yJDuKpT19d1A0jEa1sLjIIJI6
        9v6iWuq2TriWabYhcqsvIRxsvM10aQQ=
Date:   Thu, 16 Dec 2021 11:55:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
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
        Chen Zhou <dingguo.cz@antgroup.com>
Subject: Re: [PATCH v17 03/10] x86: kdump: use macro CRASH_ADDR_LOW_MAX in
 functions reserve_crashkernel()
Message-ID: <YbsbO1XnrzLAIBEu@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211216011040.GG3023@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 09:10:40AM +0800, Baoquan He wrote:
> reserve_crashkernel_low() always return 0 on x86_32, so the not equivalent
> transformation for x86_32 doesn't matter, I think.

That is, of course, very obvious... not!

Why is that function parsing crashkernel=XM, and crashkernel=X,high,
then it attempts some low memory reservation too? Why isn't
crashkernel=Y,low parsed there too?

I guess this alludes to why:

        crashkernel=size[KMG],low
                        [KNL, X86-64] range under 4G. When crashkernel=X,high
                        is passed, kernel could allocate physical memory region
                        above 4G, that cause second kernel crash on system
                        that require some amount of low memory, e.g. swiotlb
                        requires at least 64M+32K low memory, also enough extra
                        low memory is needed to make sure DMA buffers for 32-bit
                        devices won't run out.

So, before this is going anywhere, I'd like to see this function
documented properly. I see Documentation/admin-guide/kdump/kdump.rst
explains the crashkernel= options too so you can refer to it in the
comments so that when someone looks at that code, someone can follow why
it is doing what it is doing.

Then, as a future work, all that parsing of crashkernel= cmdline options
should be concentrated at the beginning and once it is clear what the
user requests, the reservations should be done.

As it is, reserve_crashkernel() is pretty unwieldy and hard to read.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
