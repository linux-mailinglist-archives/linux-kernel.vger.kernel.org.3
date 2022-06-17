Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED86054F206
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380552AbiFQHeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380228AbiFQHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 750714A3C1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655451236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U1oqihi25ZAmVelpomlVi58IVrIjPbxaxEmOpvII5S8=;
        b=WzCNcaqZeanjtJ6ygXM2xVqpmpEGKmB9T/Zpf2ACAPmNavvM5B6YM7oWu7yp6uc1vu3s9S
        teUkViSkziiBZqorVVAYpY7lvv2S/1cOUsnFcHVgXDw+WohWmC3g4wDrOxTuz8hwv83zn6
        at6oh96tf8W7R31iI3NxN5s2emkZRVc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-ThgQpbt9O8GnTmCBYhvxqQ-1; Fri, 17 Jun 2022 03:33:54 -0400
X-MC-Unique: ThgQpbt9O8GnTmCBYhvxqQ-1
Received: by mail-wm1-f71.google.com with SMTP id m23-20020a05600c3b1700b0039c6e3c169aso1863607wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=U1oqihi25ZAmVelpomlVi58IVrIjPbxaxEmOpvII5S8=;
        b=O8hIrk0w5rb7Re4hguagVtyA151CTudpB2p4hxQIwgb68q8fKS/9ykLx0Xafqandze
         utnEjsOjpdiJlx9tfVRZGUcWB0IbrJzFq+f8uFnADFk8Ry0NLpqieWZBMNIuZ0870BjI
         JYigNcXacktTnZX9X26F4HIFhup02NhSiLSqF3Dor+e3Fzkl5iFaSzVP+h9pCuWMedOQ
         ALZeTr0IhLjj4CKmplKHQR42Ep8yEVBXLdnSevfdIQHakD+OhpKJ8X27fgOqwCf3hmOb
         +JhMhbtqhU7iC/CkBOljNKh5/sj6WBTscYjsAEK3q4zn7MERirZfsVzepfZQhirC8oge
         cxXQ==
X-Gm-Message-State: AJIora/GF575Y100O5u5gKoBtsGecE9tvTtwKpcURY4cOGuAlaLbZypm
        WJ8sTDTEb+sT1LsPRUnPt/RH76x1vtCURwnJWCEILmAnZsf7Ywep+8Ox4vE/RIg2oorNgKoSbyT
        jesnM397NX5Da7wS3sOM9l9y0
X-Received: by 2002:adf:f704:0:b0:211:7eed:4412 with SMTP id r4-20020adff704000000b002117eed4412mr8050532wrp.165.1655451233022;
        Fri, 17 Jun 2022 00:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sVPZa04KCjXqes8L1HH3PmDvnvIn7RrOQ/UXO776OYHW4fRBWpuzuSN29EGefiVQ7Hf0C2sA==
X-Received: by 2002:adf:f704:0:b0:211:7eed:4412 with SMTP id r4-20020adff704000000b002117eed4412mr8050508wrp.165.1655451232694;
        Fri, 17 Jun 2022 00:33:52 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:7e00:bb5b:b526:5b76:5824? (p200300cbc70a7e00bb5bb5265b765824.dip0.t-ipconnect.de. [2003:cb:c70a:7e00:bb5b:b526:5b76:5824])
        by smtp.gmail.com with ESMTPSA id ay1-20020a05600c1e0100b0039c60e33702sm4516697wmb.16.2022.06.17.00.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:33:52 -0700 (PDT)
Message-ID: <76e468b4-c6ac-426c-7ec9-99c620e08cda@redhat.com>
Date:   Fri, 17 Jun 2022 09:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-2-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm/swapfile: make security_vm_enough_memory_mm()
 work as expected
In-Reply-To: <20220608144031.829-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.22 16:40, Miaohe Lin wrote:
> security_vm_enough_memory_mm() checks whether a process has enough memory
> to allocate a new virtual mapping. And total_swap_pages is considered as
> available memory while swapoff tries to make sure there's enough memory
> that can hold the swapped out memory. But total_swap_pages contains the
> swap space that is being swapoff. So security_vm_enough_memory_mm() will
> success even if there's no memory to hold the swapped out memory because

s/success/succeed/

> total_swap_pages always greater than or equal to p->pages.
> 
> In order to fix it, p->pages should be retracted from total_swap_pages

s/retracted/subtracted/

> first and then check whether there's enough memory for inuse swap pages.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ec4c1b276691..d2bead7b8b70 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2398,6 +2398,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	struct filename *pathname;
>  	int err, found = 0;
>  	unsigned int old_block_size;
> +	unsigned int inuse_pages;
>  
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -2428,9 +2429,13 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  		spin_unlock(&swap_lock);
>  		goto out_dput;
>  	}
> -	if (!security_vm_enough_memory_mm(current->mm, p->pages))
> -		vm_unacct_memory(p->pages);
> +
> +	total_swap_pages -= p->pages;
> +	inuse_pages = READ_ONCE(p->inuse_pages);
> +	if (!security_vm_enough_memory_mm(current->mm, inuse_pages))
> +		vm_unacct_memory(inuse_pages);
>  	else {
> +		total_swap_pages += p->pages;

That implies that whenever we fail in security_vm_enough_memory_mm(),
that other concurrent users might see a wrong total_swap_pages.

Assume 4 GiB memory and 8 GiB swap. Let's assume 10 GiB are in use.

Temporarily, we'd have

CommitLimit    4 GiB
Committed_AS  10 GiB

Not sure if relevant, but I wonder if it could be avoided somehow?


Apart from that, LGTM.

-- 
Thanks,

David / dhildenb

