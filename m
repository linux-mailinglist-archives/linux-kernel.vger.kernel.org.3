Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED55432C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241647AbiFHOir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241590AbiFHOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:38:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDB4112D1E9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654699119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rutOmktasjwV4HOl7UXvH/z+BMbngERH3yOeS84tcJs=;
        b=LYN+DLb0Bkn6iYGo93Lv/texF9jGSjWImWNRBkdIyY2ykGv3AuQyVrzEZCiDknXHFOec2T
        /jCj+TyTjFVBC6bmN4TdV49gpWaNHQBAK9dUsyEbFN2sFTYRnHi23pgY5vLn8soZ3fQucq
        mUFb/h7wZEycBXVMHrfnoRNSM6c0NoU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-gvr3LSYDPnaToGHsOXl8yg-1; Wed, 08 Jun 2022 10:38:38 -0400
X-MC-Unique: gvr3LSYDPnaToGHsOXl8yg-1
Received: by mail-wr1-f69.google.com with SMTP id m18-20020adff392000000b0021848a78a53so2366300wro.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rutOmktasjwV4HOl7UXvH/z+BMbngERH3yOeS84tcJs=;
        b=IaHkw0xuue9mo75kljG3c5meaC/KlK16KLIK644k8P9okebQi9EGpqeY9z0VEWRH1z
         1u9vEbByYn88wfziA/Lgum7HOOs2guaLlnwZkmjhLzrTpA9IWauCYLMuzf6NqLM05kHL
         waoBArP4hbbFC0ReL/v5M//DMo++gzOIrtcGMyoXWmeFMPDI+cfygAP+kFr5e5CO2NFg
         fhThrFxyY+zlnp367niZL5KXh/wX5BtUSaEoboyov10JPl0h/cvcbNUIUnGpim29Vu5H
         bG3d+TgTYoRJQgMnKJKO1mqBkxzAKkLXuulq1eXy+rYgaetBU4i88De+7pVlhr+ykx7N
         azkw==
X-Gm-Message-State: AOAM531AeOdpxgn7Bw63TOjxFdfaI/WvD9dmHz8ziv7RJpnmvdRb6lEt
        bbDfH+2Md1McQPzwFrF3Fw70UtJ8BZPPaLnrJhr5VxVS6jpS4n866cLC1JQkcRIb/Yf/slljMNV
        WjXO/MjPB6UexCX+ahwE5spwI
X-Received: by 2002:a1c:f314:0:b0:397:10a5:a355 with SMTP id q20-20020a1cf314000000b0039710a5a355mr35239223wmq.176.1654699117375;
        Wed, 08 Jun 2022 07:38:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRvEiZ3/11/o3JSbjmUEfu7+YYcdqjV0aJCIeBeXUTk7NEY8qk0uY4fnClcJYUh7Q0nmi+bg==
X-Received: by 2002:a1c:f314:0:b0:397:10a5:a355 with SMTP id q20-20020a1cf314000000b0039710a5a355mr35239207wmq.176.1654699117199;
        Wed, 08 Jun 2022 07:38:37 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b0039c2e2d0502sm21813780wmq.4.2022.06.08.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:38:35 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:38:28 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 038/144] KVM: selftests: Push
 vm_adjust_num_guest_pages() into "w/o vCPUs" helper
Message-ID: <20220608143828.b7ggvuptlngmnqvp@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-39-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-39-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:41:45AM +0000, Sean Christopherson wrote:
> Move the call to vm_adjust_num_guest_pages() from vm_create_with_vcpus()
> down into vm_create_without_vcpus().  This will allow a future patch to
> make the "w/o vCPUs" variant the common inner helper, e.g. so that the
> "with_vcpus" helper calls the "without_vcpus" helper, instead of having
> them be separate paths.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 1c5caf2ddca4..6b0b65c26d4d 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -282,6 +282,8 @@ struct kvm_vm *vm_create_without_vcpus(enum vm_guest_mode mode, uint64_t pages)
>  {
>  	struct kvm_vm *vm;
>  
> +	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);

Hi Sean,

We should pass 'mode' here.

Thanks,
drew

> +
>  	vm = __vm_create(mode, pages);
>  
>  	kvm_vm_elf_load(vm, program_invocation_name);
> @@ -341,8 +343,6 @@ struct kvm_vm *vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus,
>  		    "nr_vcpus = %d too large for host, max-vcpus = %d",
>  		    nr_vcpus, kvm_check_cap(KVM_CAP_MAX_VCPUS));
>  
> -	pages = vm_adjust_num_guest_pages(mode, pages);
> -
>  	vm = vm_create_without_vcpus(mode, pages);
>  
>  	for (i = 0; i < nr_vcpus; ++i) {
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

