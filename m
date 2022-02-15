Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2034F4B79A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbiBOV1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:27:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiBOV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:27:09 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AB5B10A1;
        Tue, 15 Feb 2022 13:26:57 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id x4so229461plb.4;
        Tue, 15 Feb 2022 13:26:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J+NlIpbaWVwSgyeODUccvQdmtmUkD9/pliXzM5eAo74=;
        b=eLBaNO9Bp0x4A9ccwaH5LT75mRlShZ8dducWfoYVQJue4HCzERE1DT65gwway9z9Mm
         Bh/fNXPNmy3gubPkaK0gE7tQguoIyVkAldbBGfl9EiDLs7AahsegLzVArMJe55JjH4TY
         e9CiAv4WJnKq4a8RbEKVQfNmA7nAWPiBhNc/x5J0TPJIccU0f9mZ1h+sEcrMrdRd1BrC
         E4FPByN+NEg3we569zJVgJn7wwQfCGBAbz7hzXAK1ARZLFf5ruY8XdksML1VYtxflnr6
         Hw6/fAmPV+VI2H9xQXlplFcuTuR3kQEKHkv9QiDPMcbWHfRvIWjrLSfwLEcOzLuy4y2V
         LUVg==
X-Gm-Message-State: AOAM530v4bW+75+2pjroBKXXVxjsA7azejG5oA8AEPdfHoaOxqCHSSd5
        bYkiH/7KME5g+676D9NqZzs=
X-Google-Smtp-Source: ABdhPJzDnpo/eAadoEBFL3xHM3Kz5f6vsKh2Fh4L8nJ06vXgJ5Mg3nhBMiXdqKfhdiZ7kvqQ+I29dg==
X-Received: by 2002:a17:90b:1d0d:: with SMTP id on13mr874630pjb.208.1644960417011;
        Tue, 15 Feb 2022 13:26:57 -0800 (PST)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id q2sm43785660pfj.94.2022.02.15.13.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 13:26:56 -0800 (PST)
Message-ID: <cb5677fc-01ac-f97f-ccf8-eb91505ad0e3@acm.org>
Date:   Tue, 15 Feb 2022 13:26:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [RFC V2 5/6] blk-ioprio: make ioprio pluggable and modular
Content-Language: en-US
To:     "Wang Jianchao (Kuaishou)" <jianchao.wan9@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     hch@infradead.org, Josef Bacik <jbacik@fb.com>,
        Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220215123705.58968-1-jianchao.wan9@gmail.com>
 <20220215123705.58968-6-jianchao.wan9@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220215123705.58968-6-jianchao.wan9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/15/22 04:37, Wang Jianchao (Kuaishou) wrote:
> diff --git a/block/Makefile b/block/Makefile
> index f38eaa612929..f6a3995af285 100644
> --- a/block/Makefile
> +++ b/block/Makefile
> @@ -17,7 +17,8 @@ obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
>   obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
>   obj-$(CONFIG_BLK_CGROUP_RWSTAT)	+= blk-cgroup-rwstat.o
>   obj-$(CONFIG_BLK_DEV_THROTTLING)	+= blk-throttle.o
> -obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= blk-ioprio.o
> +io-prio-y 			:= blk-ioprio.o
> +obj-$(CONFIG_BLK_CGROUP_IOPRIO)	+= io-prio.o
>   obj-$(CONFIG_BLK_CGROUP_IOLATENCY)	+= blk-iolatency.o
>   obj-$(CONFIG_BLK_CGROUP_IOCOST)	+= blk-iocost.o
>   obj-$(CONFIG_MQ_IOSCHED_DEADLINE)	+= mq-deadline.o

Is the above change really necessary?

> +static int blk_ioprio_init(struct request_queue *q);
>   static struct rq_qos_ops blkcg_ioprio_ops = {

Please insert a blank line between a function declaration and a 
structure definition.

Thanks,

Bart.
