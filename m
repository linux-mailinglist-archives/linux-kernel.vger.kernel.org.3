Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066EF474E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 00:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhLNXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 18:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhLNXHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 18:07:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD135C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:07:08 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gj24so1733346pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 15:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jer1i5vFNhou51G7Bt1yKsl5KXF9bp6/PXOx9zRYyGg=;
        b=lZi9I+CyW7rroYqWoRo7GvjJABV+BmFMSLUJnzLvuQzTtawa+SsckJ3iHogQyc+yoc
         I5GtGknTtEG5qZWwAbM+h8rbCGGrltfsnXCmA0zuX8xK0UIRkxQXVRm/1zfiiA7vwyqK
         lcsvCdx/l311WkQwwEsea4aj+7QhdeDoO+j+Zm107kSHdBo6iqPAFbuEc+LiPE1CDyia
         7GMhPl+u3njWOyVmgNu2LXiGjiN3jWEWgls9wRdyyLfVJC6Vw9kjSHBuquhvLuH5HbcE
         4T1gkRFdwhNx1QhY0ZD47kUHmj4pNZQOYDVcx60t3pyWtv3c7tpS/6DBqIo+cCJiHKoD
         KNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jer1i5vFNhou51G7Bt1yKsl5KXF9bp6/PXOx9zRYyGg=;
        b=Y/MS+jNh2kndMDuFk9+8nlqBrTAX45X0i9gSuC4GD9mw87hWKLstXch1fAsdgbhdJ2
         40pD85VF92AVRgqv+c488SxxAaJKu6Znvgju9BkDVSOPTGPJhb2imhAZu5IG8mG0hgmt
         aV1f1XhqoXrRPqw+B77OKA/hWxQp9Du4VOsDTT1a1/2Klftomhcg8RJ+pFBhkyyL3Wu3
         BUCzJypHbrtvQBZOEFOOsgzhPeaAV2dpVisUcAB5U2Qe7JY+K3tuK1sXgVge25fwT5gX
         UrYviz2jZatnd6ByqTSeeaQSMA034cQhlykN14oTXB0b/uoC/idwiCaXeGH80IPEpukV
         gaUA==
X-Gm-Message-State: AOAM5330aV6K+BADeBAb/jd9Bmg6Pwq0eAJjVkKrtzvUZiNPdlEnFHv1
        J7FfutAoeqnUqvkN2hNhbHD32A==
X-Google-Smtp-Source: ABdhPJwpdGISaU3XOpuFv04YLLeKzNx/4y9MbROfNoJe60SFISlkP1msnidU1FIgiDjoGxse0KLm1Q==
X-Received: by 2002:a17:902:e890:b0:148:a2e7:fb3c with SMTP id w16-20020a170902e89000b00148a2e7fb3cmr1681453plg.125.1639523228133;
        Tue, 14 Dec 2021 15:07:08 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id m6sm94896pgs.18.2021.12.14.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 15:07:07 -0800 (PST)
Date:   Tue, 14 Dec 2021 23:07:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, pbonzini@redhat.com,
        mbenes@suse.cz
Subject: Re: [PATCH v2 16/23] x86,vmx: Provide asm-goto-output vmread
Message-ID: <YbkjmGRUHgZifkB0@google.com>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.840433319@infradead.org>
 <YbcbbGW2GcMx6KpD@hirez.programming.kicks-ass.net>
 <YbjmIPWtd6ke66CU@google.com>
 <Ybkeysfj85Ej9W03@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybkeysfj85Ej9W03@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021, Peter Zijlstra wrote:
> On Tue, Dec 14, 2021 at 06:44:48PM +0000, Sean Christopherson wrote:
> > ---
> >  arch/x86/kvm/vmx/vmenter.S |  2 ++
> >  arch/x86/kvm/vmx/vmx.c     |  7 +++++++
> >  arch/x86/kvm/vmx/vmx_ops.h | 31 +++++++++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> > 
> > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > index 3a6461694fc2..d8a7a0a69ec1 100644
> > --- a/arch/x86/kvm/vmx/vmenter.S
> > +++ b/arch/x86/kvm/vmx/vmenter.S
> > @@ -238,6 +238,7 @@ SYM_FUNC_END(__vmx_vcpu_run)
> > 
> >  .section .text, "ax"
> > 
> > +#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
> 
> #ifndef ?

Huh.  Yes.  Could have sworn my gcc version doesn't have goto with output.
