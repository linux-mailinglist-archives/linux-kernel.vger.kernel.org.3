Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B33B481AA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 09:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhL3IEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 03:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbhL3IEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 03:04:48 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6149AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:04:48 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id x4so21906163ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 00:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=poVEQoDbGgeJXUGMD2Q6wlRSaI9kiXP+ZgtpdnI2aFE=;
        b=OpxRM5M/IxKJObJrF7LGaL+DWep91udX/tivO5eabr+AQ05T4Z7OVphMNgxTX6hTtQ
         uabJ3DjTEhgnYI3H6JyeCW2VUJgOAF8IcxxJ95bDZutADuP9+mn/KgQLWjPk7zPow/VW
         g7ntNOwSiDZuqXyhEBPmhMx+NXXO8VO0m3m93G0OfSmsgcp0Mks3HJpr3l58LutPzMbU
         L7KY5WKxGINOqGzlN2jCZZIeK160ZYyfqUQg2SKCsEuSfArt855KK5s7CCHMImXlqmSg
         9ODTQHBgTVXP+67987N/xxZIfNpHSUWky9SQ/qf0OJUx/y8PGoBlxt2A4CwiA615moSE
         XVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=poVEQoDbGgeJXUGMD2Q6wlRSaI9kiXP+ZgtpdnI2aFE=;
        b=PdlziZT1rX5aGABTyTcNvCKKFYDm1b7cqpP/Tw5CX4hFzDQeraJ99Y6rOUc21wkS1Q
         GAycO9F9F5LCU1xgFtWkgqj96JHNdraL9pgQSs0geMx8UXXoEwjnF4wLFDYAjRtJ2AiG
         jLCFuyitXvwk+WOCl+h2OzLqXiocXcyz6ayn+k+SVlZfMBocH3ayZyn1p8L2Tuwz+/Y6
         HfWJZIrQmIwdZfTyvEEdTd6DVAiHpdJwevy35fiPJmhFHIlncwdNLVg6gMo2JLvIaYUZ
         yO2KfjwS6fMwhFhxYeQDha05SqsS/zWq9UPWjdZmb6QtowNPCha4mJx1M8e6HixSPIoF
         ZtMA==
X-Gm-Message-State: AOAM530jN99QOQHqK4BMyPlNEbuSmlzNxI2mJz+cPxESMkgP0hpJTDRM
        LdrrhNqkgpFoionJzDwzrGyhlg==
X-Google-Smtp-Source: ABdhPJyVkZm34pyVWa0loCHGjYg7ZnM4VHCd4obXrIXkOa9Oac6D4MIYcZiGhcUQ24cLVm5LZN+W4g==
X-Received: by 2002:a2e:9617:: with SMTP id v23mr25155046ljh.363.1640851486572;
        Thu, 30 Dec 2021 00:04:46 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w38sm2417042lfu.265.2021.12.30.00.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 00:04:45 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 33BF1103C3C; Thu, 30 Dec 2021 11:05:00 +0300 (+03)
Date:   Thu, 30 Dec 2021 11:05:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 04/26] x86/traps: Add #VE support for TDX guest
Message-ID: <20211230080500.cmc6x2nbykprlyy2@box.shutemov.name>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-5-kirill.shutemov@linux.intel.com>
 <YcTR5HnkHi7CjVyx@zn.tnic>
 <20211228233112.cpycmdv55edxhvbv@black.fi.intel.com>
 <YcxGrw6Ymqs8NPjY@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcxGrw6Ymqs8NPjY@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 12:29:51PM +0100, Borislav Petkov wrote:
> On Wed, Dec 29, 2021 at 02:31:12AM +0300, Kirill A. Shutemov wrote:
> > On Thu, Dec 23, 2021 at 08:45:40PM +0100, Borislav Petkov wrote:
> > > What happens if the NMI handler triggers a #VE after all? Or where is it
> > > enforced that TDX guests should set panic_on_oops?
> > 
> > Kernel will handle the #VE normally inside NMI handler. (We tested it once
> > again, just in case.)
> > 
> > The critical part is that #VE must not be triggered in NMI entry code,
> > before kernel is ready to handle nested NMIs.
> 
> Well, I can't read that in the commit message, maybe it needs expanding
> on that aspect?
> 
> What I read is:
> 
> "Interrupts, including NMIs, are blocked by the hardware starting with
> #VE delivery until TDGETVEINFO is called."
> 
> but this simply means that *if* you get a #VE anywhere, NMIs are masked
> until TDGETVEINFO.
> 
> If you get a #VE during the NMI entry code, then you're toast...

Hm. Two sentance above the one you quoted describes (maybe badly? I donno)
why #VE doesn't happen in entry paths. Maybe it's not clear it covers NMI
entry path too.

What if I replace the paragraph with these two:

	Kernel avoids #VEs during syscall gap and NMI entry code. Entry code
	paths do not access TD-shared memory, MMIO regions, use #VE triggering
	MSRs, instructions, or CPUID leaves that might generate #VE. Similarly,
	to page faults and breakpoints, #VEs are allowed in NMI handlers once
	kernel is ready to deal with nested NMIs.

	During #VE delivery, all interrupts, including NMIs, are blocked until
	TDGETVEINFO is called. It prevents #VE nesting until kernel reads the VE
	info.

Is it better?

> > tdx_virt_exception_user()/tdx_virt_exception_kernel() will be populated by
> > following patches. The patch adds generic infrastructure for #VE handling.
> 
> Yeah, you either need to state that somewhere or keep changing those
> functions as they evolve in the patchset. As it is, it just confuses
> reviewers.

Commit message already has this:

	Add basic infrastructure to handle any #VE which occurs in the kernel
	or userspace. Later patches will add handling for specific #VE
	scenarios.

I'm not sure what need to be changed.

-- 
 Kirill A. Shutemov
