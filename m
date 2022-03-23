Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622E54E5680
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 17:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiCWQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbiCWQcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 12:32:52 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2186CA6E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:31:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id x4so2314206iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlyA01ihneYGdhEvQM86PHNf9KfO67kvj0GzTGLAXNU=;
        b=nz1opHZjdVPlTkjXUEgUlHpKpA9whYmdgayXgRb4JITVwirZcQAIssljBegsKOx70N
         bYc9NvDOz2/3RJESS9l2j2Gyd4J78aZ96vFXT0WfK3/erqhmsb9EQoy0udyTH1OnFx1i
         DUYCzNb1DIiJu6R1b9BLPdoxxJpoNYnyAyBi2zfut0GTNF5GNSzWbjclfqg79iZPocT3
         wM+nx6rBF5DVNmucW/a1zwbTRPN1NxoQztGKXHdbF+nOBLk5QmAZic3b8Mmvd0vCo26n
         eWDg+69yZAcZg5S1519bZVprQtjQfKPU5b7Suehnm910QeS6AdPCCPTHeM75zi4DeHhc
         4UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlyA01ihneYGdhEvQM86PHNf9KfO67kvj0GzTGLAXNU=;
        b=K2WqM+CcWQI448YirjzbCGxKrBt7tBmHUorzb0JyZKKn31lC2iFo5W7Rer5YaJhyte
         O2aB9Syg8+gOAZpqaNlnVs2AS/ckWr0N/TRxHtlxy2e2iMC2UIxPojyjT+IEJLARNnwG
         vUWjw5Noe7i5u9D/EjZiZtEVRLQeigXiv/kwi1sbiWbWg06ePv36TojxdP1eKwawARUj
         MXI7xvxoxb0ZmCbUNDCC/9liSe3/tX2hLiBNFyY4xJzHzPYmRzmTMFHUcIrBQWX/JYDD
         R1xsVVpYJf8EnK3AIk964UijM2OM2PmxQw2+wbc6NydwOxYlXpez5FiQkFBaH/5neWV+
         E4eA==
X-Gm-Message-State: AOAM533VzEwB87d3DNf3vAGRp3uG51qVNgh6AGLZ/OtcYDj1ndGbAAAk
        JMMTAvbQGLhovphQh4qjSt2cn+u/Fc8R4Q==
X-Google-Smtp-Source: ABdhPJzKmpUihyVIHd9cxsIGck0LnT5sXqaA34p4IFpjbGtlOfF8Eg8k9JB/wHFNggITLsEovYzBow==
X-Received: by 2002:a05:6638:4781:b0:31a:6f26:e8a7 with SMTP id cq1-20020a056638478100b0031a6f26e8a7mr364247jab.33.1648053082060;
        Wed, 23 Mar 2022 09:31:22 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm178642iog.24.2022.03.23.09.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 09:31:21 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:31:18 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 03/22] KVM: arm64: Support SDEI_VERSION hypercall
Message-ID: <YjtLVqBbL0jyFFZy@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-4-gshan@redhat.com>
 <YjoPxLAMIPobBzS0@google.com>
 <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8e151e5-080b-dc87-b7e0-9031a7928853@redhat.com>
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

On Wed, Mar 23, 2022 at 08:46:40PM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 3/23/22 2:04 AM, Oliver Upton wrote:
> > On Tue, Mar 22, 2022 at 04:06:51PM +0800, Gavin Shan wrote:
> > > This supports SDEI_VERSION hypercall by returning v1.1, which is
> > > the specification version we're following. The vendor is set to
> > > 'KVM'.
> > > 
> > > Signed-off-by: Gavin Shan <gshan@redhat.com>
> > > ---
> > >   arch/arm64/kvm/sdei.c | 10 ++++++++++
> > >   1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> > > index 8a9b477b8977..5a3a64cd6e84 100644
> > > --- a/arch/arm64/kvm/sdei.c
> > > +++ b/arch/arm64/kvm/sdei.c
> > > @@ -118,6 +118,14 @@ static bool remove_all_vcpu_events(struct kvm_vcpu *vcpu,
> > >   	return pending;
> > >   }
> > > +static unsigned long hypercall_version(struct kvm_vcpu *vcpu)
> > > +{
> > > +	/* v1.1 and the vendor is KVM */
> > > +	return (1UL << SDEI_VERSION_MAJOR_SHIFT) |
> > > +	       (1UL << SDEI_VERSION_MINOR_SHIFT) |
> > > +	       0x4b564d;
> > 
> > It looks like the SDEI specification states that the vendor-defined
> > version number is 32 bits. Could we just use one of the
> > ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_{0,3} values instead?
> > 
> > ASCII 'KVM' is neat, but in reality guest software will just throw it in
> > a macro regardless. Might as well use one of the values we've already
> > trained it to use :-)
> > 
> > Also, it would appear that guest discovery of SDEI relies upon KVM
> > reporting a valid SDEI version. IMO, this patch should come at the very
> > end when KVM actually implements SDEI.
> > 
> 
> Yeah, I was sticky to the pattern of "KVM". However, I think it's good
> to reuse the existing one. Lets use ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2
> if you agree. Its first two characters are "VM" at least.

Sounds fine to me. The only other nit I'd say is we should define a
macro for it too, something like:

  #define KVM_SDEI_VENDOR	ARM_SMCCC_VENDOR_HYP_UID_KVM_REG_2

--
Thanks,
Oliver
