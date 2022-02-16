Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F88F4B7D59
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 03:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244118AbiBPCJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 21:09:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiBPCJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 21:09:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF6F94FF;
        Tue, 15 Feb 2022 18:09:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u5so863080ple.3;
        Tue, 15 Feb 2022 18:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1KMFB0pXuH9zi57To3B7V2l9lgGQEXmph+nP7sc/74k=;
        b=QCEqVr80E4UADxN7lgRxp0obN2II8sxHR2ogacAhet2Uek2r068/GzER7A8J5HlWEi
         gEPf1QcTvbWhLXAg8sOfiuEvNhpzJDVsNLMpIH3KMsdVkHEu4Yi/yKABzRPUoTZ8UXPh
         ayMvuaZmk2wM7lCqxwfQ41/SehFlEolQI65eGS00hzNegd/H035AKg/3rkrPBIMKCZIF
         eMUQkngYIh0Pvf6p2WvPkQd6vyB9a7HlXyQzu1smdY1x4kdIQKa17o2atJF9SdyoSmbI
         LCWdraIzqgHP6EJexPX9YQ+slnUkn2Upd1y1hIZTBlI8ng8g1LQv+YPTR0Lbxz1wG8BA
         zC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1KMFB0pXuH9zi57To3B7V2l9lgGQEXmph+nP7sc/74k=;
        b=ebpbvPIWFn3Td4xS8DpZNVz2FS8fM75N/6p6o2mjCeGuYNoP4enaTn9qQLVOE3pr9D
         m4aqT0bQWGYYWXVUvDmBZU/+/7gK5OgRc7TWtJbELask9UUpCywtrS38xL5BM6fUvShR
         /YX7HZtZfYHo7SUZw5A7cKXcLlb6YzSdBLoW/1YveQAQYxC0tJEDh8i7crOiK2VcPQoA
         K97IaEL2hJKOAuplHcdWYzaZUSBQtJLnQmrOOo71sI76pXECt2gZqzBcdKdU1G2kT3z6
         LWYJcAYhA7Y+pwoellhWT8EE688lFC7FUKowYEI+ZzaRwEFMlrH0ZzdgrMWrJI3gxsQW
         g76A==
X-Gm-Message-State: AOAM530NxJ7zt2XvgtFmHCojyaRhYt4ADQ5JL0HEQGkRwY2jkqCa97iN
        JxvdAjvqPQnNO8MQWtdRsyM=
X-Google-Smtp-Source: ABdhPJxODbLI7+ZttQLhZ+xdlj9NthvtkUKmyhabewcb3oKb74szmANihkLoKwTDrhc0l9tMH76ulA==
X-Received: by 2002:a17:902:8d88:b0:14a:d1d9:9b56 with SMTP id v8-20020a1709028d8800b0014ad1d99b56mr393524plo.79.1644977353179;
        Tue, 15 Feb 2022 18:09:13 -0800 (PST)
Received: from [172.20.119.15] ([162.219.34.248])
        by smtp.gmail.com with ESMTPSA id q13sm41167898pfj.44.2022.02.15.18.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 18:09:12 -0800 (PST)
Message-ID: <0608cd82-89c6-8fba-d06b-fdef9c53114f@gmail.com>
Date:   Wed, 16 Feb 2022 10:09:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [RFC V2 5/6] blk-ioprio: make ioprio pluggable and modular
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-6-jianchao.wan9@gmail.com>
 <cb5677fc-01ac-f97f-ccf8-eb91505ad0e3@acm.org>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
In-Reply-To: <cb5677fc-01ac-f97f-ccf8-eb91505ad0e3@acm.org>
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



On 2022/2/16 5:26 上午, Bart Van Assche wrote:
> On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
>> diff --git a/block/Makefile b/block/Makefile
>> index f38eaa612929..f6a3995af285 100644
>> --- a/block/Makefile
>> +++ b/block/Makefile
>> @@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)    += bsg-lib.o
>>   obj-$(CONFIG_BLK_CGROUP)    += blk-cgroup.o
>>   obj-$(CONFIG_BLK_CGROUP_RWSTAT)    += blk-cgroup-rwstat.o
>>   obj-$(CONFIG_BLK_DEV_THROTTLING)    += blk-throttle.o
>> -obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += blk-ioprio.o
>> +io-prio-y             := blk-ioprio.o
>> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)    += io-prio.o
>>   obj-$(CONFIG_BLK_CGROUP_IOLATENCY)    += blk-iolatency.o
>>   obj-$(CONFIG_BLK_CGROUP_IOCOST)    += blk-iocost.o
>>   obj-$(CONFIG_MQ_IOSCHED_DEADLINE)    += mq-deadline.o
> 
> Is the above change really necessary?

Except for making maintaining easier on a running system, removing a
rqos policy module with cgroup supporting can release a blk-cgroup
policy slots. As BLKCG_MAX_POLS, the max slots number is fixed now.

> 
>> +static int blk_ioprio_init(struct request_queue *q);
>>   static struct rq_qos_ops blkcg_ioprio_ops = {
> 
> Please insert a blank line between a function declaration and a structure definition.

Yes, I will do it in next version.

Thanks
Jianchao
