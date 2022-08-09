Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB4A58D906
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiHIM5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243101AbiHIM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:57:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F09E14D2E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660049861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3cWe7pcfL+jSpxT9+fiiD647kCcCtDZS7mj9Rl3zBQ=;
        b=b6HvVomhT9PBiUygDb7faYgEUhCijnr0/Kr6wBQ4ep3t3mDQHtqiyBaXppShaYbhSejhLL
        opxnybZiWu2xsH6fL+uJwq6pdGbVsMofDgjgXaIeZUqWJynL0g4g/UMNyP+xA/pAqyaTor
        12KapC4w8baFrM+kvwxa1uWOvUhvh+8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-9t-xeZLtOLOdMrtwy8LQIQ-1; Tue, 09 Aug 2022 08:57:34 -0400
X-MC-Unique: 9t-xeZLtOLOdMrtwy8LQIQ-1
Received: by mail-ed1-f70.google.com with SMTP id w5-20020a05640234c500b0043dda025648so7200791edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 05:57:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=F3cWe7pcfL+jSpxT9+fiiD647kCcCtDZS7mj9Rl3zBQ=;
        b=KYUIB7PU4aB8Xdnd9LMJnqYkxxQKwSH9zsyag3cuLrEz1N714QnBXZ/I7EAfr/BTkp
         /+fIDGft9SUlabpitoU4vVFBtN70qI7VLHpprPYKIkfi1+wqX0+t1TesUK0Ln/SNbWQa
         vuo6+Pyv5Faec+aaF5BA+z9NIvshcge/tOyEyR7cQRc5PoM1ZTBh0aUzJr0yEaoPsFro
         jzrcoj916ro9oJwWklaxPuMj5CAy0AosDPrb9yfJG7KXZneXInpZjkniNPDQAHh3S8EW
         rkXvYLI3Cdv3lD2xhhX6J4tVnAL4NLEMgk/LC3z1kkm+oGeNHO5k5gHfBz6ZOfe7VH/Q
         ceIw==
X-Gm-Message-State: ACgBeo2ALLtV+Xhp51WJ1SoieiaiJg/LW7pRbzxiN/0FyUCjV1MXCxt1
        Kd+S85U5q6Zc+cSbQW6Ojm5ZHW73DR5ESd38CcFeRib1J9KdTLMIe6GnvU4WSKK+x9XQzJ7yjQ6
        YTc1cjO63T7Bu2rGY2n+Dy2s6
X-Received: by 2002:a50:ff04:0:b0:43d:67a7:dd2d with SMTP id a4-20020a50ff04000000b0043d67a7dd2dmr21829916edu.11.1660049853469;
        Tue, 09 Aug 2022 05:57:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5GIr5QJ52aSSx6gxZKOjLvTfr2Ce6VOb3LUggNaFF2sRhog+jgdqCgASBpgj2vWfyB2CEL6w==
X-Received: by 2002:a50:ff04:0:b0:43d:67a7:dd2d with SMTP id a4-20020a50ff04000000b0043d67a7dd2dmr21829900edu.11.1660049853298;
        Tue, 09 Aug 2022 05:57:33 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id y2-20020a170906070200b007306df330e5sm1131474ejb.12.2022.08.09.05.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 05:57:32 -0700 (PDT)
Message-ID: <36634375-e7ee-e28e-20dd-9ab1ebdd8040@redhat.com>
Date:   Tue, 9 Aug 2022 14:57:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Mingwei Zhang <mizhang@google.com>,
        Ben Gardon <bgardon@google.com>
References: <20220805230513.148869-1-seanjc@google.com>
 <20220805230513.148869-9-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/8] KVM: x86/mmu: explicitly check nx_hugepage in
 disallowed_hugepage_adjust()
In-Reply-To: <20220805230513.148869-9-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/22 01:05, Sean Christopherson wrote:
>   	    !is_large_pte(spte)) {
> +		u64 page_mask;
> +
> +		/*
> +		 * Ensure nx_huge_page_disallowed is read after checking for a
> +		 * present shadow page.  A different vCPU may be concurrently
> +		 * installing the shadow page if mmu_lock is held for read.
> +		 * Pairs with the smp_wmb() in kvm_tdp_mmu_map().
> +		 */
> +		smp_rmb();
> +
> +		if (!spte_to_child_sp(spte)->nx_huge_page_disallowed)
> +			return;
> +

I wonder if the barrier shouldn't be simply in to_shadow_page(), i.e. 
always assume in the TDP MMU code that sp->xyz is read after the SPTE 
that points to that struct kvm_mmu_page.

Paolo

