Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F180462A5D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhK3C1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbhK3C1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:27:01 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C679C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:23:43 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id q14so18691764qtx.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gvzqJz94vLGpFdv+RcaZazHS6JrK6llpI1GaKwU2yRM=;
        b=AVH489rcehAtETfB3MzzucfgC0dqKQioMqgN9I4wv2Q9BkbUg6dSZX8fq3h1QAp1Cb
         SBLcP7Km59dYj9PBAhHKXApCFr9xkOmKgU5aAOIlZk8qo0Ozw5u5R3czDoh89ew3YtYN
         KF8+/QuJ/QKOZK8doTcbgTi51KXg3ID1TYDPJByaXrKpkYVOcknxxAn8ytXMtAiRic/B
         OjthrlE63yGvh8C8axJquePnyKBg0nfeT0uVqDZhbTIzfDK4tfT1qyZmsaWp4CNfCnEu
         kf+H/HzOGPv2qKx6o3lvNulwlbmSTwraySmuy06s7i5tFNV9KsnpOFXGYGdKL6wIsa8X
         wxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvzqJz94vLGpFdv+RcaZazHS6JrK6llpI1GaKwU2yRM=;
        b=4OYODFvevnoe0lFjXLc+sZWFhnfAgiYBh7C1+Lk3OcVQU3A5N3IT4SazxWLw4tctFq
         nDBiqKGiDlUvKk6k+moA3e649z6tumkAghzBAlqXnKuBCGjtjo+lqf3xlTGYXpldJVoe
         ZIFHdFkEHykF7hiRCcznZyFJZn98A9zXGzki36rr6ck8dNOr2e7T1/MOYLvIXhE3XBl3
         Zo/RO/JJt9Nf+QO+5D2sDxqXracpx+gJY9+q4b8v8CsndAQvaZzKID989TAKA+A8YUtv
         mSmOabM95zYN4FMZH1pshNdJt/Qoqx5Th3bQxN2EZ0nobB3Mdd+i2FJoMAdKyrCt2sGx
         3eFA==
X-Gm-Message-State: AOAM533WzPib/qTyfSFfWqlv5sto3nzsKg73TFmbuCTLUxc5kMIijN9e
        et8lTNK5rtYWFuQNznbhN/oo+JPcqXo=
X-Google-Smtp-Source: ABdhPJw9JRjyG6YBycm9s55OBGVGqyejjq/A/1snVQv9qBw1e6LxmcA6e2YPOFR6VQlIJg2NGxmCGw==
X-Received: by 2002:ac8:5949:: with SMTP id 9mr40099817qtz.522.1638239022399;
        Mon, 29 Nov 2021 18:23:42 -0800 (PST)
Received: from [192.168.1.201] (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.googlemail.com with ESMTPSA id s7sm10332988qta.31.2021.11.29.18.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 18:23:41 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH] tools/vm/page_owner_sort.c: add switch between culling by
 stacktrace and txt
To:     Yinan Zhang <zhangyinan2019@email.szu.edu.cn>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
Message-ID: <f0a8099b-3c60-3e34-078a-be3c1280ca61@gmail.com>
Date:   Mon, 29 Nov 2021 21:23:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20211129145658.2491-1-zhangyinan2019@email.szu.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 9:56 AM, Yinan Zhang wrote:
> Culling by comparing stacktrace would casue loss of some
> information. For example, if there exists 2 blocks which
> have the same stacktrace and the different head info
> 
> Page allocated via order 0, mask 0x108c48(...), pid 73696,
>   ts 1578829190639010 ns, free_ts 1576583851324450 ns
>   prep_new_page+0x80/0xb8
>   get_page_from_freelist+0x924/0xee8
>   __alloc_pages+0x138/0xc18
>   alloc_pages+0x80/0xf0
>   __page_cache_alloc+0x90/0xc8
> 
> Page allocated via order 0, mask 0x108c48(...), pid 61806,
>   ts 1354113726046100 ns, free_ts 1354104926841400 ns
>   prep_new_page+0x80/0xb8
>   get_page_from_freelist+0x924/0xee8
>   __alloc_pages+0x138/0xc18
>   alloc_pages+0x80/0xf0
>   __page_cache_alloc+0x90/0xc8
> 
> After culling, it would be like this
> 
> 2 times, 2 pages:
> Page allocated via order 0, mask 0x108c48(...), pid 73696,
>   ts 1578829190639010 ns, free_ts 1576583851324450 ns
>   prep_new_page+0x80/0xb8
>   get_page_from_freelist+0x924/0xee8
>   __alloc_pages+0x138/0xc18
>   alloc_pages+0x80/0xf0
>   __page_cache_alloc+0x90/0xc8
> 

This is working as designed. IMO there's no point in separating
allocations like this which differ only in PID and timestamp, since you
will get no grouping at all.

> The info of second block missed. So, add -c to turn on culling
> by stacktrace. By default, it will cull by txt.

Please keep the default to actually do something in the cull step.

> Signed-off-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
> ---
>   tools/vm/page_owner_sort.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
> index 1b2acf02d3cd..492be7f752c0 100644
> --- a/tools/vm/page_owner_sort.c
> +++ b/tools/vm/page_owner_sort.c
> @@ -51,6 +51,13 @@ int read_block(char *buf, int buf_size, FILE *fin)
>   	return -1; /* EOF or no space left in buf. */
>   }
>   
> +static int compare_txt(const void *p1, const void *p2)
> +{
> +	const struct block_list *l1 = p1, *l2 = p2;
> +
> +	return strcmp(l1->txt, l2->txt);
> +}
> +
>   static int compare_stacktrace(const void *p1, const void *p2)
>   {
>   	const struct block_list *l1 = p1, *l2 = p2;
> @@ -137,12 +144,14 @@ static void usage(void)
>   		"-m	Sort by total memory.\n"
>   		"-s	Sort by the stack trace.\n"
>   		"-t	Sort by times (default).\n"
> +		"-c	cull by comparing stacktrace instead of total block.\n"
>   	);
>   }
>   
>   int main(int argc, char **argv)
>   {
>   	int (*cmp)(const void *, const void *) = compare_num;
> +	int cull_st = 0;
>   	FILE *fin, *fout;
>   	char *buf;
>   	int ret, i, count;
> @@ -151,7 +160,7 @@ int main(int argc, char **argv)
>   	int err;
>   	int opt;
>   
> -	while ((opt = getopt(argc, argv, "mst")) != -1)
> +	while ((opt = getopt(argc, argv, "mstc")) != -1)
>   		switch (opt) {
>   		case 'm':
>   			cmp = compare_page_num;
> @@ -162,6 +171,9 @@ int main(int argc, char **argv)
>   		case 't':
>   			cmp = compare_num;
>   			break;
> +		case 'c':
> +			cull_st = 1;
> +			break;

Can we set a "cull_cmp" variable like cmp?

Looking forward, I think something like

	page_owner_sort --cull=stacktrace --sort=times foo bar

would be nice.

--Sean

>   		default:
>   			usage();
>   			exit(1);
> @@ -209,7 +221,10 @@ int main(int argc, char **argv)
>   
>   	printf("sorting ....\n");
>   
> -	qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
> +	if (cull_st == 1)
> +		qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
> +	else
> +		qsort(list, list_size, sizeof(list[0]), compare_txt);
>   
>   	list2 = malloc(sizeof(*list) * list_size);
>   	if (!list2) {
> @@ -219,9 +234,11 @@ int main(int argc, char **argv)
>   
>   	printf("culling\n");
>   
> +	long offset = cull_st ? &list[0].stacktrace - &list[0].txt : 0;
> +
>   	for (i = count = 0; i < list_size; i++) {
>   		if (count == 0 ||
> -		    strcmp(list2[count-1].stacktrace, list[i].stacktrace) != 0) {
> +		    strcmp(*(&list2[count-1].txt+offset), *(&list[i].txt+offset)) != 0) {
>   			list2[count++] = list[i];
>   		} else {
>   			list2[count-1].num += list[i].num;
> 

