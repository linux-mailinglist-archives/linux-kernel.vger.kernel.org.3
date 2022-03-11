Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3497B4D5EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbiCKJ4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbiCKJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:56:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FE131B718B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646992549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0SbZtGCQk+RjFIs2wZUGH3GgdAqVUCvyBNpcfJWzG8I=;
        b=JlgEmcYzfuBiWCh3t3ulwyS8HjLGdQEvQ1mZvOkF+qY8GFoO84cZOSNGYGSv7GQQFO0OlP
        Jk5NbYETF7Th6J8pNBPkejGyM4e7jakT/UwHKhkHyA/GZ/gsp52VCGXrSLiwh7dj9Atg33
        yEP3wIAMiYChpCtScKV+9atudusJXlo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-fs-jA5FENqq-Qh4_JWvOzw-1; Fri, 11 Mar 2022 04:55:48 -0500
X-MC-Unique: fs-jA5FENqq-Qh4_JWvOzw-1
Received: by mail-wr1-f69.google.com with SMTP id a11-20020adffb8b000000b001efe754a488so2622165wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:55:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=0SbZtGCQk+RjFIs2wZUGH3GgdAqVUCvyBNpcfJWzG8I=;
        b=R3r7qgWPid1l255P1m+mnKHUukCD8mtUQS+lm2XPPt5DztAesjgwnhX8TBlhjFtAQD
         tP84mj2/fHw4eYljRNFhlxFiPd0fMXclTBiuEVrm8PqPLQkYGSnaDY5ESbNrmwNqgbki
         Y9UYDblHC2XVkTowcAX2lH0V7Z8Vt0Askjdbg4xZ2os70PnPNoLiQADmEUx48EBvZmUo
         HUNQkONZMlwJ6dH9qrDVgEfck5i5ykW1lwzBDomnuqJTe5EESbQ4A3JURkF+Q2OJhFz4
         NOtLmKy5gGMDQ60Ib4ZFVrvW2uPqkaFAbrjSFrRBEjHQNf711GuD7gJsU924detQKMRO
         IE9w==
X-Gm-Message-State: AOAM530iXUOiB9t/9O+Zece02VxQ3Ekahx/5f74YAKDncGzKSIVBMOjW
        +AnG3eWRYub403CV1uMIc2hoWTD5I+tlrt/9F2kp6CNST9GTcPHiAVHhWl747iYzjOo07LqQdRj
        /8F1HFnbw5MIZ9b1ACV3uPdbz
X-Received: by 2002:adf:f70a:0:b0:1ee:33bf:3864 with SMTP id r10-20020adff70a000000b001ee33bf3864mr6498093wrp.4.1646992547133;
        Fri, 11 Mar 2022 01:55:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwy7/m6Ad24W702h4xglXhkhq/XRbfI+NUlig4g23i0BZ8F3TjeAKyQUG7wWs7g/FTmvb0dbw==
X-Received: by 2002:adf:f70a:0:b0:1ee:33bf:3864 with SMTP id r10-20020adff70a000000b001ee33bf3864mr6498077wrp.4.1646992546843;
        Fri, 11 Mar 2022 01:55:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d498d000000b001f0587248c4sm6093300wrq.3.2022.03.11.01.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 01:55:46 -0800 (PST)
Message-ID: <7496e04f-5b34-b37c-381c-8444199f2321@redhat.com>
Date:   Fri, 11 Mar 2022 10:55:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/madvise: Use vma_lookup() instead of find_vma()
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220311082731.63513-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220311082731.63513-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.22 09:27, Miaohe Lin wrote:
> Using vma_lookup() verifies the start address is contained in the found
> vma. This results in easier to read the code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/madvise.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 5b6d796e55de..afd68bfc77d4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -883,8 +883,8 @@ static long madvise_populate(struct vm_area_struct *vma,
>  		 * our VMA might have been split.
>  		 */
>  		if (!vma || start >= vma->vm_end) {
> -			vma = find_vma(mm, start);
> -			if (!vma || start < vma->vm_start)
> +			vma = vma_lookup(mm, start);
> +			if (!vma)
>  				return -ENOMEM;
>  		}
>  

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

