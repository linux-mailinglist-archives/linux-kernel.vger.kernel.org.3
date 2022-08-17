Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7659664F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 02:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiHQAb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 20:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHQAbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 20:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1E0786C7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660696282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EuI50tpNraRR40jMmrfH90NbS+qrzYBwLBwfeWEmRwI=;
        b=dSNeIng6SYb5KN5ZTwoorvJVOvRCaFff0x2pg4jvlz94jYu9xXl/DQHH9fPbiCrAsryQ40
        4T7AKs9Xi4K50vAdDWefB8Pveg2jbylaSHLbsCKQBofRXo/brEnygs80ve50f5J3YBf2Bp
        /JVwjJ5oQYRoPcBOeqovjwZ/j3MphEY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-401-PNzYZiiGOPeSKVyzaU9TnQ-1; Tue, 16 Aug 2022 20:31:21 -0400
X-MC-Unique: PNzYZiiGOPeSKVyzaU9TnQ-1
Received: by mail-qk1-f198.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso10455145qkb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 17:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EuI50tpNraRR40jMmrfH90NbS+qrzYBwLBwfeWEmRwI=;
        b=eLNpgRRqHfLlQwUBIrUcACcGIq2W3KhKqZFjj4LiXjaY0DLB4FP8KGMDPbjjj1lcU1
         KyPuXxyOuyXjhQbc+/pzSSiQeREsDQ2F5ezL0F5IbXEokuVUZGoSxfoEeO08qTDVpzUB
         QczG6X0KakZcgw23r16EdRdq8sRuRO4TmL2+iRByhelr61kokTbjkAjq7TDvatnPi7cN
         cTLoraDB2k+TNpDJolTxI0AM2vCt940sf57ZgjGNTRXhfKG1lLygLH+UzoIj1YPszjzu
         8c8b9NTf93zsMWUCvStYsqb/sTwt4Mn3rrKegX/sZdjg2So6QJsnXznZZ9TNNzcPyfDk
         iU0w==
X-Gm-Message-State: ACgBeo3stKGjmrV7N96h8UeTtE9+LlDR62NnXSz4xDLI07MuksmbKfiv
        FnMDn2iomSZg/wa+RXyeKHuE0idD+hlD7yQSC9bTzMe0t7WwP6LLSFKGZl/wIWieCD3+Upm5Jau
        scbEo6DJ+Gp5YegmslbqxRNTN
X-Received: by 2002:a05:622a:178c:b0:31e:f628:f4ab with SMTP id s12-20020a05622a178c00b0031ef628f4abmr21278830qtk.82.1660696280716;
        Tue, 16 Aug 2022 17:31:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5ovI7vWCAOjaXmB/+1IJM/6+VevOElHyLda9cMiC8rUUPGz1pprMfvMwqBOuvxuKgPgQtH6w==
X-Received: by 2002:a05:622a:178c:b0:31e:f628:f4ab with SMTP id s12-20020a05622a178c00b0031ef628f4abmr21278810qtk.82.1660696280478;
        Tue, 16 Aug 2022 17:31:20 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id bs19-20020a05620a471300b006bb9381aee4sm19425qkb.30.2022.08.16.17.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 17:31:19 -0700 (PDT)
Date:   Tue, 16 Aug 2022 20:31:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux MM Mailing List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v2 3/3] kvm/x86: Allow to respond to generic signals
 during slow page faults
Message-ID: <Yvw21nf+Mkn6evVw@xz-m1.local>
References: <20220721000318.93522-1-peterx@redhat.com>
 <20220721000318.93522-4-peterx@redhat.com>
 <YvVitqmmj7Y0eggY@google.com>
 <YvVtX+rosTLxFPe3@xz-m1.local>
 <Yvq6DSu4wmPfXO5/@google.com>
 <YvwCZsHxZV9kPn6I@xz-m1.local>
 <CALzav=faMEU63-7-k-CMT=R-KbBPrZmSVsD3Ef0QNP7gm68wAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALzav=faMEU63-7-k-CMT=R-KbBPrZmSVsD3Ef0QNP7gm68wAA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 03:51:16PM -0700, David Matlack wrote:
> On Tue, Aug 16, 2022 at 1:48 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Aug 15, 2022 at 09:26:37PM +0000, Sean Christopherson wrote:
> > > On Thu, Aug 11, 2022, Peter Xu wrote:
> > > > On Thu, Aug 11, 2022 at 08:12:38PM +0000, Sean Christopherson wrote:
> > > > > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > > > > index 17252f39bd7c..aeafe0e9cfbf 100644
> > > > > > --- a/arch/x86/kvm/mmu/mmu.c
> > > > > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > > > > @@ -3012,6 +3012,13 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
> > > > > >  static int handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
> > > > > >                                unsigned int access)
> > > > > >  {
> > > > > > +       /* NOTE: not all error pfn is fatal; handle sigpending pfn first */
> > > > > > +       if (unlikely(is_sigpending_pfn(fault->pfn))) {
> > > > >
> > > > > Move this into kvm_handle_bad_page(), then there's no need for a comment to call
> > > > > out that this needs to come before the is_error_pfn() check.  This _is_ a "bad"
> > > > > PFN, it just so happens that userspace might be able to resolve the "bad" PFN.
> > > >
> > > > It's a pity it needs to be in "bad pfn" category since that's the only
> > > > thing we can easily use, but true it is now.
> > >
> > > Would renaming that to kvm_handle_error_pfn() help?  I agree that "bad" is poor
> > > terminology now that it handles a variety of errors, hence the quotes.
> >
> > It could be slightly helpful I think, at least it starts to match with how
> > we name KVM_PFN_ERR_*.  Will squash the renaming into the same patch.
> 
> +1 to kvm_handle_error_pfn(). Weirdly I proposed the same as part of
> another series  yesterday [1]. That being said I'm probably going to
> drop my cleanup patch (specifically patches 7-9) since it conflicts
> with your changes and there is a bug in the last patch.
> 
> [1] https://lore.kernel.org/kvm/20220815230110.2266741-8-dmatlack@google.com/

Thanks for the heads-up.

Please still feel free to keep working on new versions since I'm still not
sure which one will land earlier.  I'll repost very soon on this one (I
just added hugetlb support which I overlooked; it's a touch up in patch 1
only though).  I can always rebase on top too.

-- 
Peter Xu

