Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31D46A2A8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhLFRZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 12:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhLFRZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 12:25:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B01C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 09:21:54 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id r130so10811990pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zHMj/3qBUCC3+8//0waM7H9mXBNiTb8p3Q6GTlN1BIQ=;
        b=V89zMk9PSRF+6ij1Owd6/Wj/UvX1SzoChLPDcmQBHphtROUwfVaDe7S1YWFnQE2Plk
         Ei8bDn09+35LHdzX4DbfSInT9RDQAMUUWokyhdyjn/IH2FHJ25qwudNUPq5mGKIda/Tc
         fED6Sgp9Ndl7kX/D9YnkKHiSsp3On90gMTw0SIJhxqyHrNm9Rszak9vyaiPnSB+tmD2K
         fl1Z+FJyz+cx5+IXvtTGPFf4Lfa39WiKlYx7xZrhzHtI783+eyVMyvHfHvGtJ4ltLIK5
         3m0k/FZzpmSL4O6xGToB12SKS0VRRSuxBqV0LkMLUfLeTiSAhS+nNou4FhsKy3Ur2iOx
         cuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zHMj/3qBUCC3+8//0waM7H9mXBNiTb8p3Q6GTlN1BIQ=;
        b=2GnWTNvHTHPaJ58AivZTI4bprSmBBItRcxuluTw4jr8oY18iaZZpOYc5jvfg7J+HP7
         +fBlFJmZGwDkdFeZAkhPjgOFCOxb7I0nWi3RSZQ5cuIbl8f9s8D3RmMWK9XhiMZOscMw
         dfn4P5w9YLMnEelHqfWaIQZeSIrzZSVrD4UCOXoQ576xP2cC2cCx/OTBqdctNjcEEAjA
         DRVQxjh49N/PGIpeKs8SDAN4jc0z+1JhjtiXIyrishhp+tbj+eUIcK639iFzTWkTvjmC
         i2fU2+R4Vh/i/wulr2JKbl+yl38ztzypr7p3LfvTWIeX2Jdv+k62I4RPXQrY8H+I4e7/
         gbZQ==
X-Gm-Message-State: AOAM530yO3lyVWWwwseOt0oEca0J5uYwLkTtnpY7Dvy6M8hj0gmkE0y9
        6zHST4oXK+KJi9gihr5oyGFxZA==
X-Google-Smtp-Source: ABdhPJwh85ZC9FOQGDlaNcHaXtupLcTY72D6mwObQ4WRn2rkhSYYxj9lRDQ8qyH2uMV3mFpDVI2iGA==
X-Received: by 2002:a63:d245:: with SMTP id t5mr19286123pgi.483.1638811314127;
        Mon, 06 Dec 2021 09:21:54 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 13sm12636549pfp.216.2021.12.06.09.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 09:21:53 -0800 (PST)
Date:   Mon, 6 Dec 2021 17:21:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        jmattson@google.com,
        syzbot <syzbot+f1d2136db9c80d4733e8@syzkaller.appspotmail.com>,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        joro@8bytes.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, wanpengli@tencent.com, x86@kernel.org
Subject: Re: [syzbot] WARNING in nested_vmx_vmexit
Message-ID: <Ya5GrdTICjW6Csvr@google.com>
References: <00000000000051f90e05d2664f1d@google.com>
 <87bl1u6qku.fsf@redhat.com>
 <Ya40sXNcLzBUlpdW@google.com>
 <87k0gh675j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0gh675j.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > I objected to the patch[*], but looking back at the dates, it appears that I did
> > so after the patch was queued and my comments were never addressed.  
> > I'll see if I can reproduce this with a selftest.  The fix is likely just:
> >
> > diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> > index dc4909b67c5c..927a7c43b73b 100644
> > --- a/arch/x86/kvm/vmx/vmx.c
> > +++ b/arch/x86/kvm/vmx/vmx.c
> > @@ -6665,10 +6665,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
> >          * consistency check VM-Exit due to invalid guest state and bail.
> >          */
> >         if (unlikely(vmx->emulation_required)) {
> > -
> > -               /* We don't emulate invalid state of a nested guest */
> > -               vmx->fail = is_guest_mode(vcpu);
> > -
> >                 vmx->exit_reason.full = EXIT_REASON_INVALID_STATE;
> >                 vmx->exit_reason.failed_vmentry = 1;
> >                 kvm_register_mark_available(vcpu, VCPU_EXREG_EXIT_INFO_1);
> >
> > [*] https://lore.kernel.org/all/YWDWPbgJik5spT1D@google.com/
> 
> Let's also summon Max to the discussion to get his thoughts.

Thinking more on this, we should do three things:

  1. Revert this part back to "vmx->fail = 0".

  2. Override SS.RPL and CS.RPL on RSM for VMX.  Not sure this is strictly
     necessary, I'm struggling to remember how SS.RPL and SS.DPL can get out of
     sync.

       IF RFLAGS.VM = 0 AND (in VMX root operation OR the “unrestricted guest”
       VM-execution control is 0)
       THEN
         CS.RPL := SS.DPL;
         SS.RPL := SS.DPL;
       FI;

  3. Modify RSM to go into TRIPLE_FAULT if vmx->emulation_required is true after
     loading state for RSM.  On AMD, whose SMRAM KVM emulates, all segment state
     is read-only, i.e. if it's modified to be invalid then KVM essentially do
     whatever it wants.

  4. Reject KVM_RUN if is_guest_mode() and vmx->emulation_required are true.  By
     handling the RSM case explicitly, this means userspace has attempted to run
     L2 with garbage, which KVM most definitely doesn't want to support.

  5. Add KVM_BUG_ON(is_guest_mode(vcpu), ...) in the emulation_required path in
     vmx_vcpu_run(), as reaching that point means KVM botched VM-Enter, RSM or
     the #4 above.
