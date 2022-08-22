Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576FD59C553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 19:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiHVRqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 13:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbiHVRqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 13:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C96D42AE2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661190400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZqNPxOW6/Z1nyZu1pP3yQJS1/OLwcE0QShEsvXZLgk=;
        b=VnrQ4DEshkJ5J2BbEeouiVUuLO0hda1mgRGUZntU/XWGIZhtlkJkSLkEZksrh6giU160iJ
        XF3sv4fQllz+atfEWtxUmj6z4N7I/l8oxgy1TCW0uRjSQkYZyCq+iB7M/rTZAILfxNAf5i
        PqEfAXlTqg1p4REbvLWI9BKEvVgfGGA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-CAHjV9K_OzqsHmY96QM6Wg-1; Mon, 22 Aug 2022 13:46:39 -0400
X-MC-Unique: CAHjV9K_OzqsHmY96QM6Wg-1
Received: by mail-wm1-f70.google.com with SMTP id az42-20020a05600c602a00b003a552086ba9so8962271wmb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 10:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=9ZqNPxOW6/Z1nyZu1pP3yQJS1/OLwcE0QShEsvXZLgk=;
        b=TA3FfSSYVY3y+Ib8F76FxnLJ1419ch+MXtEh8JP420A4AQhu5ymDHJghdoIVbtV0mk
         HqyfkD2vs+xFv+5L4t8NjoOA0ZJva2XgwwamikmxKM6OeGza+dWneZQFp1U8Rde8Bi+x
         dmlHYQkBZxQzpUzuDOkINJqjFJRgyudUoqPh2GxOo2Jrsi3Fsf2G5nO7nGqUc7H7Giz0
         4sK7COs66dataole9DIQjN7zKcd6jIED/CtmAT39Hz+wox+/nQHWsRJyX7BoDzUElgr5
         CG99zI73Qxe09ohXZt3slZs4pbK29qEIFBruPa8kA9RoqKta1jwlr8OpmkWhHnsCrB1n
         bbUQ==
X-Gm-Message-State: ACgBeo3sdUsVQrtrTawJDhY3B6AkyC1P1Dg17AwafmrSYS92dIRuO0vh
        sXGK73eF/ZslXlb5mrffA8Jv9CIs7GPR0m9egTRXnpuARZM7+YINBlBExgBKWqJYB7dKSTFhvoh
        emy+cNIsIcM9dD1Vh2nudmYV5XpdDzmi4FWB493N9OJlaeKwCXqC3a/T5WyTDLwEQrgYdRbUg5k
        JY
X-Received: by 2002:adf:d087:0:b0:225:2252:3af2 with SMTP id y7-20020adfd087000000b0022522523af2mr11512738wrh.388.1661190398301;
        Mon, 22 Aug 2022 10:46:38 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7jiV976Yo7TNn7SodyrZFTHHlogswgXa2tPpG2vzIO+Y8GHf+0gwUe7HGRtA3Cc5ZsVLlZnA==
X-Received: by 2002:adf:d087:0:b0:225:2252:3af2 with SMTP id y7-20020adfd087000000b0022522523af2mr11512715wrh.388.1661190397930;
        Mon, 22 Aug 2022 10:46:37 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b18-20020a5d6352000000b002252751629dsm12060926wrw.24.2022.08.22.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 10:46:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/26] x86/hyperv: Update 'struct
 hv_enlightened_vmcs' definition
In-Reply-To: <YwO2fSCGXnE/9mc2@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com> <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com> <87czcsskkj.fsf@redhat.com>
 <YwOm7Ph54vIYAllm@google.com> <87edx8xn8h.fsf@redhat.com>
 <YwO2fSCGXnE/9mc2@google.com>
Date:   Mon, 22 Aug 2022 19:46:36 +0200
Message-ID: <878rngxjb7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Mon, Aug 22, 2022, Vitaly Kuznetsov wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>> 
>> > On Mon, Aug 22, 2022, Vitaly Kuznetsov wrote:
>> >> So I reached out to Microsoft and their answer was that for all these new
>> >> eVMCS fields (including *PerfGlobalCtrl) observing architectural VMX
>> >> MSRs should be enough. *PerfGlobalCtrl case is special because of Win11
>> >> bug (if we expose the feature in VMX feature MSRs but don't set
>> >> CPUID.0x4000000A.EBX BIT(0) it just doesn't boot).
>> >
>> > I.e. TSC_SCALING shouldn't be gated on the flag?  If so, then the 2-D array approach
>> > is overkill since (a) the CPUID flag only controls PERF_GLOBAL_CTRL and (b) we aren't
>> > expecting any more flags in the future.
>> >
>> 
>> Unfortunately, we have to gate the presence of these new features on
>> something, otherwise VMM has no way to specify which particular eVMCS
>> "revision" it wants (TL;DR: we will break migration).
>> 
>> My initial implementation was inventing 'eVMCS revision' concept:
>> https://lore.kernel.org/kvm/20220629150625.238286-7-vkuznets@redhat.com/
>> 
>> which is needed if we don't gate all these new fields on CPUID.0x4000000A.EBX BIT(0).
>> 
>> Going forward, we will still (likely) need something when new fields show up.
>
> My comments from that thread still apply.  Adding "revisions" or feature flags
> isn't maintanable, e.g. at best KVM will end up with a ridiculous number of flags.
>
> Looking at QEMU, which I strongly suspect is the only VMM that enables
> KVM_CAP_HYPERV_ENLIGHTENED_VMCS, it does the sane thing of enabling the capability
> before grabbing the VMX MSRs.
>
> So, why not simply apply filtering for host accesses as well?

(I understand that using QEMU to justify KVM's behavior is flawed but...)

QEMU's migration depends on the assumption that identical QEMU's command
lines create identical (from guest PoV) configurations. Assume we have
(simplified)

"-cpu CascadeLake-Sever,hv-evmcs"

on both source and destination but source host is newer, i.e. its KVM
knows about TSC Scaling in eVMCS and destination host has no idea about
it. If we just apply filtering upon vCPU creation, guest visible MSR
values are going to be different, right? Ok, assuming QEMU also migrates
VMX feature MSRs (TODO: check if that's true), we will be able to fail
mirgration late (which is already much worse than not being able to
create the desired configuration on destination, 'fail early') if we use
in-KVM filtering to throw an error to userspace. But if we blindly
filter control MSRs on the destination, 'TscScaling' will just disapper
undreneath the guest. This is unlikely to work.

In any case, what we need, is an option for VMM (read: QEMU) to create
the configuration with 'TscScaling' filtered out even KVM supports the
bit in eVMCS. This way the guest will be able to migrate backwards to an
older KVM which doesn't support it, i.e.

'-cpu CascadeLake-Sever,hv-evmcs'
 creates the 'origin' eVMCS configuration, no TscScaling

'-cpu CascadeLake-Sever,hv-evmcs,hv-evmcs-2022' creates the updated one.

KVM_CAP_HYPERV_ENLIGHTENED_VMCS is bad as it only takes 'eVMCS' version
as a parameter (as we assumed it will always change when new fields are
added, but that turned out to be false). That's why I suggested
KVM_CAP_HYPERV_ENLIGHTENED_VMCS2.

For the issue at hand, 'hv-evmcs-2022' can just set CPUID.0x4000000A.EBX
BIT(0) and then we gate all new fields' existence on it. It doesn't
matter much if we filter host accesses or not in this scheme.

Going all the way back, I'd certainly made the filtering apply to host
writes throwing an error when eVMCS is enabled (and I'd made it per-VM
and mandate that it is enabled prior to getting MSRs) but that doesn't
seem to help us much now.

-- 
Vitaly

