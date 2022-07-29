Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DD6585255
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbiG2PWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237352AbiG2PVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:21:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA42583219
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:21:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v18so4874817plo.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 08:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=1ZDw/3z/X+yx550UAQFNka6PWkeDe5NYwe15kEz7pHU=;
        b=S+gy6IATbpJggKXSY94td4m53HXiZ93LJGa015Sm+3LWLcwnar5FJjly6k+l6xCw3r
         mpAtrAsj50f2W5wiMzdu7cvxa8bYnCIbuSTYxt5bBeU5iEJEWpy6pMdHFuqN1EmDpH6x
         St4aQXo8iVHekOOol7nnXEftYbdcyCqs0S0uv3EBNMkFiULBJTYjIlfpNKuQtqwJStww
         SXGfrd/XRebdR/HpE/QudgSe/l1NjiSuBFvetuHCDoWz/Fs8dmtghb4wyoBFGPdrLsox
         Lk296FG2V/jnYxdVvW9+NcgxxmmxWC5PUTRE7clcq9qE85hJQdYU7NSW1eYeYqVswuhM
         Y6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=1ZDw/3z/X+yx550UAQFNka6PWkeDe5NYwe15kEz7pHU=;
        b=LKzCpYvO7mdeEEeqyio27Xs8+wj1AbQUaIE/Du/X3Xw7g4AQ94lj1MVyU/1GhtEnmD
         mlriZIFW6hQHfZl3KrLq8yW/YT9VDjxisXNEsQxxd5mkDxiZGY/uSCdgW+/+GsrRMWWk
         unjqQ2baX1B0NF/yrL6ATWgCqClUUYSZiaYmAlOLvOAj1ydJn4S1Q6HBTWNIxKOjw0bV
         GWOocX5+fL6CWoFGXTRK3YC7zG5uPZxZ69HEoeP+73OKsAwH7gkKih7lXiV3ha7pLGjf
         9fhk2FtjpG1MbObGuArb4Zo/B29cxoyRNCTXRuY7DtLvLM5oCaLHvZJfK9Dr7xS90IgU
         n+sQ==
X-Gm-Message-State: ACgBeo2X9v0OZnezRiXRPK9GOq2BfIJN35z88lRL3ui9fzS8b5ZFnUrQ
        qwhQDerDEAfqrNEhC7Q968XlwA==
X-Google-Smtp-Source: AA6agR7NYs2c/zcNB15D0jIe7jgy3CA9rztzeX745HupFnJf/9qKLBj2eCo5rDYiX+iAeJhRNlSu7g==
X-Received: by 2002:a17:90b:4a92:b0:1f2:a67b:296d with SMTP id lp18-20020a17090b4a9200b001f2a67b296dmr5383203pjb.149.1659108077936;
        Fri, 29 Jul 2022 08:21:17 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b0016a058b7547sm3773294plg.294.2022.07.29.08.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 08:21:17 -0700 (PDT)
Date:   Fri, 29 Jul 2022 15:21:13 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 4/4] KVM: SVM: Disable SEV-ES support if MMIO caching is
 disable
Message-ID: <YuP66QVxyeT4wd5H@google.com>
References: <20220728221759.3492539-1-seanjc@google.com>
 <20220728221759.3492539-5-seanjc@google.com>
 <d09972481dede743dd0a77409cd8ecaecdbf86b3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d09972481dede743dd0a77409cd8ecaecdbf86b3.camel@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022, Kai Huang wrote:
> On Thu, 2022-07-28 at 22:17 +0000, Sean Christopherson wrote:
> > Disable SEV-ES if MMIO caching is disabled as SEV-ES relies on MMIO SPTEs
> > generating #NPF(RSVD), which are reflected by the CPU into the guest as
> > a #VC.  With SEV-ES, the untrusted host, a.k.a. KVM, doesn't have access
> > to the guest instruction stream or register state and so can't directly
> > emulate in response to a #NPF on an emulated MMIO GPA.  Disabling MMIO
> > caching means guest accesses to emulated MMIO ranges cause #NPF(!PRESENT),
> > and those flavors of #NPF cause automatic VM-Exits, not #VC.
> > 
> > Fixes: b09763da4dd8 ("KVM: x86/mmu: Add module param to disable MMIO caching (for testing)")
> > Reported-by: Michael Roth <michael.roth@amd.com>
> > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---

...

> > +	/*
> > +	 * SEV-ES requires MMIO caching as KVM doesn't have access to the guest
> > +	 * instruction stream, i.e. can't emulate in response to a #NPF and
> > +	 * instead relies on #NPF(RSVD) being reflected into the guest as #VC
> > +	 * (the guest can then do a #VMGEXIT to request MMIO emulation).
> > +	 */
> > +	if (!enable_mmio_caching)
> > +		goto out;
> > +
> > 
> 
> I am not familiar with SEV, but looks it is similar to TDX -- they both causes
> #VE to guest instead of faulting into KVM.  And they both require explicit call
> from guest to do MMIO.
> 
> In this case, does existing MMIO caching logic still apply to them?

Yes, because TDX/SEV-ES+ need to generate #VE/#VC on emulated MMIO so that legacy
(or intentionally unenlightened) software in the guest doesn't simply hang/die on
memory accesses to emulated MMIO (as opposed to direct TDVMCALL/#VMGEXIT).

> Should we still treat SEV and TDX's MMIO handling as MMIO caching being
> enabled?  Or perhaps another variable?

I don't think a separate variable is necesary.  At its core, KVM is still caching
MMIO GPAs via magic SPTE values.  The fact that it's required for functionality
doesn't make the name wrong.

SEV-ES+ in particular doesn't have a strong guarantee that inducing #VC via #NPF(RSVD)
is always possible.  Theoretically, an SEV-ES+ capable CPU could ship with an effective
MAXPHYADDR=51 (after reducing the raw MAXPHYADDR) and C-bit=51, in which case there are
no resered PA bits and thus no reserved PTE bits at all.  That's obviously unlikely to
happen, but if it does come up, then disabling SEV-ES+ due to MMIO caching not being
possible is the desired behavior, e.g. either the CPU configuration is bad or KVM is
lacking support for a newfangled way to support emulated MMIO (in a future theoretical
SEV-* product).
