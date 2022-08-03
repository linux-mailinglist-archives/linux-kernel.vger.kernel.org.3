Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3161758911F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 19:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbiHCRSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbiHCRS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 13:18:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B68953D0A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659547104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ba3iLOxgTjgaPYB0G8OKdC5j0xGnpNwkrDCBhoUvC78=;
        b=KYqylz1vlu/w2vYOjvVr6iIGquCv8MGR2VOqzbdbUyzfbum15N5l17j1Ltq2YP7A6XuHe5
        +yq4gi+UDPV0CmEwG/C6YRRtCLtYk+G5wb3hhLesp7HRIDD720P+Z9rW5FxuUHp0dSB5Zw
        BspWeJlok2r86E9Z9HOfRNTjdpjeV8Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-iINCNhXmOJC83AGbQNgXwg-1; Wed, 03 Aug 2022 13:18:23 -0400
X-MC-Unique: iINCNhXmOJC83AGbQNgXwg-1
Received: by mail-wm1-f70.google.com with SMTP id v11-20020a1cf70b000000b003a318238826so366940wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 10:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Ba3iLOxgTjgaPYB0G8OKdC5j0xGnpNwkrDCBhoUvC78=;
        b=BypB1L13qT512TUf6thdFwB4GP7A+ONv9v2uKc2Hl9sEMBIvpQlMJWh/9N92jfC/sZ
         wnPEFxQVy34qNOLdyIYllOvpKukJd14LE83WCWN097Bo3hxx4BlmFt9waICcWMVV+qsU
         iZiWA53RSMzg21XesNKhR3knXnj0SH9BgcPC6FKk0loWI5WZQVGljikbLyrU3E8hHewZ
         lC0qLGxoiGNH4iotv9aGWqZGiurj4pEtFljiHuNSRYnaeguFDTR4CXJn7+eEJ6KzRxoP
         Hz/bjmuoHcnIgS+1LS2a0bNejN8XfPF296sdCbYvRl+g8qoB4qmePAvZfHm1yJLUyo7R
         8EFw==
X-Gm-Message-State: ACgBeo0zQDrAB1pWch2FMPw/MVGNkJqxZUNqaX1uTDWXJdzztfcn6+mc
        wT7SbNE893COc5cRcX+t8Hb42wIAbpsItiBvdBJ2SsXTFLDtxkAm3dPNH1nt8rg0NcCgMUeqqlx
        NR7+7WSbCR48z760KuryJdNKh
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id q12-20020a1ce90c000000b003a04c68f109mr3437857wmc.56.1659547094875;
        Wed, 03 Aug 2022 10:18:14 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7qPAL4aXq9EjlDqJBMgbr8yOpDW7Xvl8NhQdGLuc+XlQUGjcNM+XZObOHc3oNQB2gvCpWf1Q==
X-Received: by 2002:a1c:e90c:0:b0:3a0:4c68:f109 with SMTP id q12-20020a1ce90c000000b003a04c68f109mr3437848wmc.56.1659547094668;
        Wed, 03 Aug 2022 10:18:14 -0700 (PDT)
Received: from ?IPV6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.googlemail.com with ESMTPSA id b13-20020a5d4b8d000000b0021e519eba9bsm18700259wrt.42.2022.08.03.10.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 10:18:14 -0700 (PDT)
Message-ID: <b03adf94-5af2-ff5e-1dbb-6dd212790083@redhat.com>
Date:   Wed, 3 Aug 2022 19:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>
References: <20220802230718.1891356-1-mizhang@google.com>
 <20220802230718.1891356-2-mizhang@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] KVM: x86: Get vmcs12 pages before checking pending
 interrupts
In-Reply-To: <20220802230718.1891356-2-mizhang@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 01:07, Mingwei Zhang wrote:
> +	/*
> +	 * We must first get the vmcs12 pages before checking for interrupts
> +	 * that might unblock the guest if L1 is using virtual-interrupt
> +	 * delivery.
> +	 */
> +	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
> +		/*
> +		 * If we have to ask user-space to post-copy a page,
> +		 * then we have to keep trying to get all of the
> +		 * VMCS12 pages until we succeed.
> +		 */
> +		if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
> +			kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> +			return 0;
> +		}
> +	}
> +

I think request handling (except for KVM_REQ_EVENT) could be more 
generically moved from vcpu_enter_guest() to vcpu_run().

Paolo

