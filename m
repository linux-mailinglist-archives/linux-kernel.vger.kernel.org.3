Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC914B9B72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbiBQItC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:49:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiBQItB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:49:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C332A2282;
        Thu, 17 Feb 2022 00:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9UdR4si8YbnluPQ6XJGvCQutAFn/OM8Aod+663L23pQ=; b=vdgCK1IGQ5HujA3sgA7lwcLQuk
        zqSVjRYhnco4cnF4Jugom4VNOjKZ3pw8gW++AQ9f+Y14tqPGayre6B1nObycRZEwZMx8UrqEKSuD6
        4EiENGTTAjgvdOMl0ciEUPYkm2NMAaeEkuYQdfD15GLMI4IjXh/Mvr8L+Gxsr3lYBgj5DQn7f2Qf8
        BB8WE+CfgiLe0NGxvoq8bI3HtONKYv9V8RKObq5gnyVn/tslvJp88J9zFMWGIztLrjGXjrgcIazFD
        VblsJqEIMGFKD+JJvXR591bbrAWm6dYzRw/HA61dMl9ig99vT/qVP6l32eCvKPgOGgVCHVoMemHtv
        RpjAcBwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKcSx-009ZzB-IH; Thu, 17 Feb 2022 08:48:43 +0000
Date:   Thu, 17 Feb 2022 00:48:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Message-ID: <Yg4L67f96aQ2q5uy@infradead.org>
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217031349.98561-2-jianchao.wan9@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  {
>  	struct request_queue *q = rqos->q;
> -	const char *dir_name = rq_qos_id_to_name(rqos->id);
> +	const char *dir_name;
> +
> +	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);

Overly long line here.  And it would be much more readable if you used
a good old if/else.

> +static DEFINE_IDA(rq_qos_ida);
> +static int nr_rqos_blkcg_pols;
> +static DEFINE_MUTEX(rq_qos_mutex);
> +static LIST_HEAD(rq_qos_list);

Please use an allocating xarray instead of an IDA plus list.

> +	/*
> +	 * queue must have been unregistered here, it is safe to iterate
> +	 * the list w/o lock
> +	 */

Please capitalize multi-line comments.

> + * After the pluggable blk-qos, rqos's life cycle become complicated,
> + * as we may modify the rqos list there. Except for the places where
> + * queue is not registered, there are following places may access rqos
> + * list concurrently:

Code comments are not the place to explain history.  PLease explain the
current situation.

> +struct rq_qos *rq_qos_get(struct request_queue *q, int id)
> +{
> +	struct rq_qos *rqos;
> +
> +	spin_lock_irq(&q->queue_lock);

Please don't use the grab all queue_lock for new code.  It badly needs
to be split and documented, and new code is the best place to start
that.

Also with all the new code please add a new config option that is
selected by all rq-pos implementations so that blk-rq-qos.c only gets
built when actually needed.

> +static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
> +{
> +	struct rq_qos *rqos;
> +
> +	WARN_ON(!mutex_is_locked(&q->sysfs_lock) && !spin_is_locked(&q->queue_lock));

Another overly long line.  And in doubt split this into two helpers
so that you cna use lockdep_assert_held instead of doing the incorrect
asserts.
