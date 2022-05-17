Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C0652A5A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349605AbiEQPGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbiEQPG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:06:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49A1EEFE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:06:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h14so5518494wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=20L1AnQGYzSQVKR04Jw8F77QikCZxBe7S+3hNsTAc6c=;
        b=L+BBagoUwR1uYtW3iG+pr5VO++HDak5anTgdsDdFZzf4BODadEmws7TagUPulN2hjI
         ewXJs7vGg8kfKeBvSiEHaGvxioLiu/DT6fL6JWWuudqduU1SF7AaSqX+m3XSqk/H+wnJ
         HkTsGG8shh5JIsUabop9HasWyaOmivkHFCaVJRHP+XM2rjhdzkrrvVh2SPKFGRiwgm6l
         jMMxwQZym0vwvclHA+OkHW1Yrtq7QRxpKdfO3ETiOBjRXoPj6Dg7dGT5F3W01ryjrjNI
         dxwepdFgG6xQdaZtwWpyBHzxTLn1upjdSKrzCkJEbrxmMVCdzwzg8HizhGDWTw+HxQTT
         p3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=20L1AnQGYzSQVKR04Jw8F77QikCZxBe7S+3hNsTAc6c=;
        b=rmZ6dav6Hk+YG/VsKMt7ScAogaYR3/uLm9jzM/YwIMCHhhSDMU90MoE+jVvn6U16BX
         Kw7xiXFme3ZAqc0soV538wmuZ0R2fywImJt/rwB4HfNYwqr17LXNdBAbpLUxXCm6UC0E
         HudyoE/8LJz5+RnlvuJnQ6TwNXh0l5SNbDj66UHoXHil3lcithQAJa0xRYq2VK4SxNve
         GzBIAoetE4dnPQDHCOKfyVCfMRnG+VfAbDn5RMDkyTqN05jqPK2RwoBdXRyL2gmxi2IO
         gtl24D6ko6Wpj/2Upws7Di+qBN4hnU/WplYQqeOo+IzyJIEUWH11aUm5EpLgIHfZZsDm
         F4pA==
X-Gm-Message-State: AOAM5317loXRefXY4los6TSpp/OWnzhzet7oXY8PI36zRUYiyKPgyj3F
        m5AK4qZcwHbgcpiNm8vfHwnVmRfZ6fp6gg==
X-Google-Smtp-Source: ABdhPJzf+iK30k9T3XnmMSIiRKp/GAivrAHeuLczhBfSCL2rARFMlhGl0EKqhd2d4xWr2T/yFEhDKQ==
X-Received: by 2002:a5d:650f:0:b0:20d:77b:702b with SMTP id x15-20020a5d650f000000b0020d077b702bmr9925244wru.78.1652799984887;
        Tue, 17 May 2022 08:06:24 -0700 (PDT)
Received: from [192.168.0.17] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id i12-20020adfb64c000000b0020d07e7895csm6230537wre.59.2022.05.17.08.06.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 08:06:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more
 accurate
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <740D270D-8723-4399-82CC-26CD861843D7@linaro.org>
Date:   Tue, 17 May 2022 17:06:22 +0200
Cc:     Yu Kuai <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <22FEB802-2872-45A7-8ED8-2DE7D0D5E6CD@linaro.org>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-3-yukuai3@huawei.com>
 <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
 <740D270D-8723-4399-82CC-26CD861843D7@linaro.org>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 17 mag 2022, alle ore 16:21, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 16 mag 2022, alle ore 11:56, Jan Kara <jack@suse.cz> ha =
scritto:
>>=20
>> On Fri 13-05-22 10:35:07, Yu Kuai wrote:
>>> bfq_has_work() is using busy_queues currently, which is not accurate
>>> because bfq_queue is busy doesn't represent that it has requests. =
Since
>>> bfqd aready has a counter 'queued' to record how many requests are =
in
>>> bfq, use it instead of busy_queues.
>>>=20
>=20
> The number of requests queued is not equal to the number of busy
> queues (it is >=3D).

No, sorry. It is actually !=3D in general.

In particular, if queued =3D=3D 0 but there are busy queues (although
still waiting for I/O to arrive), then responding that there is no
work caused blk-mq to stop asking, and hence an I/O freeze.  IOW I/O
eventually arrives for a busy queue, but blk-mq does not ask for a new
request any longer.  But maybe things have changed around bfq since
then.

Paolo

>  If this patch is based on this assumption then
> unfortunately it is wrong :(
>=20
> Paolo
>=20
>>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus =
the
>>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>>=20
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>=20
>> Looks good. Feel free to add:
>>=20
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>=20
>> 								Honza
>>=20
>>> ---
>>> block/bfq-iosched.c | 16 ++++++++++++----
>>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 61750696e87f..740dd83853a6 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request =
*rq)
>>>=20
>>> 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>>> 	bfqq->queued[rq_is_sync(rq)]++;
>>> -	bfqd->queued++;
>>> +	/*
>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>>> +	 * may be read without holding the lock in bfq_has_work().
>>> +	 */
>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
>>>=20
>>> 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
>>> 		bfq_check_waker(bfqd, bfqq, now_ns);
>>> @@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct =
request_queue *q,
>>> 	if (rq->queuelist.prev !=3D &rq->queuelist)
>>> 		list_del_init(&rq->queuelist);
>>> 	bfqq->queued[sync]--;
>>> -	bfqd->queued--;
>>> +	/*
>>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>>> +	 * may be read without holding the lock in bfq_has_work().
>>> +	 */
>>> +	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
>>> 	elv_rb_del(&bfqq->sort_list, rq);
>>>=20
>>> 	elv_rqhash_del(q, rq);
>>> @@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct =
blk_mq_hw_ctx *hctx)
>>> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
>>>=20
>>> 	/*
>>> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>>> +	 * Avoiding lock: a race on bfqd->queued should cause at
>>> 	 * most a call to dispatch for nothing
>>> 	 */
>>> 	return !list_empty_careful(&bfqd->dispatch) ||
>>> -		bfq_tot_busy_queues(bfqd) > 0;
>>> +		READ_ONCE(bfqd->queued);
>>> }
>>>=20
>>> static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
>>> --=20
>>> 2.31.1
>>>=20
>> --=20
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
>=20

