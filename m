Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DFE4A69A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243666AbiBBBdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiBBBdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:33:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68F7C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 17:33:19 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643765597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jowI/x8YdNccjt76L3Ju9YaW8SHCFcccg8kxZkWTveE=;
        b=M8YhtPsVkg8ro6BgTyyW5fXm/QRYqQCkqJu3XTfsYXN1hJ5RpttsmQlBOD/IAuIdLmFmT8
        rCXF+ex3NshufS46xV27dUOc3ldfvdTi+ljS/DMRud6JCjC1kkVC/LcjXJgjDhyoyFqKOh
        iXm1tdWVHDvWs2v1ySndO+V5rvhKByYfzYkh6CI9MtMcakKkBVrEA8F4xEWsw3Ivmv933x
        EUqs62S5QwTp3Z8UfdpOnL2KerShVyS9GKxX0UyX9inuf3KRBjrF54zxmEvKLbnCDLtt4B
        0KgQFCUdQMMRBsHRz9gG8PzVpjV9YLZn0e1Kp6R/5tKd5ayhIaPySWWw2ClJ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643765597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jowI/x8YdNccjt76L3Ju9YaW8SHCFcccg8kxZkWTveE=;
        b=rceC0DEiSXBlOo332iwS2gwDe+qgv0LyKtpZ15VeakLXN2JM3RKNxxZ+jX0I3svDlgCwut
        s05inHoEKI0ptkAA==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 26/29] x86/tdx: ioapic: Add shared bit for IOAPIC base
 address
In-Reply-To: <20220124150215.36893-27-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-27-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 02:33:16 +0100
Message-ID: <871r0mvyqr.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:

> From: Isaku Yamahata <isaku.yamahata@intel.com>
>
> The kernel interacts with each bare-metal IOAPIC with a special
> MMIO page. When running under KVM, the guest's IOAPICs are
> emulated by KVM.
>
> When running as a TDX guest, the guest needs to mark each IOAPIC
> mapping as "shared" with the host.  This ensures that TDX private
> protections are not applied to the page, which allows the TDX host
> emulation to work.
>
> Earlier patches in this series modified ioremap() so that

The concept of earlier patches does not exist.

> ioremap()-created mappings such as virtio will be marked as
> shared. However, the IOAPIC code does not use ioremap() and instead
> uses the fixmap mechanism.
>
> Introduce a special fixmap helper just for the IOAPIC code.  Ensure
> that it marks IOAPIC pages as "shared".  This replaces
> set_fixmap_nocache() with __set_fixmap() since __set_fixmap()
> allows custom 'prot' values.

Why is this a TDX only issue and SEV does not suffer from that?

Thanks,

        tglx
