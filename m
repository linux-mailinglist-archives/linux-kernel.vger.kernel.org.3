Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632D480B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbhL1QNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:13:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48190 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235511AbhL1QNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:13:10 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B0001EC03C9;
        Tue, 28 Dec 2021 17:13:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640707984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WXiQ34aw3BVND/Em7tvSPxlLMgOR1j97eSJLIoe4hEo=;
        b=Wxfh2AfVkOPehtchcQkGOoQ0oGIuT8TcGQj16+fz/HtvWax3OrT7PDYc6oNz8WRzjBQVGz
        Y5x48biGa9AeRsmxuPHUMmhPc/e5BbRXINa6EOML0ucxMIFvD84s6QGJryKawaDfVG69Fh
        DDSVwawRqdPXycOFmaGv7WJE5dupzC8=
Date:   Tue, 28 Dec 2021 17:13:06 +0100
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
Subject: Re: [PATCH v19 02/13] x86/setup: Use parse_crashkernel_high_low() to
 simplify code
Message-ID: <Ycs3kpZD/vpoo1AX@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211228132612.1860-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021 at 09:26:01PM +0800, Zhen Lei wrote:
> Use parse_crashkernel_high_low() to bring the parsing of
> "crashkernel=X,high" and the parsing of "crashkernel=Y,low" together, they
> are strongly dependent, make code logic clear and more readable.
> 
> Suggested-by: Borislav Petkov <bp@alien8.de>

Yeah, doesn't look like something I suggested...

> @@ -474,10 +472,9 @@ static void __init reserve_crashkernel(void)
>  	/* crashkernel=XM */
>  	ret = parse_crashkernel(boot_command_line, total_mem, &crash_size, &crash_base);
>  	if (ret != 0 || crash_size <= 0) {
> -		/* crashkernel=X,high */
> -		ret = parse_crashkernel_high(boot_command_line, total_mem,
> -					     &crash_size, &crash_base);
> -		if (ret != 0 || crash_size <= 0)
> +		/* crashkernel=X,high and possible crashkernel=Y,low */
> +		ret = parse_crashkernel_high_low(boot_command_line, &crash_size, &low_size);

So this calls parse_crashkernel() and when that one fails, it calls this
new weird parse high/low helper you added.

But then all three end up in the same __parse_crashkernel() worker
function which seems to do the actual parsing.

What I suggested and what would be real clean is if the arches would
simply call a *single* 

	parse_crashkernel()

function and when that one returns, *all* crashkernel= options would
have been parsed properly, low, high, middle crashkernel, whatever...
and the caller would know what crash kernel needs to be allocated.

Then each arch can do its memory allocations and checks based on that
parsed data and decide to allocate or bail.

So it is getting there but it needs more surgery...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
