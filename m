Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A491B4A767A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346096AbiBBRIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiBBRIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:08:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3B4C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:08:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643821691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKn7hU4bqa6IMiTZIrQUUNx7GqXfdOiTzhrgFzVnWRk=;
        b=r9v7HmQMunhSCAr43zidXkwE5ViKxWca0lYCv1qcaj3in+xXHEriLWdzGqjn68c11DDvOH
        JF5Bf0i6hGO1tfryXgMsSBf9UHaShB4Y1KD+7X3tIhczcwNMinmWv1pNUIa+BpYibhevMn
        gmQtMRmKk0dRwAwa6P4f/jo3qPfn4At+ZCPTGEofMxJUBQKg7zEEyBX9OkEGLvnMCaDJK1
        CRqqR2BtNhN7XAebrfZx/UChJX1P9tEdUbTwvrsO9A4Kz5CcjDKClRbSShBL8B2cgOXCko
        KrjhB4v+X8X647DYU8RgnteHP3ou3iEVMWY6ee95t7NFzfh+rzFt4ibTWNUuMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643821691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bKn7hU4bqa6IMiTZIrQUUNx7GqXfdOiTzhrgFzVnWRk=;
        b=AUUhfdBEXX4dH2Mpt+6+Mva8cVNayXDFnkqDFUhj8fTPQw+Jc0ADor05K6/YHQU+IUHZoE
        qYMalXTNQYOs4aAQ==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>
Subject: Re: [PATCHv2 03/29] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
In-Reply-To: <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-4-kirill.shutemov@linux.intel.com>
 <87a6faz7cs.ffs@tglx> <20220202025519.csymm7r23b3ltpia@black.fi.intel.com>
Date:   Wed, 02 Feb 2022 18:08:11 +0100
Message-ID: <878ruturgk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill,

On Wed, Feb 02 2022 at 05:55, Kirill A. Shutemov wrote:
> On Tue, Feb 01, 2022 at 08:58:59PM +0100, Thomas Gleixner wrote:
> Okay, below is my take on addressing feedback for both __tdx_module_call()
> and __tdx_hypercall().
>
> It is fixup for whole patchset. It has to be folded accordingly. I wanted
> to check if it works and see if I understand your request correctly.
>
> __tdx_module_call() is now implemented by including tdxcall.S can using
> the macro defined there. Host side of TDX can do the same on their side.
> TDX_MODULE_* offsets are now outside of CONFIG_INTEL_TDX_GUEST and can be
> used by both host can guest.
>
> I changed __tdx_hypercall() to take single argument with struct pointer
> that used for both input and output.
>
> Is it the right direction? Or did I misunderstand something?

Looks good. Nice consolidation and I like the idea of using one
structure for in and out.

Thanks,

        tglx
