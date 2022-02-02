Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8144A69B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 02:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243732AbiBBBqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 20:46:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiBBBqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 20:46:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643766378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGiWiIHa+2yZNcbqcByB7204HPvD7D4tghhSB7+YXHA=;
        b=ZRAm9VXKUXAlKDa/0few4F9ACdyAEcFBXtZqLXAfAjba3ycamueBcYvbrDeSMLc77Bo8KE
        uYF8p+ipR6HEh9uCm3ON+M+WAArN1t9WXgU1J61WaAp8rUzf9vspVg+ZYWssMZADWOTu0A
        mb5s1VB273+p9PJVymN9cZHYfQRYyefG2tbOMSPWjSxH98FghP/ZUPNNfAw+rv1dWPDhvY
        dipYwmGQANfut7Q2y48gbCibOLBrsZZ41+Dh+aW0GkS3moO15NsL3yE46BAy+Mw9mD8iRz
        TZ70wgY/eR4CqylShjx3p1Zv1/uoZBp3NPB0hVW5NfJ6pC+01kONTnpdU/nmnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643766378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGiWiIHa+2yZNcbqcByB7204HPvD7D4tghhSB7+YXHA=;
        b=f7lTnpw3eN2aKkRxWSlT6IGvu6n8rka/WwFH0T0paPjPD2hl8aiNkF6LIaCUoDZow5F8e8
        zaBoj01cJ9OJvXCw==
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
Subject: Re: [PATCHv2 28/29] x86/tdx: Warn about unexpected WBINVD
In-Reply-To: <20220124150215.36893-29-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-29-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 02:46:17 +0100
Message-ID: <87y22uujkm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:

> WBINVD causes #VE in TDX guests. There's no reliable way to emulate it.
> The kernel can ask for VMM assistance, but VMM is untrusted and can ignore
> the request.
>
> Fortunately, there is no use case for WBINVD inside TDX guests.

If there is not usecase, then why

> Warn about any unexpected WBINVD.

instead of terminating the whole thing?

I'm tired of the "let us emit a warning in the hope it gets fixed'
thinking.

That's just wrong. Any code which has an assumption that it relies on
WBINVD to work correctly has to be analysed and not ignored on the
assumption that there is no use case for WBINVD inside TDX guests.

Its's simply wishful thinking that stuff gets fixed because of a
WARN_ONCE(). This has never worked. The only thing which works is to
make stuff fail hard or slow it down in a way which makes it annoying
enough to users to complain.

This is new technology. Anything which wants to use it has to obey to
the rules of this new technology. Just define it to be: WBINVD is
forbidden. End of story.

The Intel approach of 'Let us tolerate all sins of the past' has been
proven to be wrong, broken and outright dangerous in the past. So why
are you insisting to proliferate that?

Thanks,

        tglx


