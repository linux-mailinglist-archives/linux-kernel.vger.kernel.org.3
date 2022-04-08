Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855114F9818
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbiDHOdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236931AbiDHOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:33:09 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6AD38236A;
        Fri,  8 Apr 2022 07:31:05 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id u14so8841244pjj.0;
        Fri, 08 Apr 2022 07:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=K4RegTFlAS1vHtPsS6VQv2PGN8uUwFV5fmBAjh3ZjH8=;
        b=d+5p9MT5q19AAEpcwGB+UfzRygrFUbzH1pVC9pwTrmRrhhWcukdxwSO3Y1cBlkXqhc
         MkNegcMphJ6bcvuyDMSdd9qDYE4ZXxJpLLXljXZN6VewPZ3WvyDbhTEBKeDQ1QLxVvLj
         XK5rdQMaBttXaur5aVBbz4WlsxB9gp05c24WWR1Cy9r77mnDG3bq3dC7ma6fM5Btn7Qj
         n95OsfZBkxUH4ZVlfS0mhuJghtqrDs62EXNQklBdT8OMRkekkVBnAJI8jZJDRpyc8dt0
         AKQLB0PxMAieR3ecXGcKkkfOEwN02oSVENjZMJ5IH9fb5kXfg8i9u/Hna2Oeq2BAwt4d
         Y8PA==
X-Gm-Message-State: AOAM531q1fN5bEachA6scfke66PMnE5ffHM6D8o7l+nhrTJYW4DKgRjU
        WY3MAnt/WavhAhd0T/VFljI=
X-Google-Smtp-Source: ABdhPJzlFbVJCnytetIFsB8me3aL3szEJqcJz5yfU5STCm6cLL3hyv0A3UsC/wKsxjAvK80W74t9Qg==
X-Received: by 2002:a17:902:ec90:b0:154:5c1c:bbf with SMTP id x16-20020a170902ec9000b001545c1c0bbfmr20278440plg.56.1649428264730;
        Fri, 08 Apr 2022 07:31:04 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090a630a00b001c685cfd9d1sm12043002pjj.20.2022.04.08.07.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:31:04 -0700 (PDT)
Message-ID: <5d84c02f-62c6-6418-6629-cebd42dc2ca5@acm.org>
Date:   Fri, 8 Apr 2022 07:31:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 8/8] sbitmap: wake up the number of threads
 based on required tags
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, axboe@kernel.dk,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-9-yukuai3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220408073916.1428590-9-yukuai3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/22 00:39, Yu Kuai wrote:
> Always wake up 'wake_batch' threads will intensify competition and
> split io won't be issued continuously. Now that how many tags is required
> is recorded for huge io, it's safe to wake up baed on required tags.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   lib/sbitmap.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 8d01e02ea4b1..eac9fa5c2b4d 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -614,6 +614,26 @@ static inline void sbq_update_preemption(struct sbitmap_queue *sbq,
>   	WRITE_ONCE(sbq->force_tag_preemption, force);
>   }
>   
> +static unsigned int get_wake_nr(struct sbq_wait_state *ws, unsigned int nr_tags)

Consider renaming "get_wake_nr()" into "nr_to_wake_up()".

> +{
> +	struct sbq_wait *wait;
> +	struct wait_queue_entry *entry;
> +	unsigned int nr = 1;
> +
> +	spin_lock_irq(&ws->wait.lock);
> +	list_for_each_entry(entry, &ws->wait.head, entry) {
> +		wait = container_of(entry, struct sbq_wait, wait);
> +		if (nr_tags <= wait->nr_tags)
> +			break;
> +
> +		nr++;
> +		nr_tags -= wait->nr_tags;
> +	}
> +	spin_unlock_irq(&ws->wait.lock);
> +
> +	return nr;
> +}
> +
>   static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   {
>   	struct sbq_wait_state *ws;
> @@ -648,7 +668,7 @@ static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>   	smp_mb__before_atomic();
>   	atomic_set(&ws->wait_cnt, wake_batch);
>   	sbq_update_preemption(sbq, wake_batch);
> -	wake_up_nr(&ws->wait, wake_batch);
> +	wake_up_nr(&ws->wait, get_wake_nr(ws, wake_batch));
>   
>   	return true;
>   }

ws->wait.lock is unlocked after the number of threads to wake up has 
been computed and is locked again by wake_up_nr(). The ws->wait.head 
list may be modified after get_wake_nr() returns and before wake_up_nr() 
is called. Isn't that a race condition?

Thanks,

Bart.
