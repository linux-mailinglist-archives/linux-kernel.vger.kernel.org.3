Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E38BE519FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349778AbiEDMkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349539AbiEDMkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:40:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFBA12C131
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651667799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMDou8npOnizyoJjwbSzNDbswmKNhagYwyrWQyJDXU4=;
        b=gq6CdKfBLoWwmBhGftuS5XiXvQXimSraJm3LPQGbNZVgzjVP/QJdRDErHUcICv+PT9gd/8
        vF62GPOghu/0dNVPBWZ2Gv5jHKoIOhH9kiQ6u7hb6eW2W6sNsYauUPWa3piPGzVKCC37Zr
        23BkeeArHK34CuQMRnNuFloXukwNcPo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-FHMnvWZ6NsKu7HQkVR4Ovg-1; Wed, 04 May 2022 08:36:37 -0400
X-MC-Unique: FHMnvWZ6NsKu7HQkVR4Ovg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EE293C0D186;
        Wed,  4 May 2022 12:36:36 +0000 (UTC)
Received: from starship (unknown [10.40.192.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3894B40CFD32;
        Wed,  4 May 2022 12:36:34 +0000 (UTC)
Message-ID: <2a10c92d38b749b09256d6e06bfe6a841e54585b.camel@redhat.com>
Subject: Re: [PATCH v3 14/14] KVM: SVM: Add AVIC doorbell tracepoint
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, joro@8bytes.org,
        jon.grimm@amd.com, wei.huang2@amd.com, terry.bowman@amd.com
Date:   Wed, 04 May 2022 15:36:33 +0300
In-Reply-To: <20220504073128.12031-15-suravee.suthikulpanit@amd.com>
References: <20220504073128.12031-1-suravee.suthikulpanit@amd.com>
         <20220504073128.12031-15-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 02:31 -0500, Suravee Suthikulpanit wrote:
> Add a tracepoint to track number of doorbells being sent
> to signal a running vCPU to process IRQ after being injected.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  arch/x86/kvm/svm/avic.c |  4 +++-
>  arch/x86/kvm/trace.h    | 18 ++++++++++++++++++
>  arch/x86/kvm/x86.c      |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index a526fbc60bbd..e3343cfc55cd 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -343,8 +343,10 @@ void avic_ring_doorbell(struct kvm_vcpu *vcpu)
>  	 */
>  	int cpu = READ_ONCE(vcpu->cpu);
>  
> -	if (cpu != get_cpu())
> +	if (cpu != get_cpu()) {
>  		wrmsrl(MSR_AMD64_SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
> +		trace_kvm_avic_doorbell(vcpu->vcpu_id, kvm_cpu_get_apicid(cpu));
> +	}
>  	put_cpu();
>  }
>  
> diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
> index de4762517569..a47bb0fdea70 100644
> --- a/arch/x86/kvm/trace.h
> +++ b/arch/x86/kvm/trace.h
> @@ -1479,6 +1479,24 @@ TRACE_EVENT(kvm_avic_kick_vcpu_slowpath,
>  		  __entry->icrh, __entry->icrl, __entry->index)
>  );
>  
> +TRACE_EVENT(kvm_avic_doorbell,
> +	    TP_PROTO(u32 vcpuid, u32 apicid),
> +	    TP_ARGS(vcpuid, apicid),
> +
> +	TP_STRUCT__entry(
> +		__field(u32, vcpuid)
> +		__field(u32, apicid)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->vcpuid = vcpuid;
> +		__entry->apicid = apicid;
> +	),
> +
> +	TP_printk("vcpuid=%u, apicid=%u",
> +		  __entry->vcpuid, __entry->apicid)
> +);
> +
>  TRACE_EVENT(kvm_hv_timer_state,
>  		TP_PROTO(unsigned int vcpu_id, unsigned int hv_timer_in_use),
>  		TP_ARGS(vcpu_id, hv_timer_in_use),
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b14e02ea0ff6..69a91f47a509 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -13097,6 +13097,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_unaccelerated_access);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_incomplete_ipi);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_ga_log);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_kick_vcpu_slowpath);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_avic_doorbell);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_apicv_accept_irq);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_enter);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(kvm_vmgexit_exit);


To be honest we already have the 'kvm_apicv_accept_irq'
which usually results in a doorbell, but no objections
to add this tracepoint.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
        Maxim Levitsky

