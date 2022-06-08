Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F6C5432EF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241915AbiFHOpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiFHOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D76A517A88B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654699417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QGybRp7HyxPWXXi6lDayeeFfGFkvXV82mOa2oHNXnQ0=;
        b=XB/ArOQi6s1J0ORPHBwUrXsrnSmL5PvxHm4SIf/CNnJQS1pVauHa7n1IDVV6pZls7iMPsW
        LHTP4XL14t2KLmCNp+89FcgrDmCbHRyL5hARNpL35kmba/saXSsA8OVgg2dt6W1PpGBCkU
        SkdMbNILuluZi8vi1qHn662Bsqxx3s4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-_NwDF7H6OcWsCofkTYoLxw-1; Wed, 08 Jun 2022 10:43:36 -0400
X-MC-Unique: _NwDF7H6OcWsCofkTYoLxw-1
Received: by mail-wr1-f69.google.com with SMTP id bv8-20020a0560001f0800b002183c5d5c26so2770743wrb.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 07:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QGybRp7HyxPWXXi6lDayeeFfGFkvXV82mOa2oHNXnQ0=;
        b=hpjIsvgOrPXxk1DyzSB7jcaxJxFaUfy6lX0BjWoF9moXFGrjn3wHzBAVccmQXXDW9z
         FTMxGK60GoCg5DrMaF+4RFdo8NkdXPeeq59RbSX98cQ8MlLFHde1Uegd2RZh5HY/0Ere
         G56zdKJSL0FFPHuEmJI1MLWlonwSZ2EF45hiMEiPJi4Ijm6KndZ+c6lKf9gEAxVCym9C
         +1KR8CWtoUfpOGvb9d3AYu9AI7zmvTNmIqkLe/7qFys6l0ZPffmrGGo+cPrWlf4Zh+Xq
         pVZiFBTtRwpp5kDOPJmhQxtjtZnlDXWa5nqEdpMLHMeJt2XY1JLTb5ObFRJT1xtc3ZNP
         FfBA==
X-Gm-Message-State: AOAM5314VPUR9xlwa/sxCUI+z1JmKyoCOBLkjyL60i07bORcojPftp1W
        sMslyEF1WFFoCY+lQx9gzk4uiVlVWyd/N9qsmo/u+/7dKPq8YlwhSLm9xHah/BxS6dLtBLYHrr+
        Jc128NaXaT95fDjIH/xlSerls
X-Received: by 2002:a5d:66c7:0:b0:210:3385:1e44 with SMTP id k7-20020a5d66c7000000b0021033851e44mr34460987wrw.566.1654699414771;
        Wed, 08 Jun 2022 07:43:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZTwUJL7WnLig7q00WmdEPLyVRyRx9zq97cKupuodEn3Oa+hJV+aHKruVl9ORZW8O88c4CfA==
X-Received: by 2002:a5d:66c7:0:b0:210:3385:1e44 with SMTP id k7-20020a5d66c7000000b0021033851e44mr34460968wrw.566.1654699414533;
        Wed, 08 Jun 2022 07:43:34 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d4dcc000000b002100316b126sm22042605wru.6.2022.06.08.07.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:43:34 -0700 (PDT)
Date:   Wed, 8 Jun 2022 16:43:32 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 041/144] KVM: selftests: Use vm_create_without_vcpus()
 in hardware_disable_test
Message-ID: <20220608144332.a5syqvj5ttb2zarw@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-42-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-42-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:41:48AM +0000, Sean Christopherson wrote:
> Use vm_create_without_vcpus() instead of open coding a rough equivalent
> in hardware_disable_test.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/hardware_disable_test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/hardware_disable_test.c b/tools/testing/selftests/kvm/hardware_disable_test.c
> index 81ba8645772a..32837207fe4e 100644
> --- a/tools/testing/selftests/kvm/hardware_disable_test.c
> +++ b/tools/testing/selftests/kvm/hardware_disable_test.c
> @@ -104,9 +104,7 @@ static void run_test(uint32_t run)
>  	for (i = 0; i < VCPU_NUM; i++)
>  		CPU_SET(i, &cpu_set);
>  
> -	vm = vm_create(DEFAULT_GUEST_PHY_PAGES);
> -	kvm_vm_elf_load(vm, program_invocation_name);
> -	vm_create_irqchip(vm);
> +	vm  = vm_create_without_vcpus(VM_MODE_DEFAULT, DEFAULT_GUEST_PHY_PAGES);
nit:       ^ extra space
>  
>  	pr_debug("%s: [%d] start vcpus\n", __func__, run);
>  	for (i = 0; i < VCPU_NUM; ++i) {
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

