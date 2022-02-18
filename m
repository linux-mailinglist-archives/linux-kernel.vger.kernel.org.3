Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB694BB051
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiBRDnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:43:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiBRDnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:43:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B8558E5A;
        Thu, 17 Feb 2022 19:43:00 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u12so6137972plf.13;
        Thu, 17 Feb 2022 19:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lMBr67ZFYuTMoFmjD03o7/90AyuzJI9pjLQ2HUN5D4M=;
        b=lye2+ag+4YvOXqbivMwXuUQ4c6ctCAWFusWXq0iBYWwHe/rWDHNSNK5ank1hLvXsDb
         9Z3mLSBQIc5VQewS3n2mTR3S+GhjAh5DUmDqN2htoiOVwcWgqY17wNd1tvjxT/eJS9ku
         18fIiXF1IPnF9LjRWMbPsJ97b1jSZib9Pe1Su/3K+TDz2WsM6QbG4vw2BTj6WXeARbPd
         wLUgSRX4wsOyS9QsvSj+x/9gt/Sh9i6ztzGSnfBRpBkfy0HfCGNDUFON/uHXU9j41O3C
         CFoT5YvMLGkATaneQylHAPSCZmjb8AjVU8Xi/beoWGFosaP40rtuI6oIjPZrXfdfz4M1
         tkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lMBr67ZFYuTMoFmjD03o7/90AyuzJI9pjLQ2HUN5D4M=;
        b=JJV2GSRDA3kNmmDKAEoSj/JCQJT4hJ7SM7yq/loH0vrTC9Y7Et2aKdhq13XmZVc97t
         qQDBTTnav2vMBcZlMqm3Nmvnf/e+5HOTfBc0tSZ1sRuC08rWLEHoBZ9lNS5Ar7rvtTeR
         dL9+8HkHmdevj4iRWynPrQg3R5JcmHjwLM/L6PFfp/+r5kMH5hCzvl4ybQaYZ6OMETfY
         AEkulshyu36f/u7k0wHN/cyIsUU4ZQLMOYOhniZjBJsXa+pABugmcIatQLa8ATeXfhjl
         pagH/lUE3bYfPhJRfe62BlUrJkQdu65Au0mDAvTCPIkOB81t/szYHaHm+3zFNIJpUD7Z
         eABw==
X-Gm-Message-State: AOAM533Y6EGsEyRvd1afJMxMgMnwI0wKuv7d0GEDxJtsaioFMcdDdO8i
        IEx8bEW7M3wpe8eHSzK9Gww+N6IFKhW6jERg
X-Google-Smtp-Source: ABdhPJz5KOgutHfcFMNxiG5XHetial16Kg0zUgMiqR0Acr5/95ZnA14BG4HFzd21PSNlhfN3nEKbCQ==
X-Received: by 2002:a17:90a:6943:b0:1b9:e285:e4a3 with SMTP id j3-20020a17090a694300b001b9e285e4a3mr6432247pjm.153.1645155780534;
        Thu, 17 Feb 2022 19:43:00 -0800 (PST)
Received: from [172.20.119.15] ([61.16.102.70])
        by smtp.gmail.com with ESMTPSA id m8sm3424656pgb.0.2022.02.17.19.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 19:43:00 -0800 (PST)
Message-ID: <0dcd9016-5ef9-bbb7-60b7-3261a81635c5@gmail.com>
Date:   Fri, 18 Feb 2022 11:42:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [RFC V4 3/6] blk-iolatency: make iolatency pluggable
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220217031349.98561-1-jianchao.wan9@gmail.com>
 <20220217031349.98561-4-jianchao.wan9@gmail.com>
 <Yg4MnC3JydI4WmLC@infradead.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <Yg4MnC3JydI4WmLC@infradead.org>
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



On 2022/2/17 4:51 下午, Christoph Hellwig wrote:
>> +static inline struct rq_qos *blkcg_rq_qos(struct request_queue *q)
>> +{
>> +	return rq_qos_by_id(q, blkcg_iolatency_ops.id);
>> +}
> 
> This just has a single user, so open code it.
> 
>> +static int blk_iolatency_init(struct request_queue *q);
>> +
>>  static struct rq_qos_ops blkcg_iolatency_ops = {
>> +	.name = "blk-iolat",
>> +	.flags = RQOS_FLAG_CGRP_POL,
>>  	.throttle = blkcg_iolatency_throttle,
>>  	.done_bio = blkcg_iolatency_done_bio,
>>  	.exit = blkcg_iolatency_exit,
>> +	.init = blk_iolatency_init,
>>  };
> 
> I'd move this structure below blk_iolatency_init to avoid the forward
> declaration of blk_iolatency_init

Got it

Thanks
Jianchao
