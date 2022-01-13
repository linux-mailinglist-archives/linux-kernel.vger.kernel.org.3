Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0538548DE80
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 21:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbiAMUAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 15:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiAMUAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 15:00:13 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702EC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:00:12 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so19884223pjf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CiDsxYMAICiaf6TClbsZwkALDBPrkQXvflO3Z/FYFIY=;
        b=GIwZ7ViUI03GS4w60w5TWunTadMZs08JiSLHGATIDvRs+fbhZUuPmEX8hEtESBC5wd
         5Uarg3QHOjlwMMScRSBoU2EYyN1AJxcBcpreOO/36fp0+RZeLygOVG5NSLQhMD8TXZoU
         9j687e0HwoTyVSNEijscfoxpJJPvOx7xzAmPC7cpO40pnbNSL4fvvg+FUwStOMdByslN
         6140D+OxaZ7UzSV7Z1SR53jjnnLtWIh5lpi7ZDpvu85uD5TQb0hCt7b//tXz5Oe2Vtt7
         FHeT5ARV4vtrZelbtbL6SM3b8T4AknDUXTLRzjYG36jUd9IZr7H5Kl40q9JHIhXTHe+G
         x5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CiDsxYMAICiaf6TClbsZwkALDBPrkQXvflO3Z/FYFIY=;
        b=3ZO/jjGAHy07bNMdInmk9siqsnRvQqIHa1UJ9iaS9jtGvniDPrgSrElBoYZT4VtPoo
         CMp+FQ2h5rtRNq6LKsslEcRo9VnD9d6GgJJL4ocVokFBIz8yDmpvADkvNxJXZQTK6XoF
         TBBo4WNsQkU/2sEa/99tMfPJJxSItX+KuRLlHX4TSnIkOCQomPfrUXYxdp6V/ZzlPGwP
         aIRYvFCqJZnSUaGhVX91XiDZmltgHeFC5YytEXjv8I4OtBDaBYtpfS8Pn0pw1UM8fcnS
         L6MX7DP6r4hLPDqy5TtPJ2HoK+mRcQWSiMpsib0zThUBsFn11KawCEuo2QI8dSOPBF+a
         Mcdg==
X-Gm-Message-State: AOAM532OAx576u03vBOUuiO0zYQ/z9sAFWSge/RaMdj9x0pkgV+GmjZ1
        s8RGeKATrMGmhPXmaXyv2HALVA==
X-Google-Smtp-Source: ABdhPJwvo8W92RfYeoD67C08BHkLq+IUB5IGnwXqD3pWUBs4BS1pMFytsS1VjeKpVKpaeP1nlGFimQ==
X-Received: by 2002:a17:90a:4089:: with SMTP id l9mr6838062pjg.14.1642104012158;
        Thu, 13 Jan 2022 12:00:12 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f8sm2783510pga.69.2022.01.13.12.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 12:00:11 -0800 (PST)
Date:   Thu, 13 Jan 2022 20:00:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN for CPU hotplug
Message-ID: <YeCEyNz/xqcJBcU/@google.com>
References: <20220113133703.1976665-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113133703.1976665-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022, Vitaly Kuznetsov wrote:
> Recently, KVM made it illegal to change CPUID after KVM_RUN but
> unfortunately this change is not fully compatible with existing VMMs.
> In particular, QEMU reuses vCPU fds for CPU hotplug after unplug and it
> calls KVM_SET_CPUID2. Relax the requirement by implementing an allowlist
> of entries which are allowed to change.

Honestly, I'd prefer we give up and just revert feb627e8d6f6 ("KVM: x86: Forbid
KVM_SET_CPUID{,2} after KVM_RUN").  Attempting to retroactively restrict the
existing ioctls is becoming a mess, and I'm more than a bit concerned that this
will be a maintenance nightmare in the future, without all that much benefit to
anyone.

I also don't love that the set of volatile entries is nothing more than "this is
what QEMU needs today".  There's no architectural justification, and the few cases
that do architecturally allow CPUID bits to change are disallowed.  E.g. OSXSAVE,
MONITOR/MWAIT, CPUID.0x12.EAX.SGX1 are all _architecturally_ defined scenarios
where CPUID can change, yet none of those appear in this list.  Some of those are
explicitly handled by KVM (runtime CPUID updates), but why should it be illegal
for userspace to intercept writes to MISC_ENABLE and do its own CPUID emulation?
