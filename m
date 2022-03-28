Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65B34E9D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbiC1RPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244494AbiC1RO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:14:57 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567F4D63
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:13:15 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so13283812pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 10:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xkOsBgVuG0zCndlt1G8crnufHuKqrN/5aTVkYRyBZfc=;
        b=YDY+YeRkB1EvXc+KqVUKjZJIfyymRN45O804LxSksnIdheInoNyrxLgz1F47fxHVQL
         O0Kja0/2Q4FdPsdKGceWLGPOsgIB7koi3bsv2jQY5FvEw9UpUJEaEeBfe/lq8itIV2He
         SQnYSKK1Fz1SViat1FInTLq4FgbBR06LBs+nbppiyo+/q2iYabnxipScvrMV4E1MSScm
         IuEuDnKZdCEpPFMGG4zz4wq7C6Q1bv6ZTbkfGcUvtR4ftGNRAKLv/g8foAvB0eSaH3Lv
         j5RVx3sG+vmQwgxgF8/tNjDTKl16iAAeEO1TLbSC9OarbzM8Xt1ZEbnWEKcUJqGexWp3
         CiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkOsBgVuG0zCndlt1G8crnufHuKqrN/5aTVkYRyBZfc=;
        b=xiEq5aIg1Va9IGvO0NRFFOL28YiMKun5V1Fd0g09DFUu9e3CE9sDkq279rl4dxTPHt
         Au1SvD/dGa8gMsGuo5ewrU0ObIma+9hni+0UlB79SQu90WJfAIWrGTPr6O1lfrO1269J
         z+G5lQndTkL9LQ83B/qt8wSwO9Nzbc2sMM9sTZyGm5UIplcSLAL8JT9aAoFIdEJM1M8j
         1lAEnvHedTGbp/ajKFJlocoUBnrQ7DXVxGNB5W0LV82NCqUHsIyAGyr5ePZPPK82dSH/
         XA5iwi9b9R5IRgks+BvxBLcrChq2ONNB2ev9HR1hvoTZ7pS0qBgn1RvLdP7UPYnlpPev
         zKhA==
X-Gm-Message-State: AOAM530TRnCI/XRLMtMqLwpms/wDWmechIZZgT0XgGAshyMC1eyXRynp
        zojxPeM8FvyKTslR2ukSssctSw==
X-Google-Smtp-Source: ABdhPJyjv96+m6AY6ltlDIh6YwZCGgDdQJCULPA3+nexLHL1Y3Cwco6Ne/HueLnONAhilf3ume3wCw==
X-Received: by 2002:a05:6a00:1a02:b0:4fb:20f0:c1aa with SMTP id g2-20020a056a001a0200b004fb20f0c1aamr15081324pfv.45.1648487594529;
        Mon, 28 Mar 2022 10:13:14 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f91-20020a17090a706400b001c7858a6879sm80756pjk.12.2022.03.28.10.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 10:13:13 -0700 (PDT)
Date:   Mon, 28 Mar 2022 17:13:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, maz@kernel.org,
        will@kernel.org
Subject: Re: [PATCH v5 00/13] KVM: mm: fd-based approach for supporting KVM
 guest private memory
Message-ID: <YkHspg+YzOsbUaCf@google.com>
References: <20220310140911.50924-1-chao.p.peng@linux.intel.com>
 <YjyS6A0o4JASQK+B@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjyS6A0o4JASQK+B@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022, Quentin Perret wrote:
> For Protected KVM (and I suspect most other confidential computing
> solutions), guests have the ability to share some of their pages back
> with the host kernel using a dedicated hypercall. This is necessary
> for e.g. virtio communications, so these shared pages need to be mapped
> back into the VMM's address space. I'm a bit confused about how that
> would work with the approach proposed here. What is going to be the
> approach for TDX?
> 
> It feels like the most 'natural' thing would be to have a KVM exit
> reason describing which pages have been shared back by the guest, and to
> then allow the VMM to mmap those specific pages in response in the
> memfd. Is this something that has been discussed or considered?

The proposed solution is to exit to userspace with a new exit reason, KVM_EXIT_MEMORY_ERROR,
when the guest makes the hypercall to request conversion[1].  The private fd itself
will never allow mapping memory into userspace, instead userspace will need to punch
a hole in the private fd backing store.  The absense of a valid mapping in the private
fd is how KVM detects that a pfn is "shared" (memslots without a private fd are always
shared)[2].

The key point is that KVM never decides to convert between shared and private, it's
always a userspace decision.  Like normal memslots, where userspace has full control
over what gfns are a valid, this gives userspace full control over whether a gfn is
shared or private at any given time.

Another important detail is that this approach means the kernel and KVM treat the
shared backing store and private backing store as independent, albeit related,
entities.  This is very deliberate as it makes it easier to reason about what is
and isn't allowed/required.  E.g. the kernel only needs to handle freeing private
memory, there is no special handling for conversion to shared because no such path
exists as far as host pfns are concerned.  And userspace doesn't need any new "rules"
for protecting itself against a malicious guest, e.g. userspace already needs to
ensure that it has a valid mapping prior to accessing guest memory (or be able to
handle any resulting signals).  A malicious guest can DoS itself by instructing
userspace to communicate over memory that is currently mapped private, but there
are no new novel attack vectors from the host's perspective as coercing the host
into accessing an invalid mapping after shared=>private conversion is just a variant
of a use-after-free.

One potential conversions that's TBD (at least, I think it is, I haven't read through
this most recent version) is how to support populating guest private memory with
non-zero data, e.g. to allow in-place conversion of the initial guest firmware instead
of having to an extra memcpy().

[1] KVM will also exit to userspace with the same info on "implicit" conversions,
    i.e. if the guest accesses the "wrong" GPA.  Neither SEV-SNP nor TDX mandate
    explicit conversions in their guest<->host ABIs, so KVM has to support implicit
    conversions :-/

[2] Ideally (IMO), KVM would require userspace to completely remove the private memslot,
    but that's too slow due to use of SRCU in both KVM and userspace (QEMU at least uses
    SRCU for memslot changes).
