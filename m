Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2FA46F31E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243315AbhLISdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhLISdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:33:22 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003ADC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 10:29:48 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id v15-20020a9d604f000000b0056cdb373b82so7116418otj.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 10:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKSnnW4DrtdvfuzMVIOc5xYughW9KqbTrzJNLsvWkG4=;
        b=MegMbt0byg1mdzC+22f35o3uiTYsJsaGdssjvQJ7p9KaShmRI7zuMt3heJB0/iDvM6
         wzWZgcQlVzziIl5hVIAcXjJtvjclzh7Xbo2E/1pv7ewLfEZaCAJ6r4r+mOlIu22qLd8H
         HmJryRPyJumlHUlOK4a3q/aUeDA8ioz1UtvaAM54/Jp6KIDxaneJ3N5JoLwmN5uyrF2U
         3hZWDQa6j6cYDotDXQwkUcz3W3gAJC30ccS2ecszK70QesvGd5mbSIgWYHvVY/vwt8xz
         mTAZz5t0RwXAPz+73j54K2ajerCDdU6oJVCMVXADyvFUHcX8Z7jyc8L775amxLCBdIWL
         4O1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKSnnW4DrtdvfuzMVIOc5xYughW9KqbTrzJNLsvWkG4=;
        b=TcamLt08+BONU/JfJZF7fR/SLIIOrlj4MS6h1YtDxdFXD2t4ucn5NIu2At1FVeuPah
         qlVAQeZHScTGZsoaCQGFIuxMLuJ/J1wcICaPrtZ8/a5nAiqhrtQcjToGClOTytSRbaqL
         IletgJ7lqBx7LJ6PJe0TKZEhDBMQtPlS3vdhI3IugqCy0owX6krAaL0pb4C7MrK+sVdT
         lFJ5WX8BPrl2P3jkH7Ic8t3e8Q60bHFH31SlhNrd4TIFlqL/3sbOGu6TWVpkz/nXS4qu
         jKfHRY6vSrLUVW3HJYZncgY4/4mU0kLI1rL53qTDn6FHTsFaoZIIvfH8ARKJEMj2aEtP
         K4ag==
X-Gm-Message-State: AOAM531o+JwnURovA42jMRHCLLx8x9VAXloOoB0KGbT7O3FllLCXvYp2
        v6t1NEa/teUoQEuZ+WrHk9dm0Ces3GqjhJ9/MIx8GA==
X-Google-Smtp-Source: ABdhPJz9q+13fv5sPdB3A+jjI54jO9ZFPP4o4Yf+7KaxQjbeA0Cbr+AmbuCACN0gLZFmxgYDHYLQqJQgC9mc8RR8tE0=
X-Received: by 2002:a9d:2d81:: with SMTP id g1mr6993444otb.25.1639074588065;
 Thu, 09 Dec 2021 10:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20211209155257.128747-1-marcorr@google.com> <5f8c31b4-6223-a965-0e91-15b4ffc0335e@redhat.com>
 <CALMp9eThf3UtvoLFjajkrXtvOEWQvc8_=Xf6-m6fHXkOhET+GA@mail.gmail.com> <YbJJXKFevTV/L3in@google.com>
In-Reply-To: <YbJJXKFevTV/L3in@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Thu, 9 Dec 2021 10:29:36 -0800
Message-ID: <CAA03e5GE-UGB6YvZfWfWEzpC7+M+EZU3hJsTEOzN0i5UyD5Vpw@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: x86: Always set kvm_run->if_flag
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vkuznets@redhat.com,
        wanpengli@tencent.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, Thomas.Lendacky@amd.com,
        mlevitsk@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 10:22 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Thu, Dec 09, 2021, Jim Mattson wrote:
> > On Thu, Dec 9, 2021 at 9:48 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > On 12/9/21 16:52, Marc Orr wrote:
> > > > The kvm_run struct's if_flag is a part of the userspace/kernel API. The
> > > > SEV-ES patches failed to set this flag because it's no longer needed by
> > > > QEMU (according to the comment in the source code). However, other
> > > > hypervisors may make use of this flag. Therefore, set the flag for
> > > > guests with encrypted registers (i.e., with guest_state_protected set).
> > > >
> > > > Fixes: f1c6366e3043 ("KVM: SVM: Add required changes to support intercepts under SEV-ES")
> > > > Signed-off-by: Marc Orr<marcorr@google.com>
> > >
> > > Applied, though I wonder if it is really needed by those other VMMs
> > > (which? gVisor is the only one that comes to mind that is interested in
> > > userspace APIC).
> >
> > Vanadium appears to have one use of it.
> >
> > > It shouldn't be necessary for in-kernel APIC (where userspace can inject
> > > interrupts at any time), and ready_for_interrupt_injection is superior
> > > for userspace APIC.
> >
> > LOL. Here's that one use...
> >
> > if (vcpu_run_state_->request_interrupt_window &&
> > vcpu_run_state_->ready_for_interrupt_injection &&
> > vcpu_run_state_->if_flag) {
> > ...
> > }
> >
> > So, maybe this is much ado about nothing?
>
> I assume the issue is that SEV-ES always squishes if_flag, so that above statement
> can never evaluate true.

Correct. And the Vanadium code snippet above is what motivated this
patch. Technically Vanadium uses the if_flag in one other place, but I
also think that place can be replaced with the
`ready_for_interrupt_injection` flag. In fact, I had an internal patch
prepped to do this because my reading of the KVM code was identical to
Paolo's that the ready_for_interrupt_injection is superior to the
if_flag. But then after some internal discussion, we felt that the
userspace/kernel API shouldn't have been changed.

All that being said, after Jim added his Ack to this patch (which I
forgot to attach to the v2), we realized that technically the ES
patches were within their right to redefine if_flag since it's
previous semantics are maintained for non-ES VMs and ES requires
userspace changes anyway (PSP commands, guest memory pinning, etc.).

I'm OK either way here. But I assume that if this flag is giving us
pains it will give others pains. And this patch seems reasonable to
me. So all things being equal, I'd prefer to proceed with it.
