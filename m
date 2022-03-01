Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4F4C8F35
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiCAPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbiCAPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:36:43 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E3BA9962
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 07:36:02 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d17so14601447pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jUOsJO0Kh4op4ysiBpAZaJEjcEJRjoValu/KGpdNufI=;
        b=Xx/fToonpb0BLFsiJYajJg5bmf9rg6IkQTVt3S2dztqjE74NoV3y6ZAu+8QUwe57Ho
         yBtU7cxUQs7WbULkkg3MVcP0Qnp3G2k6WD1bawRHA4NPXirp8TmOyJ83BWCufpPvN2xK
         Mmms2hWOAEhgr7ZUjf9RBd0Id20pNThct9EWADODJyPTT5bdvzYsPzi6iGXuH9EZlnod
         Q1R0puyPWOa58YzCjkwHWv+5gHc8UkwjenIRpQoj7w6lqOkAgqc39lO574Y7ffpOlJ2+
         fxOT3SHB/pyJdoNnTf+vg4CGc2X5TfZllqNC1d/HiHhIo963WD5kx4UX/iG16dGunXoF
         p4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jUOsJO0Kh4op4ysiBpAZaJEjcEJRjoValu/KGpdNufI=;
        b=HE6AGXt0m4wx6/RxK/oOSt1zHKdhCWsnol/HyAD/uak1HFjZ4R8PbQTEmKTrFW4+oq
         4eGpp5kclxdU0CPEQiChSlIH7LUiltjzrwBpstAePAIiGe5koNcCZUrQhMOPFxn1/yTJ
         lkHI68GnYZnZwmaIMPT0y2MWxTa9cMGC4qkQi/TDa3PKqqutyqwBjHIuhcyZ6yQNCwTl
         rfcs9n3vN6DVvgliYFxESeoe3QMM9vhDQLqGPMo6C2oTtRxaQkSPVg3wUxWyIjHvgn9l
         81odD9m6Wv/F6ezXtpO+zWukNyWqQSmCn38SVmtaOs6KUDZxvE0HssaH5vo+JLX92HIK
         wJoQ==
X-Gm-Message-State: AOAM530HGfvjVvoVtcvs4hYYd7hJpleKqMCmNL27/hP2cCk9p9In1ULp
        OjO8+05TkIrWMedCd456goVU2nVpRFXLDw==
X-Google-Smtp-Source: ABdhPJwfTxSMRJIEVSZW5P0MeCJh888AvLZ+3mjfn41HW4RdLcUjEGXvFimCPbn2krTT5qZhI1Curw==
X-Received: by 2002:a63:f912:0:b0:372:bac6:b92d with SMTP id h18-20020a63f912000000b00372bac6b92dmr21836548pgi.265.1646148961137;
        Tue, 01 Mar 2022 07:36:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k20-20020a056a00135400b004ecc81067b8sm19037987pfu.144.2022.03.01.07.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 07:36:00 -0800 (PST)
Date:   Tue, 1 Mar 2022 15:35:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 7/7] KVM: WARN if is_unsync_root() is called on a root
 without a shadow page
Message-ID: <Yh49XaSR88HZCmQa@google.com>
References: <20220225182248.3812651-1-seanjc@google.com>
 <20220225182248.3812651-8-seanjc@google.com>
 <CANgfPd_zdQAu7m1M_g0wy0wsUpyHDtbE+tUZOKQN59y0ABpvPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_zdQAu7m1M_g0wy0wsUpyHDtbE+tUZOKQN59y0ABpvPw@mail.gmail.com>
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022, Ben Gardon wrote:
> On Fri, Feb 25, 2022 at 10:23 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > WARN and bail if is_unsync_root() is passed a root for which there is no
> > shadow page, i.e. is passed the physical address of one of the special
> > roots, which do not have an associated shadow page.  The current usage
> > squeaks by without bug reports because neither kvm_mmu_sync_roots() nor
> > kvm_mmu_sync_prev_roots() calls the helper with pae_root or pml4_root,
> > and 5-level AMD CPUs are not generally available, i.e. no one can coerce
> > KVM into calling is_unsync_root() on pml5_root.
> >
> > Note, this doesn't fix the mess with 5-level nNPT, it just (hopefully)
> > prevents KVM from crashing.
> >
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index 825996408465..3e7c8ad5bed9 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3634,6 +3634,14 @@ static bool is_unsync_root(hpa_t root)
> >          */
> >         smp_rmb();
> >         sp = to_shadow_page(root);
> > +
> > +       /*
> > +        * PAE roots (somewhat arbitrarily) aren't backed by shadow pages, the
> > +        * PDPTEs for a given PAE root need to be synchronized individually.
> > +        */
> > +       if (WARN_ON_ONCE(!sp))
> > +               return false;
> > +
> 
> I was trying to figure out if this should be returning true or false,
> but neither really seems correct. Since we never expect this to fire,
> perhaps it doesn't matter and it's easier to just return false so the
> callers don't need to be changed.

Yep, neither is correct.

> If this did fire in a production scenario, I'd want it to terminate the VM
> too.

Me too, but practically speaking this should never get anywhere near production.
IMO, it's not worth plumbing in @kvm just to be able to do KVM_BUG_ON.
