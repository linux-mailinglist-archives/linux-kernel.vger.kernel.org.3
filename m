Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BD45A239F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiHZI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiHZI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:57:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E435461B01
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661504250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LWSLe16uEsRC5Rc16K9EXjmFKNCRYHoqfDdxUYl15H0=;
        b=ewCPJXo5324m0H6crUWz3ZIwbamc30cSrVqVVmhlSfICxMmrj31GOgB1DximeClZSIixjT
        E8nBaE0qUTgGU+TAAuTP3DjqWMFhrLpiQe5nbi+QN3TjmCxxNRPzz0vyxYHcwnPCN9mxh/
        fWYS9eMnrs+VKNIu2XxUCbDMvNnMlHk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-265-ApF4DxszNEyroUpVRunPVA-1; Fri, 26 Aug 2022 04:57:28 -0400
X-MC-Unique: ApF4DxszNEyroUpVRunPVA-1
Received: by mail-ed1-f69.google.com with SMTP id z6-20020a05640240c600b0043e1d52fd98so751073edb.22
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:57:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LWSLe16uEsRC5Rc16K9EXjmFKNCRYHoqfDdxUYl15H0=;
        b=q93RQ8CvqcSA2YOgQqdgqPAKZsDntOVu6s6TSwbJ9OFK9ZpQQzeM/es7VFz0X2xLL+
         EpWjBAK5RGc9HUUhVGdXS6/dMUpDhdsjxYV4fmgOp7DiPBbu6N3A+InfMlrAvP5ruyCz
         lj3FKqqRCfqlnwd/NcIMmyUDPoRBTRrvk/WBODSWjRb+NRV6dxTyz9+PZCrsVtBrM9KI
         QQUC1Q0TBc2k46BRaQjWWLxfaTpLNa80EXdoa15V+9PE+6PO+0fnjrq4hHWji0IuYMZj
         VntSkR0aYcthHqULqh6WvSL4it4lX3mxkwQjHoGjjo2pj97fv1kDZ4oSDyF+RuXP2Olp
         +OzQ==
X-Gm-Message-State: ACgBeo0Baf/2an4lwi7T3hPmcEtBh8+hdkC6x4l8diF8yVt7esHmq8Z7
        JKFqLt3RbzerVPsjuOdElwjuJSJih3XzQP45dG5750dsDq+HdsEQMRPEosFSiBZQL9vU+FghMwv
        TvDq420RzR8cePA64ZKjEYpd9
X-Received: by 2002:a17:907:3d90:b0:741:346a:6e46 with SMTP id he16-20020a1709073d9000b00741346a6e46mr480391ejc.279.1661504246416;
        Fri, 26 Aug 2022 01:57:26 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oQfqCNio39lbXHFviZswa5IDNupVO4FwHpDtM5cdMRMjh9i/H9fV/pTNwrOJUwANJh6wPew==
X-Received: by 2002:a17:907:3d90:b0:741:346a:6e46 with SMTP id he16-20020a1709073d9000b00741346a6e46mr480379ejc.279.1661504246239;
        Fri, 26 Aug 2022 01:57:26 -0700 (PDT)
Received: from [192.168.0.198] (host-87-8-60-205.retail.telecomitalia.it. [87.8.60.205])
        by smtp.gmail.com with ESMTPSA id h5-20020a50cdc5000000b0043b986751a7sm962912edj.41.2022.08.26.01.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:57:25 -0700 (PDT)
Message-ID: <7927ac6e-7738-822a-59ce-09992947f3b4@redhat.com>
Date:   Fri, 26 Aug 2022 10:57:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH -next] sched/deadline: Add start_new_instance helper
Content-Language: en-US
To:     shangxiaojing <shangxiaojing@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20220826031521.13391-1-shangxiaojing@huawei.com>
 <651dbb96-8d6e-53e9-a99f-0bb12f5b2723@redhat.com>
 <893836a5-0aaa-e5e6-81ba-cc9570b9a026@huawei.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <893836a5-0aaa-e5e6-81ba-cc9570b9a026@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/22 09:40, shangxiaojing wrote:
>> again, this is not a good function name. Maybe, dl_replenish_new_period() ?
> 
> right, i have thought like replenish_new_instance, but when i'm making
> patch,  i was worried that "replenish" is only for ENQUEUE_REPLENISH.

I see, but that is a flag, not the action.

> what about dl_start_new_period? which means a new deadline will be set, rather than

The thing it is doing is replenishing... 

>     dl_se->deadline += pi_of(dl_se)->dl_period;
> 
> in replenish_dl_entity.

that is why I added "new_period"....  so replenish_dl_new_period() to keep the consistency.

>>> +static inline void start_new_instance(struct sched_dl_entity *dl_se, struct rq *rq)
>>>
>>> +{
>>> +    /* for non-boosted task, pi_of(dl_se) == dl_se */
>>> +    dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
>>> +    dl_se->runtime = pi_of(dl_se)->dl_runtime;
>>> +}
>>> +
>> -- Daniel 

-- Daniel

