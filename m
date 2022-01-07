Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C621E487CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiAGTGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbiAGTEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:04:41 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C982BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:04:40 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B21291EC0464;
        Fri,  7 Jan 2022 20:04:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1641582274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j2Ys9WzxqcLdk3uO6iVdMdmZ3zgyVkKQmNj4ZKYY9HQ=;
        b=GTyM5CJpu4t/5K3tu4woRUVpkdIhXbI6habGouLj7VQQIkKjgwHiOIdRaToo61h2tSMS2m
        qwsgqZ1vqZR1U1gu4emCOik1IzUEBkvKKIZO88ZtLgvVhUHL4DCLdphMGA9U/sFEC/Tt0O
        1jdmVmq1LgKbCra7eRXk75PNru21jeg=
Date:   Fri, 7 Jan 2022 20:04:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/26] x86/tdx: Handle in-kernel MMIO
Message-ID: <YdiOxFaZCTBFQdQA@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-9-kirill.shutemov@linux.intel.com>
 <YdV1BpMiAUGrwASv@zn.tnic>
 <20220105154311.bocij4mwbga4t2hb@box.shutemov.name>
 <YdhEQTnm+XMxoDPW@zn.tnic>
 <20220107174926.rh35qcyhu6u2tkzw@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107174926.rh35qcyhu6u2tkzw@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 08:49:26PM +0300, Kirill A. Shutemov wrote:
> To emulate an instruction the emulator needs two things:
> 
>   - R/W access to the register file to read/modify instruction arguments
>     and see RIP of the faulted instruction.
> 
>   - Read access to memory where instruction is placed to see what to
>     emualte. In this case it is guest kernel text.
> 
> Both of them are not available to VMM in TDX environment:
> 
>   - Register file is never exposed to VMM. When a TD exits to the module,
>     it saves registers into the state-save area allocated for that TD.
>     The module then scrubs these registers before returning execution
>     control to the VMM, to help prevent leakage of TD state.
> 
>   - Memory is encrypted TD-private key. The CPU disallows software other
>     than the TDX module and TDs from making memory accesses using the
>     private key.

Thanks, that's very helpful info. It would be nice to have it in the
commit message.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
