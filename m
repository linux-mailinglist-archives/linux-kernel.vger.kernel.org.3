Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FCE454E81C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbiFPQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiFPQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:51:53 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D46C54
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:51:52 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o7-20020a17090a0a0700b001ebad897457so886755pjo.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 09:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B696fHsY6DiUnHx/VOaVTPBR+QmPOKffcSStJeSA3Lo=;
        b=O3vvbKVHD3UXEjcysS5B/dMNu049qyCuXD8YDzlpa8Jm97N6DvJNR85vHDtaHeuaEX
         kEkLfGmKWu7Fn4HMPhsE6N+9Ez2ACAmvOlCM2O8dLReF1j3uSt50tniIyF3Z0/0wh9I0
         8NQZ5pzaLDimy0nKzoBbnc9GX8275jOE7gUmmLpG01SLhIKT5r0KX0V1PwNegeXL38ic
         agKOw1AxJLzm0CvHHFWiLUM1wy5Xyt7ziBNzhZoYMFlfNckncfjBy4wZa5FNeaiAAsFU
         37oy51VQcilau93I19AVFvwEUCB/0usmNFAW9CaDsOTb63C0yHT2IWe1rhbbzF3ZPt+6
         8r+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B696fHsY6DiUnHx/VOaVTPBR+QmPOKffcSStJeSA3Lo=;
        b=EKEC/izNxAnSO/fHqvI9eCGLgqhxgbkKfcAsqnlH/3si95RaMkK17HnTJRHZ5KjYzf
         LTGAUD6nX1jocjislXuRVmR7gYPfqkUhVhgvMwVdIXeyN3GowPeHVW5KE2nBsjgKEwuT
         uGKqm75fzVrs9wH0Rl1wphN7xewdTnVA1sQ4SupywHUtm+5YGYD2ZcVvcjEFPUbLMS95
         hzjDCDKePQPXuLP5B4bvH3KilvFhToi6HIbXKk7RiNjqzkefJ5KXh39lMQY5xHos00ot
         yu0r5r2LxpfXYeQpVhKPmcHf328G8wMTsm0ePXeI2prTjwqti7xR07ceZg8+/0Vjand8
         An/A==
X-Gm-Message-State: AJIora/WFLYt404RY4YEd8HU7ymfrhC0dks84tVHQJt1YhCnKkTnfomp
        rbyR1X6QCNDvtzNIaIDEvzH8oA==
X-Google-Smtp-Source: AGRyM1sCtnO0FS91EtADcMOsdlxRCJzfl46mnSOXP30sI0/Lr2p8cCMIa3JwEy5xnRmNkpFjtXN4Kw==
X-Received: by 2002:a17:902:8503:b0:168:8fbf:61f7 with SMTP id bj3-20020a170902850300b001688fbf61f7mr5355202plb.87.1655398312271;
        Thu, 16 Jun 2022 09:51:52 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a458a00b001e292e30129sm1784914pjg.22.2022.06.16.09.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 09:51:51 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:51:48 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] KVM: Do not zero initialize 'pfn' in hva_to_pfn()
Message-ID: <YqtfpKof5IEBdKW4@google.com>
References: <20220429010416.2788472-1-seanjc@google.com>
 <20220429010416.2788472-2-seanjc@google.com>
 <3dccee6c-8682-66c8-6a22-e58630825443@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dccee6c-8682-66c8-6a22-e58630825443@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022, Paolo Bonzini wrote:
> On 4/29/22 03:04, Sean Christopherson wrote:
> > Drop the unnecessary initialization of the local 'pfn' variable in
> > hva_to_pfn().  First and foremost, '0' is not an invalid pfn, it's a
> > perfectly valid pfn on most architectures.  I.e. if hva_to_pfn() were to
> > return an "uninitializd" pfn, it would actually be interpeted as a legal
> > pfn by most callers.
> > 
> > Second, hva_to_pfn() can't return an uninitialized pfn as hva_to_pfn()
> > explicitly sets pfn to an error value (or returns an error value directly)
> > if a helper returns failure, and all helpers set the pfn on success.
> > 
> > Note, the zeroing of 'pfn' was introduced by commit 2fc843117d64 ("KVM:
> > reorganize hva_to_pfn"), and was unnecessary and misguided paranoia even
> > then.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   virt/kvm/kvm_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 0848430f36c6..04ed4334473c 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -2567,7 +2567,7 @@ kvm_pfn_t hva_to_pfn(unsigned long addr, bool atomic, bool *async,
> >   		     bool write_fault, bool *writable)
> >   {
> >   	struct vm_area_struct *vma;
> > -	kvm_pfn_t pfn = 0;
> > +	kvm_pfn_t pfn;
> >   	int npages, r;
> >   	/* we can do it either atomically or asynchronously, not both */
> 
> I wonder if it was needed to avoid uninitialized variable warnings on
> "return pfn;"...

That was my guess too, but IIRC I tried the old code with older compilers (gcc-7)
and couldn't trigger any warning.  So AFAICT, it was pure paranoia.
