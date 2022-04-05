Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026094F45AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444948AbiDEUIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388972AbiDEOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 10:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FCE612B767
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649164633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPr7NyzPsM6lb9uL4EUAQIbJ/AzbEssi4MJbl6X0Xkw=;
        b=gyfiaZjJmat9v0PEkyW5JNFs1MS19Ur+cA0Stj2apWveSJNIWM03RxuR/lH16CZp8ya/4S
        EIdfdRLo3HB9oBLTfpelAJX1Igmhl3R5qnFFCckaimVE8zIsir93jx33GqlFNe4ekpedt/
        d+sZk+P7e5zIv4zmoF6daZyuq2hEzjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-197-C5MEeRjqMN6bI0GoTEJNyA-1; Tue, 05 Apr 2022 09:17:12 -0400
X-MC-Unique: C5MEeRjqMN6bI0GoTEJNyA-1
Received: by mail-wm1-f72.google.com with SMTP id x8-20020a7bc768000000b0038e73173886so1238104wmk.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 06:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NPr7NyzPsM6lb9uL4EUAQIbJ/AzbEssi4MJbl6X0Xkw=;
        b=ooTvWU+5+uwieKLsbvTCCN4Cfuw2YuEgGnwpnb922sPNhY9I3ezEwgxXPTzDRrllzy
         IdiH62WgPxD8CU0NIDtZReV1Ma9OOOqvPgw+zdtcxYco23AdGA3uvt57ycvsKcU6rKsQ
         gVu5RfoifpXushA1czc4bvEbLPE3TVNOh7WotgFbu64w2Yr7SWskBBLH3UccFNZxI5n/
         zVUZF6JdbiM1OUitO3gaBckdYRyNxzfCAVQ1nV9vrKr1812SwfPlNrMBohrTU/g6mZ/J
         f2+shn8AgbdJHGgyumJ5d96dMpMuat4JXV4Tx9BIopL/N5mna7o8cwzuj/BIM8AgYzDv
         PLZg==
X-Gm-Message-State: AOAM533Bkxwg/6wvG5welr5vIuXodWIcgsnNEfEbxleri+tFb6Xu/E8k
        sqD/d1a8aHj0IT/LCFMY7j5f3ZEYBd2he1JMK+gbFQi5gsjnpvm0H1dVAMxZYN3spR00fZaGD5U
        PbOesCe8SvQ7E7dfuDKFFWtuh
X-Received: by 2002:a7b:c0c9:0:b0:38e:7d65:6e7f with SMTP id s9-20020a7bc0c9000000b0038e7d656e7fmr3069459wmh.168.1649164631099;
        Tue, 05 Apr 2022 06:17:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwO1qwBZcVBSXGotEJB514xkNDND8cMVp2SwXHyhGdkT8SjDU5/40/xNvyAtW7gDpIWAk6dQQ==
X-Received: by 2002:a7b:c0c9:0:b0:38e:7d65:6e7f with SMTP id s9-20020a7bc0c9000000b0038e7d656e7fmr3069438wmh.168.1649164630849;
        Tue, 05 Apr 2022 06:17:10 -0700 (PDT)
Received: from [10.32.181.87] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.googlemail.com with ESMTPSA id n65-20020a1c2744000000b003862bfb509bsm2115805wmn.46.2022.04.05.06.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Apr 2022 06:17:10 -0700 (PDT)
Message-ID: <68e1fd5f-d58b-695b-0fc7-bdc3e5491de7@redhat.com>
Date:   Tue, 5 Apr 2022 15:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH v5 036/104] KVM: x86/mmu: Explicitly check for MMIO
 spte in fast page fault
Content-Language: en-US
To:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
 <b0e81b4a4abfbe8bd6d43e4b1c0349a79517dfb0.1646422845.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <b0e81b4a4abfbe8bd6d43e4b1c0349a79517dfb0.1646422845.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 20:48, isaku.yamahata@intel.com wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Explicitly check for an MMIO spte in the fast page fault flow.  TDX will
> use a not-present entry for MMIO sptes, which can be mistaken for an
> access-tracked spte since both have SPTE_SPECIAL_MASK set.
> 
> The fast page fault handles the case of changing access bits without
> obtaining mmu_lock.  For example, clear write protect bit for dirty page
> tracking.  MMIO emulation is handled in a slow path.  So it doesn't affect

"MMIO sptes are handled in handle_mmio_page_fault for non-TDX VMs, so 
this patch does not affect them.  TDX will handle MMIO emulation through 
a hypercall instead".

For this comment, it is not necessary to talk about the slow path, since 
that is just where MMIO sptes are installed.  If the slow path is 
reached, fast_page_fault must not have seen is_mmio_spte(spte).

> @@ -3167,7 +3167,7 @@ static int fast_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
>   			break;
>   
>   		sp = sptep_to_sp(sptep);
> -		if (!is_last_spte(spte, sp->role.level))
> +		if (!is_last_spte(spte, sp->role.level) || is_mmio_spte(spte))
>   			break;
>   
>   		/*

I would include the check a couple lines before:

	if (!is_shadow_present_pte(spte) || is_mmio_spte(spte))

This matches what is in the commit message: the problem is that MMIO 
SPTEs are present in the TDX case, so you need to check them even if 
is_shadow_present_pte(spte) returns true.

Paolo

