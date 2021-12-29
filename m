Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBCF481189
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhL2KLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:11:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38122 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235394AbhL2KLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:11:34 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8870C1EC03AD;
        Wed, 29 Dec 2021 11:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640772688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XQf533yWQdBT38yB7mdOOcurLjmzI8J7ZoVrHIkrc50=;
        b=oOgJDMQKM1SFMh8gHEisQaHDFBwMkYtzINOa+bgaMwWNui8U8fvsrimltxAgZw2hv6NOpl
        vA1sppzPxgrjRS4Q0yBgWtXsdKwsQVO1/nYWaz/y3jPK36jLMOlk7RgKejTp7Ygkpb0sXH
        DqIpw73jFcPpG/NNXrzYaHwgf8RNROA=
Date:   Wed, 29 Dec 2021 11:11:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
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
Message-ID: <Ycw0V1CmBPCPqexn@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
 <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcwSCAuEgO10DFDT@dhcp-128-65.nay.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 03:45:12PM +0800, Dave Young wrote:
> BTW, I would suggest to wait for reviewers to response (eg. one week at
> least, or more due to the holidays) before updating another version
> 
> Do not worry to miss the 5.17.  I would say take it easy if it will
> miss then let's just leave with it and continue to work on the future
> improvements.  I think one reason this issue takes too long time is that it was
> discussed some time but no followup and later people need to warm up
> again.  Just keep it warm and continue to engage in the improvements, do
> not hurry for the specific mainline release.

Can you tell this to *all* patch submitters please?

I can't count the times where people simply hurry to send the new
revision just to get it in the next kernel, and make silly mistakes
while doing so. Or not think things straight and misdesign it all.

And what this causes is the opposite of what they wanna achieve - pissed
maintainers and ignored threads.

And they all *know* that the next kernel is around the corner. So why
the hell does it even matter when?

What most submitters fail to realize is, the moment your code hits
upstream, it becomes the maintainers' problem and submitters can relax.

But maintainers get to deal with this code forever. So after a while
maintainers learn that they either accept ready code and it all just
works or they make the mistake to take half-baked crap in and then they
themselves get to clean it up and fix it.

So maintainers learn quickly to push back.

But it is annoying and it would help immensely if submitters would
consider this and stop hurrying the code in but try to do a *good* job
first, design-wise and code-wise by thinking hard about what they're
trying to do.

Yeah, things could be a lot simpler and easier - it only takes a little
bit of effort...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
