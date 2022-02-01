Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6864A6819
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiBAWjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235380AbiBAWjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:39:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98521C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 14:39:12 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643755150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4h+vyzXpDW4ZNaMrVI+q087vA1yRAvhD8QP7ZXxaeA=;
        b=14aM81RSD0yePQqejZmdcc7/UWKbsJCKYQ+ma+tf6oxKvQVRCaKxiVBM5fDEe7vwAwxKA6
        zfj0W+1CUwHuIODI/R9b/iPXoktE2WxoCa9RI2F727zV7OvdhAA9khsTV4JxKTEhOPWXAV
        UOJuayoHgXKLGeQ4t8nvzSo1JZvur2sEJB40LUXPHhGptz41kK+xJyaIqD9uNMyOeEoc1h
        e0ZNqq1BMgBR8MGOpB0ZoyFZ3VuFOSoFzKj1S7d776vzoEly/EBUWMdJA99+MuT1cvh06x
        +P9J6O9FWvRBrD/4BQCLQG1pd+ayR0LvfFbWFPffkQjXCfwuZ64Nztdjm11TZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643755150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J4h+vyzXpDW4ZNaMrVI+q087vA1yRAvhD8QP7ZXxaeA=;
        b=2UYh0o0X7Nvr4QO/w20a1HU/wBRv5aadIn3+GLJ768wvxQnQ1vHuG2K30oXWo/YtjmUxCv
        ssPOjyWQtFhOPYBg==
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 11/29] x86/boot: Allow to hook up alternative port I/O
 helpers
In-Reply-To: <20220124150215.36893-12-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-12-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 23:39:09 +0100
Message-ID: <87k0eexlde.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:

> Port I/O instructions trigger #VE in the TDX environment. In response to
> the exception, kernel emulates these instructions using hypercalls.
>
> But during early boot, on the decompression stage, it is cumbersome to
> deal with #VE. It is cleaner to go to hypercalls directly, bypassing #VE
> handling.
>
> Add a way to hook up alternative port I/O helpers in the boot stub.
> All port I/O operations are routed via 'pio_ops'. By default 'pio_ops'
> initialized with native port I/O implementations.
>
> This is a preparation patch. The next patch will override 'pio_ops' if
> the kernel booted in the TDX environment.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Aside of Borislav's comments:

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
