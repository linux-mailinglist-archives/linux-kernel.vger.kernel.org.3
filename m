Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6274E4A76A2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiBBRSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBBRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:18:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC2C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 09:18:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643822289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1W3CatsTSaUESh2pkzhl+s6MMLwXYDYPpJVqIQel9g=;
        b=BM7ijJSoWFhsx+IJG+Ciy3huo54Ne+GD2NQo3AhMANrlhYr76bkuHZssRUlCeRe0WapzrL
        5hPrZFuggzB9Fe/3nGjXGW/xNeJYtIDGVdeEw7a6J1TYAod0/J/I7T+20IsJfvGY7J/xZ3
        /zs2U6UivxL6+gEWqYZZTr+hH+lAy5rEyz8MHM4/KiScBRCC2Id2h8qElic3bjLZog9BuP
        0KknlDXDjPIdldh39ZIH1jEOwzRKXR39kOSBkj854dBBJ5HHVGfIdDYRuTxA53kIHb0IPT
        607ehe4SZ/YSfi/SbS8FTqhLwvmCn9Nkof8/RjgMSwLpdBnh46WZeQYOaawzEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643822289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G1W3CatsTSaUESh2pkzhl+s6MMLwXYDYPpJVqIQel9g=;
        b=Ng0gWOzyxTwpnKsxUeDFWyN+tH8LL8OykXncuppiAUPrpIKqcvBibRczwaldYaG4rYizCY
        MEE/MVGzFcm+TmCg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 06/29] x86/tdx: Add MSR support for TDX guests
In-Reply-To: <20220202130616.xknv5y5s4xavuzmi@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-7-kirill.shutemov@linux.intel.com>
 <871r0mz2rm.ffs@tglx> <20220202130616.xknv5y5s4xavuzmi@black.fi.intel.com>
Date:   Wed, 02 Feb 2022 18:18:08 +0100
Message-ID: <8735l1uqzz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at 16:06, Kirill A. Shutemov wrote:
> On Tue, Feb 01, 2022 at 10:38:05PM +0100, Thomas Gleixner wrote:
>> Hmm?
>
> No problem with this approach on read side.
>
> On the write side there's one important optimization (outside of the
> initial TDX enabling):
>
> https://github.com/intel/tdx/commit/2cea8becaa5a287c93266c01fc7f2a4ed53c509d
>
> It will require rework, maybe use separate __tdx_hypercall() for the
> paravirt call implementation.

Yes, but that's not the end of the world.

Thanks,

        tglx
