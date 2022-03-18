Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81584DD377
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbiCRDMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiCRDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:12:04 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1704EC558D;
        Thu, 17 Mar 2022 20:10:46 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso3148198pjb.5;
        Thu, 17 Mar 2022 20:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Haz+GoKyB3RSep3ECvx7j8Nv1Ufqm9H0K//j2fwFt60=;
        b=vOJxbuI4WYSAL5OgRiDikT2Od5sbYakHcx9WJhXDlbLt/jMAeQY1U4eLVqieK8cALI
         NsccIoe76plmYCsOtfpOqPNcG2M9lsG8hNC64e7voDQR2tyvzP0R4jg7IYZ8USInzkVm
         qrYwr/D1cS4ppyQWHP59pNPpWbAz8A7XG89eVqzAWLxQxO7lUrtppB95EbXU04HdSAEp
         vzwODq+YuFmW9y8T3DglGK/X92A2YqzBw2nfrWJYxvkeZLWeZeChl6kIAAFTLg/5h1rD
         98CipiXy4ye0EF0soLLiyzIjsB2RKFpAj6oSOGCxDgRVETGf296dq43vbuIcWTtUahPq
         Oe+A==
X-Gm-Message-State: AOAM530GCamPArO5XSU+pceD015V4B1xEHld10kMbuTNdkbVZ4nrdTFS
        9P1xht2UMxgqvQbZy+r57Yiz+C1XZlw=
X-Google-Smtp-Source: ABdhPJxf4ee0q3k3GEsPwEFvGnMbi9h8ql49UgY9UGkxNYVB8h8rMExIzTzQr8b69UOcIYIiDmGfVQ==
X-Received: by 2002:a17:902:7802:b0:150:baa:bc1a with SMTP id p2-20020a170902780200b001500baabc1amr8265239pll.110.1647573045319;
        Thu, 17 Mar 2022 20:10:45 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a0023cc00b004f707cc97f9sm8461505pfc.52.2022.03.17.20.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 20:10:44 -0700 (PDT)
Message-ID: <132f9c86-5a2b-6770-377a-9323ba344402@acm.org>
Date:   Thu, 17 Mar 2022 20:10:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 1/3] block: don't show disk stats if io accounting is
 disabled
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>, axboe@kernel.dk,
        mpatocka@redhat.com, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220317112653.1019490-1-yukuai3@huawei.com>
 <20220317112653.1019490-2-yukuai3@huawei.com>
 <22cd48e9-fe36-414c-942e-382b8139ab4b@acm.org>
 <32a69b87-270e-479a-6207-24de3d70e9ed@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <32a69b87-270e-479a-6207-24de3d70e9ed@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/17/22 18:36, yukuai (C) wrote:
> 在 2022/03/17 22:06, Bart Van Assche 写道:
>> On 3/17/22 04:26, Yu Kuai wrote:
>>> If io accounting is disabled, there is no point to handle such device
>>> in diskstats_show(), and it can be confused for users because all fields
>>> in iostat are zero while the disk is handling io.
>>>
>>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>>> ---
>>>   block/genhd.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index c3b32c665aec..e5307f512185 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -937,6 +937,9 @@ ssize_t part_stat_show(struct device *dev,
>>>       struct disk_stats stat;
>>>       unsigned int inflight;
>>> +    if (!blk_queue_io_stat(q))
>>> +        return sprintf(buf, "io accounting is disabled\n");
>>> +
>>
>> Hmm ... the above looks sub-optimal to me. Has it been considered to 
>> return an error code instead or even better to hide the stat attribute 
>> if I/O accounting is disabled? The latter can be achieved by modifying 
>> disk_visible().
 >
> It's right this way is much better, i'll hide the 'stat' in next
> iteration.

Please note that modifying disk_visible() only is not sufficient. 
sysfs_update_group() needs to be called to trigger a call to 
disk_visible() if a variable has changed that affects the return value 
of disk_visible().

> BTW, do you have any suggestion about patch 3?

I need more time to analyze that patch.

Thanks,

Bart.
