Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7869B49D122
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 18:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiAZRsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 12:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiAZRsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:48:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C824C061747
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:48:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i1so227533pla.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cNfxPUvWvaI1vHO/jmsIjiSEzNXExUCiFtH31cxBIdo=;
        b=LoqmHXH523JnCj+p+8Rc/S9F5Y06QO7Q0xw2slJ2Ei/D6SbNPbbHBQAMEnxOcutBHB
         Ju0IJZE4f2IWVpl2YW5W0bRsCRXRv5ANtlQf28JmbFRXOV5kbZY/4yUwqxOWbNHqKf+l
         lDbZZnOjZ08qpJVMISJiLzXgNjxUCG+yQhQ7K+aLI3qAWKv0i70R+zlADzFYVsICutYJ
         r2iPLS0593bUYMoURAqZxpeVu+m1XvDfZECG6CC6ifVRRXXg+keDo3vfkqieMtuaGX8E
         ifbtkzcQOeoVoQhzurv50K5samEA0tvwrl1DY5HO2RrhmkfavJJr0eB2WEHRl+BMVLzy
         m4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cNfxPUvWvaI1vHO/jmsIjiSEzNXExUCiFtH31cxBIdo=;
        b=ZWdEX4pKAeNemMZ9/pjufaY4AY+kqwmkqzW7amgkG2ayRCzf16TZMcz7iVuC30hDdM
         Oi4+SCoW4e1EJHyFbZ4MV7bpM256aVFwibSW2wP6HTi9J/aig9n5Bj8Qv86TLUZRl7ez
         uI6Be7Cri+UYixQpIiesna0hnwFglIrGmYZKmQMfRefyrIy7N2LHI8lhF+L+nA8WzQ3n
         oXerCFQ7G3ammftZamYr9Rq+5LfvlTRKWTRfcGAaGBcP6jsHHcYEiow9jrB7235u6lz1
         Nd3gvMszKUUQsX88fl30aXtgd6XMsKt3VBKqNnsDLvSoom7FivDleuBrqCcV2E19qTFT
         ZSMw==
X-Gm-Message-State: AOAM533IggXzBRM+Y2Xj/0mwtwtw8IpXPcyiugVUJdidz36oF9BeAhlh
        eBZrWbCSr7qACqjnaO8b92yPHw==
X-Google-Smtp-Source: ABdhPJxwsiEqrNgJNlq8u/NfwI/GMmXVNl3SBs8rnKUQWQw1WWtgCuYRSuQeqhARV4DBKFuSYR7tNQ==
X-Received: by 2002:a17:90a:ab91:: with SMTP id n17mr915pjq.238.1643219292505;
        Wed, 26 Jan 2022 09:48:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id k12sm2822797pfc.107.2022.01.26.09.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 09:48:11 -0800 (PST)
Date:   Wed, 26 Jan 2022 17:48:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Like Xu <likexu@tencent.com>
Subject: Re: [PATCH 0/3] KVM: x86: XSS and XCR0 fixes
Message-ID: <YfGJWNVuFYZ8kl2I@google.com>
References: <20220126172226.2298529-1-seanjc@google.com>
 <3e978189-4c9a-53c3-31e7-c8ac1c51af31@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e978189-4c9a-53c3-31e7-c8ac1c51af31@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022, Paolo Bonzini wrote:
> On 1/26/22 18:22, Sean Christopherson wrote:
> > For convenience, Like's patch split up and applied on top of Xiaoyao.
> > Tagged all for @stable, probably want to (retroactively?) get Xiaoyao's
> > patch tagged too?
> > Like Xu (2):
> >    KVM: x86: Update vCPU's runtime CPUID on write to MSR_IA32_XSS
> >    KVM: x86: Sync the states size with the XCR0/IA32_XSS at, any time
> > 
> > Xiaoyao Li (1):
> >    KVM: x86: Keep MSR_IA32_XSS unchanged for INIT
> > 
> >   arch/x86/kvm/x86.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > 
> > base-commit: e2e83a73d7ce66f62c7830a85619542ef59c90e4
> 
> Queued, though I'll note that I kinda disagree with the stable@ marking of
> patch 1 (and therefore with the patch order) as it has no effect in
> practice.

Hmm, that's not a given, is it?  E.g. the guest can configure XSS early on and
then expect the configured value to live across INIT-SIPI-SIPI.  I agree it's
highly unlikely for any guest to actually do that, but I don't like assuming all
guests will behave a certain way.
