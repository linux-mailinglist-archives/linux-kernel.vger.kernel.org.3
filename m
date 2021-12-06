Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76F46A3B4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347047AbhLFSFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347002AbhLFSE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:04:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE204C061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:01:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id l64so5679808pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 10:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZS1r0CcS7ggO1DDxQXYjV5u2RzqWZvKX9IDzXi7hKWY=;
        b=SxhVCSj0l3Pq2RVNEnaIUsIpbm8lrDpxXQEmiYVVb6T8STgsyZvnO0Yk6shHxSXxH7
         nntO1QbDiE31p0fzfIvTR3sXrSKcAUohetClCWpHgtbNuYsztOM71z81dLKNrME4FOJR
         1lg5PQ8uwDruWykG1DVvzWvFwyGbhDoyGn2aC4QoonSijfKSTunskc+TO32S+/azuAeU
         dJvf96l7RItKP2VLTslVZBhQ1iUO215O4Gt7c1tWJTGChoZIQEQBC2mNCovMIdNgVmwy
         LcGcpmXUmthuKt4cbdjk7uy5hxn0driAYe95t5HtQUdXeDmlWfUzQ1xhqTqaqIdlcYD0
         EceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZS1r0CcS7ggO1DDxQXYjV5u2RzqWZvKX9IDzXi7hKWY=;
        b=u9AA9xH3hXYWTl3GXmPOpniWfwdopUi8xp/pzCYTNrznslsP5wCEmrXtZ4oWLRECQK
         rizQF2Xf/rwNkhT+J51cGiwfrnD5NLf4KvToaMHi6kMml5lrGcB220Tl4OLhNtpmJtFt
         5sPsgtqb47Gh0qNujmKiZqeKqpFsmAaYlWYM5gZN0XTQzAWbOfG1ITfZ0s1R401CCC38
         4byXDaQv0JHRKUXLJtTnzccGuFggHHcOM9zhc+/K+RtP3GiMbVM+0p1pXrCjkmFcm7yc
         h2sHVdAUy3n8aafFtpaweiPul2jmvV8XqPomA4kzXJF8nrScg4wvQV5msr0C2X/K2B7F
         7qnw==
X-Gm-Message-State: AOAM530cPAwxyQtJAdZSjyu20Iq0EbstjMENyfNRPkjXp49XJ6nPpcnu
        LIGUHr5GX3nsLR/5BIMTKFTqNw==
X-Google-Smtp-Source: ABdhPJxL8xkWl2TyC1yBw7chLKkCO37arya0zRV57H32iA8SZePNvtJjHQcKe7LByy96i2zLQSrY3g==
X-Received: by 2002:a63:1950:: with SMTP id 16mr20714540pgz.422.1638813670112;
        Mon, 06 Dec 2021 10:01:10 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n7sm4181992pgt.6.2021.12.06.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 10:01:09 -0800 (PST)
Date:   Mon, 6 Dec 2021 18:01:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
Cc:     vkuznets@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com
Subject: Re: [PATCH v3] KVM: x86: fix for missing initialization of return
 status variable
Message-ID: <Ya5P4WWsgCyQZvBH@google.com>
References: <20211206160813.GA37599@hamza-OptiPlex-7040>
 <20211206164503.135917-1-amhamza.mgc@gmail.com>
 <Ya5CCU0zf+MzMwcX@google.com>
 <20211206172746.GA141396@hamza-OptiPlex-7040>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206172746.GA141396@hamza-OptiPlex-7040>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021, Ameer Hamza wrote:
> On Mon, Dec 06, 2021 at 05:02:01PM +0000, Sean Christopherson wrote:
> > On Mon, Dec 06, 2021, Ameer Hamza wrote:
> > > If undefined ioctl number is passed to the kvm_vcpu_ioctl_device_attr
> > > ioctl, we should trigger KVM_BUG_ON() and return with EIO to silent
> > > coverity warning.
> > > 
> > > Addresses-Coverity: 1494124 ("Uninitialized scalar variable")
> > > Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> > > ---
> > > Changes in v3:
> > > Added KVM_BUG_ON() as default case and returned -EIO
> > > ---
> > >  arch/x86/kvm/x86.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index e0aa4dd53c7f..b37068f847ff 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -5019,6 +5019,9 @@ static int kvm_vcpu_ioctl_device_attr(struct kvm_vcpu *vcpu,
> > >  	case KVM_SET_DEVICE_ATTR:
> > >  		r = kvm_arch_tsc_set_attr(vcpu, &attr);
> > >  		break;
> > > +	default:
> > > +		KVM_BUG_ON(1, vcpu->kvm);
> > > +		r = -EIO;
> > 
> > At least have a
> > 
> > 		break;
> > 
> > if we're going to be pedantic about things.
> I just started as a contributer in this community and trying
> to fix issues found by static analyzer tools. If you think that's
> not necessary, its totally fine :)

(Most) Static analyzers are great, they definitely find real bugs.  But they also
have a fair number of false positives, e.g. this is a firmly a false positive, so
the results of any static analyzer needs to thought about critically, not blindly
followed.  It's completely understandable that Coverity got tripped up in this
case, but that's exactly why having a human vet the bug report is necessary.

There is arguably value in having a default statement to ensure future KVM code
doesn't end up adding a bad call, which is why I'm not completely opposed to the
above addition.

Where folks, myself included, get a bit grumpy is when patches are sent to "fix"
bug reports from static analyzers without evidence that the submitter has done
their due dilegence to understand the code they are changing, e.g. even without
any understanding of KVM, a search of kvm_vcpu_ioctl_device_attr() in the code
base and reading of the function would have shown that the report was a false
positive, albeit a somewhat odd one, and that returning -EINVAL was likely the
wrong thing to do.  If you're unsure if something is a real bug, please ask a
question.

Rapid firing patches at the list also makes reviewers grumpy as it again suggests
a lack of due dilegence, especially when the patches have typos ("EINV" in v2)
and/or have obvious shortcomings (missing "break" in v3).

TL;DR: I have no objection whatsover to fixing (potential) bugs found by static
analyzers, but please slow down and (a) make sure that it's actually a bug, (b)
ask if you're unsure, and (c) do your best to ensure that what you're sending is
an overall improvement.
