Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0948EE02
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiANQWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiANQWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:22:02 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76810C06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:22:02 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso22426202pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 08:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elOwmhf+rzcQgZMfoeUXN1l9H5VGHHZ0l6UT+nIDAOg=;
        b=dvQyhXvSwz3tlHeQlP9hgUsSHmw2hh9MaTChbDAad9NgZA/72wIx4T4NJ9MV0zx2AA
         EMM1pFrrgj5GYfXQid9hIAlwP3A76ti84WWwj1n2/0/0YHEAmVBIEOgEJtkzl7Oo7cuf
         bvVcwoZmmCINTe5hs1e0w7dD41lnhED5Hbu6+rddGa1jDsss/w32iFdhfKfwTfeAZwFy
         NeZAf6n4o2EPXnN6wGjs8WeGJ3dhj8QAJ1nN1Lftn4I8W7UqiiKKubJ6/13ANq54EXOG
         X7pWTsL4jP0WQifhikkk0Iv27A8/AoEZhnAMY+mI6Y9xa7kPD9E2Zr5JVAYOVu+Cw1EI
         BRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elOwmhf+rzcQgZMfoeUXN1l9H5VGHHZ0l6UT+nIDAOg=;
        b=22Vs0ZjbBiW8ku+KSGSDe7YLWVidmnCDZPdqJolDXfLSAxoFRwH5txBb/LHVo4u36Z
         VbDJnlsQdh5wRIAu8tq0rwuFxD5vXFsDC3wvJV+SEyPT6j5jMto42XMiJ4TsUtnIeS7D
         pKlT+MZHBWOiiYGOYnNV4sIcWXccZ51fQJJ5/nh/Mt0p8eEEeEtzc+scnaF66zHTUC2i
         r1mhjcb7MaZT/OBTZqhFT7uFMnss3VR8DE73YqSuSMTOXMY92RUB0N+uSJvIelprP+uc
         WkvNU17DL+B4FZxK+/lJGVnDhJE1ut3pcbBglELM9rluFDOUtJCs6IoMsqFj31GFcXFP
         aEgw==
X-Gm-Message-State: AOAM530AGhVldY+qtROXcBraac9sbwaUC4GMkrLTuEQiD8sy0+USN/At
        le2/gwaiFgWmzLS8pXpLitqdWw==
X-Google-Smtp-Source: ABdhPJzKnGGEjoTCd5mvsGX8rMFiKOHI+wVjEU+z7K2C79NByOmLaTMK5vJDiFlLCGYRARv3VOlFxQ==
X-Received: by 2002:a17:902:ee4c:b0:14a:436e:56d7 with SMTP id 12-20020a170902ee4c00b0014a436e56d7mr9941712plo.169.1642177321863;
        Fri, 14 Jan 2022 08:22:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id o186sm6091069pfb.187.2022.01.14.08.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:22:01 -0800 (PST)
Date:   Fri, 14 Jan 2022 16:21:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] KVM: x86: Partially allow KVM_SET_CPUID{,2} after
 KVM_RUN for CPU hotplug
Message-ID: <YeGjJRfpJ8mMa6c7@google.com>
References: <20220113133703.1976665-1-vkuznets@redhat.com>
 <YeCEyNz/xqcJBcU/@google.com>
 <20220114100849.277c04ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114100849.277c04ee@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022, Igor Mammedov wrote:
> On Thu, 13 Jan 2022 20:00:08 +0000
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Thu, Jan 13, 2022, Vitaly Kuznetsov wrote:
> > > Recently, KVM made it illegal to change CPUID after KVM_RUN but
> > > unfortunately this change is not fully compatible with existing VMMs.
> > > In particular, QEMU reuses vCPU fds for CPU hotplug after unplug and it
> > > calls KVM_SET_CPUID2. Relax the requirement by implementing an allowlist
> > > of entries which are allowed to change.  
> > 
> > Honestly, I'd prefer we give up and just revert feb627e8d6f6 ("KVM: x86: Forbid
> > KVM_SET_CPUID{,2} after KVM_RUN").  Attempting to retroactively restrict the
> > existing ioctls is becoming a mess, and I'm more than a bit concerned that this
> > will be a maintenance nightmare in the future, without all that much benefit to
> > anyone.
> 
> in 63f5a1909f9 ("KVM: x86: Alert userspace that KVM_SET_CPUID{,2} after KVM_RUN is broken")
> you mention heterogeneous configuration, and that implies that
> a userspace (not upstream qemu today) might attempt to change CPUID
> and that would be wrong. Do we still care about that?

We still care, and I really do like the idea in theory, but if we're stuck choosing
between taking on a pile of ugly code in KVM and letting userspace shoot themselves
in the foot, I choose the latter :-)
