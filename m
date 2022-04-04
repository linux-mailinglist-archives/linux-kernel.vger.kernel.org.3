Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C74F1E6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380601AbiDDVsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380339AbiDDTfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:35:48 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9A763FF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 12:33:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c23so9031894plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 12:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kB7kulErLH1kl+/AkfN+Aryh9y9jz6Qw47u7OIjWlmM=;
        b=T8vdp5Vd2LrsNPs6YvCZuqgogEONB0T2IO+VEUWJ5yMRSwDYr2kk/GwmMrzzCucSes
         q82jwU9p39/ooLngHkw4d+W43XpFKkGy96Hcx7DwKvdeowr0P5edl3Kgaep0e8G7CWYb
         CKOvtOPXCZrbiLi/l5lwqLW3NZLzfl2HLXZZfa1ptnEWSs/Bv0w9PqXVw5xCh0GOoZce
         ZWHzLFMb2mak0znwGeqe+emmfKTPk7lf7qXOTaTUZRRqfz7b13htM5P0HRUWfu1j4sC/
         8QCGQSmdY5ivg+WrU5Q9LuCPBcLlcZC5hMOkVd4osPzd3V06zpXl6JGW6mIJanhMmdnT
         jD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kB7kulErLH1kl+/AkfN+Aryh9y9jz6Qw47u7OIjWlmM=;
        b=YRjykHHfFDKVxr4e9yNve6wVluBTUgHVc7B831NU00Uj9btBP6NHDFUaHICOAg9dZm
         jRI1gvanSLn4HphCdxgXfmnzksEC0OBFy+UP143sYsTEtyIUYesJ3Sp0cyMjv8NmpVpE
         5lLOKMLRkFfz7C77+hm0KK+zo3SN6Jye8oQGiSTAoJtoHlKKEiUyCVhZxLkcGX62Fyix
         MoZA9gcEezFOD6a3+5LJftn6N6L2VANZt9/Rs2XKrpqqhPKKg/5O+8zPzjbMD9/L49HR
         QH+VeSCAOi9imFAfFGB8WGyUmUxUEIsOqe/RwhC/8DDfW/ol7/lUgsz+bKQUOdPnzLiU
         vhWA==
X-Gm-Message-State: AOAM530QtUv2qpUrdTSHujdXienMg+Mtt8SM8WRNrf1nLy+ps2ViecM9
        nrxuAbPxeNkIOqo4tgiZtFJGFQ==
X-Google-Smtp-Source: ABdhPJxC/X5ZTY4Tf/eOli9bCS5k8iEBk8BofOU/FLMR8VrlKPxKF25FGRMVYBJMtdAi5f5RjwQLSQ==
X-Received: by 2002:a17:902:b613:b0:156:7d82:c09b with SMTP id b19-20020a170902b61300b001567d82c09bmr1229152pls.80.1649100829838;
        Mon, 04 Apr 2022 12:33:49 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 77-20020a621450000000b004fa923bb57asm12500493pfu.201.2022.04.04.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:33:49 -0700 (PDT)
Date:   Mon, 4 Apr 2022 19:33:44 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] KVM: SVM: Re-inject INT3/INTO instead of retrying
 the instruction
Message-ID: <YktIGHM86jHkzGdF@google.com>
References: <20220402010903.727604-1-seanjc@google.com>
 <20220402010903.727604-6-seanjc@google.com>
 <a47217da0b6db4f1b6b6c69a9dc38350b13ac17c.camel@redhat.com>
 <YkshgrUaF4+MrrXf@google.com>
 <a3cf781b-0b1a-0bba-6b37-12666c7fc154@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3cf781b-0b1a-0bba-6b37-12666c7fc154@maciej.szmigiero.name>
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

On Mon, Apr 04, 2022, Maciej S. Szmigiero wrote:
> > > > index 47e7427d0395..a770a1c7ddd2 100644
> > > > --- a/arch/x86/kvm/svm/svm.h
> > > > +++ b/arch/x86/kvm/svm/svm.h
> > > > @@ -230,8 +230,8 @@ struct vcpu_svm {
> > > >   	bool nmi_singlestep;
> > > >   	u64 nmi_singlestep_guest_rflags;
> > > > -	unsigned int3_injected;
> > > > -	unsigned long int3_rip;
> > > > +	unsigned soft_int_injected;
> > > > +	unsigned long soft_int_linear_rip;
> > > >   	/* optional nested SVM features that are enabled for this guest  */
> > > >   	bool nrips_enabled                : 1;
> > > 
> > > 
> > > I mostly agree with this patch, but think that it doesn't address the
> > > original issue that Maciej wanted to address:
> > > 
> > > Suppose that there is *no* instruction in L2 code which caused the software
> > > exception, but rather L1 set arbitrary next_rip, and set EVENTINJ to software
> > > exception with some vector, and that injection got interrupted.
> > > 
> > > I don't think that this code will support this.
> > 
> > Argh, you're right.  Maciej's selftest injects without an instruction, but it doesn't
> > configure the scenario where that injection fails due to an exception+VM-Exit that
> > isn't intercepted by L1 and is handled by L0.  The event_inj test gets the coverage
> > for the latter, but always has a backing instruction.
> 
> Still reviewing the whole patch set, but want to clear this point quickly:
> The selftest does have an implicit intervening NPF (handled by L0) while
> injecting the first L1 -> L2 event.

I'll do some debug to figure out why the test passes for me.  I'm guessing I either
got lucky, e.g. IDT was faulted in already, or I screwed up and the test doesn't
actually pass.
