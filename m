Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE82598835
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 18:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbiHRQAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 12:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344398AbiHRQAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:00:46 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E99DB603D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:00:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id p18so1864399plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=Md0gqsgG3jFAl1wR6CS4wNUGR6tMe9JnKpQiqkFk8wI=;
        b=lD2VBI0yYKDGq5ygpl4NryxCxxm0W49DPg9YW7q+/9UhYYDkE06nmkOjwV15pfLCoH
         u1RtvXQg8Wfbrc3KZ2Ysupxr6xdeE9zFA9RT5txFycz7BXf3I5tPZfsPUKc5FFi5PYjS
         TYLgzJ+kZKBEo2bszM/IkideETbAIriUmbOZaLEW5Re4WfN63UNzxvHrdXjPp1aVieXd
         ZetnFjjcxndCwRSyd1nhw4ES9yKD99VsXSaMgn9EvOsf9jSJv7aS0CwojxPEiUJ+fj53
         z581qFfz3BKM9boNjqa+0jXhSosz3xhVkc2bSYdc/j5OKkXQuKMiBk6Rx1Vwv9W2RTo2
         BXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=Md0gqsgG3jFAl1wR6CS4wNUGR6tMe9JnKpQiqkFk8wI=;
        b=uQbyqDM0mldfVSc6SMsZsjKJvk9WHE/obpAzGV2F4os3SCoHbV+eKkvrvgb80BJ5ke
         b2J49OQ20ARYGe062slfCzKBrx4TVABl0BrAszNqD5vh1UZjo2dgzUAiU831W6UgGtKT
         mt+zWz7ligFGLmkzn3c4/ONzK2pcqS+BnWaVPXBVMY3apUnGxnkVJeeAujSjbxAt/35M
         JFPfw43oxaqtlWo1shZOBeQRB0e7QnSZyc8jIDRzOWBQdOe4nuKuhb/u4Giag0heyyxe
         SEOT1OuNQxsldoRqXTttMdtNPW5lGTA2jTMDvIoPC500Ykam1JWEzrl2C24CqrV7WU6j
         m5NQ==
X-Gm-Message-State: ACgBeo0DxIq+F0rSTDnOf/k/bJrJZ6nzIsjbwCXMDXr5oJMPS80UZNyX
        3NjNeCVPuDRqpN0Hta0qCL/EbQ==
X-Google-Smtp-Source: AA6agR7Xuk8Ndhj2kNLCx6+7RRPDzKcLI6MG7Sw9abJClLxY5bkNrmhDJsPF1dRJwYUDmYrneEpnFA==
X-Received: by 2002:a17:902:e748:b0:16f:953e:2770 with SMTP id p8-20020a170902e74800b0016f953e2770mr3162438plf.156.1660838444610;
        Thu, 18 Aug 2022 09:00:44 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id y4-20020a626404000000b0052c87380aebsm1805506pfb.1.2022.08.18.09.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:00:43 -0700 (PDT)
Date:   Thu, 18 Aug 2022 16:00:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcorr@google.com,
        michael.roth@amd.com, thomas.lendacky@amd.com, joro@8bytes.org,
        mizhang@google.com, pbonzini@redhat.com, vannapurve@google.com
Subject: Re: [V3 10/11] KVM: selftests: Add ucall pool based implementation
Message-ID: <Yv5iKJbjW5VseagS@google.com>
References: <20220810152033.946942-1-pgonda@google.com>
 <20220810152033.946942-11-pgonda@google.com>
 <20220816161350.b7x5brnyz5pyi7te@kamzik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816161350.b7x5brnyz5pyi7te@kamzik>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022, Andrew Jones wrote:
> On Wed, Aug 10, 2022 at 08:20:32AM -0700, Peter Gonda wrote:
> > diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > index 132c0e98bf49..ee70531e8e51 100644
> > --- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > +++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
> > @@ -81,12 +81,16 @@ void *ucall_arch_get_ucall(struct kvm_vcpu *vcpu)
> >  
> >  	if (run->exit_reason == KVM_EXIT_MMIO &&
> >  	    run->mmio.phys_addr == (uint64_t)ucall_exit_mmio_addr) {
> > -		vm_vaddr_t gva;
> > +		uint64_t ucall_addr;
> 
> Why change this vm_vaddr_t to a uint64_t? We shouldn't, because...
> 
> >  
> >  		TEST_ASSERT(run->mmio.is_write && run->mmio.len == 8,
> >  			    "Unexpected ucall exit mmio address access");
> > -		memcpy(&gva, run->mmio.data, sizeof(gva));
> > -		return addr_gva2hva(vcpu->vm, gva);
> > +		memcpy(&ucall_addr, run->mmio.data, sizeof(ucall_addr));
> 
> ...here we assume it's a vm_vaddr_t and only...
> 
> > +
> > +		if (vcpu->vm->use_ucall_pool)
> > +			return (void *)ucall_addr;
> 
> ...here do we know otherwise. So only here should be any casting.

It technically should be a union, because if sizeof(vm_vaddr_t) < sizeof(void *)
then declaring it as a vm_addr_t will do the wrong thing.  But then it's possible
that this could read too many bytes and inducs failure.  So I guess what we really
need is a "static_assert(sizeof(vm_vaddr_t) == sizeof(void *))".

But why is "use_ucall_pool" optional?  Unless there's a use case that fundamentally
conflicts with the pool approach, let's make the pool approach the _only_ approach.
IIRC, ARM's implementation isn't thread safe, i.e. there's at least one other use
case that _needs_ the pool implementation.

By supporting both, we are signing ourselves up for extra maintenance and pain,
e.g. inevitably we'll break whichever option isn't the default and not notice for
quite some time.
