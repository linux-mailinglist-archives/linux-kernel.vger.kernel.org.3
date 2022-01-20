Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0E4494496
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 01:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357767AbiATA1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 19:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiATA1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 19:27:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B035FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:27:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so3286323pju.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 16:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+TqAt14XKXCbtB/P6ewZv6dez1U9WqxQBNJ+sItXmlI=;
        b=F/r6jm4JzyNVaU7DF6e9U4M2zV1h4k4Mrg4VYBW7l2IN1j8EcwrQiXOcu6Gvnk3jmR
         Zm2RatSb4zvpG74iCIhDtzCg6rvMo+nBURyCB3QB1+fQAnKweumNAkvx1I0SD+PE25XA
         5QD9kMNy3iNJXNSIyNTNzCWpvVz749GYxa3+R3vpzTKty2zLTAegEINhm195SOL+mC+y
         tkU6I6kM6Ccpiy6EtPro96tevnIfYb9L/UeN5LaOpwbNxRGL8uOeJwIGfpi1eufa0kdF
         F7O2Ur+Xe5ycOLIpqYgay4HF0msKYazYuSjCZjRzZrXKKAgO4PZHEWZ7mwcdTem4h2oT
         zocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+TqAt14XKXCbtB/P6ewZv6dez1U9WqxQBNJ+sItXmlI=;
        b=vuK/ybU4mOHkhgLBZf3tpa8mSQtcHBYbK7UDUXRpQENqPpIIl13bwjHbKqpPpKu/ei
         5jRYtuyvXClA4ISfDbuvvGpo2ggdHHEi7bbptS7cYNQ2LCDE0xTPBp8lx+c0fsmPtOFB
         TJrIVBXjDD9LLzTr+FwLsoDylhW+BEqT2WC8msDhh44HQU7bHFpc89oNpj3+RxcYlxM7
         SCKYUG3WkoKWwdmru05M2sXurgWfBOImQv15jGNh5xNih3OZBz+EqC4JwD1HljCXnKXe
         J9m1GHdQmJo9n+PhPVAUv9uA8vjLmXBNhF5kBXf2gTFEWzqRqI4dUktE4olCPMEj1yV+
         pSgg==
X-Gm-Message-State: AOAM530KAkb8GqjYfBSMp1iHauzu12QdXlw9kSSNT1vxMJfZFsjThmGz
        q/V94BXhnCeD75+JAnJu/fZdVA==
X-Google-Smtp-Source: ABdhPJy8eb351Wq5iEXEb6Pkw/V9Y3ntyEY4dpEYnYofdfrP1ruzhmhasshPA0tIWyfCz/62Czq8cA==
X-Received: by 2002:a17:90a:5d07:: with SMTP id s7mr7432257pji.226.1642638440008;
        Wed, 19 Jan 2022 16:27:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id a3sm706367pfo.163.2022.01.19.16.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 16:27:19 -0800 (PST)
Date:   Thu, 20 Jan 2022 00:27:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Reiji Watanabe <reijiw@google.com>
Cc:     Raghavendra Rao Ananta <rananta@google.com>, kvm@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Peter Shier <pshier@google.com>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [RFC PATCH v3 01/11] KVM: Capture VM start
Message-ID: <YeisZCJedWYJPLV5@google.com>
References: <CALMp9eQDzqoJMck=_agEZNU9FJY9LB=iW-8hkrRc20NtqN=gDA@mail.gmail.com>
 <CAJHc60xZ9emY9Rs9ZbV+AH-Mjmkyg4JZU7V16TF48C-HJn+n4A@mail.gmail.com>
 <CALMp9eTPJZDtMiHZ5XRiYw2NR9EBKSfcP5CYddzyd2cgWsJ9hw@mail.gmail.com>
 <CAJHc60xD2U36pM4+Dq3yZw6Cokk-16X83JHMPXj4aFnxOJ3BUQ@mail.gmail.com>
 <CALMp9eR+evJ+w9VTSvR2KHciQDgTsnS=bh=1OUL4yy8gG6O51A@mail.gmail.com>
 <CAJHc60zw1o=JdUJ+sNNtv3mc_JTRMKG3kPp=-cchWkHm74hUYA@mail.gmail.com>
 <YeBfj89mIf8SezfD@google.com>
 <CAAeT=Fz2q4PfJMXes3A9f+c01NnyORbvUrzJZO=ew-LsjPq2jQ@mail.gmail.com>
 <YedWUJNnQK3HFrWC@google.com>
 <CAAeT=FyJAG1dEFLvrQ4UXrwUqBUhY0AKkjzFpyi74zCJZUEYVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeT=FyJAG1dEFLvrQ4UXrwUqBUhY0AKkjzFpyi74zCJZUEYVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022, Reiji Watanabe wrote:
> On Tue, Jan 18, 2022 at 4:07 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Jan 14, 2022, Reiji Watanabe wrote:
> > > The restriction, with which KVM doesn't need to worry about the changes
> > > in the registers after KVM_RUN, could potentially protect or be useful
> > > to protect KVM and simplify future changes/maintenance of the KVM codes
> > > that consumes the values.
> >
> > That sort of protection is definitely welcome, the previously mentioned CPUID mess
> > on x86 would have benefit greatly by KVM being restrictive in the past.  That said,
> > hooking KVM_RUN is likely the wrong way to go about implementing any restrictions.
> > Running a vCPU is where much of the vCPU's state is explicitly consumed, but it's
> > all too easy for KVM to implicity/indirectly consume state via a different ioctl(),
> > e.g. if there are side effects that are visible in other registers, than an update
> > can also be visible to userspace via KVM_{G,S}ET_{S,}REGS, at which point disallowing
> > modifying state after KVM_RUN but not after reading/writing regs is arbitrary and
> > inconsitent.
> 
> Thank you for your comments !
> I think I understand your concern, and that's a great point.
> That's not the case for those pseudo registers though at least for now :)
> BTW, is this concern specific to hooking KVM_RUN ? (Wouldn't it be the
> same for the option with "if kvm->created_vcpus > 0" ?)

Not really?  The goal with created_vcpus is to avoid having inconsistent state in
"struct kvm_vcpu" with respect to the VM as whole.  "struct kvm" obvioulsy can't
be inconsistent with itself, e.g. even if userspace consumes some side effect,
that's simply "the state".  Did that make sense?  Hard to explain in writing :-)

> > If possible, preventing modification if kvm->created_vcpus > 0 is ideal as it's
> > a relatively common pattern in KVM, and provides a clear boundary to userpace
> > regarding what is/isn't allowed.
> 
> Yes, I agree that would be better in general.  For (pseudo) registers,

What exactly are these pseudo registers?  If it's something that's an immutable
property of the (virtual) system, then it might make sense to use a separate,
non-vCPU mechanism for setting/getting their values.  Then you can easily restrict
the <whatever> to pre-created_vcpus, e.g. see x86's KVM_SET_IDENTITY_MAP_ADDR.

> I would think preventing modification if kvm->created_vcpus > 0 might
> not be a very good option for KVM/ARM though considering usage of
> KVM_GET_REG_LIST and KVM_{G,S}ET_ONE_REG.
