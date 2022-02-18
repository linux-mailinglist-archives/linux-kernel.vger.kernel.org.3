Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 579A44BB043
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiBRDfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:35:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiBRDfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:35:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDED10FC0;
        Thu, 17 Feb 2022 19:34:58 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id om7so7441909pjb.5;
        Thu, 17 Feb 2022 19:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bg+M/53E71OGRs8mVxe7azXsdV17hdariP4bI8/+sLM=;
        b=nWwSNIgt+olaLsHCJqjmkpAr+dPku8dsAlYQjbctiR5FFJP8ts2bcKftkAUFSX5t02
         Iy0KXMNqFU5K0gNsFTMEfFPSLSCFR5mMsgUEXKIp80jyj+FZtvbc4nC8xjSAaQtvtfeP
         qfIACCxrP3an2ypnyxgx6U/IDXLkg+sONivLYBsY2do75HwNnLbPsI1ujBexNTMFsBtH
         /3lNnGhlJYDCS971lvq0adpHt/ueXW3wWTQvb3hbko3pCOcmuw7D74CNfNrvhQkr+Ea7
         ytwfyab1OsEpqfcRAufuTC2W5jMyi1ulSxHkh/4yzFByghAcT7x8CmFTpTNtG9QiGn4d
         yv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bg+M/53E71OGRs8mVxe7azXsdV17hdariP4bI8/+sLM=;
        b=kV34U8iJMjlnYT8a5E8aq/6V/JGtrua63PFyIwpqDPH4aaAO4Hh2jXpKHxRR3mWw7o
         37DNSHmUa4aEz/ejhxiivrk0vQZd0eQ/ThGcBe+0r/nMb+/16fX+5gCc9XFMDzyWjF4P
         LD7jncbMqYepaDIpWa4+sqBWHQ/TvUA5lDzy855dlTwshlYxPuMxe/5khyOE58U1QKLV
         Stziv3WBqqIoaQ1M5Gwq1DQuhGgOWd3QrSbNHeeOPFz0RLsMaxZZFaPgMJRWrttPJz/W
         +FNC+T1pBwVrBBzkhHO/zAj0YiDyr3SeUCpxR5GNoTxBcgKZs6dnxs2c4pHDbElQdmHR
         EP5Q==
X-Gm-Message-State: AOAM530HILkiTzY2JpCXcb6iBggfMpSeaEdspn0/IIu8ismnZnjotswp
        S7SCnSxn0LzVwX7qA/qh570=
X-Google-Smtp-Source: ABdhPJyL/2W21CPt0s5nmadX3AEms+t2nPu80iSgGfnuyCyUOQ9fue4Fa/0J7QcHhrxOWLt2SpyIOA==
X-Received: by 2002:a17:902:9046:b0:14d:5c9d:e7df with SMTP id w6-20020a170902904600b0014d5c9de7dfmr5772139plz.65.1645155298423;
        Thu, 17 Feb 2022 19:34:58 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.69])
        by smtp.gmail.com with ESMTPSA id 131sm1054254pfz.76.2022.02.17.19.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:34:58 -0800 (PST)
Message-ID: <842be400-baf0-9185-25f2-8c00c2db553d@gmail.com>
Date:   Fri, 18 Feb 2022 11:34:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 1/6] blk: prepare to make blk-rq-qos pluggable and
 modular
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-2-jianchao.wan9@gmail.com>
 <Yg4L67f96aQ2q5uy@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4L67f96aQ2q5uy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/2/17 4:48 下午, Christoph Hellwig wrote:
>>  {
>>  	struct request_queue *q = rqos->q;
>> -	const char *dir_name = rq_qos_id_to_name(rqos->id);
>> +	const char *dir_name;
>> +
>> +	dir_name = rqos->ops->name ? rqos->ops->name : rq_qos_id_to_name(rqos->id);
> 
> Overly long line here.  And it would be much more readable if you used
> a good old if/else.
> 
>> +static DEFINE_IDA(rq_qos_ida);
>> +static int nr_rqos_blkcg_pols;
>> +static DEFINE_MUTEX(rq_qos_mutex);
>> +static LIST_HEAD(rq_qos_list);
> 
> Please use an allocating xarray instead of an IDA plus list.
> 
>> +	/*
>> +	 * queue must have been unregistered here, it is safe to iterate
>> +	 * the list w/o lock
>> +	 */
> 
> Please capitalize multi-line comments.
> 
>> + * After the pluggable blk-qos, rqos's life cycle become complicated,
>> + * as we may modify the rqos list there. Except for the places where
>> + * queue is not registered, there are following places may access rqos
>> + * list concurrently:
> 
> Code comments are not the place to explain history.  PLease explain the
> current situation.
> 
>> +struct rq_qos *rq_qos_get(struct request_queue *q, int id)
>> +{
>> +	struct rq_qos *rqos;
>> +
>> +	spin_lock_irq(&q->queue_lock);
> 
> Please don't use the grab all queue_lock for new code.  It badly needs
> to be split and documented, and new code is the best place to start
> that.
> 
> Also with all the new code please add a new config option that is
> selected by all rq-pos implementations so that blk-rq-qos.c only gets
> built when actually needed.
> 
>> +static inline struct rq_qos *rq_qos_by_id(struct request_queue *q, int id)
>> +{
>> +	struct rq_qos *rqos;
>> +
>> +	WARN_ON(!mutex_is_locked(&q->sysfs_lock) && !spin_is_locked(&q->queue_lock));
> 
> Another overly long line.  And in doubt split this into two helpers
> so that you cna use lockdep_assert_held instead of doing the incorrect
> asserts.

Thanks so much for your kindly comment. I'd change the code in next version.

Regards
Jianchao
