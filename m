Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEF250CCEF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiDWSrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233864AbiDWSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 14:46:59 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844D19B64B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:44:01 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id y85so11845022iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 11:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VbVWQztzQUCaSUHCwdMv5UtXh8bXbn7wlBJQ/zCV3AA=;
        b=r+KGN5IhFoYhtR9dsmWVnQ4ADvPFKx+b0hk77KmBqjn+S5rhPKYQf2zOVWGiTvmbNP
         jDOY9eYh0lFzVHHiXKBSB1YuyWSh+luhw5PcR6URh+cgLT1kW97Pku0M7xPaX57+pa5d
         Y3v6r75HOrsSsNeoVN56ToQ+VRCURzi2Cg/ZdHmZwMciHetH1PrwBzhFlriADftW3lmC
         dbvhvOLnu84RFveuEuMOTUwKBFZ1GYw2vclInQUnLEN7Aeoyz90HGBkfr7JtP2OjXtjb
         wy900cqqezrL0TS7B5AF8+k+Uvz3zy6r/i4nvKqpMS8P/rGFsAPAdrjwX7aiunUXTGK9
         SxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VbVWQztzQUCaSUHCwdMv5UtXh8bXbn7wlBJQ/zCV3AA=;
        b=DVjCtu0ffVxaaadY87uHtOCQjo5tkJLMJb6fCXa6rDdQUlRTUfAgn9o2xUrcIyPiYf
         Qz42xdkQv896rDRYg2Cw3Ls8VW9wtYVDOwcHg8jfOgigC0177E1+vdXA52tbrFlJMl4W
         JBrAZQSfLj6X3J/5bZq88M3EW/t9jEL9LTmvnqk8XediKGvgIzFlfGd3AolTuZW+flrE
         FF/4vlPcq1/H/BSKiw47O8fDKqhAbeB/910BYmzerJLjLJCOEcj1Q0h2u1nLRAhTHrNE
         7nGuqottDoiXCCwHvtgos4VFg9Wvof586Rxdf+7ycprsahYVrkRCKKFsicQ7KhbRwqPl
         Hg9Q==
X-Gm-Message-State: AOAM531q7GQawChfgmRr0U682NZI6a86Qy6mbv7Injw4Ofj2PNHmYR7T
        KcLphi29ueaoI2sEHP39MhantA==
X-Google-Smtp-Source: ABdhPJxDPceXX4mmu/GhmaWV2Ff6CiRmh6w/bKxEoHr4noJEuTSkN3KYjHdwYkdImOlR4Tq7g0WU4g==
X-Received: by 2002:a6b:ed06:0:b0:649:d35f:852c with SMTP id n6-20020a6bed06000000b00649d35f852cmr4429831iog.186.1650739440776;
        Sat, 23 Apr 2022 11:44:00 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id t2-20020a92dc02000000b002cd6f5634ffsm3485130iln.12.2022.04.23.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 11:43:59 -0700 (PDT)
Date:   Sat, 23 Apr 2022 18:43:56 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 03/18] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <YmRI7Bh7fWCYLUGT@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-4-gshan@redhat.com>
 <YmMiyt/TDjJt0mdG@google.com>
 <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36899ea9-e8bd-27b2-8dfb-75b76eab50d7@redhat.com>
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

On Sat, Apr 23, 2022 at 10:18:49PM +0800, Gavin Shan wrote:
> Hi Oliver,
> 
> On 4/23/22 5:48 AM, Oliver Upton wrote:
> > On Sun, Apr 03, 2022 at 11:38:56PM +0800, Gavin Shan wrote:
> > > Software Delegated Exception Interface (SDEI) provides a mechanism
> > > for registering and servicing system events, as defined by ARM DEN0054C
> > > specification. One of these events will be used by Asynchronous Page
> > > Fault (Async PF) to deliver notifications from host to guest.
> > > 
> > > The events are classified into shared and private ones according to
> > > their scopes. The shared events are system or VM scoped, but the
> > > private events are CPU or VCPU scoped. The shared events can be
> > > registered, enabled, unregistered and reset through hypercalls
> > > issued from any VCPU. However, the private events are registered,
> > > enabled, unregistered and reset on the calling VCPU through
> > > hypercalls. Besides, the events are also classified into critical
> > > and normal events according their priority. During event delivery
> > > and handling, the normal event can be preempted by another critical
> > > event, but not in reverse way. The critical event is never preempted
> > > by another normal event.
> > 
> > We don't have any need for critical events though, right? We should avoid
> > building out the plumbing around the concept of critical events until
> > there is an actual use case for it.
> > 
> 
> The Async PF one is critical event, as guest needs to handle it immediately.

But that's the sticking point for me. IIUC, we're going to deliver an
aync PF SDEI event to the PE that is waiting on a page so it can go do
something else and wait for the page to come in. Normal events preempt
~everything, critical events preempt even normal events.

How can the guest context switch and do something better at an arbitrary
instruction boundary (such as in an SDEI handler of normal priority)? If
a guest takes a page fault in that context, it may as well wait
synchronously for the page to come in.

And in the case of the page ready event, we still need to clean up shop
before switching to the unblocked context.

> Otherwise, it's possible that guest can't continue its execution. Besides,
> the software signaled event (0x0) is normal event. They're the only two
> events to be supported, I assume the software signaled event (0x0) is only
> used selftest/kvm. So Async PF one becomes the only event and it can be
> in normal priority until other SDEI event needs to be added and supported.

I believe there are multiple use cases for guest-initiated SDEI events
beyond just testing. Poking a hung PE but one example.

> However, the logic to support critical/normal events has been here. So
> I think it's probably nice to keep it. At least, it make it easier to
> add a new SDEI event in future. We dropped the support for the shared
> event from v5 to v6, I think we probably never need a shared event for
> ever :)

But then we're sprinkling a lot of dead code throughout KVM, right? It
makes KVM's job even easier if it doesn't have to worry about nesting
SDEI events.
> > > +struct kvm_sdei_exposed_event {
> > > +	unsigned int	num;
> > > +	unsigned char	type;
> > > +	unsigned char	signaled;
> > 
> > what is this used for?
> > 
> 
> It indicates the event can be raised by software or not. For those
> events exposed by KVM should be raised by software, so this should
> always be true.

Isn't there always going to be some piece of software that raises an
event?

For KVM, we have guest-initiated 'software-signaled' events and KVM-initiated
async PF (whatever else may follow as well).

> > Do we need this if we disallow nesting events?
> > 
> 
> Yes, we need this. "event == NULL" is used as indication of invalid
> context. @event is the associated SDEI event when the context is
> valid.

What if we use some other plumbing to indicate the state of the vCPU? MP
state comes to mind, for example.

> > > +/*
> > > + * According to SDEI specification (v1.1), the event number spans 32-bits
> > > + * and the lower 24-bits are used as the (real) event number. I don't
> > > + * think we can use that much event numbers in one system. So we reserve
> > > + * two bits from the 24-bits real event number, to indicate its types:
> > > + * physical or virtual event. One reserved bit is enough for now, but
> > > + * two bits are reserved for possible extension in future.
> > > + *
> > > + * The physical events are owned by firmware while the virtual events
> > > + * are used by VMM and KVM.
> > 
> > Doesn't KVM own everything? I don't see how the guest could interact
> > with another SDEI implementation.
> > 
> 
> I might be overthinking on the scheme. The host's firmware might have
> SDEI supported and we want to propogate these events originated from
> host's firmware to guest. In this case, we need to distinguish the events
> originated from host's firmware and kvm (guest's firmware). Even this
> case isn't possible to happen, I think it's still nice to distinguish
> the events originated from a real firmware or KVM emulated firmware.

The guest ABI w.r.t. SDEI is under full ownership of KVM. Any other
implementations events will never get exposed to the guest.

Couldn't the guest own the host if it was talking to our firmware
anyway?

> > > + */
> > > +#define KVM_SDEI_EVENT_NUM_TYPE_SHIFT	22
> > > +#define KVM_SDEI_EVENT_NUM_TYPE_MASK	(3 << KVM_SDEI_EVENT_NUM_TYPE_SHIFT)
> > > +#define KVM_SDEI_EVENT_NUM_TYPE_PHYS	0
> > > +#define KVM_SDEI_EVENT_NUM_TYPE_VIRT	1
> > > +
> > > +static inline bool kvm_sdei_is_virtual(unsigned int num)
> > > +{
> > > +	unsigned int type;
> > > +
> > > +	type = (num & KVM_SDEI_EVENT_NUM_TYPE_MASK) >>
> > > +	       KVM_SDEI_EVENT_NUM_TYPE_SHIFT;
> > > +	if (type == KVM_SDEI_EVENT_NUM_TYPE_VIRT)
> > > +		return true;
> > > +
> > > +	return false;
> > > +}
> > > +
> > > +static inline bool kvm_sdei_is_sw_signaled(unsigned int num)
> > > +{
> > > +	return num == SDEI_SW_SIGNALED_EVENT;
> > > +}
> > 
> > Couldn't the caller just check the event number on their own?
> > 
> 
> It would be hard because the caller can be guest. Generally, the
> event and its associated information/state are accessed by hypercalls,
> event injection and delivery, migration to be supported in future.
> So I think it's good to check the event number by ourselves.

What I'm saying is, can't the caller of kvm_sdei_is_sw_signaled() just
do the comparison?

--
Thanks,
Oliver
