Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C099D4C923F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbiCAR4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiCAR4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:56:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B67D146650
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 09:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646157317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1YIiZLEwfCWZucVBeA6r7mIGJsSg3Tucbm5qI7Xnyg=;
        b=TXdysaZBLB5MSiRk/TZIkzn66wsEbWeoLpkWF55BoF61B5gKq4aV7wsTsVg2fV7D+9lsMP
        4NmUKt3jiTzScEfce8oWxFKCKtjmJUFKSyrtNKMS9f+RiuhqWBTYJ1NvTzrdg9sRYhysiZ
        neeou/iO1lA3qXLMBzSi3LdEtqvCdqQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-zW5D4xEIML6OloRcLwMUEw-1; Tue, 01 Mar 2022 12:55:16 -0500
X-MC-Unique: zW5D4xEIML6OloRcLwMUEw-1
Received: by mail-wr1-f71.google.com with SMTP id v17-20020adfa1d1000000b001ed9d151569so3574428wrv.21
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 09:55:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=C1YIiZLEwfCWZucVBeA6r7mIGJsSg3Tucbm5qI7Xnyg=;
        b=SbvIFBcgLARHS6pD1l5nNsZAsYZaHrZGMmFOjIRIo0ab/2+gLUFhRT8GvAotmQzgXs
         sJ+sAyf5OQup9x7P5OqBrKK1dCyYPXEmqFHP+6ZFwbVL3L50rmToRarkQktQzOdJuIiY
         xzYt6gXddjIHhCaZW4s4GWXSOF43PfQYkmGm2pPTBoW7qVnarUN2GaVYCdc8D/BfyUgw
         rqT0GoNcwFkSTYQI9eJscRNPSErDStdvSKKzjhGqSvLQRCPKl+M7olMVqGFg5/D1aITh
         1Y4ooeX45rotIo00i9AZ0qwv2ZxavUbAKkrmediF5VQ04fWeA1fuIUUjZV5w347/taWh
         l4og==
X-Gm-Message-State: AOAM531K5x8S5maCp7lZ+HWHvgLGlAX/ORD87MXVsKGr1W3HezOXgIPO
        xse6D6me2+w/Qjk5wRz/lXc0mcKluv2N/5qfDoVUReO9K+xC9wjO9RHHEo938hOymsKUtgQq7gJ
        /bm/sToO6J5h2+os/4gycRyVr
X-Received: by 2002:a5d:410c:0:b0:1ef:766b:ef5b with SMTP id l12-20020a5d410c000000b001ef766bef5bmr15308387wrp.183.1646157315556;
        Tue, 01 Mar 2022 09:55:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRd6t6YiBjKSS8HtAllf0a/R/xRzLfl/+eN2+xfWBBjB3U07ISLYFsNd+mEn9N0S/owUGCjA==
X-Received: by 2002:a5d:410c:0:b0:1ef:766b:ef5b with SMTP id l12-20020a5d410c000000b001ef766bef5bmr15308374wrp.183.1646157315215;
        Tue, 01 Mar 2022 09:55:15 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id v12-20020a5d4a4c000000b001e68ba61747sm14329725wrs.16.2022.03.01.09.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 09:55:14 -0800 (PST)
Message-ID: <40a22c39-9da4-6c37-8ad0-b33970e35a2b@redhat.com>
Date:   Tue, 1 Mar 2022 18:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 4/7] KVM: x86/mmu: Zap only obsolete roots if a root
 shadow page is zapped
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
References: <20220225182248.3812651-1-seanjc@google.com>
 <20220225182248.3812651-5-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220225182248.3812651-5-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 19:22, Sean Christopherson wrote:
> @@ -5656,7 +5707,7 @@ static void kvm_mmu_zap_all_fast(struct kvm *kvm)
>   	 * Note: we need to do this under the protection of mmu_lock,
>   	 * otherwise, vcpu would purge shadow page but miss tlb flush.
>   	 */
> -	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_RELOAD);
> +	kvm_make_all_cpus_request(kvm, KVM_REQ_MMU_FREE_OBSOLETE_ROOTS);
>   

I was going to squash in this:

  	 * invalidating TDP MMU roots must be done while holding mmu_lock for
-	 * write and in the same critical section as making the reload request,
+	 * write and in the same critical section as making the free request,
  	 * e.g. before kvm_zap_obsolete_pages() could drop mmu_lock and yield.

But then I realized that this needs better comments and that my knowledge of
this has serious holes.  Regarding this comment, this is my proposal:

         /*
          * Invalidated TDP MMU roots are zapped within MMU read_lock to be
          * able to walk the list of roots, but with the expectation of no
          * concurrent change to the pages themselves.  There cannot be
          * any yield between kvm_tdp_mmu_invalidate_all_roots and the free
          * request, otherwise somebody could grab a reference to the root
	 * and break that assumption.
          */
         if (is_tdp_mmu_enabled(kvm))
                 kvm_tdp_mmu_invalidate_all_roots(kvm);

However, for the second comment (the one in the context above), there's much
more.  From easier to harder:

1) I'm basically clueless about the TLB flush "note" above.

2) It's not clear to me what needs to use for_each_tdp_mmu_root; for
example, why would anything but the MMU notifiers use for_each_tdp_mmu_root?
It is used in kvm_tdp_mmu_write_protect_gfn, kvm_tdp_mmu_try_split_huge_pages
and kvm_tdp_mmu_clear_dirty_pt_masked.

3) Does it make sense that yielding users of for_each_tdp_mmu_root must
either look at valid roots only, or take MMU lock for write?  If so, can
this be enforced in tdp_mmu_next_root?

4) If the previous point is correct, _who_ could grab a reference and
not release it before kvm_tdp_mmu_zap_invalidated_roots runs?  That is,
is "somebody could grab a reference" an accurate explanation in the first
comment above?

Thanks,

Paolo

