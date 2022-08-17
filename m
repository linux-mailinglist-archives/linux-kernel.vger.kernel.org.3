Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769D95970C3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiHQOLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbiHQOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E92A738
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660745424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hygZeITYKaN6tWwzgaB+JBZJRP0ECIzs8aj0xsU3pQI=;
        b=NG8bEuVrY3ssRa700q0fwx0JgeK1sfYYThy4kTq6iCJ51KEivlp0/z/71sI2rJZ730zXuh
        ZBP5UTrRSJt5Mz3QYWKz7rggmJoK/PQR7NOsPHfbsEWVhRopJXeXFCuwag+VqzJ4WO8qoB
        i+EkYv3Vkf6/Rp42iLuaZQwWQqo34io=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-7vBE5DO_MLCeE7I5_P7LBA-1; Wed, 17 Aug 2022 10:10:23 -0400
X-MC-Unique: 7vBE5DO_MLCeE7I5_P7LBA-1
Received: by mail-wr1-f70.google.com with SMTP id o3-20020adfa103000000b0022514e8e99bso1135148wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=hygZeITYKaN6tWwzgaB+JBZJRP0ECIzs8aj0xsU3pQI=;
        b=UdM6oApezqW5CXYeAh0v2yMEdXCX70xiqwy54MlKTlVovsAEdvkWJL3a694sVF+0zg
         finsNNLmnd4N6ay2v1Q4Ff+mAJRmfUBq4PkScCwHp0oo9gdZpvYhHyY44cTp+aohq76n
         tsjuT99mJW3QUgeqZvLhCnhqnatRJHIMPPFyPS+XqEPJAS70oo5Tjldq+3cb+IsPQGdJ
         gNoluvT0FViHZchX/NJ2BjpezW2kdO1LXNuahUkFFXn9zzKV106ju2YJpF2Ri/hkvf7n
         L1/oOXb5kgM1PjMYmnTrMQfu0FvV1Plgg7VrV6u5iHCqyd3ptR2L5SxGmRvnPJl+Vogh
         mRxw==
X-Gm-Message-State: ACgBeo0o13CQjFtXwNeYM5zw6etatnbZHsRPcJALkrSribl7XoEkJBs3
        ibHIsl2fDuBL8i2RX8bDlzqRHFFRb/kIJ8GfCq7rOxk7adYxrdySgk9XnHsbyTkY1m7JHML6R22
        SQkQ5nsplP61lBo5Cat9js0dC
X-Received: by 2002:a05:6000:144a:b0:220:7181:9283 with SMTP id v10-20020a056000144a00b0022071819283mr13854033wrx.158.1660745422093;
        Wed, 17 Aug 2022 07:10:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR71JHkv660Ed2nt0u4G8tifr++EbajKsB7yItwYP1910fKANnnUzWMF9SuDBpp3iYFox6lnWg==
X-Received: by 2002:a05:6000:144a:b0:220:7181:9283 with SMTP id v10-20020a056000144a00b0022071819283mr13854016wrx.158.1660745421825;
        Wed, 17 Aug 2022 07:10:21 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id s4-20020adfdb04000000b002211fc70174sm15181404wri.99.2022.08.17.07.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:10:21 -0700 (PDT)
Message-ID: <17d647aa55db14435a88b48f11ab62bb59831935.camel@redhat.com>
Subject: Re: [PATCH v2 2/9] KVM: x86: remove return value of kvm_vcpu_block
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
Date:   Wed, 17 Aug 2022 17:10:19 +0300
In-Reply-To: <Yvwpb6ofD1S+Rqk1@google.com>
References: <20220811210605.402337-1-pbonzini@redhat.com>
         <20220811210605.402337-3-pbonzini@redhat.com> <Yvwpb6ofD1S+Rqk1@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-08-16 at 23:34 +0000, Sean Christopherson wrote:
> On Thu, Aug 11, 2022, Paolo Bonzini wrote:
> > The return value of kvm_vcpu_block will be repurposed soon to return
> 
> kvm_vcpu_block()
> 
> > the state of KVM_REQ_UNHALT.  In preparation for that, get rid of the
> > current return value.  It is only used by kvm_vcpu_halt to decide whether
> 
> kvm_vcpu_halt()
> 
> > the call resulted in a wait, but the same effect can be obtained with
> > a single round of polling.
> > 
> > No functional change intended, apart from practically indistinguishable
> > changes to the polling behavior.
> 
> This "breaks" update_halt_poll_stats().  At the very least, it breaks the comment
> that effectively says "waited" is set if and only if schedule() is called.
> 
>         /*
>          * Note, halt-polling is considered successful so long as the vCPU was
>          * never actually scheduled out, i.e. even if the wake event arrived
>          * after of the halt-polling loop itself, but before the full wait.
>          */
>         if (do_halt_poll)
>                 update_halt_poll_stats(vcpu, start, poll_end, !waited);
> 
> > @@ -3493,35 +3489,32 @@ void kvm_vcpu_halt(struct kvm_vcpu *vcpu)
> >  {
> >         bool halt_poll_allowed = !kvm_arch_no_poll(vcpu);
> >         bool do_halt_poll = halt_poll_allowed && vcpu->halt_poll_ns;
> > -       ktime_t start, cur, poll_end;
> > +       ktime_t start, cur, poll_end, stop;
> >         bool waited = false;
> >         u64 halt_ns;
> >  
> >         start = cur = poll_end = ktime_get();
> > -       if (do_halt_poll) {
> > -               ktime_t stop = ktime_add_ns(start, vcpu->halt_poll_ns);
> > +       stop = do_halt_poll ? start : ktime_add_ns(start, vcpu->halt_poll_ns);
> 
> This is inverted, the loop should terminate after the first iteration (stop==start)
> if halt-polling is _not_ allowed, i.e. do_halt_poll is false.
> 
> Overall, I don't like this patch.  I don't necessarily hate it, but I definitely
> don't like it.

Roughtly same opinion here.

> 
> Isn't freeing up the return from kvm_vcpu_check_block() unnecessary?  Can't we
> just do:
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9f11b505cbee..ccb9f8bdeb18 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10633,7 +10633,7 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
>                 if (hv_timer)
>                         kvm_lapic_switch_to_hv_timer(vcpu);
> 
> -               if (!kvm_check_request(KVM_REQ_UNHALT, vcpu))
> +               if (!kvm_arch_vcpu_runnable(vcpu))


The 'kvm_vcpu_block()' returns when 'kvm_vcpu_check_block()' returns a negative number
which can happen also due to pending apic timer / signal, however it only sets the
'KVM_REQ_UNHALT' only when 'kvm_arch_vcpu_runnable()==true' so the above does make
sense.


Best regards,
 Maxim Levitsky


>                         return 1;
>         }
> 
> 
> which IMO is more intuitive and doesn't require reworking halt-polling (again).
> 
> I don't see why KVM cares if a vCPU becomes runnable after detecting that something
> else caused kvm_vcpu_check_block() to bail.  E.g. a pending signal doesn't invalidate
> a pending vCPU event, and either way KVM is bailing from the run loop.
> 


