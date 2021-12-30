Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E243481F17
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 19:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbhL3SNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 13:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbhL3SNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 13:13:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98642C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:13:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so23855784pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LVIepjUeywWQTwzqZkmOLGHlr0Rs5KUDVzAJo/3VPTw=;
        b=IhQHIH3fbtS7YKyPalKqhcrTm7Jcj2EaHZk3PYD1UcoA0hsNvhc/QmMTTGNXXjwpwk
         eISCewL26nXu5t7Y9G7mUOG/cMWioCd3KRI6dJNBAceykAy3So2n5HRYCa58nLT3O0vx
         ArAQv9qbYDifZI+3BlnT3Zsbs59LJgs6hc/sIfBB+Gqz0L7jBlVE6EHXYZy/qEvySMsd
         Wh7z2BhT4JbD4sJ7gseI03bxCIg5ObxNeHnjXsxiCqICL4ynA90b+gOo/FJqCqAPcKxw
         E8KlKg3WxmD6bMBZJMUBx+oOiPOwTj2EHDN7UwssQVXIQNi1nXhIj/LinGATAvXi+QX0
         782g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LVIepjUeywWQTwzqZkmOLGHlr0Rs5KUDVzAJo/3VPTw=;
        b=SQ1FWcjlYT4bWsiql+pGJzqC2Ep653gI00/MSVjZt5RSIOzctqbFMnCcpEanUqdauv
         y0IG133O1m+8IE66fwtaqfZOLMf3kSz5M0E03zWDMId6xWpfdcfkH68KczyoZwiUF0/v
         1EltBeLtK5r8yXIq+IWTqLHeyPGj/fqkylO9Ks79bl0j8W6F/I+wNNktyKMOQSRBN7Vs
         6KCEzOHzdVDbUrn/fDuducQI+L19ImNufV2lrs7QIdDOf5qRRuWSQt6IP3CdeVx+mc1t
         c8REBEaoOJkyz2XAeU6lBp5PesZiT7/towSr6WqtT8tvnYVu60too6tusgAPmwTifDVu
         WCFg==
X-Gm-Message-State: AOAM5302BsNOVxY/IUr5ngU4wgrHxPC1lexk8rCtL58aE//x+PchUa3Z
        j233PJvQOi4Y7Vo6kaMZTiqinQ==
X-Google-Smtp-Source: ABdhPJym+aBZbvt0f4f//4rqrmh4++sTtxZMOZit7++cTuaDxGY+Ip1EabqlzDVIs+aUw77l8Mh6IQ==
X-Received: by 2002:a17:902:9894:b0:149:9b36:7c9c with SMTP id s20-20020a170902989400b001499b367c9cmr9763679plp.61.1640888025029;
        Thu, 30 Dec 2021 10:13:45 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g14sm23365549pgp.76.2021.12.30.10.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 10:13:44 -0800 (PST)
Date:   Thu, 30 Dec 2021 18:13:41 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Like Xu <likexu@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/17] perf/x86/intel: Add EPT-Friendly PEBS for Ice
 Lake Server
Message-ID: <Yc321e9o16luwFK+@google.com>
References: <20211210133525.46465-1-likexu@tencent.com>
 <20211210133525.46465-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210133525.46465-2-likexu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021, Like Xu wrote:
> From: Like Xu <like.xu@linux.intel.com>
> 
> From: Like Xu <like.xu@linux.intel.com>

Did one of these get handcoded?

> The new hardware facility supporting guest PEBS is only available on
> Intel Ice Lake Server platforms for now. KVM will check this field
> through perf_get_x86_pmu_capability() instead of hard coding the cpu
> models in the KVM code. If it is supported, the guest PEBS capability
> will be exposed to the guest.

So what exactly is this new feature?  I've speed read the cover letter and a few
changelogs and didn't find anything that actually explained when this feature does.

Based on the shortlog, I assume the feature handles translating linear addresses
via EPT?  If that's correct, then x86_pmu.pebs_vmx should be named something like
x86_pmu.pebs_ept.

That also raises the question of what will happen if EPT is disabled.  Presumably
things will Just Work since no additional translation is needed, but if that's the
case then arguably vmx_pebs_supported() should be:

	return boot_cpu_has(X86_FEATURE_PEBS) &&
	       (!tdp_enabled || kvm_pmu_cap.pebs_vmx);

I'm guessing no one actually cares about supporting PEBS on older CPUs using shadow
paging, but the changelog should at least call out that PEBS is allowed if and only
if "pebs_vmx" is supported for simplicity, even though it would actually work if EPT
is disabled.  And if for some reason it _doesn't_ work when EPT is disabled, then
vmx_pebs_supported() and friends need to actually check tdp_enabled.

Regardless, this changelog really, really needs an explanation of the feature.
