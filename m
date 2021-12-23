Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750DA47E6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 18:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbhLWR0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 12:26:12 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37560 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233445AbhLWR0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 12:26:10 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 247051EC050F;
        Thu, 23 Dec 2021 18:26:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640280365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LMGR+C4m+9735OKWvzE0ovfyOVaNRuViyaqk9TpUU70=;
        b=pEsc1O/vnUhF2PpdTe0dYzrWZuYPARhmwaANkBfA0WcDaXQGQnq7zL3/WQNXKOFHnO8TyC
        5U5gxduSv6Qzp+EpkTNBXD2r+RiK5R8qKC8qIOhzjCWBX6Tk0aE/hZHbWG7lbPn+lciTrS
        NUn+YJWn2Ix4REiuv5J6C57w6h2L45g=
Date:   Thu, 23 Dec 2021 18:26:06 +0100
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
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: Re: [PATCH v18 02/17] x86/setup: Move xen_pv_domain() check and
 insert_resource() to setup_arch()
Message-ID: <YcSxLodOnxXHx0sV@zn.tnic>
References: <20211222130820.1754-1-thunder.leizhen@huawei.com>
 <20211222130820.1754-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211222130820.1754-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 09:08:05PM +0800, Zhen Lei wrote:
> From: Chen Zhou <chenzhou10@huawei.com>
> 
> We will make the functions reserve_crashkernel() as generic, the
> xen_pv_domain() check in reserve_crashkernel() is relevant only to
> x86,

Why is that so? Is Xen-PV x86-only?

> the same as insert_resource() in reserve_crashkernel[_low]().

Why?

Looking at

  0212f9159694 ("x86: Add Crash kernel low reservation")

it *surprisingly* explains why that resources thing is being added:

    We need to add another range in /proc/iomem like "Crash kernel low",
    so kexec-tools could find that info and append to kdump kernel
    command line.

Then,

  157752d84f5d ("kexec: use Crash kernel for Crash kernel low")

renamed it because, as it states, kexec-tools was taught to handle
multiple resources of the same name.

So why does kexec-tools on arm *not* need those iomem resources? How
does it parse the ranges there? Questions over questions...

So last time I told you to sit down and take your time with this cleanup.
From reading this here, it doesn't look like it. Rather, it looks like
hastily done in a hurry and hurrying stuff doesn't help you one bit - it
actually makes it worse.

Your commit messages need to explain *why* a change is being done and
why is that ok. This one doesn't.

> @@ -1120,7 +1109,17 @@ void __init setup_arch(char **cmdline_p)
>  	 * Reserve memory for crash kernel after SRAT is parsed so that it
>  	 * won't consume hotpluggable memory.
>  	 */
> -	reserve_crashkernel();
> +#ifdef CONFIG_KEXEC_CORE
> +	if (xen_pv_domain())
> +		pr_info("Ignoring crashkernel for a Xen PV domain\n");

This is wrong - the check is currently being done inside
reserve_crashkernel(), *after* it has parsed a crashkernel= cmdline
correctly - and not before.

Your change would print on Xen PV, regardless of whether it has received
crashkernel= on the cmdline or not.

This is exactly why I say that making those functions generic and shared
might not be such a good idea, after all, because then you'd have to
sprinkle around arch-specific stuff.

One of the ways how to address this particular case here would be:

1. Add a x86-specific wrapper around parse_crashkernel() which does
all the parsing. When that wrapper finishes, you should have parsed
everything that has crashkernel= on the cmdline.

2. At the end of that wrapper, you do arch-specific checks and setup
like the xen_pv_domain() one.

3. Now, you do reserve_crashkernel(), if those checks pass.

The question is, whether the flow on arm64 can do the same. Probably but
it needs careful auditing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
