Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E2476F7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbhLPLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhLPLHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:07:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2F6C061574;
        Thu, 16 Dec 2021 03:07:49 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB68F1EC02B9;
        Thu, 16 Dec 2021 12:07:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639652863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=BrVDiCHbnVYMyrljDT1mFBKTxVyUx0D+6RzE7M0+qxw=;
        b=di2yjhRUDGcgCqkH34oUcizLGQZi0cWtZSc+dBHCpK/y0lPeGyZTJEv1zmLFBX6J/RJFvi
        yPAuwru4HDrDVDreMFbK9e0ngnPVqb1CJLYovdon+DdSUueHe73fSFpz5Mh3j6i56CB2Bo
        o9b4Q2gi3X3o/iSTuoKcSfaZKGwRyv4=
Date:   Thu, 16 Dec 2021 12:07:45 +0100
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
Message-ID: <YbseAX6X1VHUF12f@zn.tnic>
References: <20211210065533.2023-1-thunder.leizhen@huawei.com>
 <20211210065533.2023-4-thunder.leizhen@huawei.com>
 <YbntdtQo2jfbO4cO@zn.tnic>
 <20211216011040.GG3023@MiWiFi-R3L-srv>
 <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9513d74c-d4c7-babd-f823-8999e195d96d@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 10:46:12AM +0800, Leizhen (ThunderTown) wrote:
> The original value (1ULL << 32) is inaccurate

I keep asking *why*?

> and it enlarged the CRASH_ADDR_LOW upper limit.

$ git grep -E "CRASH_ADDR_LOW\W"
$

I have no clue what you mean here.

> This is because when the memory is allocated from the low end, the
> address cannot exceed CRASH_ADDR_LOW_MAX, see "if (!high)" branch.

> If
> the memory is allocated from the high end, 'crash_base' is greater than or
> equal to (1ULL << 32), and naturally, it is greater than CRASH_ADDR_LOW_MAX.
> 
> I think I should update the description, thanks.

I think you should explain why is (1ULL << 32) wrong.

It came from:

  eb6db83d1059 ("x86/setup: Do not reserve crashkernel high memory if low reservation failed")

which simply frees the high memory portion when the low reservation
fails. And the test for that is, is crash base > 4G. So that makes
perfect sense to me.

So your change is a NOP on 64-bit and it is a NOP on 32-bit by virtue of
the _low() variant always returning 0 on 32-bit.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
