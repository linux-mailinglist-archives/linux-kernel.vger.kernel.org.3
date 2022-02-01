Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC3A4A6856
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbiBAXCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 18:02:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42606 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiBAXCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 18:02:23 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643756542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZnqi5NAaCEARCm6y/D7myUaPkXPlYi+FcgR7vkS/B0=;
        b=1GriwfztG0L3IoVt5rIMgQMd+m5JzrUxFKRH1KtgynVIBN6rHCxWCcWbre5uo7K+U2J28A
        6UXhMPyImNWD1sUyk3BRpjX/QoJv2p2eynZ2ZaeuuBNVPDxblf9obTWfZPCNyg7hDF2b0K
        U3wokPgZNI/kDpm9/Zkd9kFgfHXQDDNNavAfgEvoMrKvkQ5AzFlv3H5n6VhPXVHNbcJJ85
        0YKa8kE0XX5FNe5Dz5wus3CD1VDszKqoobasuChbZZo1It6f2RxIKDH47zY4aItNKDFEoV
        MrLZJUoncyIa9f/I95sp0P380pBcVeDcUAXO2EAOl+thazilauH1aY78a9sHTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643756542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZnqi5NAaCEARCm6y/D7myUaPkXPlYi+FcgR7vkS/B0=;
        b=AjrF6Haj0KMXOOIZMU7OpT98ZbhN9GJN7QhWsqbA6sSiwvIBg1qx1ZW0/hRUzUh8yeMt0n
        f+/3sd9wj5PTVXAg==
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
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 14/29] x86/tdx: Early boot handling of port I/O
In-Reply-To: <20220124150215.36893-15-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-15-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 00:02:22 +0100
Message-ID: <875ypyxkap.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> This early handler enables the use of normal in*/out* macros without
> patching them for every driver. Since there is no expectation that
> early port I/O is performance-critical, the #VE emulation cost is worth
> the simplicity benefit of not patching the port I/O usage in early
> code. There are also no concerns with nesting, since there should be
> no NMIs or interrupts this early.
>
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
