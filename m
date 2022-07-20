Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E174A57C070
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 01:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiGTXFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiGTXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 19:05:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F6B5B783
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:05:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l14-20020a17090a72ce00b001f20ed3c55dso3652214pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 16:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agG7UVRQdg8e2EP+3/jBhjlCekFVJFIsZ++hL4DCHhg=;
        b=cAxN78BrxCxiDW+0kYB8SCmTCYj112kJQWiiFgA+sRye+PEBO5LXbTMgS6KFlk4zVB
         8n/jhipW4npAqnJIA7tH0t4UDCSUzgXrBMvhIaJ1/CvQ/g36GNRj9P28LNeiU/FQVisl
         1FLI7Rt77+1Vip5T8Z+WEe223NS7gtX093cO7nJ5j8V6n7f3EkWQawcyijip0M7tzhcR
         +ntxvecAcLVMJoeAbDk6mYuMYeuNVTvm17RSG7ytutZYjFjt6k64Cye5Q5AK73DhL+te
         1I3qzpnb4fSqzccgUJ9GnCUuE/gEJXQELqNpdSOE7B7gXOLMLf+Ziy6bdxerlJV8uRi7
         7/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agG7UVRQdg8e2EP+3/jBhjlCekFVJFIsZ++hL4DCHhg=;
        b=j83CKdBEWjf0Z6fprGz2LMIzvQF08LUx1Vl+F7wgf/VY0Qd4zYf4W+jwN703/q+QJv
         d81oAKdiLuetrQNoNkWw3zjzRpx0S7tGmeE6UQTNyQiNV5Fpa6WxyyMN3kX9g5CjxeZd
         WW0XEU40T8zs3PiSJPgJN8S5Qzs/SDLVJY9nWvowq1Zgvy74E/sPMnTr981hiebtsEd3
         IxAKc64X4897WJZc/TjZotgqyFFQN7tL1HOGqVymKEPQb3xtU7K13Iazuvi1mNS0bhNx
         MsqzdP/uYtYltFuXXEL/jBUAqvTZ2UAuvFdgtKTErDaBMFJTpTZOrLNM/LxLJ5muQtBZ
         esBg==
X-Gm-Message-State: AJIora88XVuw3ofIRM1EbgvYQjrxhPqVWxEf+umatUs6sey8K2jtklao
        KqT8k329Abxa1d2TP3iImx2EJQ==
X-Google-Smtp-Source: AGRyM1vzbnUt8hk1ufGacP/3gRVnEj1puHWMUNJ6iD1mMLKE99yXW4YUsgVDTIT1hwOJnrHXuSYT0A==
X-Received: by 2002:a17:90a:9409:b0:1f0:e171:f2bd with SMTP id r9-20020a17090a940900b001f0e171f2bdmr7795636pjo.245.1658358301261;
        Wed, 20 Jul 2022 16:05:01 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b0015ee60ef65bsm81899plh.260.2022.07.20.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 16:05:00 -0700 (PDT)
Date:   Wed, 20 Jul 2022 23:04:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 5/7] KVM: SVM: Add VNMI support in inject_nmi
Message-ID: <YtiKGKhrQYp1TAWU@google.com>
References: <20220709134230.2397-1-santosh.shukla@amd.com>
 <20220709134230.2397-6-santosh.shukla@amd.com>
 <Yth2eik6usFvC4vW@google.com>
 <CALMp9eQ_ygX7P-YKGQh0mZein6LcTM=gMbQpi8HNfm7XaFi36w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eQ_ygX7P-YKGQh0mZein6LcTM=gMbQpi8HNfm7XaFi36w@mail.gmail.com>
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

On Wed, Jul 20, 2022, Jim Mattson wrote:
> On Wed, Jul 20, 2022 at 2:41 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Sat, Jul 09, 2022, Santosh Shukla wrote:
> > > Inject the NMI by setting V_NMI in the VMCB interrupt control. processor
> > > will clear V_NMI to acknowledge processing has started and will keep the
> > > V_NMI_MASK set until the processor is done with processing the NMI event.
> > >
> > > Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> > > ---
> > > v2:
> > > - Added WARN_ON check for vnmi pending.
> > > - use `get_vnmi_vmcb` to get correct vmcb so to inject vnmi.
> > >
> > >  arch/x86/kvm/svm/svm.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 44c1f2317b45..c73a1809a7c7 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -3375,12 +3375,20 @@ static void pre_svm_run(struct kvm_vcpu *vcpu)
> > >  static void svm_inject_nmi(struct kvm_vcpu *vcpu)
> > >  {
> > >       struct vcpu_svm *svm = to_svm(vcpu);
> > > +     struct vmcb *vmcb = NULL;
> > > +
> > > +     ++vcpu->stat.nmi_injections;
> > > +     if (is_vnmi_enabled(svm)) {
> > > +             vmcb = get_vnmi_vmcb(svm);
> > > +             WARN_ON(vmcb->control.int_ctl & V_NMI_PENDING);
> >
> > Haven't read the spec, but based on the changelog I assume the flag doesn't get
> > cleared until the NMI is fully delivered.
> 
> Ooh! Is there a spec to read now?!?

Apparently not.  I just assumed there's a spec, but I haven't found one.
