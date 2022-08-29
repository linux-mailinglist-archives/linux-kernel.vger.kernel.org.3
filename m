Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555AB5A4531
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiH2Ies (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiH2Ie3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE8958DDC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661762035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hM8HJaijm1Mkioa6hopD9yAVjvlgH6+HcTEXEv171y0=;
        b=JPPM7QJ21wPis65TWXOw3+5IQVwgn/F7gpL8c83nUhLfmYC7e0E34RI+N9EhT/vWCMGQ3c
        x9f5FG692SSCEM7INRi1SRVvR70dj8GFASdv/H9nY5Lde4I11R8CPtYLQw1XTmag5dUXzM
        240ichwQ//NVh4CF2WyO4Mu0I/3eor8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-WuILL2OoP0S_is-V4jm7dQ-1; Mon, 29 Aug 2022 04:33:53 -0400
X-MC-Unique: WuILL2OoP0S_is-V4jm7dQ-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640235d400b0043e1e74a495so5069222edc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hM8HJaijm1Mkioa6hopD9yAVjvlgH6+HcTEXEv171y0=;
        b=bGGPl87gqvn9l/7pvGsNeCXwnYEXXV1tW5W5vXBDC4zWbeAshEaoM5hZ9Hrwcr/kkc
         LmkazgoIpr8TfB129L9Hn+Al5Ue7C4miNFGbFf/XU5YIL9Wj4hvK08eV9fE7SCje7Xea
         u/AfS8tV9p+KfyurmAqPsgcK1VMIx++M6V50p4ZZk7QBfMrADmgYX8eTqRGaS709lwKS
         if6zn+KAf/R7Ia4nQwChb667o/oAI7ccxy48SCbCou2+0yZUmBfMgTEjYfjZi4igxoC0
         lBvgASLLFbv+oYyktr4hCrts0bTeacosk3a+2VCaCtkkgr//tAZ0YcDlWiQJZdwaWWG8
         o6wA==
X-Gm-Message-State: ACgBeo0PsS8S1p79Js3lA9Ik0lR4UMUB/xCEY+WGsVSzqm1e2SEF8NEC
        AsUPVQbzRwJPlwKgp0bUqUYFPv9x0rFKwqQ5krIckZMjYios6E54jqmXHYnjApTgRHbzR6sV0Gx
        k8ZToa+//VSxOLYaadZHBvj5X
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id xf9-20020a17090731c900b00740ef932ffdmr8452823ejb.584.1661762032238;
        Mon, 29 Aug 2022 01:33:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR70UPPGbBViyRTVwz/+mggKcBfe/vGVnpnvQcgVk/BYNS9tIZjxZivQ97eKHE8mipYj76UHAw==
X-Received: by 2002:a17:907:31c9:b0:740:ef93:2ffd with SMTP id xf9-20020a17090731c900b00740ef932ffdmr8452811ejb.584.1661762032017;
        Mon, 29 Aug 2022 01:33:52 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id s14-20020a1709067b8e00b0073dc60271b2sm4242195ejo.32.2022.08.29.01.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 01:33:51 -0700 (PDT)
Message-ID: <3a623696-a0f9-2246-420d-aee88d6acd75@redhat.com>
Date:   Mon, 29 Aug 2022 10:33:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] sched/deadline: Save processing meaningless ops in
 dl_task_offline_migration
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220827020430.29415-1-shangxiaojing@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220827020430.29415-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/22 04:04, Shang XiaoJing wrote:
> Task's bw will be sub from old rd, and add to new rd, even though
> find_lock_later_rq returns a new rq that belong to the same rd with old
> rq. Save ops for moving task's bw if rd is not changed.

This subject is not good. Please change it to a "meaningful" one, describing the
change, not its consequence.

-- Daniel
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  kernel/sched/deadline.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3bf4b12ec5b7..58ca9aaa9c44 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -714,20 +714,22 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
>  		add_rq_bw(&p->dl, &later_rq->dl);
>  	}
>  
> -	/*
> -	 * And we finally need to fixup root_domain(s) bandwidth accounting,
> -	 * since p is still hanging out in the old (now moved to default) root
> -	 * domain.
> -	 */
> -	dl_b = &rq->rd->dl_bw;
> -	raw_spin_lock(&dl_b->lock);
> -	__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> -	raw_spin_unlock(&dl_b->lock);
> +	if (&rq->rd != &later_rq->rd) {
> +		/*
> +		 * And we finally need to fixup root_domain(s) bandwidth accounting,
> +		 * since p is still hanging out in the old (now moved to default) root
> +		 * domain.
> +		 */
> +		dl_b = &rq->rd->dl_bw;
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_sub(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
> +		raw_spin_unlock(&dl_b->lock);
>  
> -	dl_b = &later_rq->rd->dl_bw;
> -	raw_spin_lock(&dl_b->lock);
> -	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
> -	raw_spin_unlock(&dl_b->lock);
> +		dl_b = &later_rq->rd->dl_bw;
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(later_rq->rd->span));
> +		raw_spin_unlock(&dl_b->lock);
> +	}
>  
>  	set_task_cpu(p, later_rq->cpu);
>  	double_unlock_balance(later_rq, rq);

