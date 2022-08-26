Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D7A5A2173
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 09:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245111AbiHZHKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 03:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiHZHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 03:10:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B214646F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661497813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wRfHC8y5N2h+J4cn5c41LQNHjlhGvIk+K6AECyuILZg=;
        b=D1RAinlIHgpJGxNQuFOeq+409pP4A2hbhGrcQZL/dsusY31MlhdzQFXUbUHGGoDosa40MH
        5hsTNUdLygLhlPSQu1sOP0eZKrLzHXoHkA6Yv4eL4AVA14c+zistxQyNx5prDnGcXimMAp
        sFPwIIlv0KN3ZRta6+RDKwtdbq2W1V4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-90-SDdo-IGuPsiIEaaHboe1Vg-1; Fri, 26 Aug 2022 03:10:11 -0400
X-MC-Unique: SDdo-IGuPsiIEaaHboe1Vg-1
Received: by mail-ed1-f69.google.com with SMTP id y11-20020a056402270b00b00446a7e4f1bcso637553edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 00:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wRfHC8y5N2h+J4cn5c41LQNHjlhGvIk+K6AECyuILZg=;
        b=KGBCnzbszHnz028/nsOHQffs39i/pEd8xlZ9SYkhY70smkdrj2s7Zeh8/FaQysbeTs
         IaEqzdPBmHgl0r2Sq2kXU3dYiER0CvWaeShmp4vKnuQUQBNyK7/+ewj3ZP/SMIBh7niF
         LxgNoKecUKq/dF0Sq5GyMbYwh22O52ZAgnoa9aIgbT211naWIeL9lrivkUL9ptDQ75rl
         ZhcWS+QROYF2G3vU5iFg1TIJJYONWGMHr7u5v5UAvqXpZopp+tYnJmO6iX6vVwT3nnZX
         U744q7bC2hEBPb3p88EMblt/mU034PDqXTxZieGZWmTyl+/MAvn2rc88FLFoBkk1zXu4
         NkWA==
X-Gm-Message-State: ACgBeo3aNt+oDdn2f52+Cx0RNIQ2r4jWFxVVm/muKmAEX1IOlzz4gUR7
        cojyltNuQ9h7w59y1wS44jeUgLL6HuMrw1H4Mtkv3JMsGCSkx3wu5oz8Ug+U3++iXQeAkqbc3qF
        N1l5wedEurKAy+IKkhm5PwOnQ
X-Received: by 2002:a05:6402:42ca:b0:446:8f11:3b96 with SMTP id i10-20020a05640242ca00b004468f113b96mr5833203edc.353.1661497810484;
        Fri, 26 Aug 2022 00:10:10 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4pO9oL2N59UL8jr9N9XCriMit+V7lYj1e2Qps4gO6+DSHcxbRu0RlNAXgebza2w2eywMg0rg==
X-Received: by 2002:a05:6402:42ca:b0:446:8f11:3b96 with SMTP id i10-20020a05640242ca00b004468f113b96mr5833189edc.353.1661497810268;
        Fri, 26 Aug 2022 00:10:10 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id u6-20020a170906c40600b0073dd1ac2fc8sm511393ejz.195.2022.08.26.00.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 00:10:09 -0700 (PDT)
Message-ID: <c5d40522-037d-e324-697b-23e5e4686d58@redhat.com>
Date:   Fri, 26 Aug 2022 09:10:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] sched/deadline: Add compare_task_rq helper
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>
References: <20220826031143.9501-1-shangxiaojing@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20220826031143.9501-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 05:11, Shang XiaoJing wrote:
> Wrap repeated code in helper function compare_task_rq, which return true
> if there is no deadline task on the rq at all, or task's deadline
> earlier than the rq.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  kernel/sched/deadline.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d116d2b9d2f9..4a40a462717c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1810,6 +1810,13 @@ static void yield_task_dl(struct rq *rq)
>  
>  #ifdef CONFIG_SMP

I see the value of this helper, but "compare_task_rq" is making things more confuse.

Choose a more descriptive name, like, dl_task_is_earliest_deadline() ?

> +static inline bool compare_task_rq(struct task_struct *p, struct rq *rq)
> +{
> +	return (!rq->dl.dl_nr_running ||
> +		dl_time_before(p->dl.deadline,
> +			       rq->dl.earliest_dl.curr));
> +}
> +

-- Daniel

