Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF885464B0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 12:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349259AbiFJKwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 06:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345195AbiFJKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F10A30545B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654858138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWkh+WwrOXy+lr72hI3IJZ1D1qWbN8stgCGKeJESz34=;
        b=ArAw1ADEIS8vebxKZ93YBIuwm2Sh8/zcPv3q+hardnrDKcQiCLh2gsUQCv+0wTNuqkM6Rk
        4Gmu68NQeyC5TDDxOIqn+i+VAnRKRGtTaO6UziZ8MQJ636ngBSD9Yzxeq16tUyzNyD8/Zq
        +ipcwsUUOjdrd5I7xZU4MCKMOJ2Ryx4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-kdLxpJK5MLutOl0n-5KCYA-1; Fri, 10 Jun 2022 06:48:55 -0400
X-MC-Unique: kdLxpJK5MLutOl0n-5KCYA-1
Received: by mail-wm1-f71.google.com with SMTP id k32-20020a05600c1ca000b0039c4cf75023so1122223wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWkh+WwrOXy+lr72hI3IJZ1D1qWbN8stgCGKeJESz34=;
        b=V4uNiw9dRHwK18kopoAeRIqw0Lv+R3nQ3Atz7d9QNcnaZxwZkRQgKRdC0STXLdk4fa
         WgmfvvVD4W/EIRM5/6nhiRrQK3VK/b7J26MDTzfy28DV2UaIlN1oAbFg/U6hbLWB20N2
         0mYLDYHCrKLBiwQ60GH5IoBssXnPalc9n2ltKRf3ju2uMvEF8w6zwtx/vyQSxjVhFqM7
         Y2e63ZX/qY5NMG5QJL3bfo9mDfoK8WUQo/7QG4X2BkL+zPh0RCkk9rnPaxOiGgc8fbka
         srHYBprcleWr1Y3bpQt6pZprrmi/jFuC0yl5ghFgYEpNg5SQkm3NUKHn/isXu36jhxOJ
         CFzw==
X-Gm-Message-State: AOAM531bFO6EUxuhMqi5MiKesBbkrkyLoP8xqq0LNJV4hLVDi1QUDJov
        FrPMjJKdD7rt+Wt5HboxuMs8U5jQStJeYgHiQteDSYJYGyn96Czolzusjev8X8bj86FdBXqXd17
        hmzwI92cUmtsiQ/ntLGV6f+/J
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr8284536wmj.110.1654858134639;
        Fri, 10 Jun 2022 03:48:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0W/iRnqZGok+Dtln1QGHn4dkyrs5LOr4eKgyWhEe1ws2y4/hUtrhhuo/t9QkujNnxNRICuw==
X-Received: by 2002:a7b:c310:0:b0:38c:f07a:e10d with SMTP id k16-20020a7bc310000000b0038cf07ae10dmr8284516wmj.110.1654858134365;
        Fri, 10 Jun 2022 03:48:54 -0700 (PDT)
Received: from gator (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id d12-20020adff2cc000000b00215859413f3sm20414628wrp.107.2022.06.10.03.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:48:53 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:48:51 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 126/144] KVM: selftests: Convert kvm_binary_stats_test
 away from vCPU IDs
Message-ID: <20220610104851.g2r6yzd6j22xod6m@gator>
References: <20220603004331.1523888-1-seanjc@google.com>
 <20220603004331.1523888-127-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603004331.1523888-127-seanjc@google.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 12:43:13AM +0000, Sean Christopherson wrote:
> Track vCPUs by their 'struct kvm_vcpu' object in kvm_binary_stats_test,
> not by their ID.  The per-vCPU helpers will soon take a vCPU instead of a
> VM+vcpu_id pair.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/kvm_binary_stats_test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> index 407e9ea8e6f3..dfc3cf531ced 100644
> --- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> +++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
> @@ -172,9 +172,9 @@ static void vm_stats_test(struct kvm_vm *vm)
>  	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
>  }
>  
> -static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
> +static void vcpu_stats_test(struct kvm_vcpu *vcpu)
>  {
> -	int stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
> +	int stats_fd = vcpu_get_stats_fd(vcpu->vm, vcpu->id);
>  
>  	stats_test(stats_fd);
>  	close(stats_fd);
> @@ -195,6 +195,7 @@ static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
>  int main(int argc, char *argv[])
>  {
>  	int i, j;
> +	struct kvm_vcpu **vcpus;
>  	struct kvm_vm **vms;
>  	int max_vm = DEFAULT_NUM_VM;
>  	int max_vcpu = DEFAULT_NUM_VCPU;
> @@ -220,17 +221,21 @@ int main(int argc, char *argv[])
>  	/* Create VMs and VCPUs */
>  	vms = malloc(sizeof(vms[0]) * max_vm);
>  	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> +
> +	vcpus = malloc(sizeof(struct kvm_vcpu *) * max_vm * max_vcpu);
> +	TEST_ASSERT(vcpus, "Allocate memory for storing vCPU pointers");
> +
>  	for (i = 0; i < max_vm; ++i) {
>  		vms[i] = vm_create_barebones();
>  		for (j = 0; j < max_vcpu; ++j)
> -			__vm_vcpu_add(vms[i], j);
> +			vcpus[j * max_vcpu + i] = __vm_vcpu_add(vms[i], j);

The expression for the index should be 'i * max_vcpu + j'. The swapped
i,j usage isn't causing problems now because
DEFAULT_NUM_VM == DEFAULT_NUM_VCPU, but that could change.

>  	}
>  
>  	/* Check stats read for every VM and VCPU */
>  	for (i = 0; i < max_vm; ++i) {
>  		vm_stats_test(vms[i]);
>  		for (j = 0; j < max_vcpu; ++j)
> -			vcpu_stats_test(vms[i], j);
> +			vcpu_stats_test(vcpus[j * max_vcpu + i]);

Same comment as above.

Thanks,
drew

>  	}
>  
>  	for (i = 0; i < max_vm; ++i)
> -- 
> 2.36.1.255.ge46751e96f-goog
> 

