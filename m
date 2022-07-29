Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C9A5851B9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbiG2Ol3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbiG2Ol0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:41:26 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90130CF9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:41:25 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so4808549plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=l6vl6ca73afFDe1dwkZCvYaT2HbaszVLHWeIgM0p68Q=;
        b=DGnbOED8lHCv9LKFZzoznPEAMqQykB8lamD3rHMLRweCz609+UyPI8tVXZ17ZvA3B6
         9YfSbQWrwRCcUCgg0uxXYFkBZLyEPIkzBJo5xl7S0ir2fu37zg+sqUndtw9Ba8FKYJm/
         bT1xp4d/7ffTswlbmEw6zuOCGf5JVzlF11J+k6Fw0CrqMuu6aHVrqxmZu/yZBQ8VFkE1
         9k3yKvif/D7bohRnpGFp8GQ9+lVa/kbi1D+eFKHzJ8ObBJ437+RXe5a+b4lYdgOKJNP1
         h6ABub5bOJUu9ke5+xL4zkjlJoSvEBSOaCJ3f2w6fhNWgBve5NFeAaxN6Pasf/Iuxk0U
         5+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=l6vl6ca73afFDe1dwkZCvYaT2HbaszVLHWeIgM0p68Q=;
        b=uZMWFjUe0Whllx5e7Rn5dRTij974qmWuvnVFBDgrcxoQggP13HtxrdwqAhkdf58IXf
         411pQFdV88FRbmuYgMjfYhwdCUw/+AJz+Kon20C3ye5Mn49R44RrN+qXCX6A6I5mLXpW
         POyoPuOOfys+XAsDqkXBCY18F41ABwrjdYX48Su32ucixmShLjvXHUaUwMtzFaYeGJpq
         bdBWfK7njo+erX/RoLzTUh+///yg96Bk8YOa2KTi2iaYYdCS6IcAsiv+3NRT0vNyT5Uo
         bV424mbR643BUNFCwsCUzwZIybg5xPzW6aDbsqUpjNaDbkkzT7QZHHNaB9lLqXsWtytt
         /yyA==
X-Gm-Message-State: ACgBeo3a24fM13GQ/e2MH6jKUVXGrYeV+/lxB0thZIA6YV+RyHiuqVby
        iu09hnChQf3AOe/yKq4Kh6Vf8Q==
X-Google-Smtp-Source: AA6agR4X7fAFXTDw6OjZ5xRKI0Lw6Or/jMev9hgZVz//3MiEjIpKJ8O97KNwiTbXNAAu8OJZrokubQ==
X-Received: by 2002:a17:90b:1d8f:b0:1f0:270a:b556 with SMTP id pf15-20020a17090b1d8f00b001f0270ab556mr4557647pjb.192.1659105684880;
        Fri, 29 Jul 2022 07:41:24 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id l1-20020a170902ec0100b0016d338160d6sm3651019pld.155.2022.07.29.07.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 07:41:24 -0700 (PDT)
Date:   Fri, 29 Jul 2022 14:41:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Shukla, Santosh" <santosh.shukla@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/7] KVM: SVM: Report NMI not allowed when Guest busy
 handling VNMI
Message-ID: <YuPxkMW2aZxrw57n@google.com>
References: <20220709134230.2397-1-santosh.shukla@amd.com>
 <20220709134230.2397-5-santosh.shukla@amd.com>
 <Yth5hl+RlTaa5ybj@google.com>
 <20c2142a-ec88-02cf-01f2-cf7f8dfcef77@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c2142a-ec88-02cf-01f2-cf7f8dfcef77@amd.com>
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

On Fri, Jul 29, 2022, Shukla, Santosh wrote:
> Hello Sean,
> 
> On 7/21/2022 3:24 AM, Sean Christopherson wrote:
> > On Sat, Jul 09, 2022, Santosh Shukla wrote:

...

> >> @@ -3609,6 +3612,9 @@ static void svm_enable_nmi_window(struct kvm_vcpu *vcpu)
> >>  {
> >>  	struct vcpu_svm *svm = to_svm(vcpu);
> >>  
> >> +	if (is_vnmi_enabled(svm))
> >> +		return;
> > 
> > Ugh, is there really no way to trigger an exit when NMIs become unmasked?  Because
> > if there isn't, this is broken for KVM.
> > 
> 
> Yes. there is.
> 
> NMI_INTERCEPT will trigger VMEXIT when second NMI arrives while guest is busy handling first NMI.

But NMI_INTERCEPT only applies to "real" NMIs.  The scenario laid out below is where
KVM wants to inject a virtual NMI without an associated hardware/real NMI, e.g. if
multiple vCPUs send NMI IPIs to the target.

> And in that scenario, Guest will exit with V_NMI_MASK set to 1, KVM can inject pending(Second)
> NMI(V_NMI=1). Guest will resume handling the first NMI, then HW will
> clear the V_NMI_MASK and later HW will take the pending V_NMI in side the guest. 
> 
> I'll handle above case in v3.
> 
> Thanks,
> Santosh
> 
> > On bare metal, if two NMIs arrive "simultaneously", so long as NMIs aren't blocked,
> > the first NMI will be delivered and the second will be pended, i.e. software will
> > see both NMIs.  And if that doesn't hold true, the window for a true collision is
> > really, really tiny.
> > 
> > But in KVM, because a vCPU may not be run a long duration, that window becomes
> > very large.  To not drop NMIs and more faithfully emulate hardware, KVM allows two
> > NMIs to be _pending_.  And when that happens, KVM needs to trigger an exit when
> > NMIs become unmasked _after_ the first NMI is injected.
> > 
> >> +
> >>  	if ((vcpu->arch.hflags & (HF_NMI_MASK | HF_IRET_MASK)) == HF_NMI_MASK)
> >>  		return; /* IRET will cause a vm exit */
> >>  
> >> -- 
> >> 2.25.1
> >>
