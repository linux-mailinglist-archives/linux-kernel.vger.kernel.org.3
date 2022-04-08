Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EC44F9F37
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 23:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiDHVeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 17:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiDHVem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:34:42 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510AC6155
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:32:38 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r66so8838167pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tak/peBIKT6UVGXS7hYNJ30uDtO8wQxTMCgn2NCJfwo=;
        b=nVefE23XWYCerZu/aug04cs7bFFfV3oUKcSChEd75hYrCONQxtq8UoTwnERPLksn6e
         tOGK/HwxvyCigXuFmnYSRi8Pnd3v/uFJaznvRQXEoasHqd6OJJR3xTc9nfZysFECq7ae
         j8P2mkc/U2iawvKQe0r6djKkzeLNy8j244w3ScpNrJ1kgXj00UvelE7aziDZJjeWNYJV
         WJntqAWU8o3P4J3I3Wvp4wCQPyNQmfb/4bbLaan4ET3H2VW3Q6CeslCnLeTjqMqpGDhy
         NkkQYaeGoc6MPW6ZFgOdbZ3w+y2gF/zoaZ0lgLRByuC3CmWff8zd4P4qaPq7y6CXISyi
         dw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tak/peBIKT6UVGXS7hYNJ30uDtO8wQxTMCgn2NCJfwo=;
        b=SgGrRcN32iU8XC0aEkTSVeF+WAyKCRIn2Ol1ab58jbJRjvMTH/ZwbJvJNKnfOFpAjW
         QgZ7WVguCFVEgMMGGuCNwkAg7IVKxND1GZszNGarFhk5Eg2N8wksypNy/ZLAilqL5pQs
         ZkP5U7vWQBMuSgIfrVpEXhNskCTBKRj1CCKgMvNJcoxkXhpI3h1z/xUjWBy4fMryCN57
         +tN3qWNQeHgCYJ5+Q1eFlsYJ4vFZ9eorsQPEKiXOR6hMEtDJifVjW7qqdIatj1H/PDnn
         cHG5XDaNQju0oNf2lO+GPI6eaybXWYQzLlVUrZK/7N1JkXqIDrvkaTfTafTfdMpdbobf
         KcoQ==
X-Gm-Message-State: AOAM533w4TuJfZmv+bDV06ejjQzSHmYmsQ6x3qImnZa53BRUNm8iKT39
        X6SlDtOsNF6Tptpb9ZIuAJL2PQ==
X-Google-Smtp-Source: ABdhPJyIcVSF8NCUAmrbPJmc02JxzH4iJpSrNMM/p5XL26C87MCZRDAit08INOcVmUFfDxb6ssXRnA==
X-Received: by 2002:a63:788:0:b0:39c:c451:be53 with SMTP id 130-20020a630788000000b0039cc451be53mr9002487pgh.71.1649453557666;
        Fri, 08 Apr 2022 14:32:37 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6da3a1a3bsm30436673pfk.8.2022.04.08.14.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:32:36 -0700 (PDT)
Date:   Fri, 8 Apr 2022 21:32:33 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     SU Hang <darcy.sh@antgroup.com>, kvm@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Kr???m?????? <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: x86/mmu: Derive EPT violation RWX bits from
 EPTE RWX bits
Message-ID: <YlCp8RrWeHPt3rJo@google.com>
References: <20220329030108.97341-1-darcy.sh@antgroup.com>
 <20220329030108.97341-3-darcy.sh@antgroup.com>
 <20220408211140.GE857847@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408211140.GE857847@ls.amr.corp.intel.com>
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

On Fri, Apr 08, 2022, Isaku Yamahata wrote:
> On Tue, Mar 29, 2022 at 11:01:07AM +0800,
> SU Hang <darcy.sh@antgroup.com> wrote:
> 
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Derive the mask of RWX bits reported on EPT violations from the mask of
> > RWX bits that are shoved into EPT entries; the layout is the same, the
> > EPT violation bits are simply shifted by three.  Use the new shift and a
> > slight copy-paste of the mask derivation instead of completely open
> > coding the same to convert between the EPT entry bits and the exit
> > qualification when synthesizing a nested EPT Violation.
> > 
> > No functional change intended.
> > 
> > Cc: SU Hang <darcy.sh@antgroup.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  arch/x86/include/asm/vmx.h     | 7 +------
> >  arch/x86/kvm/mmu/paging_tmpl.h | 8 +++++++-
> >  arch/x86/kvm/vmx/vmx.c         | 4 +---
> >  3 files changed, 9 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
> > index 3586d4aeaac7..46bc7072f6a2 100644
> > --- a/arch/x86/include/asm/vmx.h
> > +++ b/arch/x86/include/asm/vmx.h
> > @@ -543,17 +543,12 @@ enum vm_entry_failure_code {
> >  #define EPT_VIOLATION_ACC_READ_BIT	0
> >  #define EPT_VIOLATION_ACC_WRITE_BIT	1
> >  #define EPT_VIOLATION_ACC_INSTR_BIT	2
> > -#define EPT_VIOLATION_READABLE_BIT	3
> > -#define EPT_VIOLATION_WRITABLE_BIT	4
> > -#define EPT_VIOLATION_EXECUTABLE_BIT	5
> >  #define EPT_VIOLATION_GVA_IS_VALID_BIT	7
> >  #define EPT_VIOLATION_GVA_TRANSLATED_BIT 8
> >  #define EPT_VIOLATION_ACC_READ		(1 << EPT_VIOLATION_ACC_READ_BIT)
> >  #define EPT_VIOLATION_ACC_WRITE		(1 << EPT_VIOLATION_ACC_WRITE_BIT)
> >  #define EPT_VIOLATION_ACC_INSTR		(1 << EPT_VIOLATION_ACC_INSTR_BIT)
> > -#define EPT_VIOLATION_READABLE		(1 << EPT_VIOLATION_READABLE_BIT)
> > -#define EPT_VIOLATION_WRITABLE		(1 << EPT_VIOLATION_WRITABLE_BIT)
> > -#define EPT_VIOLATION_EXECUTABLE	(1 << EPT_VIOLATION_EXECUTABLE_BIT)
> > +#define EPT_VIOLATION_RWX_MASK		(VMX_EPT_RWX_MASK << EPT_VIOLATION_RWX_SHIFT)
> 
> 
> "#define EPT_VIOLATION_RWX_SHIFT 3" is missing.
> It fails to compile.
> 
>   CC [M]  arch/x86/kvm/vmx/vmx.o
> In file included from linux/arch/x86/include/asm/virtext.h:18,
>                  from /linux/arch/x86/kvm/vmx/vmx.c:49:
> /linux/arch/x86/kvm/vmx/vmx.c: In function 'handle_ept_violation':
> /linux/arch/x86/include/asm/vmx.h:551:54: error: 'EPT_VIOLATION_RWX_SHIFT' undeclared (first use in this function); did you mean 'EPT_VIOLATION_RWX_MASK'?
>   551 | #define EPT_VIOLATION_RWX_MASK  (VMX_EPT_RWX_MASK << EPT_VIOLATION_RWX_SHIFT)
>       |                                                      ^~~~~~~~~~~~~~~~~~~~~~~

Yeah, not sure how that one line got dropped.

https://lore.kernel.org/all/20220408202815.386932-1-seanjc@google.com
