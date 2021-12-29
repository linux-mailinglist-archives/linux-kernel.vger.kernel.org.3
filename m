Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53677481262
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240119AbhL2L7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:59:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52262 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240091AbhL2L7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:59:39 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58FC31EC0423;
        Wed, 29 Dec 2021 12:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1640779174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fPekXIco6mkcy/L3Ln7pJoNNXLAlPWchiHu7ERKhQgs=;
        b=r4LxfH9vspyhp96dB7g7Q9aaqS4j/UK/BHoq7GcEUYFpFrRn50b9gyLpAMosFuCdd7jjU/
        s5OuLnnWDs1hPs0g7RDPraA0vovwkTCMQ4G40MCHacHf7KQm2jPU/sZmoQf/r10n4K9H04
        0vBTIbwNRB1sh+XmecUCkU8QS+C4TKk=
Date:   Wed, 29 Dec 2021 12:59:37 +0100
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
Subject: Re: [PATCH 06/26] x86/tdx: Add MSR support for TDX guests
Message-ID: <YcxNqavkZylqoHjw@zn.tnic>
References: <20211214150304.62613-1-kirill.shutemov@linux.intel.com>
 <20211214150304.62613-7-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214150304.62613-7-kirill.shutemov@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:02:44PM +0300, Kirill A. Shutemov wrote:
> +static bool tdx_read_msr_safe(unsigned int msr, u64 *val)
> +{
> +	struct tdx_hypercall_output out;
> +
> +	/*
> +	 * Emulate the MSR read via hypercall. More info about ABI
> +	 * can be found in TDX Guest-Host-Communication Interface
> +	 * (GHCI), sec titled "TDG.VP.VMCALL<Instruction.RDMSR>".
> +	 */
> +	if (_tdx_hypercall(EXIT_REASON_MSR_READ, msr, 0, 0, 0, &out))
> +		return false;
> +
> +	*val = out.r11;
> +
> +	return true;
> +}
> +
> +static bool tdx_write_msr_safe(unsigned int msr, unsigned int low,

Why the "_safe" suffix?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
