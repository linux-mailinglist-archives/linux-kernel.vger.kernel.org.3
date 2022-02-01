Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A144A650E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 20:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbiBATbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 14:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiBATbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:31:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92591C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 11:31:17 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643743876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Y/ekKx7CJbzOSRaYt7+hWzCBFyjxOeNdwQMqGnqAqE=;
        b=IhM3+XjYX1kJQfOubKofcK0GxCzGx4aWPQAXyv2tyTlJQ0y5BU/AKPQGFwMWTXXNBef3pK
        FIukCel09gTeDg1B3NUBrtopVzmONfJU7lW3YcuodaPATodDDYoe1qodLSlgdAPel/Cr9Y
        5Wg4jE0uwzNpmc49q42SMOQe9gT+2xXw4IDiRoLZBF7JKyGGI97Kz+dx3vjOuRhXopOCCk
        AC2tczeteIk8GA5CDcQ2fM8KzdD8l/1cLmLw9SmwA6H3lN/WmO7QVAUzE6ToBOnTqIrMXI
        9dIo7ZEjV0CKzBD123lG41RgCxn5kQDNJqdMsS5QElnWTy7vki1fe+EgJQxj0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643743876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Y/ekKx7CJbzOSRaYt7+hWzCBFyjxOeNdwQMqGnqAqE=;
        b=CpLkh25j1CyRbED6oZx21axuSTv3ecUvO0rCf5uPyk5QeKSEP4X4LNgLp0yjb/kDQteyW1
        N1ymqpUjJw6MR9Dg==
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
Subject: Re: [PATCHv2 02/29] x86/tdx: Extend the cc_platform_has() API to
 support TDX guests
In-Reply-To: <20220124150215.36893-3-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-3-kirill.shutemov@linux.intel.com>
Date:   Tue, 01 Feb 2022 20:31:15 +0100
Message-ID: <87czk6z8n0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:01, Kirill A. Shutemov wrote:
> Since is_tdx_guest() function (through cc_platform_has() API) is used in
> the early boot code, disable the instrumentation flags and function
> tracer. This is similar to AMD SEV and cc_platform.c.
>
> Since intel_cc_platform_has() function only gets called when
> is_tdx_guest() is true (valid CONFIG_INTEL_TDX_GUEST case), remove the
> redundant #ifdef in intel_cc_platform_has().
>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
