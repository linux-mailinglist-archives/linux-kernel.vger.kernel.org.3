Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A386050BF8F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237852AbiDVSIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiDVSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:02:10 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF15610FB43
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:59:15 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p62so9450572iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PvYO7bo8SW1Y4ZSBFDfeF93l7A3erH7xTOKbq6F1GXw=;
        b=DvuwE7lFq4nlwhDZJKEgwLV17hmwV7Skel1e4+I34Cth3Krw4NZ61wmOvoCCnRReZC
         l2rV8MSmu9YodSSz1sMXtrHdz0CPmSuN9x7O1iuHt/sJpKpos+oeQCGtMEiLUeIqk0AV
         C9A1w2lQ7zSCd/5X7sqmI4iqBM0gPv5UlWPrd8o4WUrmBlydJkAZcxOjjND5ma4uXPRJ
         A5YoyGMZW4lmeclSiha1SeF6c+wUXK9/3NxD072mKsH+Ncp29cXL6Oxia9ObDhHGk10I
         I5DqTIWIimUTaWzzDpXvg4wsXIT+4Ftb6KLRRggges3bmjjZyxcXjdteoE+OKHCkYw5g
         7P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PvYO7bo8SW1Y4ZSBFDfeF93l7A3erH7xTOKbq6F1GXw=;
        b=vA+DnQCxQd1uEcj4/RFrarf3XF2Om1vXsjuHaZ44emyaK/6nhMwZfd9SYxJ8u4/bdy
         gE0aYmErMegKsGiJpt58fzQMjKVqp3DljHXdURIn3QJJ8EtwIX+yfVHYA04B+LNjv51Y
         8nXZE6yeJDMg3IwMVCuagc1DXu+BD4LeW/PZHFGKSP6P2NPINIKA2X1W24ImYF+/cUb7
         51X6mEMiY3vGEf8It+g8KF51Gmccqi/AtV0SU9yx3qygVgWnDU9yGyZqDmX5lXyHZKip
         dZqa+y2rlXrm7Lw2jAxOoIYnN5NDK49nPB5VUUHdh8hXnh/9E5GqGRTk82+fqUyhEk6E
         5mzA==
X-Gm-Message-State: AOAM5322BN50DdYtbdq8sc+qrXBc/LHEIfQJpeP97CEBnN78z81KBGjL
        /ULc4eQluhPuDqQQsFeudHoYLB8bL06bpQ==
X-Google-Smtp-Source: ABdhPJz8wfhINFssvIsT0Zvy7AA5wPuZkh2tzpWPxtGot8eLDBt3NrS/v8VN+/Kyj1Mis3VNtO1hEA==
X-Received: by 2002:a6b:f405:0:b0:640:a963:2c24 with SMTP id i5-20020a6bf405000000b00640a9632c24mr2574692iog.110.1650650353924;
        Fri, 22 Apr 2022 10:59:13 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id q13-20020a056e020c2d00b002caa365b43bsm1771133ilg.76.2022.04.22.10.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 10:59:11 -0700 (PDT)
Date:   Fri, 22 Apr 2022 17:59:06 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 02/18] KVM: arm64: Route hypercalls based on their
 owner
Message-ID: <YmLs6t8iUn+BH6mo@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-3-gshan@redhat.com>
 <YmETmWvPPQvHpQwP@google.com>
 <2519e2fa-4d6a-a5f8-1057-6b1820853036@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2519e2fa-4d6a-a5f8-1057-6b1820853036@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 08:20:50PM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 4/21/22 4:19 PM, Oliver Upton wrote:
> > On Sun, Apr 03, 2022 at 11:38:55PM +0800, Gavin Shan wrote:
> > > kvm_hvc_call_handler() directly handles the incoming hypercall, or
> > > and routes it based on its (function) ID. kvm_psci_call() becomes
> > > the gate keeper to handle the hypercall that can't be handled by
> > > any one else. It makes kvm_hvc_call_handler() a bit messy.
> > > 
> > > This reorgnizes the code to route the hypercall to the corresponding
> > > handler based on its owner.
> > 
> > nit: write changelogs in the imperative:
> > 
> > Reorganize the code to ...
> > 
> 
> Thanks again for your review. It will be corrected in next respin.
> By the way, could you help to review the rest when you have free
> cycles? :)

Yup, I've been thinking on the rest of the series just to make sure the
feedback I give is sane.

> > > The hypercall may be handled directly
> > > in the handler or routed further to the corresponding functionality.
> > > The (function) ID is always verified before it's routed to the
> > > corresponding functionality. By the way, @func_id is repalced by
> > > @func, to be consistent with by smccc_get_function().
> > > 
> > > PSCI is the only exception, those hypercalls defined by 0.2 or
> > > beyond are routed to the handler for Standard Secure Service, but
> > > those defined in 0.1 are routed to the handler for Standard
> > > Hypervisor Service.
> > > 
> > > Suggested-by: Oliver Upton <oupton@google.com>
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > ---
> > >   arch/arm64/kvm/hypercalls.c | 199 +++++++++++++++++++++++-------------
> > >   1 file changed, 127 insertions(+), 72 deletions(-)
> > > 
> > > diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> > > index 8438fd79e3f0..b659387d8919 100644
> > > --- a/arch/arm64/kvm/hypercalls.c
> > > +++ b/arch/arm64/kvm/hypercalls.c
> > 
> > [...]
> > 
> > > +static int kvm_hvc_standard(struct kvm_vcpu *vcpu, u32 func)
> > > +{
> > > +	u64 val = SMCCC_RET_NOT_SUPPORTED;
> > > +
> > > +	switch (func) {
> > > +	case ARM_SMCCC_TRNG_VERSION ... ARM_SMCCC_TRNG_RND32:
> > > +	case ARM_SMCCC_TRNG_RND64:
> > > +		return kvm_trng_call(vcpu);
> > > +	case PSCI_0_2_FN_PSCI_VERSION ... PSCI_0_2_FN_SYSTEM_RESET:
> > > +	case PSCI_0_2_FN64_CPU_SUSPEND ... PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> > > +	case PSCI_1_0_FN_PSCI_FEATURES ... PSCI_1_0_FN_SET_SUSPEND_MODE:
> > > +	case PSCI_1_0_FN64_SYSTEM_SUSPEND:
> > > +	case PSCI_1_1_FN_SYSTEM_RESET2:
> > > +	case PSCI_1_1_FN64_SYSTEM_RESET2:
> > 
> > Isn't it known from the SMCCC what range of hypercall numbers PSCI and
> > TRNG fall under, respectively?
> > 
> > https://developer.arm.com/documentation/den0028/e/
> > 
> > See sections 6.3 and 6.4.
> > 
> 
> Bit#30 of the function ID is the call convention indication, which is
> either 32 or 64-bits. For TRNG's function IDs, its 32-bits and 64-bits
> variants are discrete. Besides, the spec reserves more functions IDs
> than what range we're using. It means we don't have symbols to match
> the reserved ranges. So it looks good to me for TRNG cases.
> 
> For PSCI, it can be simplified as below, according to the defination
> in include/uapi/linux/psci.h:
> 
>     case PSCI_0_2_FN_PSCI_VERSION ...
>          PSCI_1_1_FN_SYSTEM_RESET2:     /* 32-bits */
>     case PSCI_0_2_FN64_CPU_SUSPEND ...
>          PSCI_1_1_FN64_SYSTEM_RESET2:   /* 64-bits */

Right, but this still requires that we go back and update this switch
statement every time we add a new PSCI call, which is exactly what I was
hoping we could avoid. Doing this based exactly on the spec reduces the
burden for future changes, and keeps all relevant context in a single
spot.

  #define SMCCC_STD_PSCI_RANGE_START	0x0000
  #define SMCCC_STD_PSCI_RANGE_END	0x001f
  #define SMCCC_STD_TRNG_RANGE_START	0x0050
  #define SMCCC_STD_TRNG_RANGE_END	0x005f

  switch (ARM_SMCCC_FUNC_NUM(function_id)) {
          case SMCCC_STD_PSCI_RANGE_START ... SMCCC_STD_PSCI_RANGE_END:
	          return kvm_psci_call(vcpu);
          case SMCCC_STD_TRNG_RANGE_START ... SMCCC_STD_TRNG_RANGE_END:
	  	  return kvm_trng_call(vcpu);

	 ...
  }

[...]

> > > +	case KVM_PSCI_FN_CPU_SUSPEND ... KVM_PSCI_FN_MIGRATE:
> > > +		return kvm_psci_call(vcpu);
> > 
> > You might want to handle these from the main call handler with a giant
> > disclaimer that these values predate SMCCC and therefore collide with
> > the standard hypervisor service range.
> > 
> > [...]
> > 
> 
> I probably just keep it as it is to follow the rule: to route
> based on the owner strictly. Besides, there are 3 levels to
> handle SMCCCs after this patch is applied, which corresponds
> to 3 handlers as main/owner/function. It sounds more natural
> for reader to follow the implementation in this way.

I think this makes it much more confusing for the reader, as you'd be
hard pressed to find these function IDs in the SMCCC spec. Since their
values are outside of the specification, it is confusing to only address
them after these switch statements have decided that they belong to a
particular service owner as they do not.

--
Thanks,
Oliver
