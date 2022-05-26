Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3242D5351A8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345746AbiEZPtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 11:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232235AbiEZPtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:49:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CBFDE310
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:49:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso2065918pjg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8+kFGpa6WG/8P4KGK7Q7CsR6BA6PXcaVv3f+wbatqA=;
        b=qcRJYrtLPdS5HIFpDeNWvxSb+jua7RcbrYDqXFW1R79pDktiYOl/8Sn3mc7NX/N71i
         y6EoXXYWj8ErSOJ3O2YPBEK6y1930WHh7eLCELUadJCTkCI92eXx3L0omP0zdnyA6MLV
         w6GwDV2KATg3CVCAHDhTr3WufBd74cMY732RdvsdmxQOwGFy3sLGVU+ywbxEbRrRW0wj
         DoNaMefw3RqOzpto+upI5DkaarSz/nntiVttV2MQJph9QExWlN43ysHLLJORQuqCgfzh
         HtGjyTFYU/hv11rtQq8nC7YmpP06aHUdKIfx9a8yBbMmiwdWRdlaGWeMQeFgu7EbSC+u
         QN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8+kFGpa6WG/8P4KGK7Q7CsR6BA6PXcaVv3f+wbatqA=;
        b=05j4Ld08nZAFVc0OawroCRu1wSnoQM8dU+01VKJxPj9BkpjvV195m9g0rzuIJiiBzY
         v5YSxIgYKAYC7E8h7qG6optf5U642gKsMJS33vAQ5ADsuj7D4d2AHNqWe2RR32sa54ys
         bWcYjRF7H8KBj7UbYv5i1pZ8WeJPK5wlS04sYQzYPXJGZJ94TQb5nBSe9NGoDuGoTHOW
         vaTBKFC/DUTUCPIJ3znFp+76xRWIul5YxSCYqs0wZnNc62T5vmam9PwvMZGSaPnmwKm9
         Bvd+zf14qDzCR2PIZq7Bm7aw2yQzFepxjCd/i/tnptXA5T1UuzeAS7SkdEfVXK8Yj8UL
         74CA==
X-Gm-Message-State: AOAM532hfltyZto8zZZTSGL4jK0KQXaITzkoidYah1zAyiSAk7xEKdSc
        +ttrTmmfxFAxrbLKbj9JmtQrrg==
X-Google-Smtp-Source: ABdhPJxZfiTtbqLSvmdM+DF9AK6mwBD+lnzB8KeHH0kizks2Nf7IrFQHVj6Fk67fQD7HkOoiXGNIEg==
X-Received: by 2002:a17:90b:4c4a:b0:1df:9cbf:879f with SMTP id np10-20020a17090b4c4a00b001df9cbf879fmr3248622pjb.84.1653580180846;
        Thu, 26 May 2022 08:49:40 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x1-20020aa79401000000b0050dc7628179sm1693749pfo.83.2022.05.26.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 08:49:40 -0700 (PDT)
Date:   Thu, 26 May 2022 15:49:36 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Dinse <nanook@eskimo.com>,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] KVM: x86: Harden _regs accesses to guard against
 buggy input
Message-ID: <Yo+hkH9Uy0eSPErf@google.com>
References: <20220525222604.2810054-1-seanjc@google.com>
 <20220525222604.2810054-3-seanjc@google.com>
 <87r14gqte2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r14gqte2.fsf@redhat.com>
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

On Thu, May 26, 2022, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > ---
> >  arch/x86/kvm/emulate.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> > index 7226a127ccb4..c58366ae4da2 100644
> > --- a/arch/x86/kvm/emulate.c
> > +++ b/arch/x86/kvm/emulate.c
> > @@ -247,6 +247,9 @@ enum x86_transfer_type {
> >  
> >  static ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
> >  {
> > +	if (WARN_ON_ONCE(nr >= 16))
> > +		nr &= 16 - 1;
> 
> As the result of this is unlikely to match the expectation (and I'm
> unsure what's the expectation here in the first place :-), why not use 
> KVM_BUG_ON() here instead?

ctxt->vcpu is a 'void *' due to the (IMO futile) separation of the emulator from
regular KVM.  I.e. this doesn't have access to the 'kvm'.
