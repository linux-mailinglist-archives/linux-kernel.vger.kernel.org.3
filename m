Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8742047D136
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbhLVLpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhLVLph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:45:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F76C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:45:37 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e5so4348476wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 03:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QjoNb5vM5ldUOVON2Gxca/tEx2Xoz7XugK8Pv65lPPg=;
        b=J4gd24a+jmBz5goQsAbvzRUX0ApxbJuOtd/In1JJTBeMsCSCBnHLB6JYmF0GTbn7+j
         CK87vaL1NQ94tnaza0mI7xjCB4TWSdtW/sytr59dMzDiVwdy2P1T6sXkgYl+ejh0mcBH
         y2dB8ddqg6qALNFx0+PQ4BBWwcPxg2BzSrgIg0fiyI/Q83goSv5s7Z0oXzXWfINICTXq
         dJZUgrqJfdBoX28PD3CIBo7//Hl9U7b+h4tCzesQcozwAP+PJZEvHs8Aj4C8xdaohOih
         Tqt6tW7fRXx4UmxLz7bOzPUbVh8oz8C7QbMgwn7hYe8uKP9dZ2rzaFVUJRwT4YM7DHbE
         0/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QjoNb5vM5ldUOVON2Gxca/tEx2Xoz7XugK8Pv65lPPg=;
        b=2L/yCYL1rSssgsi/aSPypRqfR/MTRcemSgP5NtIuqLlPcj8MLpyqPLzWjWU7vxdJlD
         TPSK7Mle+dF/brfzpIZWwnmxYNgArNUv8XL3TgtkDTpqVpWLu8XkAhY9g91yRF/zLZQ7
         vzuO4thSjXVAVgnUQxmuZt4rmemlu+N4/IQOKwmrT2ESPL2wS885iWsZIkaq8Ecok1XE
         KNbsDV6bGQtiO7/q/dFZIcUts9h8BmvU0VBqZ5257LG9Prvu3BzAHt/P4I5II61QGPGN
         kiTyMxO5Q4Ut+Azk6pKxTlRtepf2UOmteIzZPuUz3IjW2Rb7oc3wft2BDe3OGDjL+x8s
         FFpA==
X-Gm-Message-State: AOAM531M73vy8mQ7z07pfPxGVIr1upGZM8SQfwIady0E+/MSQeIQGqHH
        10REa+S+G+KSfQqfskMO9a+scg==
X-Google-Smtp-Source: ABdhPJziRP7YTjBvvVxjZlNbcIO5/HjYdWPjQMdI2Oc1n5R58vEl6w5OnRpZQag6WP8Us/UB0jSu4Q==
X-Received: by 2002:a5d:44ce:: with SMTP id z14mr1829621wrr.383.1640173535893;
        Wed, 22 Dec 2021 03:45:35 -0800 (PST)
Received: from ?IPV6:2003:d9:9708:7800:3dae:64a4:7964:a371? (p200300d9970878003dae64a47964a371.dip0.t-ipconnect.de. [2003:d9:9708:7800:3dae:64a4:7964:a371])
        by smtp.googlemail.com with ESMTPSA id n15sm1625467wru.66.2021.12.22.03.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 03:45:35 -0800 (PST)
Message-ID: <63840bf3-2199-3240-bdfa-abb55518b5f9@colorfullife.com>
Date:   Wed, 22 Dec 2021 12:45:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] ipc/sem: do not sleep with a spin lock held
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     vvs@virtuozzo.com, shakeelb@google.com, rdunlap@infradead.org,
        dbueso@suse.de, unixbhaskar@gmail.com, chi.minghao@zte.com.cn,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
References: <20211222081026.484058-1-chi.minghao@zte.com.cn>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20211222081026.484058-1-chi.minghao@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minghao,

On 12/22/21 09:10, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> We can't call kvfree() with a spin lock held, so defer it.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Could you add

Fixes: fc37a3b8b438 ("[PATCH] ipc sem: use kvmalloc for sem_undo 
allocation")

Cc: stable@vger.kernel.org

I will review/test the change in the next few days.

Especially, I would like to check if there are further instances where 
the same mistake was made.

> /**
> * kvfree() - Free memory.
> * @addr: Pointer to allocated memory.
> *
> * kvfree frees memory allocated by any of vmalloc(), kmalloc() or 
> kvmalloc().
> * It is slightly more efficient to use kfree() or vfree() if you are 
> certain
> * that you know which one to use.
> *
> * Context: Either preemptible task context or not-NMI interrupt.
> */
>
As an independent change: Should we add a


       might_sleep_if(!in_interrupt());

into kvfree(), to trigger bugs more easily?

> ---
>   ipc/sem.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 6693daf4fe11..0dbdb98fdf2d 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -1964,6 +1964,7 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>   	 */
>   	un = lookup_undo(ulp, semid);
>   	if (un) {
> +		spin_unlock(&ulp->lock);
>   		kvfree(new);
>   		goto success;
>   	}
> @@ -1976,9 +1977,8 @@ static struct sem_undo *find_alloc_undo(struct ipc_namespace *ns, int semid)
>   	ipc_assert_locked_object(&sma->sem_perm);
>   	list_add(&new->list_id, &sma->list_id);
>   	un = new;
> -
> -success:
>   	spin_unlock(&ulp->lock);
> +success:
>   	sem_unlock(sma, -1);
>   out:
>   	return un;


