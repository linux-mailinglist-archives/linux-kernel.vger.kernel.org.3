Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BBA501735
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349920AbiDNPYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243573AbiDNN7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CE62251B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:56:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q3so4710328plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/QTs0RczXygwAYcS5h0KeNs+pGHapDmqhINk1BHctPU=;
        b=hroOF8MUVKJR3wgOMgHqQL681su3zuxIouCO3EgDtB4QrloQ20G44j9rkPsbCFvhvp
         Ltt/qkuL7/WOd7xMeChuiKndeNNag5Pc/CkDmLFmFvIcvkZ7p8vjxl86/7+I0J6dttoA
         tJdpfDuhXe4v3WP30uq5j+11Tx11994EUGB8KPqDC34nkPk/7QYkEz+m1+JPALeJ+d36
         xSFeNLGdDyQGww8HtK7d+xMRIvbYDS0RzUdLExHV0aBzk43Ba3WQ5gXHl2W35N6twpVb
         vVciDoezarBm+0hvqLeUg1oL+st2zo2mA6vJS8k3XP3Ra/nLRVJ8PtcxoIw7cm9JXppB
         QiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QTs0RczXygwAYcS5h0KeNs+pGHapDmqhINk1BHctPU=;
        b=dqwgf2MpV051lEP2F6xe4ajLc19hhjDdUZtdiRNNQjzR1lP3KQautydaLYmduDHF5H
         8tskOabqguAhxfpJH8vRvzGjer4x0sxR1C+Z9CEu0+X2279JOA0aISKLLtszbpAO+l1U
         o8cYBHCtkjS1xyE1Sll/nJe9LBx68oL2GQVQMGFUqVtzFgGD3C/zBLn0plTRHK831U/V
         wgKqnTc/JUnK9eEulSCv3kSe9DbWtUTk+9qsClSYv4hXwaNpKtb9c+mql7B1LZejwogJ
         Q2w5rOaEvTf3/K6pC0uDX6pyKfkCTUDeY0FEtD3EErJy+mXt+MSwICeb01NOE4ZQe5VR
         DbeA==
X-Gm-Message-State: AOAM531goC8fNuJV0HFcfnJ89ZknwNwP3NTH2ygREGbxEIVHg1eUQqOy
        tPBzH7P0DJAJ2xAjsXyNXTNrCgFIif4rMA==
X-Google-Smtp-Source: ABdhPJy8sWO+VIJUB1UbX8WEkHEpWxztb3VJTna8Asnid4LM358eJALVQTe8KI/42nrqLOi2KZBg1A==
X-Received: by 2002:a17:90b:380c:b0:1cb:a43d:4c29 with SMTP id mq12-20020a17090b380c00b001cba43d4c29mr4372318pjb.240.1649944577159;
        Thu, 14 Apr 2022 06:56:17 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090a7a8400b001cd4a0c3270sm2088932pjf.7.2022.04.14.06.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:56:16 -0700 (PDT)
Date:   Thu, 14 Apr 2022 13:56:12 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH] kvm: selftests: Fix cut-off of addr_gva2gpa lookup
Message-ID: <Ylgn/Jw+FMIFqqc0@google.com>
References: <20220414010703.72683-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414010703.72683-1-peterx@redhat.com>
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

On Wed, Apr 13, 2022, Peter Xu wrote:
> Our QE team reported test failure on access_tracking_perf_test:
> 
> Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
> guest physical test memory offset: 0x3fffbffff000
> 
> Populating memory             : 0.684014577s
> Writing to populated memory   : 0.006230175s
> Reading from populated memory : 0.004557805s
> ==== Test Assertion Failure ====
>   lib/kvm_util.c:1411: false
>   pid=125806 tid=125809 errno=4 - Interrupted system call
>      1  0x0000000000402f7c: addr_gpa2hva at kvm_util.c:1411
>      2   (inlined by) addr_gpa2hva at kvm_util.c:1405
>      3  0x0000000000401f52: lookup_pfn at access_tracking_perf_test.c:98
>      4   (inlined by) mark_vcpu_memory_idle at access_tracking_perf_test.c:152
>      5   (inlined by) vcpu_thread_main at access_tracking_perf_test.c:232
>      6  0x00007fefe9ff81ce: ?? ??:0
>      7  0x00007fefe9c64d82: ?? ??:0
>   No vm physical memory at 0xffbffff000
> 
> And I can easily reproduce it with a Intel(R) Xeon(R) CPU E5-2630 with 46
> bits PA.
> 
> It turns out that the address translation for clearing idle page tracking
> returned wrong result, in which addr_gva2gpa()'s last step should have

"should have" is very misleading, that makes it sound like the address was
intentionally truncated.  Or did you mean "should have been treated as 64-bit
value"?

> treated "pte[index[0]].pfn" to be a 32bit value.

It didn't get treated as a 32-bit value, it got treated as a 40-bit value, because
the pfn is stored as 40 bits.

struct pageTableEntry {
	uint64_t present:1;
	uint64_t writable:1;
	uint64_t user:1;
	uint64_t write_through:1;
	uint64_t cache_disable:1;
	uint64_t accessed:1;
	uint64_t dirty:1;
	uint64_t reserved_07:1;
	uint64_t global:1;
	uint64_t ignored_11_09:3;
	uint64_t pfn:40;  <================
	uint64_t ignored_62_52:11;
	uint64_t execute_disable:1;
};

> In above case the GPA
> address 0x3fffbffff000 got cut-off into 0xffbffff000, then it caused
> further lookup failure in the gpa2hva mapping.
> 
> I didn't yet check any other test that may fail too on some hosts, but
> logically any test using addr_gva2gpa() could suffer.
> 
> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2075036
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/kvm/lib/x86_64/processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 9f000dfb5594..6c356fb4a9bf 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -587,7 +587,7 @@ vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
>  	if (!pte[index[0]].present)
>  		goto unmapped_gva;
>  
> -	return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> +	return ((vm_paddr_t)pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);

This is but one of many paths that can get burned by pfn being 40 bits.  The
most backport friendly fix is probably to add a pfn=>gpa helper and use that to
place the myriad "pfn * vm->page_size" instances.

For a true long term solution, my vote is to do away with the bit field struct
and use #define'd masks and whatnot.
