Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642C522072
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346975AbiEJQDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347623AbiEJP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:57:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F26C2B033D
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:50:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so15280275pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gfpjV8IALC9FJVn33em1iNVzqEpeGBseY180FMbd8Ow=;
        b=WiHjV1BmyyNgau3dtoPNO9BFYoSW3ODWrDGqHWLJzczmgkziq9lKDze3/+3u36SK4z
         P7gSeY8DT4ugkQneFF+5GPFbUhUvCLLPB8Ywc8ahh7mq8JDL483utRzqZ2KbeC6CA63A
         h9FdIysAawhAqcvTPyJEFK4ZAuGmLwpybu5jhDBZU8suS3Ku61+0o2SvSo+QYGv+MVEt
         LnZu9nwvZYvUBXaV1VCx3mCMiWkmIVJynDySDY0v1ZOtLa2aQOZiDOxSox0zDEz0CgBm
         vl+U2krr59IK9ZbN71JrixmQbyjiXmWVaw1SDaZEsa8HK51l8toG9cswPLXti+ti2/N7
         mnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gfpjV8IALC9FJVn33em1iNVzqEpeGBseY180FMbd8Ow=;
        b=mkpSrn733GAI1pAg/yHNnE1yrOdr27y3ybr8lq6NTIGhZ+rXwq2fx/wUq6dz6DLfAA
         m7EjZCoRMDP4D5f3LCmrg+TJNLQHrfhmqRgcinMrl4+mDeK5vdjrkp7RZnVcAKB3QHUr
         /C5pPh2zK88IUcZDutAr/scz3tEceIE0vtF6K5HGyLIAXZWVRNGIWVXHByKNQzGKQJAH
         1m+gu5rpFjIgavKvxbmYcHqb1Ve/b8nXDPktlRHmB3V8zrDJdLTtHyRdqYePczguzKel
         ADCiaWQRzl8YXfHKFzwA7pBo4hK1J4MC9UPs/YqIWhkvHXDrOQ/2Sw2fCtiQHa0oGtDd
         znBg==
X-Gm-Message-State: AOAM531ZxFCu96p+7E4oCt3xz0yuGJsKgynd0P84d6WMxtyW6Wj6V0aL
        U57Bf6fGEpv0R4uh5G1PmE9H/w==
X-Google-Smtp-Source: ABdhPJwqe4OhHWIUrq0UdpkIgG435w9A+b/Kf1hvIdj4flh1vu16gW8WOO5oZvEuL7OEXjEC+cfpVg==
X-Received: by 2002:a65:6aa3:0:b0:3ab:23fb:adae with SMTP id x3-20020a656aa3000000b003ab23fbadaemr17341359pgu.278.1652197835222;
        Tue, 10 May 2022 08:50:35 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x2-20020a623102000000b0050dc76281easm10879795pfx.196.2022.05.10.08.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 08:50:34 -0700 (PDT)
Date:   Tue, 10 May 2022 15:50:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jon Kohler <jon@nutanix.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Balbir Singh <sblbir@amazon.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3] x86/speculation, KVM: only IBPB for
 switch_mm_always_ibpb on vCPU load
Message-ID: <YnqJx/5hos0lKqI9@google.com>
References: <YmxKqpWFvdUv+GwJ@google.com>
 <YmxRnwSUBIkOIjLA@zn.tnic>
 <Ymxf2Jnmz5y4CHFN@google.com>
 <YmxlHBsxcIy8uYaB@zn.tnic>
 <YmxzdAbzJkvjXSAU@google.com>
 <Ym0GcKhPZxkcMCYp@zn.tnic>
 <4E46337F-79CB-4ADA-B8C0-009E7500EDF8@nutanix.com>
 <Ym1fGZIs6K7T6h3n@zn.tnic>
 <Ynp6ZoQUwtlWPI0Z@google.com>
 <520D7CBE-55FA-4EB9-BC41-9E8D695334D1@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520D7CBE-55FA-4EB9-BC41-9E8D695334D1@nutanix.com>
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

On Tue, May 10, 2022, Jon Kohler wrote:
> 
> > On May 10, 2022, at 10:44 AM, Sean Christopherson <seanjc@google.com> wrote:
> > 
> > On Sat, Apr 30, 2022, Borislav Petkov wrote:
> >> But I'm likely missing a virt aspect here so I'd let Sean explain what
> >> the rules are...
> > 
> > I don't think you're missing anything.  I think the original 15d45071523d ("KVM/x86:
> > Add IBPB support") was simply wrong.
> > 
> > As I see it:
> > 
> >  1. If the vCPUs belong to the same VM, they are in the same security domain and
> >     do not need an IPBP.
> > 
> >  2. If the vCPUs belong to different VMs, and each VM is in its own mm_struct,
> >     defer to switch_mm_irqs_off() to handle IBPB as an mm switch is guaranteed to
> >     occur prior to loading a vCPU belonging to a different VMs.
> > 
> >  3. If the vCPUs belong to different VMs, but multiple VMs share an mm_struct,
> >     then the security benefits of an IBPB when switching vCPUs are dubious, at best.
> > 
> > If we only consider #1 and #2, then KVM doesn't need an IBPB, period.
> > 
> > #3 is the only one that's a grey area.  I have no objection to omitting IBPB entirely
> > even in that case, because none of us can identify any tangible value in doing so.
> 
> Thanks, Sean. Our messages crossed in flight, I sent a reply to your earlier message
> just a bit ago. This is super helpful to frame this up.
> 
> What would you think framing the patch like this:
> 
>     x86/speculation, KVM: remove IBPB on vCPU load
> 
>     Remove IBPB that is done on KVM vCPU load, as the guest-to-guest
>     attack surface is already covered by switch_mm_irqs_off() ->
>     cond_mitigation().
> 
>     The original 15d45071523d ("KVM/x86: Add IBPB support") was simply wrong in
>     its guest-to-guest design intention. There are three scenarios at play
>     here:
> 
>     1. If the vCPUs belong to the same VM, they are in the same security 
>     domain and do not need an IPBP.
>     2. If the vCPUs belong to different VMs, and each VM is in its own mm_struct,
>     switch_mm_irqs_off() will handle IBPB as an mm switch is guaranteed to
>     occur prior to loading a vCPU belonging to a different VMs.
>     3. If the vCPUs belong to different VMs, but multiple VMs share an mm_struct,
>     then the security benefits of an IBPB when switching vCPUs are dubious, 
>     at best.
> 
>     Issuing IBPB from KVM vCPU load would only cover #3, but there are no

Just to hedge, there are no _known_ use cases.

>     real world tangible use cases for such a configuration.

and I would further qualify this with:

      but there are no known real world, tangible use cases for running multiple
      VMs belonging to different security domains in a shared address space.

Running multiple VMs in a single address space is plausible and sane, _if_ they
are all in the same security domain or security is not a concern.  That way the
statement isn't invalidated if someone pops up with a use case for running multiple
VMs but has no security story.

Other than that, LGTM.

>     If multiple VMs
>     are sharing an mm_structs, prediction attacks are the least of their
>     security worries.
> 
>     Fixes: 15d45071523d ("KVM/x86: Add IBPB support")
>     (Reviewedby/signed of by people here)
>     (Code change simply whacks IBPB in KVM vmx/svm and thats it)
> 
> 
> 
