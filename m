Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85019586828
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 13:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiHALce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiHALcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 07:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE05C2FFF4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659353551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/ljHOVKU9U8teT2dBH6Opp3iD1PkE+R+CLm1slr49U=;
        b=D6Kp+Bk78K0SCZYUNIQoe6Qb8SywwiReINZp+syqp076u3T8H1kVuB4xp0BFLmwhV8aVOC
        gnQmV21mCHZoB94qXsP8ZZrX/du0PRF68OnV1CPTpmS6cRzbugKJHhjXeEojXlrxgXHWSZ
        1eo5JoQE5FID6JT9NrzRElscttuvw4Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-A9UlCrDUMumbY-ac7Jkslw-1; Mon, 01 Aug 2022 07:32:27 -0400
X-MC-Unique: A9UlCrDUMumbY-ac7Jkslw-1
Received: by mail-wm1-f70.google.com with SMTP id v18-20020a05600c215200b003a2fea66b7cso1471620wml.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 04:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z/ljHOVKU9U8teT2dBH6Opp3iD1PkE+R+CLm1slr49U=;
        b=IheAFsoo/m6eZC+SkXtQoaRl0csRmKdnOXwILjWTWNO9+kZiWvAq1X9RpIsZZQlcGA
         4o0wYteQDMnk/F78OJP/0cgwSuZ9VuM+PuATVKpjW7B8gjGelZPRg2clhzJxqb/iVH6x
         EszJS6G9cjE1mnP0gaMFe8kHr3bNIEi7Ih4Eiq8yDc/kEtWibKH/ex6cXqU583/TCBrm
         DYoXe6nJajWAXhXV2Ga3dhYbbifqHD7ZXB6GS1SyT9bpyOtk3QElWx1+fP6vTucPahPj
         QUh4S15+jBkKP0Mb12qTN7mjc8c9yrbPbsMyv3/55bUq6yRJD9ZbQ9AohunkJjwb/914
         ssug==
X-Gm-Message-State: ACgBeo0MsGCr48Zo1GIfmqKrueRF84xNOWm1Sjv3+7jEHAYa7eEr6kt5
        ycA4Csb7FjtZCrpoCwJp+bnL+L06DNyuJd+LaHoauG+pyMaRHfe/+OVVyfFo9GucYLOnke0lfKO
        r8Af/S8g3Hg3kwyaf2orDfCW4
X-Received: by 2002:a5d:47a1:0:b0:21d:a4c6:352b with SMTP id 1-20020a5d47a1000000b0021da4c6352bmr9768523wrb.365.1659353546613;
        Mon, 01 Aug 2022 04:32:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jzKYhikBbfyqIdSZ+K8UkiAfp/aZxXq5TLhp5eMZl3/wiJ/GScuUV2+dvGt5/OH7YbfnxCA==
X-Received: by 2002:a5d:47a1:0:b0:21d:a4c6:352b with SMTP id 1-20020a5d47a1000000b0021da4c6352bmr9768499wrb.365.1659353546343;
        Mon, 01 Aug 2022 04:32:26 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id j38-20020a05600c48a600b003a3080eacb9sm13850227wmp.24.2022.08.01.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 04:32:25 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Andrei Vagin <avagin@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Andrei Vagin <avagin@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jianfeng Tan <henry.tjf@antfin.com>,
        Adin Scannell <ascannell@google.com>,
        Konstantin Bogomolov <bogomolov@google.com>,
        Etienne Perot <eperot@google.com>
Subject: Re: [PATCH 4/5] selftests/kvm/x86_64: set rax before vmcall
In-Reply-To: <20220722230241.1944655-5-avagin@google.com>
References: <20220722230241.1944655-1-avagin@google.com>
 <20220722230241.1944655-5-avagin@google.com>
Date:   Mon, 01 Aug 2022 13:32:24 +0200
Message-ID: <87y1w819o7.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrei Vagin <avagin@google.com> writes:

> kvm_hypercall has to place the hypercall number in rax.
>
> Trace events show that kvm_pv_test doesn't work properly:
>      kvm_pv_test-53132: kvm_hypercall: nr 0x0 a0 0x0 a1 0x0 a2 0x0 a3 0x0
>      kvm_pv_test-53132: kvm_hypercall: nr 0x0 a0 0x0 a1 0x0 a2 0x0 a3 0x0
>      kvm_pv_test-53132: kvm_hypercall: nr 0x0 a0 0x0 a1 0x0 a2 0x0 a3 0x0
>
> With this change, it starts working as expected:
>      kvm_pv_test-54285: kvm_hypercall: nr 0x5 a0 0x0 a1 0x0 a2 0x0 a3 0x0
>      kvm_pv_test-54285: kvm_hypercall: nr 0xa a0 0x0 a1 0x0 a2 0x0 a3 0x0
>      kvm_pv_test-54285: kvm_hypercall: nr 0xb a0 0x0 a1 0x0 a2 0x0 a3 0x0
>

Fixes: ac4a4d6de22e ("selftests: kvm: test enforcement of paravirtual cpuid features")

> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index ead7011ee8f6..5d85e1c021da 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -1422,7 +1422,7 @@ uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
>  
>  	asm volatile("vmcall"
>  		     : "=a"(r)
> -		     : "b"(a0), "c"(a1), "d"(a2), "S"(a3));
> +		     : "a"(nr), "b"(a0), "c"(a1), "d"(a2), "S"(a3));

Wouldn't '"+a"(r)' instead of '"=a"(r)' suffice (assuming we also assing
'r' to 'nr' in the beginning, something like

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index ead7011ee8f6..fdd6554b94a1 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1418,10 +1418,10 @@ bool set_cpuid(struct kvm_cpuid2 *cpuid,
 uint64_t kvm_hypercall(uint64_t nr, uint64_t a0, uint64_t a1, uint64_t a2,
                       uint64_t a3)
 {
-       uint64_t r;
+       uint64_t r = nr;
 
        asm volatile("vmcall"
-                    : "=a"(r)
+                    : "+a"(r)
                     : "b"(a0), "c"(a1), "d"(a2), "S"(a3));
        return r;
 }

-- 
Vitaly

