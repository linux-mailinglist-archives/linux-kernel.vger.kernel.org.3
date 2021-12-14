Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38152474B86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbhLNTIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:08:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50090 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237308AbhLNTIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:08:01 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9E571EC018B;
        Tue, 14 Dec 2021 20:07:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639508875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=O5l+/RcN/07Kl4BXvkg+d4wvjSGbu0tu/uIm4ulPS5E=;
        b=KpyrcqBL1bMsZhEnaOVmzHhHXxk3lxdpD24NsiYNL8esi9Edi85U/xNazpOPFOGs2+t5Ru
        NraCkvbLY083zCr9qw9AWnvtMtZDRzApPqPUYsdijhbRFepf3NT/DYk9RxMWiYGi+cl8Nj
        8QBJn3wrP1yGzHWQ/rc2R5OabrDzbFQ=
Date:   Tue, 14 Dec 2021 20:07:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
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
Subject: Re: [PATCH v17 02/10] x86: kdump: make the lower bound of crash
 kernel reservation consistent
Message-ID: <YbjrjpehprvoRXbV@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210065533.2023-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:55:25PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> The lower bounds of crash kernel reservation and crash kernel low
> reservation are different, use the consistent value CRASH_ALIGN.

A big WHY is missing here to explain why the lower bound of the
allocation range needs to be 16M and why was 0 wrong?

> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 5cc60996eac56d6..6424ee4f23da2cf 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -441,7 +441,8 @@ static int __init reserve_crashkernel_low(void)
>  			return 0;
>  	}
>  
> -	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
> +	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, CRASH_ALIGN,
> +			CRASH_ADDR_LOW_MAX);

You don't have to break this line.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
