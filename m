Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF12A589D4C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240028AbiHDOPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiHDOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 092E42AE11
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659622500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uKa0k1pu8bSknr94zUVvK1qOtcTwaJejfGYE5WdbSpk=;
        b=Q6CcS/B1QM/KTspo/ar+z5njHpVMYTPrkVbJBlmKQFaAD3wotwSmj7B1xIddfYSmSiM2qz
        aoO5v2WgEVJJg1WCNUJ94iV9tmcVC3HMk4YKRPrENbz2nwOI4a8t+CBnIUHf5iWvsFG8Eh
        SOb29AwzlF3LHJNguQNv2cyzNKfclx8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-_FeozLbWMPi0l64NKFcKiQ-1; Thu, 04 Aug 2022 10:14:59 -0400
X-MC-Unique: _FeozLbWMPi0l64NKFcKiQ-1
Received: by mail-ed1-f70.google.com with SMTP id o2-20020a056402438200b0043d552deb2aso9387737edc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 07:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=uKa0k1pu8bSknr94zUVvK1qOtcTwaJejfGYE5WdbSpk=;
        b=lMH1Srom0X8Mn4wuZiAqTzWGNLNLymIH4vfbf72vm4lb79i9v3Vto8qshlQ1m0G4Rq
         +gVtAHhlVi+n/Vulpt0p58QezqMLtXqFNWd4Xorbui/Ls9RaJ8izD58d8CQKDx2/UiRr
         n7ioQuO0UAzFN4qkwd8yqez/gSHYdWjnyiO6fmFUv5xwmO4Q5yKHHG7Jj8Jg+FtIycTb
         ejA59Dl2czT85RkDThP+1bjYJz9yzUrI9C5KLz/XpJ3wcpTlYTYhWHLdoQjSvlMCdxjC
         81PBuj9Sl7ryfkTVUjpC/gmrOHr44QaqRbS36FRo3E1zzC8bp5YsDclg72DUMi1nJ1h6
         Gnug==
X-Gm-Message-State: ACgBeo3WnGBLdLUei0kAC9kCwJUrXRjguLaZ8pNu1N0ZF8tqvLtkmbWJ
        3xnyxsGmizSL5E0zl1b4JGChXjE0DEXbOjncn7soifqWF1i5tpC9Rm1m2qyaYimEVy5KnpnlXKC
        QANmGSS/a3f4yxPnH8dJrEv+1
X-Received: by 2002:a05:6402:194d:b0:43d:8001:984b with SMTP id f13-20020a056402194d00b0043d8001984bmr2219029edz.327.1659622497863;
        Thu, 04 Aug 2022 07:14:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4DAfrIrLDdirj9qVvkYfz4MEN/Yj/dOocisAMkW2NI4/B73cfFiqA0kXnCUrMQSun8V3VYKg==
X-Received: by 2002:a05:6402:194d:b0:43d:8001:984b with SMTP id f13-20020a056402194d00b0043d8001984bmr2219010edz.327.1659622497649;
        Thu, 04 Aug 2022 07:14:57 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q17-20020aa7d451000000b0043d7ff1e3bcsm728723edr.72.2022.08.04.07.14.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 07:14:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     dgilbert@redhat.com, David Woodhouse <dwmw@amazon.co.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: do not report preemption if the steal time
 cache is stale
In-Reply-To: <20220804140406.1335587-1-pbonzini@redhat.com>
References: <20220804140406.1335587-1-pbonzini@redhat.com>
Date:   Thu, 04 Aug 2022 16:14:55 +0200
Message-ID: <87sfmcyu1s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Commit 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time
> / preempted status", 2021-11-11) open coded the previous call to
> kvm_map_gfn, but in doing so it dropped the comparison between the cached
> guest physical address and the one in the MSR.  This cause an incorrect
> cache hit if the guest modifies the steal time address while the memslots
> remain the same.  This can happen with kexec, in which case the preempted
> bit is written at the address used by the old kernel instead of
> the old one.
>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: stable@vger.kernel.org
> Fixes: 7e2175ebd695 ("KVM: x86: Fix recording of guest steal time / preempted status")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

No need to S-o-b twice)

> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 0f3c2e034740..8ee4698cb90a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4715,6 +4715,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
>  	struct kvm_steal_time __user *st;
>  	struct kvm_memslots *slots;
>  	static const u8 preempted = KVM_VCPU_PREEMPTED;
> +	gpa_t gpa = vcpu->arch.st.msr_val & KVM_STEAL_VALID_BITS;
>  
>  	/*
>  	 * The vCPU can be marked preempted if and only if the VM-Exit was on
> @@ -4742,6 +4743,7 @@ static void kvm_steal_time_set_preempted(struct kvm_vcpu *vcpu)
>  	slots = kvm_memslots(vcpu->kvm);
>  
>  	if (unlikely(slots->generation != ghc->generation ||
> +		     gpa != ghc->gpa ||
>  		     kvm_is_error_hva(ghc->hva) || !ghc->memslot))

(We could probably have a common helper for both these places.)

>  		return;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

