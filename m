Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207C653F820
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 10:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiFGI0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 04:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbiFGI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 04:26:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D8A7CEB94
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654590386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zoo+KIK+2hXw7m+A9JV2cdh9xeihyzNqNUSrFaulo5g=;
        b=UDEv/VKJQuXup5QfISZVBv9Q98+XLxrk5IpdsGo5gAgg+hNAHVLfASlPTUMd/CmOR1lNak
        SCHmjIsOxxE7JbXoRTRcDIgI7mgK/BCfaXKJpjYNxk2VumtP5W3lU3yKU+XQBwznOc6KRN
        A7ydY1XMvAjI9ODDRUljtpOGrbBjOWs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-l6U_TZxBNCa5XJ2gxhmmIg-1; Tue, 07 Jun 2022 04:26:25 -0400
X-MC-Unique: l6U_TZxBNCa5XJ2gxhmmIg-1
Received: by mail-qt1-f197.google.com with SMTP id f22-20020ac859d6000000b00304bf4dba7fso13417286qtf.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 01:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zoo+KIK+2hXw7m+A9JV2cdh9xeihyzNqNUSrFaulo5g=;
        b=ohjA1IOVYK+uE4h+6gxWUD2UNN3NtUjTR+mQpo65TcmF3GCC1GU+DdPTxCALT1JqsM
         2wvB+DjZzfUYde/dTJAbC/j+ZNkX1NYbuIrMo2oHleIY185+yYMh6X124HH/EgHSx6FK
         /mhxp75tUdijD37izgUgo8qP8EpcIjdrhvvRJQmzHVul9rmEyWm5e/mW9a+t6dBCb8hq
         WWl+JFZpYnU/R7LT+sfycWAZJcQoX3STRVrYLm8qbV0+l8+1ffBrs/Pg4OzZL4STqzYT
         75CSFyHUpg6PHsCRUXNYJY/NG5DCeccJeehhcRnrhjrlpD00o73dJjvIbe//G0djx1er
         qZwA==
X-Gm-Message-State: AOAM531TWVHhDPN4VPofMLq4H3ZAMkAvyBElQEEvu+AIYiNNvQFQ4IpH
        ipFcqxbsSGkTRMZVO2OVgIFgQEZi8xolj3U0dWk8p8CX91VlGt/demaqXr30ZUrpzkzqZF+ROJx
        R9hczFOorvWY1+W+Ld8/yU6xA
X-Received: by 2002:ac8:5bc3:0:b0:304:ee25:8410 with SMTP id b3-20020ac85bc3000000b00304ee258410mr5946405qtb.361.1654590382417;
        Tue, 07 Jun 2022 01:26:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgcH0xkZvP/Tdtvo+KK3omMT6Dem7OtwnxEwBY0D7EL3k7gyQ2WhMIlGxo8KJSumIOCSx6Yg==
X-Received: by 2002:ac8:5bc3:0:b0:304:ee25:8410 with SMTP id b3-20020ac85bc3000000b00304ee258410mr5946401qtb.361.1654590382217;
        Tue, 07 Jun 2022 01:26:22 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id u3-20020a372e03000000b006a323e60e29sm13007341qkh.135.2022.06.07.01.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 01:26:21 -0700 (PDT)
Message-ID: <01bbe664f61475fb6e5d409a3e7f2da304ed2560.camel@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Make hyperv_clock selftest more stable
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 11:26:18 +0300
In-Reply-To: <20220601144322.1968742-1-vkuznets@redhat.com>
References: <20220601144322.1968742-1-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-01 at 16:43 +0200, Vitaly Kuznetsov wrote:
> hyperv_clock doesn't always give a stable test result, especially
> with
> AMD CPUs. The test compares Hyper-V MSR clocksource (acquired either
> with rdmsr() from within the guest or KVM_GET_MSRS from the host)
> against rdtsc(). To increase the accuracy, increase the measured
> delay
> (done with nop loop) by two orders of magnitude and take the mean
> rdtsc()
> value before and after rdmsr()/KVM_GET_MSRS.
Tiny nitpick: any reason why you think that AMD is more prone
to the failure? This test was failing on my Intel's laptop as well.

> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/x86_64/hyperv_clock.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> index e0b2bb1339b1..3330fb183c68 100644
> --- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> +++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
> @@ -44,7 +44,7 @@ static inline void nop_loop(void)
>  {
>         int i;
>  
> -       for (i = 0; i < 1000000; i++)
> +       for (i = 0; i < 100000000; i++)
>                 asm volatile("nop");
>  }
>  
> @@ -56,12 +56,14 @@ static inline void check_tsc_msr_rdtsc(void)
>         tsc_freq = rdmsr(HV_X64_MSR_TSC_FREQUENCY);
>         GUEST_ASSERT(tsc_freq > 0);
>  
> -       /* First, check MSR-based clocksource */
> +       /* For increased accuracy, take mean rdtsc() before and afrer
> rdmsr() */
>         r1 = rdtsc();
>         t1 = rdmsr(HV_X64_MSR_TIME_REF_COUNT);
> +       r1 = (r1 + rdtsc()) / 2;
>         nop_loop();
>         r2 = rdtsc();
>         t2 = rdmsr(HV_X64_MSR_TIME_REF_COUNT);
> +       r2 = (r2 + rdtsc()) / 2;
>  
>         GUEST_ASSERT(r2 > r1 && t2 > t1);
>  
> @@ -181,12 +183,14 @@ static void host_check_tsc_msr_rdtsc(struct
> kvm_vm *vm)
>         tsc_freq = vcpu_get_msr(vm, VCPU_ID,
> HV_X64_MSR_TSC_FREQUENCY);
>         TEST_ASSERT(tsc_freq > 0, "TSC frequency must be nonzero");
>  
> -       /* First, check MSR-based clocksource */
> +       /* For increased accuracy, take mean rdtsc() before and afrer
> ioctl */
>         r1 = rdtsc();
>         t1 = vcpu_get_msr(vm, VCPU_ID, HV_X64_MSR_TIME_REF_COUNT);
> +       r1 = (r1 + rdtsc()) / 2;
>         nop_loop();
>         r2 = rdtsc();
>         t2 = vcpu_get_msr(vm, VCPU_ID, HV_X64_MSR_TIME_REF_COUNT);
> +       r2 = (r2 + rdtsc()) / 2;
>  
>         TEST_ASSERT(t2 > t1, "Time reference MSR is not monotonic
> (%ld <= %ld)", t1, t2);
>  

Both changes make sense, and the test doesn't fail anymore on my AMD
laptop.
Soon I'll test on my Intel laptop as well.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

