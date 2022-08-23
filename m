Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0979B59D23A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbiHWHdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiHWHdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692D463F28
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661239988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ONerqKdocOJl27KKdUeRrTYuQ3xXPZVssG9HygGkPU=;
        b=ioVmC1BjBG8qiakSBvgdDG3og/0EHFe2H6RyYTpKABZ/Tf393YfXJlcJuFkM3W0YUPmFwy
        /Qg4F2wfNqVvHxinRfA2xtXOuHTHsefVHO1Sf6s9PqGsqjZ4hACw3wLYCvC5/hyz4xUOIX
        MUCbk3GpA2tEwP7drXr34BWv1W0ZcHw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-189-6GIhdz5IMT6sUC3EXeH7wg-1; Tue, 23 Aug 2022 03:33:07 -0400
X-MC-Unique: 6GIhdz5IMT6sUC3EXeH7wg-1
Received: by mail-wr1-f69.google.com with SMTP id g11-20020adfa48b000000b002250d091f76so2021187wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=2ONerqKdocOJl27KKdUeRrTYuQ3xXPZVssG9HygGkPU=;
        b=iTBZ6JmWvvesy7h3XUS4xDUHK1f9p4LwjwRFFNFka4JRE48AZBCzuJnKw7fJcAauj/
         DgR3oqQwhnhUCkFxYOBMdL3qo2NyZZlTclZwlFNoOb3KhBP7E1J12aMvWxx2L+SebwVw
         PVT2fjZPlkrgf9n4NceIhCvIcxSJ9DAQM56cakpsyZ1FquUa7LtE30TGdALFfmmd4gFI
         EOsylrBd2SCxER0/o6+bbssNOvDTm/BZxAKQuEVwXfsuh1v/E4fGuvNmsNQ/EawnFkra
         1r68wLCeKFbfxm2tKqTQllFvPUPkmftyB3zhhUzQ7PhU01RyXvwZ+CLyVHulvpO9Elv0
         eTkw==
X-Gm-Message-State: ACgBeo0hIxmaaSdy1J0VL6g4JVpa+OFvRRX0DIOY+kUJskCzxF0Qs4il
        x8PAZvR1Lm8M0RH03pMF6geKQhrT4LYa1RXJ2suWgFXe9QyPjJ/5gLfKmEDUqCuBpyh8x/LBNzU
        Nc2X38Xv9+7ObJdtwMjkVXdFmfXdVCwvddpfga7uaKoGj7zSX6JyBvxRel2VEPWJ7YJUucn31IM
        q1
X-Received: by 2002:adf:e18b:0:b0:225:644c:59c2 with SMTP id az11-20020adfe18b000000b00225644c59c2mr1763291wrb.673.1661239986501;
        Tue, 23 Aug 2022 00:33:06 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6hwzHxlbGc8XuBX/h1Dx9/8oX54010sDfiLiygEgsGTbYt//zKkeH4Afdfph4nQolz745tNQ==
X-Received: by 2002:adf:e18b:0:b0:225:644c:59c2 with SMTP id az11-20020adfe18b000000b00225644c59c2mr1763265wrb.673.1661239986213;
        Tue, 23 Aug 2022 00:33:06 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p15-20020adfcc8f000000b002252ec781f7sm13612694wrj.8.2022.08.23.00.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:33:05 -0700 (PDT)
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
In-Reply-To: <YwPLt2e7CuqMzjt1@google.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
 <20220802160756.339464-4-vkuznets@redhat.com>
 <Yv5ZFgztDHzzIQJ+@google.com> <875yiptvsc.fsf@redhat.com>
 <Yv59dZwP6rNUtsrn@google.com> <87czcsskkj.fsf@redhat.com>
 <YwOm7Ph54vIYAllm@google.com> <87edx8xn8h.fsf@redhat.com>
 <YwO2fSCGXnE/9mc2@google.com> <878rngxjb7.fsf@redhat.com>
 <YwPLt2e7CuqMzjt1@google.com>
Date:   Tue, 23 Aug 2022 09:33:04 +0200
Message-ID: <87wnazwh1r.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
>> >> My initial implementation was inventing 'eVMCS revision' concept:
>> >> https://lore.kernel.org/kvm/20220629150625.238286-7-vkuznets@redhat.com/
>> >> 
>> >> which is needed if we don't gate all these new fields on CPUID.0x4000000A.EBX BIT(0).
>> >> 
>> >> Going forward, we will still (likely) need something when new fields show up.
>> >
>> > My comments from that thread still apply.  Adding "revisions" or feature flags
>> > isn't maintanable, e.g. at best KVM will end up with a ridiculous number of flags.
>> >
>> > Looking at QEMU, which I strongly suspect is the only VMM that enables
>> > KVM_CAP_HYPERV_ENLIGHTENED_VMCS, it does the sane thing of enabling the capability
>> > before grabbing the VMX MSRs.
>> >
>> > So, why not simply apply filtering for host accesses as well?
>> 
>> (I understand that using QEMU to justify KVM's behavior is flawed but...)
>> 
>> QEMU's migration depends on the assumption that identical QEMU's command
>> lines create identical (from guest PoV) configurations. Assume we have
>> (simplified)
>> 
>> "-cpu CascadeLake-Sever,hv-evmcs"
>> 
>> on both source and destination but source host is newer, i.e. its KVM
>> knows about TSC Scaling in eVMCS and destination host has no idea about
>> it. If we just apply filtering upon vCPU creation, guest visible MSR
>> values are going to be different, right? Ok, assuming QEMU also migrates
>> VMX feature MSRs (TODO: check if that's true), we will be able to fail
>> mirgration late (which is already much worse than not being able to
>> create the desired configuration on destination, 'fail early') if we use
>> in-KVM filtering to throw an error to userspace. But if we blindly
>> filter control MSRs on the destination, 'TscScaling' will just disapper
>> undreneath the guest. This is unlikely to work.
>
> But all of that holds true irrespetive of eVMCS.  If QEMU attempts to migrate a
> nested guest from a KVM that supports TSC_SCALING to a KVM that doesn't support
> TSC_SCALING, then TSC_SCALING is going to disappear and VM-Entry on the dest will
> fail.  I.e. QEMU _must_ be able to detect the incompatibility and not attempt
> the migration.  And with that code in place, QEMU doesn't need to do anything new
> for eVMCS, it Just Works.

I'm obviously missing something. "-cpu CascadeLake-Sever" presumes
cetain features, including VMX features (e.g. TSC_SCALING), an attempt
to create such vCPU on a CPU which doesn't support it will lead to
immediate failure. So two VMs created on different hosts with

-cpu CascadeLake-Sever

are guaranteed to look exactly the same from guest PoV. This is not true
for '-cpu CascadeLake-Sever,hv-evmcs' (if we do it the way you suggest)
as 'hv-evmcs' will be a *different* filter on each host (which is going
to depend on KVM version, not even on the host's hardware).

>
>> In any case, what we need, is an option for VMM (read: QEMU) to create
>> the configuration with 'TscScaling' filtered out even KVM supports the
>> bit in eVMCS. This way the guest will be able to migrate backwards to an
>> older KVM which doesn't support it, i.e.
>> 
>> '-cpu CascadeLake-Sever,hv-evmcs'
>>  creates the 'origin' eVMCS configuration, no TscScaling
>> 
>> '-cpu CascadeLake-Sever,hv-evmcs,hv-evmcs-2022' creates the updated one.
>
> Again, this conundrum exists irrespective of eVMCS.  Properly solve the problem
> for regular nVMX and eVMCS should naturally work.

I don't think we have this problem for VMX features as named CPU models
in QEMU encode all of them explicitly, they *must* be present whenever
such vCPU is created.

>
>> KVM_CAP_HYPERV_ENLIGHTENED_VMCS is bad as it only takes 'eVMCS' version
>> as a parameter (as we assumed it will always change when new fields are
>> added, but that turned out to be false). That's why I suggested
>> KVM_CAP_HYPERV_ENLIGHTENED_VMCS2.
>
> Enumerating features via versions is such a bad API though, e.g. if there's a
> bug with nested TSC_SCALING, userspace can't disable just nested TSC_SCALING
> without everything else under the inscrutable "hv-evmcs-2022" being collateral
> damage.

Why? Something like 

"-cpu CascadeLake-Sever,hv-evmcs,hv-evmcs-2022,-vmx-tsc-scaling" 

should work well, no? 'hv-evmcs*' are just filters, if the VMX feature
is not there -- it's not there.

We can certainly make this fine-grained and introduce
KVM_CAP_HYPERV_EVMCS_TSC_SCALING instead and make a 'hv-*' flag for it,
however, with Hyper-V and Windows I really don't like 'frankenstein'
Hyper-V configurations which look nothing like genuine Hyper-V as nobody
at Microsoft tests new Windows builds with such configurations. And yes,
bugs were discovered in the past (e.g. PerfGlobalCtrl and Win11).

-- 
Vitaly

