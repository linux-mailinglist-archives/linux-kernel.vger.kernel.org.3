Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3437A494175
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 21:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357252AbiASUIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 15:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiASUIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 15:08:14 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F0C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:08:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so12813216lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 12:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7XYML8NlB13bGuse2hF1bLIaMZ5sfkRPfFnmW1aohsc=;
        b=rxUbtiRmtkky00vtyPWlAYOefjVAHqGIMV2Os4969SRTEatw086kKc5xyaUjFFXZ2l
         SszLrySdH5wLQ+of9Rvam/Lg/qWCG9zxcmoA7VttOYi6avi8UxSS3gkvcgt6+PL3DvgT
         obhvzOxR2cn1GULTv4So9YFRSp1RJSHaM6mypXXoXC/YIRqOeIQG6lxF4ELOHEnUb/LF
         KWq/h53lou6blnK9Bq2i3fRJ0xHP/7/2g4RZ5QlTMnC3BdMowM2ledCTvIee3mh1jGjN
         QZ/knKqUYIn/HfCWCe99En4lE8/F0uG4AR19j9+KaHUylpRF5tad3FUu6rLJf8EZQt5g
         Fr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7XYML8NlB13bGuse2hF1bLIaMZ5sfkRPfFnmW1aohsc=;
        b=ZoOcQNY0SqKyWZd/iTMYmfxLRhrydg+Cb0mBXX+arsJiJhaDCqbN7tvA5gEnmEuY+5
         9g9FqCLccYC0UKbsPc3P6UAGT2xpew8oPgx3VWaMqWoYXvxfevo6RtY3GSOdQd/b3mrO
         3h52YsedwGw2CRG5iXpuGJP7UPeJiW0E5aSNsQXziepy6LZhJ64QTI/jPDDGqDoqJk9y
         eGZeSlqixsa76zAT6u2g4yhCj0w7wuxjtFAwxHN5uz+0lsZI7/ibIv1QJFP90PpNI7oi
         3CKyf7KPH7v/k8ZUMLAlPEBFZq0Thc7lE15ZT5hI0sR7/n9+6Ayvsp74muw1fyv8Tg6q
         2HOA==
X-Gm-Message-State: AOAM5313rnXv+2z3VZlcPXejT9Q777lLYmkJniuHY46sQtigaNuAFbvj
        D+lpP/Tl8U27OZL7R+UU9x1+mg==
X-Google-Smtp-Source: ABdhPJwPEHkCPoo9NpCBThrfHsmy44IF3kMjyNQg16dvkReKSsZIiN0c4eZ1yyaRO0+SOj/b0DMFhQ==
X-Received: by 2002:a2e:b80b:: with SMTP id u11mr1377463ljo.375.1642622892582;
        Wed, 19 Jan 2022 12:08:12 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p13sm57883lfh.189.2022.01.19.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 12:08:11 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 216EA10369A; Wed, 19 Jan 2022 23:08:41 +0300 (+03)
Date:   Wed, 19 Jan 2022 23:08:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, dave.hansen@intel.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/26] x86/tdx: Support TDX guest port I/O at
 decompression time
Message-ID: <20220119200841.fupa3hemmswllmxc@box.shutemov.name>
References: <20211214150304.62613-11-kirill.shutemov@linux.intel.com>
 <YeAuehoOEjUH3vZ3@zn.tnic>
 <20220115010155.ss2hnyotw4a3nljf@black.fi.intel.com>
 <YeK7AJXGN5GVGkRV@zn.tnic>
 <20220117143920.3umnnlx7dl27cm5z@box.shutemov.name>
 <YeW2U9vH65NcLHtY@zn.tnic>
 <20220119115326.rw2aj3ho2mct4xxv@box.shutemov.name>
 <YegTjdltOFBIDlf2@zn.tnic>
 <20220119154925.mzri4zaz3o477e3k@box.shutemov.name>
 <YehqkKNgQ65uUOe6@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YehqkKNgQ65uUOe6@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 08:46:24PM +0100, Borislav Petkov wrote:
> On Wed, Jan 19, 2022 at 06:49:25PM +0300, Kirill A. Shutemov wrote:
> > const struct port_io_ops default_pio_ops = {
> > 	.inb = inb,
> > 	.inw = inw,
> > 	.inl = inl,
> > 	.outb = outb,
> > 	.outw = outw,
> > 	.outl = outl,
> > };
> > 
> > make pio_ops a pointer and assign it here:
> > 
> > 	pio_ops = &default_pio_ops;
> > 
> > But it leads to an issue on linking:
> > 
> > ld.lld: error: Unexpected run-time relocations (.rela) detected!
> 
> So the above generates absolute relocations of type R_X86_64_64
> 
> Relocation section '.rela.data.rel.local' at offset 0x5c18 contains 6 entries:
>   Offset          Info           Type           Sym. Value    Sym. Name + Addend
> 000000000000  000200000001 R_X86_64_64       0000000000000000 .text + 10
> 000000000008  000200000001 R_X86_64_64       0000000000000000 .text + 30
> 000000000010  000200000001 R_X86_64_64       0000000000000000 .text + 50
> 000000000018  000200000001 R_X86_64_64       0000000000000000 .text + 0
> 000000000020  000200000001 R_X86_64_64       0000000000000000 .text + 20
> 000000000028  000200000001 R_X86_64_64       0000000000000000 .text + 40
> 
> and the linker doesn't like them probably because of the mcmodel we use
> but I need to talk to toolchain folks first to make sense of what's
> going on...

JFYI, the message comes from ASSERT in vmlinux.lds.S.

I assume for now I can proceed with the assignment that works, right?
It can be changed later once we figure out what is going on.

-- 
 Kirill A. Shutemov
