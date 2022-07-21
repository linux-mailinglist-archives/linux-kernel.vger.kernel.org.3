Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456B057D60F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbiGUVey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiGUVew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:34:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247F93609
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:34:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso2542910pja.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qUQyIRg/Ws6CaK4DrYiF9O28EdMBNbfwwguAIe1dzWU=;
        b=NxNDm67Tl3dUEqNnoCeIlr8y+tYuWVLZLRKnkuemECPc4Zzq3raaozxRQX4/f3pG9n
         bb9rouzMCfMNDxOuSwu9XDBGx9br7uqDNgNmAAueUUphKMtxxxSN9XOokc92/AiLHaAx
         RiHjMuc2XXEqqgxHW5mt9BUfEsQANJ03wUFOPD5UMtvVMkWV9I35Gr5LPdFtKSswQSRL
         b3YYmWatn4D1suwTI2+iLvboDpXOZ53q39gEzU7PVAVN6kBijNV0MENTJraWZRnABBeP
         E3825VNih7OHqH2wlWOOsWsX7+03gpT4zEh4J7Yg47xyC2iTPcEl2I+f7KqjKsXuIbCP
         wLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qUQyIRg/Ws6CaK4DrYiF9O28EdMBNbfwwguAIe1dzWU=;
        b=y1hqSi5A6vVWdk4AB8VsveAZw1KR+rhNr5sh8RjFftYZdvvOQFVejlQJRKw3Vw+g4+
         gOVINwg16a8Os8EbfnQulO6Z4jet6RW4/0dwzOiWfj3OqOruGnFzZJCmUjQGT0/cFJtj
         0wv4a03NAtOlnMmjOLY41qcweHpRrv5gUQwTNluCFvwag8i0fQEUsWYiiVkEj5tPAYO9
         pA0bnOOM1VdMxEv+lcxP3w5s7GIFhsbhcN/7E/NhWq9fObgm5CVOZqKTbROCSrcgkFKn
         eIZ6qFUgvYMZeXvSi0tiyZO5DWElcT2QFpTTduWaWDfuvO2lrfeYR5FsEV1NbsNSVApI
         T9Tg==
X-Gm-Message-State: AJIora8bmIp9ax0xnx2sfl6DCTso0Ser4pysUQqyugTIAK7OONTIczjR
        d+rJB08AQTJPwYmFFSE9q8OAHA==
X-Google-Smtp-Source: AGRyM1um6IQ+oDuMjW2ZxBjcQ6cO5vSwdpAzTnrlJvL0MFZ3SiWGhYRY1ssbW2ut3SVTdh7K+7vDTw==
X-Received: by 2002:a17:902:d395:b0:16b:e5e9:ac59 with SMTP id e21-20020a170902d39500b0016be5e9ac59mr290590pld.74.1658439290971;
        Thu, 21 Jul 2022 14:34:50 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b0016892555955sm2186853plx.179.2022.07.21.14.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 14:34:50 -0700 (PDT)
Date:   Thu, 21 Jul 2022 21:34:47 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 33/39] KVM: selftests: nVMX: Allocate Hyper-V
 partition assist page
Message-ID: <YtnGd4OT3FQJ75b8@google.com>
References: <20220714134929.1125828-1-vkuznets@redhat.com>
 <20220714134929.1125828-34-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714134929.1125828-34-vkuznets@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022, Vitaly Kuznetsov wrote:
> In preparation to testing Hyper-V L2 TLB flush hypercalls, allocate
> so-called Partition assist page and link it to 'struct vmx_pages'.
> 
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/vmx.h | 4 ++++
>  tools/testing/selftests/kvm/lib/x86_64/vmx.c     | 7 +++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> index cc3604f8f1d3..f7c8184c1de8 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> @@ -570,6 +570,10 @@ struct vmx_pages {
>  	uint64_t enlightened_vmcs_gpa;
>  	void *enlightened_vmcs;
>  
> +	void *partition_assist_hva;
> +	uint64_t partition_assist_gpa;
> +	void *partition_assist;

Rather than duplicate this and other Hyper-V stuff, can you first add a struct
to hold the Hyper-V pages, along with a helper to populate them?  I'd even throw
in the eVMCS stuff, it's trivial for the helper to have a flag saying "don't bother
allocating eVMCS".  That will give us an easier path to allocating these pages
if and only if the test actually wants to enable Hyper-V stuff.
