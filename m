Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4051B57583B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 02:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiGOAA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240879AbiGOAAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 20:00:51 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6DF27FF3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:00:50 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r186so2988706pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7kQcbuUpYF4D2BnaWIUhPJeFUYzIn6+Qgr3BLmvM4Yw=;
        b=Ww/hsP1MY82xo12KIVt4OgyeqvT1sRQBHFWuE8zAZHSRmd/pig+6qvG/tUm+17L6Xq
         kOpudqH7nzu0nHLkbvZlGTUMLA2dfpMf/iKXHonqjpTdUm9HXYntGUWpOu8S1ep9s0ap
         SgJ+I0gUVrRwJPfvv7bxqaSEi9tNAL/XHGDxO/qQTrdFxSjqjImw9NH5xNmW4aGQ5KN4
         shUtsd6TrEC5yZyv0AhxuKD0hzzdGOnXIazAI92IRdOZp2cKSVhiLzBOJxypbeIyUMas
         i7N1nnnbSLyvJtmpAJc3JagJQN5r8k/QDU2P2OK68VuW84jUNq9O2VpSoSz80c+lutN9
         RVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7kQcbuUpYF4D2BnaWIUhPJeFUYzIn6+Qgr3BLmvM4Yw=;
        b=WDRnFEttObqapPL1kZqowWOMJvZDIAXsF4hlmbNzRtAvuyDOKq2wAlXDWW874ewLT4
         4Dv4P54RrvJ8gGjjzdMPvQoqj/glb4uwZjhjgb0c6X2GDSe91OnboGXEm7xReisZGU4d
         nH3ZfjcpYQ5UyvhmfPdIvIgZ6c2V4fFrNpZQ1bTDLACqPEg+yqU05U8fvR+n+DeUeCmm
         WGkQiM3hdWcJ9KHDNXfeiXst6kQAUnUi4jNZ2jY6R7m8h1Zt3l2yDDloBmn7LKYlBkIJ
         ya27VtWsDmoJayzSoBeGW33BM+9eVHO9PCT7NvF2tnoYEYMNG4cUOgeqcJcprhbx3bqn
         jc0A==
X-Gm-Message-State: AJIora+mrxGgE7w9T33xt6nNXeZFO10zDk1lximImHtv2ywSohe47yAR
        EQPkQLBxXmz+T36FLZL7Z0ik4A==
X-Google-Smtp-Source: AGRyM1vB1Bx0JIdA2uKlH7N/GZYabyRhn+4zGmjeXbgLfPo6T5PvUMOywAs5A1ZieCWcXkppBuQHvg==
X-Received: by 2002:a05:6a00:998:b0:52a:db4c:541b with SMTP id u24-20020a056a00099800b0052adb4c541bmr10834227pfg.35.1657843249678;
        Thu, 14 Jul 2022 17:00:49 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id w6-20020a17090a780600b001f09d9b6673sm2029731pjk.7.2022.07.14.17.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 17:00:47 -0700 (PDT)
Date:   Fri, 15 Jul 2022 00:00:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: fix task switch emulation on INTn instruction.
Message-ID: <YtCuK36YnKp/sojH@google.com>
References: <20220714124453.188655-1-mlevitsk@redhat.com>
 <52d44630-21ad-1291-4185-40d5728eaea6@maciej.szmigiero.name>
 <034401953bc935d997c143153938edb1034b52cd.camel@redhat.com>
 <84646f56-dcb0-b0f8-f485-eb0d69a84c9c@maciej.szmigiero.name>
 <YtClmOgBV8j3eDkG@google.com>
 <CALMp9eTZKyFM4oFNJbDDe69xfqtSmj5jZnPbe0aQaxxCvqdFTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMp9eTZKyFM4oFNJbDDe69xfqtSmj5jZnPbe0aQaxxCvqdFTA@mail.gmail.com>
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

On Thu, Jul 14, 2022, Jim Mattson wrote:
> On Thu, Jul 14, 2022 at 4:24 PM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Fri, Jul 15, 2022, Maciej S. Szmigiero wrote:
> > > On 14.07.2022 15:57, Maxim Levitsky wrote:
> > > > On Thu, 2022-07-14 at 15:50 +0200, Maciej S. Szmigiero wrote:
> > > > > On 14.07.2022 14:44, Maxim Levitsky wrote:
> > > > > > Recently KVM's SVM code switched to re-injecting software interrupt events,
> > > > > > if something prevented their delivery.
> > > > > >
> > > > > > Task switch due to task gate in the IDT, however is an exception
> > > > > > to this rule, because in this case, INTn instruction causes
> > > > > > a task switch intercept and its emulation completes the INTn
> > > > > > emulation as well.
> > > > > >
> > > > > > Add a missing case to task_switch_interception for that.
> > > > > >
> > > > > > This fixes 32 bit kvm unit test taskswitch2.
> > > > > >
> > > > > > Fixes: 7e5b5ef8dca322 ("KVM: SVM: Re-inject INTn instead of retrying the insn on "failure"")
> > > > > >
> > > > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > > > ---
> > > > >
> > > > > That's a good catch, your patch looks totally sensible to me.
> > > > > People running Win 3.x or OS/2 on top of KVM will surely be grateful for it :)
> > > >
> > > > Yes and also people who run 32 bit kvm unit tests :)
> > >
> > > It looks like more people need to do this regularly :)
> >
> > I do run KUT on 32-bit KVM, but until I hadn't done so on AMD for a long time and
> > so didn't realize the taskswitch2 failure was a regression.  My goal/hope is to
> > we'll get to a state where we're able to run the full gamut of tests before things
> > hit kvm/queue, but the number of permutations of configs and module params means
> > that's easier said than done.
> >
> > Honestly, it'd be a waste of people's time to expect anyone else beyond us few
> > (and CI if we can get there) to test 32-bit KVM.  We do want to keep it healthy
> > for a variety of reasons, but I'm quite convinced that outside of us developers,
> > there's literally no one running 32-bit KVM.
> 
> It shouldn't be necessary to run 32-bit KVM to run 32-bit guests! Or
> am I not understanding the issue that was fixed here?

Ah, no, I'm the one off in the weeds.  I only ever run 32-bit KUT on 32-bit VMs
because I've been too lazy to "cross"-compile.  Time to remedy that...
