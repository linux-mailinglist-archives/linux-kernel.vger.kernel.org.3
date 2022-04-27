Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59540511B68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiD0ONs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiD0ONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:13:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557EA50441
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:10:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i62so1550750pgd.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QROBmO2BAVk9SZQzJJmoimXjF1FyGUSBf/Gpm01j1MQ=;
        b=G5NEajlu9uY1Ou6Q4brZAvezHexAyL3QfOSOc8h1txtQJf0Xd/+vA3qeT36tqqESOj
         wTFpnOcOPIOKWUHbUPDdwCFrVHoJG6AkTw6aaZbnL1mdnUqLg5k4o5M5lhtJai8QQBZs
         DP3kJuN+WuJuYqwoXWcnTmke+dbsgN1tyzI8F1FJ2S+pbcbmIux7uM0MPbcGaZY8C4yX
         FuVFuI/k1AmaYQF0SMRbwu2KLXGvIL4N4ZYcCypfI3+EZ2WLsMydNRr1DHATzO1FM3Vm
         cx7QirpY6fVmF2H9F8bxbpYX/MR2Mq0t2N4MBi7Ftl1XXZsSqZ99gTGonkvtEwq9BWiB
         Y5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QROBmO2BAVk9SZQzJJmoimXjF1FyGUSBf/Gpm01j1MQ=;
        b=BhHUA94lkBAnL6dzKvZbLoK5pUOUoij8F3LyWjtLqGLtW54zTI+TV+8BCTuNvG2oS6
         ytMdsndH3FNMZIzUC9Xp2aMIPD83f1JpMzqtVAhEhdlvl+MtCBn35laDbAJ/uFhbmRwi
         H4oTx8GFXWTmA1o9Uob+rBQsxhobHh2ZpkAkD5jnfi/K57yWDYRLJ4dhO6jr5UOV1kRM
         N4LJTVXuCEWrnnOGdLr9N1gKRNNUje4Padm6avur2bvDlIj6Q3H4WJE/90++S41UF8z/
         Ar3wdKF/GEdMtu1utFOb3YOVAQPFvW/K8h2nynM7f9m7dsiQQm5NzQV/M+dMjFyMUG6Q
         fK4Q==
X-Gm-Message-State: AOAM530ESMRBA82X9uBgHkEeMzlrcEANqhADMdqNR8Um682F7ZRbeIOV
        kTZ7uqtZ3axWbb4SFWuK+x1VFjJY11H4bA==
X-Google-Smtp-Source: ABdhPJyFLS6l1LQOaK/YVk0cZXiXdB1q3tmJnGJxTwec5i+dzy0026F+cezHkoTB1iXo/vtNJOsk3w==
X-Received: by 2002:a65:6bd6:0:b0:39d:4f85:9ecf with SMTP id e22-20020a656bd6000000b0039d4f859ecfmr24635802pgw.336.1651068620373;
        Wed, 27 Apr 2022 07:10:20 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j19-20020a056a00235300b0050a858af58fsm20544882pfj.145.2022.04.27.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 07:10:20 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:10:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH v2 6/8] KVM: Fix multiple races in gfn=>pfn cache refresh
Message-ID: <YmlOyISNFbrztPky@google.com>
References: <20220427014004.1992589-1-seanjc@google.com>
 <20220427014004.1992589-7-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427014004.1992589-7-seanjc@google.com>
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

On Wed, Apr 27, 2022, Sean Christopherson wrote:
> Finally, the refresh logic doesn't protect against concurrent refreshes
> with different GPAs (which may or may not be a desired use case, but its
> allowed in the code), nor does it protect against a false negative on the
> memslot generation.  If the first refresh sees a stale memslot generation,
> it will refresh the hva and generation before moving on to the hva=>pfn
> translation.  If it then drops gpc->lock, a different user can come along,
> acquire gpc->lock, see that the memslot generation is fresh, and skip
> the hva=>pfn update due to the userspace address also matching (because
> it too was updated).  Address this race by adding an "in-progress" flag
> so that the refresh that acquires gpc->lock first runs to completion
> before other users can start their refresh.

...

> @@ -159,10 +249,23 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
>  
>  	write_lock_irq(&gpc->lock);
>  
> +	/*
> +	 * If another task is refreshing the cache, wait for it to complete.
> +	 * There is no guarantee that concurrent refreshes will see the same
> +	 * gpa, memslots generation, etc..., so they must be fully serialized.
> +	 */
> +	while (gpc->refresh_in_progress) {
> +		write_unlock_irq(&gpc->lock);
> +
> +		cond_resched();
> +
> +		write_lock_irq(&gpc->lock);
> +	}
> +	gpc->refresh_in_progress = true;

Adding refresh_in_progress can likely go in a separate patch.  I'll plan on doing
that in a v3 unless it proves to be painful.

> @@ -246,9 +296,26 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
>  	}
>  
>   out:
> +	/*
> +	 * Invalidate the cache and purge the pfn/khva if the refresh failed.
> +	 * Some/all of the uhva, gpa, and memslot generation info may still be
> +	 * valid, leave it as is.
> +	 */
> +	if (ret) {
> +		gpc->valid = false;
> +		gpc->pfn = KVM_PFN_ERR_FAULT;
> +		gpc->khva = NULL;
> +	}
> +
> +	gpc->refresh_in_progress = false;
