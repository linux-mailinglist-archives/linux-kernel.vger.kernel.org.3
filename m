Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2F548117C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 11:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239652AbhL2KDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 05:03:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36986 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235190AbhL2KDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 05:03:22 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ABC701EC03AD;
        Wed, 29 Dec 2021 11:03:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640772196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=E7l2Hget7TEfy/D4Kt6JxexeerHjWcOm+gP+OBWenWQ=;
        b=RcQiLjen9MnTUyP0mwt93CuYK5qID8MRKmaVpcZFZQoHI5gs37RP3GHECR/ijjiVfj9KdU
        ZGs+Zv41YZg66Hlb7k/rkIiO1GGaACLCXL2ZW6eA6hDXGY/QsoQlj8YrFNeyyN1fGd5EgC
        zHvCIoGUZ3SwKCTJStrtSnq7mQ6gEpk=
Date:   Wed, 29 Dec 2021 11:03:17 +0100
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
Message-ID: <YcwyZRDJUMniSaY9@zn.tnic>
References: <20211228132612.1860-1-thunder.leizhen@huawei.com>
 <20211228132612.1860-3-thunder.leizhen@huawei.com>
 <Ycs3kpZD/vpoo1AX@zn.tnic>
 <b017a8ea-989b-c251-f5c8-a8a7940877cf@huawei.com>
 <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcwN9Mfwsh/lPbbd@dhcp-128-65.nay.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 03:27:48PM +0800, Dave Young wrote:
> So I think you can unify the parse_crashkernel* in x86 first with just
> one function.  And leave the further improvements to later work. But
> let's see how Boris think about this.

Well, I think this all unnecessary work. Why?

If the goal is to support crashkernel...high,low on arm64, then you
should simply *copy* the functionality on arm64 and be done with it.

Unification is done by looking at code which is duplicated across
architectures and which has been untouched for a while now, i.e., no
new or arch-specific changes are going to it so a unification can be
as simple as trivially switching the architectures to call a generic
function.

What this does is carve out the "generic" parts and then try not to
break existing usage.

Which is a total waste of energy and resources. And it is casting that
functionality in stone so that when x86 wants to change something there,
it should do it in a way not to break arm64. And I fail to see the
advantage of all that. Code sharing ain't it.

So what it should do is simply copy the necessary code to arm64.
Unifications can always be done later, when the dust settles.

IMNSVHO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
