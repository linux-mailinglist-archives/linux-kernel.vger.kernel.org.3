Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650C34680E8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383482AbhLCXwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354321AbhLCXwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:52:11 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C94C061353
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 15:48:46 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 133so4527732pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 15:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZAmDHsC6a6B1+lUDqpdszqQCD3+V34qAynkOGNqzOs=;
        b=ZROJNDJMOq5eIJoHp0p2tGr6bzowIDKO97CIqwhIh2xybI8owSYD51r3cZQjUy7SMs
         /P40psd2IV5qDAXCOCYwHiSHhml5L0HIMnhaLZObQG+0Hv1TAktoB1btbfH4raGuMAMe
         ell0IVFfKq86nUJQpY0EZXb2dY9wbbgAGzMXedTAW+uehWC6uWCvbOHeg2kpnbzPykUN
         lX9e0y4K1FLLZBvfJWvyw8HhVNgXjG49W4LKgWJQwTZg4t1woSQEZRu5HpUtfTQJq5h8
         rwdbRyd+awbHRbi9DEg9SXwvQGC6Ubgqnzoyn+LSR2ttCXmaRK2RKHh6RimVCyhhdZs8
         i/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jZAmDHsC6a6B1+lUDqpdszqQCD3+V34qAynkOGNqzOs=;
        b=mmkuW2yLU4xJlAh2NYqFe9hvYrOD4X1mzvW1a7BCOn+mc9k/W8XGNgKQMfiVDeYVMx
         /idwTBFpJgsNPqtiRDHuKu3ltka+bNJuWSsJpcdT9Xo2QlSV3jIlaRHz2yu6r8uDsik4
         2sh5t0MrECB06l8SuLX6bwVcEpzCjYy1NVwaT2Oiwv0F7utvorQ09Xp5ysAu3bLlRYtt
         fm2NW/1+w8aHkSrSqXijLKcuiW/kMX6bwCH/3/ij2fHbjO1AafnqrOXxzRl7mI55RN/J
         h8GLW1isAMIi77YKYnRrTNEY2KiQlxzG6M+yRo1ybUtsph+7viyRtaMVZ6BUBXP8oXHs
         Vxeg==
X-Gm-Message-State: AOAM532SJRRZnH8QPVKllZw2hQpXizDWi0qFshonQ3vXTxY5L9W4aYz1
        dD+NfGWCoquTrbpAwLMDRJY3UQ==
X-Google-Smtp-Source: ABdhPJxiSrEcmRBZRtgKjhJMnu5tJLdEcIhiCx8GQtfxumShdLMvRSAXNQRAKE0vEMsLMNwHj3EJRQ==
X-Received: by 2002:a05:6a00:2353:b0:4ab:1694:6f50 with SMTP id j19-20020a056a00235300b004ab16946f50mr6815870pfj.7.1638575326038;
        Fri, 03 Dec 2021 15:48:46 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j6sm4164413pfu.205.2021.12.03.15.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:48:45 -0800 (PST)
Date:   Fri, 3 Dec 2021 23:48:42 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 7/8] KVM: x86: Reject fixeds-size Hyper-V hypercalls
 with non-zero "var_cnt"
Message-ID: <Yaqs2uIiAoyfbdbX@google.com>
References: <20211030000800.3065132-1-seanjc@google.com>
 <20211030000800.3065132-8-seanjc@google.com>
 <87y268jhm1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y268jhm1.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > @@ -2331,6 +2331,11 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
> >  			ret = HV_STATUS_OPERATION_DENIED;
> >  			break;
> >  		}
> > +		if (unlikely(hc.var_cnt)) {
> > +			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
> > +			break;
> > +		}
> > +
> 
> Probably true for HVCALL_RESET_DEBUG_SESSION but I'm not sure about
> HVCALL_POST_DEBUG_DATA/HVCALL_RETRIEVE_DEBUG_DATA (note 'fallthrough'
> above) -- these are not described well in TLFS.

I'll drop the check for all the DEBUG hypercalls and add a note in the changelog
to call out that they're probably not supposed to use var_cnt, but that the TLFS
documentation isn't clear one way or the other.
