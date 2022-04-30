Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0DF515E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382806AbiD3OUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382800AbiD3OUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:20:14 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49A551E6B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:16:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c125so12341819iof.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNUkiMcCvuqau25R+EENrrWPTYBEDVmpTh7ORFLGfdQ=;
        b=V5ewJa5J23zM0KK4rrTVTkAiVJ/H28FHkYVWnfpJ3enYsHDRuCr7ybFix6+yPH6qtX
         b1tYX8kPl1TKvrEWFpQpoLCjMNSJ2SOsqjy2LnZ7mK4S1faBrQxvDz4e8Z/tes+7IT5p
         zr0etttNhsUpECK3hF+7Px6H6fEY+0SLcGLbUIjQjAmTgc9I7Ik6+QfP2eNH4OSjAOkk
         CLbNEVsYYY2O6uNiVBxyu7YLtMpcgl/adK0QkIGi54g671vik+F80kUdVP7mXcrbMlDp
         8R3lsQDBUO+tYdS4LND9ZHnhFlN4c+Cuiiq212y/NOV3VPaYtoicSvj6lt7jSdREqfH/
         MIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNUkiMcCvuqau25R+EENrrWPTYBEDVmpTh7ORFLGfdQ=;
        b=2AuvkALRfCqCNJ7701NFMIFBX99Q1+SliD3naAw4vON85co/meDNKZ6SLtxvzi581b
         2lc3lcEEGHu8wbfgyFhODUzuFlC2FdpSs5+pgNXoMfZfV7hwOHsVXv+3OSnr4tamHnZL
         tmNaI1nWlU85l7I53hq8+C5+wzHYkS9TobZCIhkKOE0Zd+YYtPt930f7YYGKRmF1YXN9
         kZA8ZmF4mRqUWnrB5T1UhMyYC0/adD7kJi8pNoBQvruLbtlRQem8VQ8v94qBk0UxS+vq
         B+vhD/Unomcs5b37Dj+itK2HMZuoCHoMntBg44y/9JfXEoX5C8Vqwp6mFJ3g0qodDWdp
         AoYg==
X-Gm-Message-State: AOAM530oUy2JdDUbytvjBx0D2BVG+7NsTfEY6X0Zj5heHqrQyqBynN/P
        yfrBHSgk4SAjc5LR3WVwTJEwMg==
X-Google-Smtp-Source: ABdhPJy2facdBmo8TiAJfeKbYsZTLzGRDMY35o+oE7ykZeUGdIqdkyQtBzx0u+yMiyryxC4hgqaoEw==
X-Received: by 2002:a05:6602:482:b0:614:b990:28c9 with SMTP id y2-20020a056602048200b00614b99028c9mr1651794iov.6.1651328211000;
        Sat, 30 Apr 2022 07:16:51 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id y89-20020a029562000000b0032b3a78174asm1459351jah.14.2022.04.30.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 07:16:50 -0700 (PDT)
Date:   Sat, 30 Apr 2022 14:16:46 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <Ym1EztjkJIHrg4Qz@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com>
 <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
 <YmRI7Bh7fWCYLUGT@google.com>
 <0e26da1a-00bb-3d63-a8bf-6cd3271b0a38@redhat.com>
 <Ymr45B+8xTlhi7vk@google.com>
 <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96711526-c4f3-3b50-c015-beba8cc9fcc9@redhat.com>
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

Hi Gavin,

On Sat, Apr 30, 2022 at 07:38:29PM +0800, Gavin Shan wrote:
> Thank you for the comments and details. It should work by using bitmaps
> to represent event's states. I will adopt your proposed structs in next
> respin. However, there are more states needed. So I would adjust
> "struct kvm_sdei_vcpu" like below in next respin.
> 
>     struct kvm_sdei_vcpu {
>         unsigned long registered;    /* the event is registered or not                 */
>         unsigned long enabled;       /* the event is enabled or not                    */
>         unsigned long unregistering; /* the event is pending for unregistration        */

I'm not following why we need to keep track of the 'pending unregister'
state directly. Is it not possible to infer from (active && !registered)?

>         unsigned long pending;       /* the event is pending for delivery and handling */
>         unsigned long active;        /* the event is currently being handled           */
> 
>         :
>         <this part is just like what you suggested>
>     };
> 
> I rename @pending to @unregister. Besides, there are two states added:
> 
>    @pending: Indicate there has one event has been injected. The next step
>              for the event is to deliver it for handling. For one particular
>              event, we allow one pending event in the maximum.

Right, if an event retriggers when it is pending we still dispatch a
single event to the guest. And since we're only doing normal priority
events, it is entirely implementation defined which gets dispatched
first.

>    @active:  Indicate the event is currently being handled. The information
>              stored in 'struct kvm_sdei_event_context' instance can be
>              correlated with the event.

Does this need to be a bitmap though? We can't ever have more than one
SDEI event active at a time since this is private to a vCPU.

> Furthermore, it's fair enough to put the (vcpu) mask state into 'flags'
> field of struct kvm_vcpu_arch :)

I think you can get away with putting active in there too, I don't see
why we need more than a single bit for this info.

> > > > > > Do we need this if we disallow nesting events?
> > > > > > 
> > > > > 
> > > > > Yes, we need this. "event == NULL" is used as indication of invalid
> > > > > context. @event is the associated SDEI event when the context is
> > > > > valid.
> > > > 
> > > > What if we use some other plumbing to indicate the state of the vCPU? MP
> > > > state comes to mind, for example.
> > > > 
> > > 
> > > Even the indication is done by another state, kvm_sdei_vcpu_context still
> > > need to be linked (associated) with the event. After the vCPU context becomes
> > > valid after the event is delivered, we still need to know the associated
> > > event when some of hypercalls are triggered. SDEI_1_0_FN_SDEI_EVENT_COMPLETE
> > > is one of the examples, we need to decrease struct kvm_sdei_event::event_count
> > > for the hypercall.
> > 
> > Why do we need to keep track of how many times an event has been
> > signaled? Nothing in SDEI seems to suggest that the number of event
> > signals corresponds to the number of times the handler is invoked. In
> > fact, the documentation on SDEI_EVENT_SIGNAL corroborates this:
> > 
> > """
> > The event has edgetriggered semantics and the number of event signals
> > may not correspond to the number of times the handler is invoked in the
> > target PE.
> > """
> > 
> > DEN0054C 5.1.16.1
> > 
> > So perhaps we queue at most 1 pending event for the guest.
> > 
> > I'd also like to see if anyone else has thoughts on the topic, as I'd
> > hate for you to go back to the whiteboard again in the next spin.
> > 
> 
> Agreed. In next respin, we will have one pending event at most. Error
> can be returned if user attempts to inject event whose pending state
> (struct kvm_sdei_vcpu::pending) has been set.

I don't believe we can do that. The SDEI_EVENT_SIGNAL call should succeed,
even if the event was already pending.

> Indeed, the hardest part is to determine the data structures and
> functions we need. Oliver, your valuable comments are helping to
> bring this series to the right track. However, I do think it's
> helpful if somebody else can confirm the outcomes from the previous
> discussions. I'm not sure if Marc has time for a quick scan and provide
> comments.
> 
> I would summarize the outcomes from our discussions, to help Marc
> or others to confirm:

Going to take a look at some of your later patches as well, just a heads
up.

> - Drop support for the shared event.
> - Dropsupport for the critical event.
> - The events in the implementations are all private and can be signaled
>   (raised) by software.
> - Drop migration support for now, and we will consider it using
>   pseudo firmware registers. So add-on patches are expected to support
>   the migration in future.

Migration will be supported in a future spin of this series, not a
subsequent one right? :) I had just made the suggestion because there was
a lot of renovations that we were discussing.

> - Drop locking mechanism. All the functions are executed in vcpu context.

Well, not entirely. Just need to make sure atomics are used to post
events to another vCPU in the case of SDEI_EVENT_SIGNAL.

set_bit() fits the bill here, as we've discussed.

> - To use the data struct as you suggested. Besides, the vcpu's mask
>   state is put to struct kvm_arch_vcpu::flags.
>   enum kvm_sdei_event
>   struct kvm_sdei_event_handler
>   struct kvm_sdei_event_context
>   struct kvm_sdei_vcpu
> 
> Thanks,
> Gavin
>

--
Thanks,
Oliver
