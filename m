Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776FD5137AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348748AbiD1PIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346740AbiD1PH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:07:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98729B3DCA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:04:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x52so2921164pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1izZyID2JVcsZHuk9qcOHy8QVMSnHDmxGlhaD1X6JZE=;
        b=WRrJSVfXKnRNEU+qLmI6Rj4HeuvfpqNhpSzfbha0UXvP5WsX/CY+Mkf0pCsoTch+hq
         svxDaQLsuJlSGtth0lbdJkOyy/GkU6McQfvA2Kv8LUa29WtIbFgShnyjHj7EA4fg6Usz
         H3Lv9xgE1ALBpsbhNoVhyIvkXT/ohsz0pgzmDDKtYscNfegRR556kZLTSOjRnBnZUJgl
         LsKfLKhjf8uYsT0xnqXCTzYiZ8/nzsdLgEwvM64AI5AQe5PE6wOICBBZgEscHUaq9Ros
         2I6p6Pz7jYW4IGIqw3eGJ0qBdWOmeFThZBTcx+evNZtZLsoB9FQfEhVfVOGey2/NykuD
         fc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1izZyID2JVcsZHuk9qcOHy8QVMSnHDmxGlhaD1X6JZE=;
        b=Tt6Di9ALFPhB0HFI3KbvIx0TgFfnJfVjItNPU6KVzpc2t1lForV3svpqi8wRVk1Gly
         0Jol04EKGTZcelL3M2LQKxYpBMiZjZ+cSNCcAsytLMZc6zoG1m1wu2xUK+KjogsXBhxf
         XugcTxX28ihlwgmbdF57YiIJJbbOQ41UCxEQl5ogvi3bGximIXbfrmTPL1SNl3oO58y+
         wO7w8/Vy2Wr3E0VQwkGXJtKk/0A4h6bgV8ZN3/7OTjm3HbzufxU0xZdh8owlhwSNadW2
         8MHaAeMEKdyHrKIN+IU2+UnV+jzFGM1qsLeV9v8b8HZwTuG4NG8evQb9elqknvmyt76t
         1yKw==
X-Gm-Message-State: AOAM533EbrFxqAPjhkYxALPVKhgZQGhLBauop9L2U0F242sd/YGVgEcJ
        VNyk8GUOAj9OltT9V3AjhY9t6A==
X-Google-Smtp-Source: ABdhPJyaj8spNf9/8BRmduOg+RCzwbSCa+S1Ac5s2d0kitz8NoF0jbdjfCL+Rbgk9DOX5MTCpjjaew==
X-Received: by 2002:a65:6955:0:b0:380:64fd:a2dd with SMTP id w21-20020a656955000000b0038064fda2ddmr27637714pgq.383.1651158283925;
        Thu, 28 Apr 2022 08:04:43 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9-20020a639e09000000b003c14af5063asm3225467pgd.82.2022.04.28.08.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 08:04:43 -0700 (PDT)
Date:   Thu, 28 Apr 2022 15:04:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/11] KVM: SVM: Don't BUG if userspace injects a soft
 interrupt with GIF=0
Message-ID: <YmqtCNFxCSF2hENP@google.com>
References: <20220423021411.784383-1-seanjc@google.com>
 <20220423021411.784383-3-seanjc@google.com>
 <61ad22d6de1f6a51148d2538f992700cac5540d4.camel@redhat.com>
 <4baa5071-3fb6-64f3-bcd7-2ffc1181d811@maciej.szmigiero.name>
 <b8a02f2eab780262c172cd4bbffd801ca8a37e98.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8a02f2eab780262c172cd4bbffd801ca8a37e98.camel@redhat.com>
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

On Thu, Apr 28, 2022, Maxim Levitsky wrote:
> On Thu, 2022-04-28 at 15:27 +0200, Maciej S. Szmigiero wrote:
> > On 28.04.2022 09:35, Maxim Levitsky wrote:
> > > On Sat, 2022-04-23 at 02:14 +0000, Sean Christopherson wrote:
> > > > From: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > 
> > > > Don't BUG/WARN on interrupt injection due to GIF being cleared if the
> > > > injected event is a soft interrupt, which are not actually IRQs and thus
> > > 
> > > Are any injected events subject to GIF set? I think that EVENTINJ just injects
> > > unconditionaly whatever hypervisor puts in it.
> > 
> > That's right, EVENTINJ will pretty much always inject, even when the CPU
> > is in a 'wrong' state (like for example, injecting a hardware interrupt
> > or a NMI with GIF masked).
> > 
> > But KVM as a L0 is not supposed to inject a hardware interrupt into guest
> > with GIF unset since the guest is obviously not expecting it then.
> > Hence this WARN_ON().
> 
> If you mean L0->L1 injection, that sure, but if L1 injects interrupt to L2,
> then it should always be allowed to do so.

Yes, L1 can inject whatever it wants, whenever it wants.

I kept the WARN_ON() under the assumption that KVM would refuse to inject IRQs
stuffed by userspace if GIF is disabled, but looking at the code again, I have
no idea why I thought that.  KVM_SET_VCPU_EVENTS blindly takes whatever userspace
provides, I don't see anything that would prevent userspace from shoving in a
hardware IRQ.
