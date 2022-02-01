Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B94A685D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbiBAXGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiBAXGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:06:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F490C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 15:06:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsIbqrvI/zARQdc/D4KLBMZ/ArgLCUOgCsV2CDm2CBw=;
        b=sHPTeiCbmIfTcTtiCeKPy3qTrSoc6L72A7bGLhNyUUmZJW2mIDeviCzdLwuhxjjA1+ef8l
        AIdiXoIj8eS1GBTQWxE3Cjga+eaV+EobN6V4IOyC50brt9dhf7goOqbPNFmxtljPMV5RM3
        pEAPiYTT4pPBk8I+S8sFFOcHw+r1/8da5Sj1pwwZa4D6DkXngE5caViQ958XvD7Mcm6Zoh
        7yH9LcVYQ/w00Jtm1Ztn9QZoKUqgRu7V3D4tOp6QQi7q81dkB1A4SELOia3nYpCCkpZqbQ
        q0mKrb2L0ZaHxQLKyz43IGo7KPion6hWC1aXQ1bHljm1zyWhFT2uncDmbtskPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsIbqrvI/zARQdc/D4KLBMZ/ArgLCUOgCsV2CDm2CBw=;
        b=3GZ8WNf28mUAHBi2YJMfb0IY2bmXlNmLMF47ruvXp9iqdzqzgYS4d5ztHHdMJ12ss9qjZv
        pN9l+l7ioLtUzRDQ==
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
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
In-Reply-To: <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 00:06:40 +0100
Message-ID: <87y22uw5j3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:

> From: Sean Christopherson <sean.j.christopherson@intel.com>
>
> Historically, x86 platforms have booted secondary processors (APs)
> using INIT followed by the start up IPI (SIPI) messages. In regular
> VMs, this boot sequence is supported by the VMM emulation. But such a
> wakeup model is fatal for secure VMs like TDX in which VMM is an
> untrusted entity. To address this issue, a new wakeup model was added
> in ACPI v6.4, in which firmware (like TDX virtual BIOS) will help boot
> the APs. More details about this wakeup model can be found in ACPI
> specification v6.4, the section titled "Multiprocessor Wakeup Structure".
>
> Since the existing trampoline code requires processors to boot in real
> mode with 16-bit addressing, it will not work for this wakeup model
> (because it boots the AP in 64-bit mode). To handle it, extend the
> trampoline code to support 64-bit mode firmware handoff. Also, extend
> IDT and GDT pointers to support 64-bit mode hand off.
>
> There is no TDX-specific detection for this new boot method. The kernel
> will rely on it as the sole boot method whenever the new ACPI structure
> is present.
>
> The ACPI table parser for the MADT multiprocessor wake up structure and
> the wakeup method that uses this structure will be added by the following
> patch in this series.
>
> Reported-by: Kai Huang <kai.huang@intel.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
