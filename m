Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261044774F1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 15:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhLPOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 09:48:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237402AbhLPOsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 09:48:21 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2FB6E1EC04DE;
        Thu, 16 Dec 2021 15:48:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639666096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yghcZ9SCdjsqe3xvr3DH9VJQok+aWYGqWKGyGqjZksU=;
        b=oHYx6aYS6tIj6LoZN+GBAYyUBxsWaPwpMGtiSVdRVoeTON1rZA0a52qHjEXKVX7g//ADsi
        rO3av99YMS8aovAS4KRPWc+BkGVdfnBUhgOZcLNrnAGFnJ+w7jeFi2iDU7u8+Br+ggksuT
        3S1KzL6GtR5B9qfhTL5iNTHFXoS142Y=
Date:   Thu, 16 Dec 2021 15:48:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Baoquan He <bhe@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YbtRs3Tq1UpCOpg8@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
 <YbseAX6X1VHUF12f@zn.tnic>
 <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <35810a61-604e-9b90-2a7f-cfca6ae042ac@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 08:08:30PM +0800, Leizhen (ThunderTown) wrote:
> If the memory of 'crash_base' is successfully allocated at (1), because the last
> parameter CRASH_ADDR_LOW_MAX is the upper bound, so we can sure that
> "crash_base < CRASH_ADDR_LOW_MAX". So that, reserve_crashkernel_low() will not be
> invoked at (3). That's why I said (1ULL << 32) is inaccurate and enlarge the CRASH_ADDR_LOW
> upper limit.

No, this is actually wrong - that check *must* be 4G. See:

  eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")

It is even documented:

        crashkernel=size[KMG],low
                        [KNL, X86-64] range under 4G. When crashkernel=X,high
                        is passed, kernel could allocate physical memory region
                        above 4G, that cause second kernel crash on system
                        that require some amount of low memory, e.g. swiotlb
                        requires at least 64M+32K low memory, also enough extra
                        low memory is needed to make sure DMA buffers for 32-bit
                        devices won't run out.

so you need to do a low allocation for DMA *when* the reserved memory is
above 4G. *NOT* above 512M. But that works due to the obscure situation,
as Baoquan stated, that reserve_crashkernel_low() returns 0 on 32-bit.

So all this is telling us is that that function needs serious cleanup.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
