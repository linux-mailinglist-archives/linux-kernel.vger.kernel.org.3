Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1BF48255A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhLaRTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhLaRTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:19:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D31C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 09:19:37 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E7A7D1EC046C;
        Fri, 31 Dec 2021 18:19:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640971172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2aOL80wsyqOZmowEPcxmvRLU7ex76lWW2NGLhp4+oiE=;
        b=db9Xim3NkUEBoQVNphYhD8DKYNjj1/qoHQnbB50HW3n49bM5HZJZ9SJzx3qh619Y6qGN/j
        RHXplDIJyEFgFym0op8jAct6J/iU86o6UdWT7IQPsDPKQsVYiDJwP2Sy9Jmt+6n3mlI2Wm
        Ua9NYka4WHTcS6tVi7UEJDbPXADbfLA=
Date:   Fri, 31 Dec 2021 18:19:35 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/26] x86/tdx: Handle CPUID via #VE
Message-ID: <Yc87mpjSNbgUtqKV@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-8-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-8-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:45PM +0300, Kirill A. Shutemov wrote:
> In TDX guests, most CPUID leaf/sub-leaf combinations are virtualized
> by the TDX module while some trigger #VE.
> 
> Implement the #VE handling for EXIT_REASON_CPUID by handing it through
> the hypercall, which in turn lets the TDX module handle it by invoking
> the host VMM.
> 
> More details on CPUID Virtualization can be found in the TDX module
> specification [1], the section titled "CPUID Virtualization".

The exact name and section should be enough to find the spec document
because...

> 
> [1] - https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf

... those links are never stable and become stale eventually. Just save
yourself the effort of adding them to commit messages.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
