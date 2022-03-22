Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BD84E4980
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbiCVXHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiCVXHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:07:37 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394886EB17
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:06:09 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id z6so12467032iot.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21fg6XWhU71tdjvtfle0AJij7OP2A2tXWl2jGQhNfvU=;
        b=WmVfjk0ZQjejqSijckp6Pw+yiFEK2WgK97TPc650R9vz61ruco/HdtN/loRXvj/fZY
         TpoYto7Qkfc1WWv0Kti0nvVS1+cIHPLHqziHvknk/NGBdxjXGOKeJWQ6fv/cimzX4qSU
         uTZtPGjqDZ2AJlTc0y0m2g0n/rlQHpTeeDGGRjAqhE/F4aWTp/km/QlYmiEUMjDGBwpt
         AOU+vDFwhqaG7US7+OvkH+hM6ITRrhBhvOWg9CqaHdcMwBAYyOWx8zN+DUL9eAFkIo/F
         smHrN1GRopkkH4wgH+6RD3BzpK6hfOMC8wSDZWFguX3hupusBLvAls19QuRtGUoaTIqK
         SUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21fg6XWhU71tdjvtfle0AJij7OP2A2tXWl2jGQhNfvU=;
        b=B6fVYhB6GvRFRN+E53sAAjFDPygHxYe18+1Gvv19j+fTJ1Bohdqo7IVyVm/2hWbN95
         iV0SoeCYtMJfJujx4UnW9yhLn9OC1nLQDblBr0drns4SYU1DCI6neRagKotsjPw1TlJd
         x89GQayRx2Mw9KzvvDIZFiXg1RMO9F4F7mfJgsxeQHtuUHSSqAoxNgMmiY0o84EixzwG
         MQGML5YEf6nq26tmnyzGPcn0SGa06GaKB7ypL3lC51ALCyIbeuH3Xy8actr7z6Kb4zEZ
         SUcj+WgK7U8PAGWX6/VEh2nJRQ8nG7Jj3tyLi5MAQAqTdIclFfugx+n04vpP68FltkUZ
         kMlw==
X-Gm-Message-State: AOAM531ZTW+gpEd6rbLHBzbrgtTQMmgXYd2vVSQ3TAD0JV0vNC0w5zMi
        AgIg0I5mYvPV8x+UE3PMMGa5vw==
X-Google-Smtp-Source: ABdhPJzGCE6EzVZman8fSiUohf3D8+V2/3CWoBE09YGE21g6Vy6+LY5kvFh/StgAYK6rV9NtGAC5Xg==
X-Received: by 2002:a05:6638:1511:b0:319:fde7:501c with SMTP id b17-20020a056638151100b00319fde7501cmr14282398jat.13.1647990368349;
        Tue, 22 Mar 2022 16:06:08 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id y3-20020a92c983000000b002c7dce8329fsm10292511iln.72.2022.03.22.16.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 16:06:07 -0700 (PDT)
Date:   Tue, 22 Mar 2022 23:06:04 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 15/22] KVM: arm64: Support SDEI_EVENT_SIGNAL hypercall
Message-ID: <YjpWXGIoaXUVjXQW@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-16-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-16-gshan@redhat.com>
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

On Tue, Mar 22, 2022 at 04:07:03PM +0800, Gavin Shan wrote:
> This supports SDEI_EVENT_SIGNAL hypercall. It's used by the guest
> to inject SDEI event, whose number must be zero to the specified
> vCPU. As the routing mode and affinity isn't supported yet, the
> calling vCPU is assumed to be the target.
> 
> The SDEI event 0x0 is a private one, with normal priority. It's
> usually used for testing.

I don't know if that is actually the case. One real use that immediately
comes to mind is doing an NMI on a wedged CPU. KVM probably shouldn't
glean at how the guest may use a particular call, so at most we should
just point at the spec and state that event 0 is for software signaled
events.

> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/kvm/sdei.c | 64 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
> index a24270378305..ba2ca65c871b 100644
> --- a/arch/arm64/kvm/sdei.c
> +++ b/arch/arm64/kvm/sdei.c
> @@ -726,6 +726,66 @@ static int do_inject_event(struct kvm_vcpu *vcpu,
>  	return 0;
>  }
>  
> +static unsigned long hypercall_signal(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm = vcpu->kvm;
> +	struct kvm_sdei_kvm *ksdei = kvm->arch.sdei;
> +	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
> +	struct kvm_sdei_exposed_event *exposed_event;
> +	struct kvm_sdei_registered_event *registered_event;
> +	unsigned long event_num = smccc_get_arg1(vcpu);
> +	int index;
> +	unsigned long ret = SDEI_SUCCESS;
> +
> +	/* @event_num must be zero */
> +	if (!kvm_sdei_is_default(event_num)) {

0 isn't KVM's default event. I'd argue KVM doesn't have a default event
to begin with. This has a precise definition coming from the spec. In
fact, 'KVM_SDEI_DEFAULT_EVENT' should probably be eliminated, and any
missing SDEI definitions should be added to include/uapi/linux/arm_sdei.h.

That goes for any values coming from the specification. KVM's
implementation details belong in a KVM header :)

--
Thanks,
Oliver
