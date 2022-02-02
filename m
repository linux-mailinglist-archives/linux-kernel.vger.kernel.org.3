Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FF4A6915
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbiBBAJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:09:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiBBAJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:09:40 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643760579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHzOIspLMv73aXUdrSGNFW39BSJMmYuDCXEiGCsKL3I=;
        b=SddBQn3tbEj9uq9HH0HpL4tKPW/8vHJX5YPfZ/5pJDgekxbyZvsPBeki89w2AvHI5sj9Dc
        1zn4nCfa8t/D78uosMj0SFxDPIeC8Up+MVe9Jz2FMhemvDKll7rXwZ4XhdBCix661xsFwZ
        bN0RHGW24KWM3UaLG7WlSCnAbEmIkOJyR/djalBAmKiHAyPK8x6wzX2WZ6dT+TRWRl/eiX
        eVBqQQDM9ivkJXeglpD6DCZ/pBEVp6SPlnjWRk78/NwSTV4qHmwzvrwc7s4GRLyg0lsatg
        IaWSJyPYDwbtxDpaaEsZyvq+x2v/GBMsnOXo/44pFaF+zXEvUcxoN+PEosjv3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643760579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHzOIspLMv73aXUdrSGNFW39BSJMmYuDCXEiGCsKL3I=;
        b=JcnDnzoZIKSpAYcryi+Vxs3ALqPzKDHWewutc1JIYiXdJSsTEkal3t2ivVGOQLffxst1kz
        l+KB5sZmob7+yvBw==
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
Subject: Re: [PATCHv2 19/29] x86/topology: Disable CPU online/offline
 control for TDX guests
In-Reply-To: <20220124150215.36893-20-kirill.shutemov@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-20-kirill.shutemov@linux.intel.com>
Date:   Wed, 02 Feb 2022 01:09:38 +0100
Message-ID: <87o83qw2m5.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>  static bool intel_cc_platform_has(enum cc_attr attr)
>  {
> -	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
> +	switch (attr) {
> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
> +	case CC_ATTR_HOTPLUG_DISABLED:
>  		return true;
> +	default:
> +		return false;
> +	}
>  
>  	return false;

Sigh. If 'default:' returns false then this final return cannot be
reached, no?

Thanks,

        tglx
