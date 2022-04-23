Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4761150CC1F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiDWQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbiDWQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:05:53 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F22496E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:02:56 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1niIDl-0004Qj-VQ
        for linux-kernel@vger.kernel.org; Sat, 23 Apr 2022 18:02:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 3/3] binder: Use kmap_local_page() in
 binder_alloc_get_page()
Date:   Sat, 23 Apr 2022 18:02:48 +0200
Message-ID: <fad918d3-6923-5bec-7830-5cddf7a725d6@wanadoo.fr>
References: <20220423102421.16869-1-fmdefrancesco@gmail.com>
 <20220423102421.16869-4-fmdefrancesco@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: fr
In-Reply-To: <20220423102421.16869-4-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 23/04/2022 à 12:24, Fabio M. De Francesco a écrit :
> The use of kmap_atomic() is being deprecated in favor of kmap_local_page()
> where it is feasible. Each call of kmap_atomic() in the kernel creates
> a non-preemptible section and disable pagefaults. This could be a source
> of unwanted latency, so it should be only used if it is absolutely
> required, otherwise kmap_local_page() should be preferred.
> 
> With kmap_local_page(), the mapping is per thread, CPU local and not
> globally visible. Furthermore, the mapping can be acquired from any context
> (including interrupts).
> 
> Therefore, use kmap_local_page() / kunmap_local() in place of
> kmap_atomic() / kunmap_atomic().
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/android/binder_alloc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 0875c463c002..058595cc7ff0 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1250,17 +1250,17 @@ static int binder_alloc_do_buffer_copy(struct binder_alloc *alloc,
>   		page = binder_alloc_get_page(alloc, buffer,
>   					     buffer_offset, &pgoff);
>   		size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
> -		base_ptr = kmap_atomic(page);
> +		base_ptr = kmap_local_page(page);
>   		tmpptr = base_ptr + pgoff;
>   		if (to_buffer)
>   			memcpy(tmpptr, ptr, size);
>   		else
>   			memcpy(ptr, tmpptr, size);

in the same spirit as patch 1/3, memcpy_to_page() and memcpy_from_page() 
looks good candidate to avoid code duplication.

Not checked in details, but looks mostly the same.

Just my 2c.

CJ

>   		/*
> -		 * kunmap_atomic() takes care of flushing the cache
> +		 * kunmap_local() takes care of flushing the cache
>   		 * if this device has VIVT cache arch
>   		 */
> -		kunmap_atomic(base_ptr);
> +		kunmap_local(base_ptr);
>   		bytes -= size;
>   		pgoff = 0;
>   		ptr = ptr + size;


