Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E755A7EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiHaNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiHaNYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:24:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83BCA50E1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661952278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Omu4YpZEW3bXVejWiGo0Hr4Xg9+WFqfzLBahZAcI0Kg=;
        b=Kk78tUarTUSctoEIgq/3//JsdPgsweltdBcO2ZCtAE4isapPQntxldDBxMdL9nNOrJ4Vk4
        YHflJLRFGL0zX3qcrznT9/fXnrfUwBt9+GMG35ehNyCX03rvrFsk3u8Xa6rRPDCs808MB1
        ZgHw/b/YlwwRO8LAPtJA+vx9Y50p89M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606--SIqiyzcO2m_KhAa5CuHOA-1; Wed, 31 Aug 2022 09:24:37 -0400
X-MC-Unique: -SIqiyzcO2m_KhAa5CuHOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21A523804069;
        Wed, 31 Aug 2022 13:24:37 +0000 (UTC)
Received: from starship (unknown [10.40.194.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81B8D112131E;
        Wed, 31 Aug 2022 13:24:35 +0000 (UTC)
Message-ID: <4a4bc3ad639b0dca9f24a7616d86a7cc9abd13ea.camel@redhat.com>
Subject: Re: [PATCH 13/19] KVM: x86: Disable APIC logical map if vCPUs are
 aliased in logical mode
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Li RongQing <lirongqing@baidu.com>
Date:   Wed, 31 Aug 2022 16:24:34 +0300
In-Reply-To: <20220831003506.4117148-14-seanjc@google.com>
References: <20220831003506.4117148-1-seanjc@google.com>
         <20220831003506.4117148-14-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-08-31 at 00:35 +0000, Sean Christopherson wrote:
> Disable the optimized APIC logical map if multiple vCPUs are aliased to
> the same logical ID.  Architecturally, all CPUs whose logical ID matches
> the MDA are supposed to receive the interrupt; overwriting existing map
> entries can result in missed IPIs.
> 
> Fixes: 1e08ec4a130e ("KVM: optimize apic interrupt delivery")
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/lapic.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 82278acae95b..d537b51295d6 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -303,12 +303,13 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
>  		if (!mask)
>  			continue;
>  
> -		if (!is_power_of_2(mask)) {
> +		ldr = ffs(mask) - 1;
> +		if (!is_power_of_2(mask) || cluster[ldr]) {
>  			new->mode = KVM_APIC_MODE_XAPIC_FLAT |
>  				    KVM_APIC_MODE_XAPIC_CLUSTER;
>  			continue;
>  		}
> -		cluster[ffs(mask) - 1] = apic;
> +		cluster[ldr] = apic;
>  	}
>  out:
>  	old = rcu_dereference_protected(kvm->arch.apic_map,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

