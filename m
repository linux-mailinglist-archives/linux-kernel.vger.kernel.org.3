Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BAA4E4947
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiCVWow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbiCVWos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:44:48 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA045DA00
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:43:19 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n16so13450724ile.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=drm0r/PTZ7ubOkgkGBi9eLSIu5ArVOIUaQXVPgE87AY=;
        b=XknlLv7TdmebHzy9yFDqqH0piVqt3T3ZXQ+HPYmQbGlDH4YwRxIoDgeDp0ZoZW3F72
         YFfzaMZ9DUIB32yaljw94bnXkHvQ89n8Em/xm/HJHhmPcB6QHF752z5i7+a/86fLpa9j
         xu4bKVJIwrkmosNPbwdjYsDLJBNTt9gCwhGZ4Uw2iBYPzWiYIWznX5ghaMzTWk9EvFXp
         607ye0H4LYZufAOnNPq6FQCYWNaSX4y2Cn0xIFC2Fv0gO8rnXYrKRtFP9x3vxSpZkc2P
         eKSfFlv1qXK4ryO5H+UTdsCtZm+eHJboUH8Y5YD/DCvGy5ktb52nGZN68P/8plGv2VFW
         RgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=drm0r/PTZ7ubOkgkGBi9eLSIu5ArVOIUaQXVPgE87AY=;
        b=hGZUo1gGjnoCxb1gyDAv+/uuh94zzQStIRLFID9qAdyMULE4EZ5+Qzb1ZZN5IO9xb0
         3IMcFYgBpcHZlKuzYXOVYLSi0F6D/hP8ODlVhRa9L3rxb3gUopCCyqrFhVd0t1E0X1La
         Fv6Z5yX7MyawFWRlPSTY/MqVVixwCB1q+uqftHzDSUuFVoAxIzvz6bJyluKIxd1jZYiv
         TJAqreNTG/Qr77LRwHGN17XrQ5d+AFyEWoXMfyFeJXJG3O/NSOo9PBauiXXz/euNY/kM
         nisFV6BhWIwuavuuDF/0Doitju9sOdYcBI1RmiR52FQoLmsLqrAlnt2gc1hc650kZw1i
         GqCg==
X-Gm-Message-State: AOAM532RhsfkIopVm34XRwAVTariHRXMJl1ys2GhB1nLziD9hm6p1IoN
        wmzkKK8RbimEGUrsB9Hkz9SMTA==
X-Google-Smtp-Source: ABdhPJysB8brbkgeKvnoTeVG/g7dtRmXqNObqCO/2NcRFKLsIAwo4kytaJ78kIO09+y2li+AsEYP6g==
X-Received: by 2002:a05:6e02:164b:b0:2c7:f5b9:214e with SMTP id v11-20020a056e02164b00b002c7f5b9214emr11160945ilu.188.1647988998589;
        Tue, 22 Mar 2022 15:43:18 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id w5-20020a056e021c8500b002c7f39eba1bsm9085186ill.82.2022.03.22.15.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:43:17 -0700 (PDT)
Date:   Tue, 22 Mar 2022 22:43:14 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 02/22] KVM: arm64: Add SDEI virtualization
 infrastructure
Message-ID: <YjpRArSezR3gVv2K@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-3-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-3-gshan@redhat.com>
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

Hi Gavin,

On Tue, Mar 22, 2022 at 04:06:50PM +0800, Gavin Shan wrote:
> Software Delegated Exception Interface (SDEI) provides a mechanism for
> registering and servicing system events. Those system events are high
> priority events, which must be serviced immediately. It's going to be
> used by Asynchronous Page Fault (APF) to deliver notification from KVM
> to guest. It's noted that SDEI is defined by ARM DEN0054C specification.

I'm guessing that you're using linked lists for stitching all of this
together because the specification provides for 24 bits of event
encoding. However, it seems that there will be a finite number of events
in KVM. So the APF stuff and a software signaled event.

Given that the number of events in KVM is rather small, would it make
more sense to do away with the overhead of linked lists and having the
state just represented in a static or allocated array? I think you can
cram all of the VM scoped event state into a single structure and hang
the implementation off of that.

> This introduces SDEI virtualization infrastructure where the SDEI events
> are registered and manipulated by the guest through hypercall. The SDEI
> event is delivered to one specific vCPU by KVM once it's raised. This
> introduces data structures to represent the needed objects to support
> the feature, which is highlighted as below. As those objects could be
> migrated between VMs, these data structures are partially exposed to
> user space.
> 
>    * kvm_sdei_exposed_event
>      The exposed events are determined and added by VMM through ioctl
>      interface. Only the exposed events can be registered from the
>      guest.
> 
>    * kvm_sdei_registered_event
>      The events that have been registered from the guest through the
>      SDEI_1_0_FN_SDEI_EVENT_REGISTER hypercall.
> 
>    * kvm_sdei_vcpu_event
>      The events that have been delivered to the target vCPU.
> 
>    * kvm_sdei_vcpu
>      Used to save the preempted context when the SDEI event is serviced
>      and delivered. After the SDEI event handling is completed, the
>      execution is resumed from the preempted context.
> 
>    * kvm_sdei_kvm
>      Place holder for the exposed and registered events.

It might be a good idea to expand these a bit and move them into
comments on each of the structures.

> The error of SDEI_NOT_SUPPORTED is returned for all SDEI hypercalls for
> now. They will be supported in the subsequent patches.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/kvm_host.h            |   3 +
>  arch/arm64/include/asm/kvm_sdei.h            | 171 +++++++++++++
>  arch/arm64/include/uapi/asm/kvm.h            |   1 +
>  arch/arm64/include/uapi/asm/kvm_sdei_state.h |  72 ++++++
>  arch/arm64/kvm/Makefile                      |   2 +-
>  arch/arm64/kvm/arm.c                         |   8 +
>  arch/arm64/kvm/hypercalls.c                  |  21 ++
>  arch/arm64/kvm/sdei.c                        | 244 +++++++++++++++++++
>  include/uapi/linux/arm_sdei.h                |   2 +
>  9 files changed, 523 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kvm_sdei.h
>  create mode 100644 arch/arm64/include/uapi/asm/kvm_sdei_state.h
>  create mode 100644 arch/arm64/kvm/sdei.c
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 031e3a2537fc..5d37e046a458 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -113,6 +113,8 @@ struct kvm_arch {
>  	/* Interrupt controller */
>  	struct vgic_dist	vgic;
>  
> +	struct kvm_sdei_kvm *sdei;
> +

nit: avoid repeating 'kvm'. struct kvm_sdei should be descriptive enough
:)

>  	/* Mandated version of PSCI */
>  	u32 psci_version;
>  
> @@ -338,6 +340,7 @@ struct kvm_vcpu_arch {
>  	 * Anything that is not used directly from assembly code goes
>  	 * here.
>  	 */
> +	struct kvm_sdei_vcpu *sdei;
>

nit: put your scoping tokens at the beginning of a symbol name, so
'struct kvm_vcpu_sdei'.

[...]

> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 202b8c455724..3c20fee72bb4 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -5,6 +5,7 @@
>  #include <linux/kvm_host.h>
>  
>  #include <asm/kvm_emulate.h>
> +#include <asm/kvm_sdei.h>
>  
>  #include <kvm/arm_hypercalls.h>
>  #include <kvm/arm_psci.h>
> @@ -151,6 +152,26 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
>  	case ARM_SMCCC_TRNG_RND32:
>  	case ARM_SMCCC_TRNG_RND64:
>  		return kvm_trng_call(vcpu);
> +	case SDEI_1_0_FN_SDEI_VERSION:
> +	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
> +	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
> +	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
> +	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
> +	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
> +	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
> +	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
> +	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
> +	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
> +	case SDEI_1_0_FN_SDEI_EVENT_ROUTING_SET:
> +	case SDEI_1_0_FN_SDEI_PE_MASK:
> +	case SDEI_1_0_FN_SDEI_PE_UNMASK:
> +	case SDEI_1_0_FN_SDEI_INTERRUPT_BIND:
> +	case SDEI_1_0_FN_SDEI_INTERRUPT_RELEASE:
> +	case SDEI_1_1_FN_SDEI_EVENT_SIGNAL:
> +	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
> +	case SDEI_1_0_FN_SDEI_SHARED_RESET:
> +	case SDEI_1_1_FN_SDEI_FEATURES:

Consider only adding switch statements for hypercalls when they're
actually implemented.

Additionally, while this isn't directly related to your patch, I do have
a gripe about kvm_hvc_call_handler(). It is really ugly that we
enumerate the specific hypercalls we support, and otherwise fall through
to PSCI.

IMO, a cleaner approach would be to have kvm_hvc_call_handler() simply
route a particular service range/service owner to the appropriate
handler. We can then terminate individual hypercalls in those handlers,
avoiding a catch-all switch such as this one is currently.

--
Thanks,
Oliver
