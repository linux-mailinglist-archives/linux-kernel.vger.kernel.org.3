Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0034A691D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbiBBAOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:14:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43118 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiBBAOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:14:04 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643760843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1iuteILaPcmgvp38R5NiLj75GPRCBDoy7MZSpt1+8hM=;
        b=UF9dQE//G2hFtiR519c7nrBHi6qG0E+UIqruYP3beScI8y2Kx5F4Oo4liE7VKRh0jVDzfC
        WLscCbPfIzvlfJd4KU2kUt+HRB5F5oI03teYSVCB+gdhj6DbkGjFd91A2MUHuuihF3dbRi
        NLEsOfUCCxQ27TmGgeB0MwUXs1REp7K8oRH2FiGQHJnRoTNNjVkwSeZUf+qXg/oJpJww+V
        sd45np4TB0AINSpmGC0VlnlWVAnWZ2aNaEL+x8LNbDjCa5teROoAUO13A0toG4fJNmNaR7
        VnBCmjBnChdjANgXB6XAAh5TWDt+Zq147Fh6nnB1dkY8guIDYt1mWhZVxu1dTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643760843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1iuteILaPcmgvp38R5NiLj75GPRCBDoy7MZSpt1+8hM=;
        b=c/UfHEfAqc7D8XEeTv/84lXl/3GHmRrM31wYegdcAHPkBjjU/RyRVL16JUfMG2LEOvM3a0
        nuOpqz7JyDmrqlAA==
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
Subject: Re: [PATCHv2 20/29] x86/tdx: Get page shared bit info from the TDX
 module
In-Reply-To: <20220124150215.36893-21-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-21-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:14:02 +0100
Message-ID: <87iltyw2et.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
> +static void tdx_get_info(void)
> +{
> +	struct tdx_module_output out;
> +	u64 ret;
> +
> +	/*
> +	 * TDINFO TDX module call is used to get the TD execution environment
> +	 * information like GPA width, number of available vcpus, debug mode
> +	 * information, etc. More details about the ABI can be found in TDX
> +	 * Guest-Host-Communication Interface (GHCI), sec 2.4.2 TDCALL
> +	 * [TDG.VP.INFO].
> +	 */
> +	ret = __tdx_module_call(TDX_GET_INFO, 0, 0, 0, 0, &out);
> +
> +	/* Non zero return value indicates buggy TDX module, so panic */

Can you please get rid of these useless comments all over the place. The
panic() message tells the same story. Please document the non-obvious
things.

Thanks,

        tglx
