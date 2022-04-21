Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C927750A7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391137AbiDUSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391140AbiDUSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:05:16 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0594B1E3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:02:22 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f5so6708766ljp.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ak6QqPmm4AQbpNhOQu87q9LEr9+mQ3asTsa/QbWlBQU=;
        b=ootSWzXFAwsBY7jD1xTnFCZHZtZEjwkBUZp8yzJvhEwIf1usqNgy3MW3YXnTFyInRl
         pgFLlTuvlZwFwfmwQMvQVVzOIV/9rUmprEtVY+6MgcilOQPIpyMbYES7Jyq/LVZSNAB0
         ErOb4YXRYVh3GI2aGEtVAHn66KBvwvGG2gVW0TJTDtKDvSWEtgZHwIw7OI78Aoj8k6qe
         00U0aoQKCBcIg33r0tKrH5dWA7v702Pdv70LF5HkPDjVolF2ANqHBBXVr4Q/t+4nIXsw
         zdcH5nwNiRcAYGOqPjB7Ne1CM92SzA+I+SqtgHgl+1vhFj2AsLfvCD39bkfyOuHZbrUZ
         uBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak6QqPmm4AQbpNhOQu87q9LEr9+mQ3asTsa/QbWlBQU=;
        b=kT6a9zaHAg5BZ2xlF84yERhg+Mtt0Fb3Z9JEay7UR8X/qLPmU8FshO50F0W7Ss7TpW
         Ugb5FA0ubpdPTzIVYsNvD5x/rt2EE4CC08Kb7ThDnPn0Hv3Fh8BZvFO235P4UX2FTlig
         7ZSDs0r6903UG6+ksZPB5B0mLo6mPwHBPpp4uq944E8ECCMOOOtBjRuRqQqul38e4vHE
         uyulnvML1884XZwbDjNKgdnTc45/TjTg9UvlKtvaa54C9D2/MHD+yTkfuO8keRDbIEIL
         bZtTy1c/0y3cGqeY1VSTrD7x+BzSpk2wPKlMVh1SjqSNZ9gFiN9aOmHe0p1XfrlieZgE
         lEFw==
X-Gm-Message-State: AOAM532w+lYZC0wuxBvbs2hGtHD9XeQY/uZuE65yPF3r9LoPv3Gnu/2h
        5Zv4WQvMlu79bKy0ruOPF1NHJIXB04ermQvbfaXc5g==
X-Google-Smtp-Source: ABdhPJzUI1h3NotonH2SjnObM5v+rR0GgHD0HFAj+ft7o7CvhswV6yU9RmjDy5j1AbIBljPX4izK26oRhqyVO7/cvF0=
X-Received: by 2002:a2e:bf27:0:b0:246:7ed6:33b0 with SMTP id
 c39-20020a2ebf27000000b002467ed633b0mr513433ljr.167.1650564140447; Thu, 21
 Apr 2022 11:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220421165137.306101-1-posk@google.com> <b1b04160-1604-8281-4c82-09b1f84ba86c@redhat.com>
In-Reply-To: <b1b04160-1604-8281-4c82-09b1f84ba86c@redhat.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 21 Apr 2022 11:02:09 -0700
Message-ID: <CAPNVh5cQ6HhVqfuM7rhyK5RH6YYczkjAAgMwn7qHt8cbJneG_g@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: add HC_VMM_CUSTOM hypercall
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@posk.io>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 10:14 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 4/21/22 18:51, Peter Oskolkov wrote:
> > Allow kvm-based VMMs to request KVM to pass a custom vmcall
> > from the guest to the VMM in the host.
> >
> > Quite often, operating systems research projects and/or specialized
> > paravirtualized workloads would benefit from a extra-low-overhead,
> > extra-low-latency guest-host communication channel.
>
> You can use a memory page and an I/O port.  It should be as fast as a
> hypercall.  You can even change it to use ioeventfd if an asynchronous
> channel is enough, and then it's going to be less than 1 us latency.

Thank you for the suggestion. Let me try that.

Thanks,
Peter

[...]
