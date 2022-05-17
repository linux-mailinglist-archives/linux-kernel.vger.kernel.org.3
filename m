Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C3C52A4A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiEQOVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348881AbiEQOVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:21:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93F2D1F7
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:21:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h14so5339064wrc.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w3FmS8E9GJtG8KLMLCBP6OvEjEYRbncgJvuz92a9Y3Q=;
        b=reiEdp1V5nE0JJpdbBW2qBOflS79Ztgb8g8CdO/Li+I37z7PR/59XE+Leg1L75CqQw
         9BK6faOl2tdi01jeq7p0CxMeqwUAP/8qr1OWlOck10571SjEiPhn6wA1kqE+GEt4S8br
         pjJjOypYrTSGrc73ECniAR48ENwqW0G+dWPV5cohLnjN5DEtKiGZXQwy1eEldaU12TVp
         i3GTSqcC/HcH+zoKUymPtYAbdOwPYjViLp0qOIuU/MNmtJQFiFAwJKrmQcIZOhvZSoYq
         1TO4gDor+UHW9mcxYF1TSzosi3or36/MC5o0jiEJB3EPIpv9Dij9oTYF5qrTs9T5Ar7K
         Fubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=w3FmS8E9GJtG8KLMLCBP6OvEjEYRbncgJvuz92a9Y3Q=;
        b=qXu4JLsYlORxcilqtfT5Jx/49xEZ+O2Ka2rB/hiMuZER5uOblijcx4AmRlUsUFH4Ng
         KfNgl0tTKjTV3EZx8Xeri7e6dvy0wSR+C+9hgviqOJ6UR7t28HABknxZ8WZfkBvBOTXN
         004sOMg3aquSfljDW1hmpjHf+KlpjLIeR23GdgLzSTzAJ6TxMe4y+hTPXNPQNbBkPZhq
         mZSWYZXh7IBp7ajDSKKwUCLuKk8kP/8tmvWq2o/naQGh/3lbV2zRQvneWwLo2MvoGE0M
         QLvrP8KZhvgwflp6w5rAB9lw+xrDp0jZNp8oQBpjPLzDufnsOzNZcFOyNYVPLSaUiQpR
         BpvA==
X-Gm-Message-State: AOAM531+4v7n0wwOYvDsBTbb47NoZOY5APX3WBdeVXUIfDyqRwMRkmQV
        x2O9Vxt4joZ7dvzjYpXuGBo9VuKsUp5dmg==
X-Google-Smtp-Source: ABdhPJzDo6M41lTh6LfJJOPr5Ccy1udQgFveVfW+rzJ2VmZxCOHS/lYnJrFJ8GYXESDMFs6f/GY+dA==
X-Received: by 2002:adf:ed01:0:b0:20c:c137:aaeb with SMTP id a1-20020adfed01000000b0020cc137aaebmr19194049wro.638.1652797270323;
        Tue, 17 May 2022 07:21:10 -0700 (PDT)
Received: from [192.168.0.17] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id g16-20020a7bc4d0000000b003942a244ed6sm1987123wmk.27.2022.05.17.07.21.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 May 2022 07:21:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next v2 2/2] block, bfq: make bfq_has_work() more
 accurate
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
Date:   Tue, 17 May 2022 16:21:08 +0200
Cc:     Yu Kuai <yukuai3@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <740D270D-8723-4399-82CC-26CD861843D7@linaro.org>
References: <20220513023507.2625717-1-yukuai3@huawei.com>
 <20220513023507.2625717-3-yukuai3@huawei.com>
 <20220516095620.ge5gxmwrnbanfqea@quack3.lan>
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



> Il giorno 16 mag 2022, alle ore 11:56, Jan Kara <jack@suse.cz> ha =
scritto:
>=20
> On Fri 13-05-22 10:35:07, Yu Kuai wrote:
>> bfq_has_work() is using busy_queues currently, which is not accurate
>> because bfq_queue is busy doesn't represent that it has requests. =
Since
>> bfqd aready has a counter 'queued' to record how many requests are in
>> bfq, use it instead of busy_queues.
>>=20

The number of requests queued is not equal to the number of busy
queues (it is >=3D).  If this patch is based on this assumption then
unfortunately it is wrong :(

Paolo

>> Noted that bfq_has_work() can be called with 'bfqd->lock' held, thus =
the
>> lock can't be held in bfq_has_work() to protect 'bfqd->queued'.
>>=20
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>=20
> Looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> 								Honza
>=20
>> ---
>> block/bfq-iosched.c | 16 ++++++++++++----
>> 1 file changed, 12 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 61750696e87f..740dd83853a6 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -2210,7 +2210,11 @@ static void bfq_add_request(struct request =
*rq)
>>=20
>> 	bfq_log_bfqq(bfqd, bfqq, "add_request %d", rq_is_sync(rq));
>> 	bfqq->queued[rq_is_sync(rq)]++;
>> -	bfqd->queued++;
>> +	/*
>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>> +	 * may be read without holding the lock in bfq_has_work().
>> +	 */
>> +	WRITE_ONCE(bfqd->queued, bfqd->queued + 1);
>>=20
>> 	if (RB_EMPTY_ROOT(&bfqq->sort_list) && bfq_bfqq_sync(bfqq)) {
>> 		bfq_check_waker(bfqd, bfqq, now_ns);
>> @@ -2402,7 +2406,11 @@ static void bfq_remove_request(struct =
request_queue *q,
>> 	if (rq->queuelist.prev !=3D &rq->queuelist)
>> 		list_del_init(&rq->queuelist);
>> 	bfqq->queued[sync]--;
>> -	bfqd->queued--;
>> +	/*
>> +	 * Updating of 'bfqd->queued' is protected by 'bfqd->lock', =
however, it
>> +	 * may be read without holding the lock in bfq_has_work().
>> +	 */
>> +	WRITE_ONCE(bfqd->queued, bfqd->queued - 1);
>> 	elv_rb_del(&bfqq->sort_list, rq);
>>=20
>> 	elv_rqhash_del(q, rq);
>> @@ -5063,11 +5071,11 @@ static bool bfq_has_work(struct blk_mq_hw_ctx =
*hctx)
>> 	struct bfq_data *bfqd =3D hctx->queue->elevator->elevator_data;
>>=20
>> 	/*
>> -	 * Avoiding lock: a race on bfqd->busy_queues should cause at
>> +	 * Avoiding lock: a race on bfqd->queued should cause at
>> 	 * most a call to dispatch for nothing
>> 	 */
>> 	return !list_empty_careful(&bfqd->dispatch) ||
>> -		bfq_tot_busy_queues(bfqd) > 0;
>> +		READ_ONCE(bfqd->queued);
>> }
>>=20
>> static struct request *__bfq_dispatch_request(struct blk_mq_hw_ctx =
*hctx)
>> --=20
>> 2.31.1
>>=20
> --=20
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

