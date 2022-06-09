Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C55444FD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 09:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbiFIHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiFIHkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1C751AF1F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654760433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HBuT8LFJwROeCZP4IF58tzngJRh3BhcTlm83VA6fvFc=;
        b=WFc2wjH5aQevHwr3vPXgbRHZdoA+yYUpncljw514d4NNPaEh6MbHi3sFBNrBqVTkxqI/mU
        UFuztfVvQIMjf67qRXTHC4q1XLkuW4lLU3jdwIEZPqE7g9Z3VGcp6nVUenew83egYgRbOu
        33+nxSdHn/MiQj3DU2ZxVpH9nKMDmps=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-7b7vJ4eHOCKWhJzVUjLrpw-1; Thu, 09 Jun 2022 03:40:31 -0400
X-MC-Unique: 7b7vJ4eHOCKWhJzVUjLrpw-1
Received: by mail-wm1-f69.google.com with SMTP id o2-20020a05600c510200b0039747b0216fso15644850wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBuT8LFJwROeCZP4IF58tzngJRh3BhcTlm83VA6fvFc=;
        b=g9svI8lZt/usHAxDJPakbo9O7t/czKDuElfb/Dsin1aJtTviVVhpBHXjezkzJlW8A9
         1QqiAwANb8XJTRv8BFdYt7iKcnsYAK7VpS2XHqp3Kozeykwlkp1P0Qpor76LKp6k3Pzh
         w+7XtW1Tm/2woceZJdjpSZplsmVpXfdaGwXJSuYkHCyZsxZvHAV/q/aChOXbUTs5Vo6T
         meb4qsw9hw8xXjPN9+Vt+DyGBPMDdYxZSC2I9/dYqpktTGT8RUWON0+saNQgAtpmpmsa
         jSGN8CgSw/Y/6IcBEILoilFhX0jGk7bcUo8H1odsjP7ajOeQmP35SIOdvxVsTw35W6Bb
         NeXA==
X-Gm-Message-State: AOAM531z7ORuXgvpEVRr4LvxD4iKStINQp8Iyharmq8n9ff4RVA19/jK
        NCSbxRZE4PTVIQSB1yJtnR8U+eMaLKkDNgbwUzvY+po0DMMwsc+bpx0f2QcTKV58/zmAvxx0kIw
        L0EaYsR4VEN+El/iX/4j7H80j
X-Received: by 2002:a05:6000:15c3:b0:216:7c87:9f4f with SMTP id y3-20020a05600015c300b002167c879f4fmr25488107wry.160.1654760430684;
        Thu, 09 Jun 2022 00:40:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyB2+R+t8EounNd5T08dWhvgRidgMX1btQr8TcNmUNuAataAzxl6fU9Leh2WdmnMN+EONSvLA==
X-Received: by 2002:a05:6000:15c3:b0:216:7c87:9f4f with SMTP id y3-20020a05600015c300b002167c879f4fmr25488083wry.160.1654760430502;
        Thu, 09 Jun 2022 00:40:30 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id k1-20020a1ca101000000b0039c4ff5e0a7sm11917679wme.38.2022.06.09.00.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 00:40:29 -0700 (PDT)
Date:   Thu, 9 Jun 2022 09:40:27 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        anup@brainfault.org, Raghavendra Rao Ananta <rananta@google.com>,
        eric.auger@redhat.com
Subject: Re: [PATCH v2 000/144] KVM: selftests: Overhaul APIs, purge VCPU_ID
Message-ID: <20220609074027.fntbvcgac4nroy35@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <21570ac1-e684-7983-be00-ba8b3f43a9ee@redhat.com>
 <93b87b7b5a599c1dfa47ee025f0ae9c4@kernel.org>
 <YqEupumS/m5IArTj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqEupumS/m5IArTj@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 11:20:06PM +0000, Sean Christopherson wrote:
> On Wed, Jun 08, 2022, Marc Zyngier wrote:
> > On 2022-06-07 16:27, Paolo Bonzini wrote:
> > > Marc, Christian, Anup, can you please give this a go?
> > 
> > Can you please, pretty please, once and for all, kill that alias you
> > seem to have for me and  email me on an address I actually can read?
> > 
> > I can't remember how many times you emailed me on my ex @arm.com address
> > over the past 2+years...
> > 
> > The same thing probably applies to Sean, btw.
> 
> Ha!  I was wondering how my old @intel address snuck in...
> 
> On the aarch64 side, with the following tweaks, courtesy of Raghu, all tests
> pass.  I'll work these into the next version, and hopefully also learn how to
> run on aarch64 myself...
> 
> Note, the i => 0 "fix" in test_v3_typer_accesses() is a direct revert of patch 3,
> "KVM: selftests: Fix typo in vgic_init test".  I'll just drop that patch unless
> someone figures out why doing the right thing causes the test to fail.

CCing Eric for that one.

> 
> diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> index b91ea02a8a80..66b7e9c76370 100644
> --- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
> +++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
> @@ -317,7 +317,7 @@ static void test_vgic_then_vcpus(uint32_t gic_dev_type)
> 
>         /* Add the rest of the VCPUs */
>         for (i = 1; i < NR_VCPUS; ++i)
> -               vm_vcpu_add(v.vm, i, guest_code);
> +               vcpus[i] = vm_vcpu_add(v.vm, i, guest_code);
> 
>         ret = run_vcpu(vcpus[3]);
>         TEST_ASSERT(ret == -EINVAL, "dist/rdist overlap detected on 1st vcpu run");
> @@ -424,7 +424,7 @@ static void test_v3_typer_accesses(void)
>                             KVM_DEV_ARM_VGIC_CTRL_INIT, NULL);
> 
>         for (i = 0; i < NR_VCPUS ; i++) {
> -               ret = v3_redist_reg_get(v.gic_fd, i, GICR_TYPER, &val);
> +               ret = v3_redist_reg_get(v.gic_fd, 0, GICR_TYPER, &val);
>                 TEST_ASSERT(!ret && !val, "read GICR_TYPER before rdist region setting");
>         }
> 
> @@ -654,11 +654,12 @@ static void test_v3_its_region(void)
>   */
>  int test_kvm_device(uint32_t gic_dev_type)
>  {
> +       struct kvm_vcpu *vcpus[NR_VCPUS];
>         struct vm_gic v;
>         uint32_t other;
>         int ret;
> 
> -       v.vm = vm_create_with_vcpus(NR_VCPUS, guest_code, NULL);
> +       v.vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
> 
>         /* try to create a non existing KVM device */
>         ret = __kvm_test_create_device(v.vm, 0);
> diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> index b3116c151d1c..17f7ef975d5c 100644
> --- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
> @@ -419,7 +419,7 @@ static void run_test(struct vcpu_config *c)
> 
>         check_supported(c);
> 
> -       vm = vm_create_barebones();
> +       vm = vm_create(1);

Hmm, looks like something, somewhere for AArch64 needs improving to avoid
strangeness like this. I'll look into it after we get this series merged.

>         prepare_vcpu_init(c, &init);
>         vcpu = aarch64_vcpu_add(vm, 0, &init, NULL);
>         finalize_vcpu(vcpu, c);
> 

Thanks,
drew

