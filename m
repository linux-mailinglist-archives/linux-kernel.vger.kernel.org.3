Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59B14C8372
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiCAFol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 00:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiCAFoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 00:44:39 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67FA3C726;
        Mon, 28 Feb 2022 21:43:59 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id y11so13207107pfa.6;
        Mon, 28 Feb 2022 21:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=LwvwEzrp1xIn/jiiFpp6P3SyFgnwZ8pdXfzOU/9VimM=;
        b=ET/mFAPhigISowfoXYA20OpHqk3b9a377bJHQAx/qiZNGD/rCjrHZIID+csiK8jxjw
         csAgrclrCMAp3lafFbwBkY1TMlrh2B335k7jWtctCtNZb3vne87S95RBhOSy1pDqnV/8
         j8gfCKCjHHrSLNZi9QW045rbK1MOOUD1eGhAUKx9fZkqtiC7mCV1D0azocajXFOhLhqa
         Mh+yu10gYbKl0F60BnGwmMLZRKNIKwva12PFiREuNWNmfx1u/nAVoeAWGexFmoOzQYeM
         wFcyQ0rnCo+MXgzicTl97V7dqClDSjQaCG/nmNmXmu9IIDLbvCRIb6nKEp5m0RgjuQZH
         BKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=LwvwEzrp1xIn/jiiFpp6P3SyFgnwZ8pdXfzOU/9VimM=;
        b=fCIJsfRbR8iPqKM8dlUiXBm0PWm9fjRvVeG4sfIn1t/R9IGbkoELw+kH85VX3GuTYV
         LkjFVHeM0FlaCayoyeVJCjHSCHWPIEH1WJSAGlfSuao1kluuN8RKghXbFTWdE9V0hvAk
         vJMfNAFoxwaP/5BqCoDetqMM7p6alw8AxQgSym7MDYW0x5mEeA0lVOGKBkII5yn5trMK
         AC3qljaeovGiXZqWLXO65+WOjy2I92DOWfJ6dyJzrC9xKgi+BxwK+Z9DUH4/0tT7XloA
         fm/r3n0Q1BUnC0UzRO1Otj+m8IYL3r3DlXH8rPA3H6gKztL+FzJRKZQOkCiuOgFK410P
         FvnA==
X-Gm-Message-State: AOAM532ZrVvhgvvKLRf9jf8xxvIm3PgAWX2P+4K5zrTe13EYeBjm2dyk
        /MRvNPextZA9KowlSVO+A4Y=
X-Google-Smtp-Source: ABdhPJz6BAAdB9CWW32JUQzeaQpYg9pPmndbJaPAFugg683B8RIVCOr4kFFB4mO+fVhzp5+5G2m/mQ==
X-Received: by 2002:a63:1350:0:b0:378:7fb4:63eb with SMTP id 16-20020a631350000000b003787fb463ebmr10043971pgt.457.1646113439190;
        Mon, 28 Feb 2022 21:43:59 -0800 (PST)
Received: from [192.168.66.3] (p912131-ipoe.ipoe.ocn.ne.jp. [153.243.13.130])
        by smtp.gmail.com with ESMTPSA id l13-20020a056a00140d00b004e13da93eaasm16233690pfu.62.2022.02.28.21.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 21:43:58 -0800 (PST)
Message-ID: <e306700c-3153-9422-974c-1f5f10e232d6@gmail.com>
Date:   Tue, 1 Mar 2022 14:43:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] virtio-blk: Assign discard_granularity
Content-Language: en-US
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220224093802.11348-1-akihiko.odaki@gmail.com>
 <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
From:   Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <YhypTNtWpcgh3gb2@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/02/28 19:51, Stefan Hajnoczi wrote:
> On Thu, Feb 24, 2022 at 06:38:02PM +0900, Akihiko Odaki wrote:
>> Virtual I/O Device (VIRTIO) Version 1.1
>> https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-csprd01.html
>>> discard_sector_alignment can be used by OS when splitting a request
>>> based on alignment.
>>
>> According to Documentation/ABI/stable/sysfs-block, the corresponding
>> field in the kernel is, confusingly, discard_granularity, not
>> discard_alignment.
> 
> Good catch, struct virtio_blk_config->discard_sector_alignment is Linux
> q->limits.discard_granularity.
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@gmail.com>
>> ---
>>   drivers/block/virtio_blk.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>> index c443cd64fc9b..1fb3c89900e3 100644
>> --- a/drivers/block/virtio_blk.c
>> +++ b/drivers/block/virtio_blk.c
>> @@ -913,11 +913,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>>   		blk_queue_io_opt(q, blk_size * opt_io_size);
>>   
>>   	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
>> -		q->limits.discard_granularity = blk_size;
>> -
>>   		virtio_cread(vdev, struct virtio_blk_config,
>>   			     discard_sector_alignment, &v);
>> -		q->limits.discard_alignment = v ? v << SECTOR_SHIFT : 0;
> 
> Should we use struct virtio_blk_config->topology.alignment_offset
> ("offset of first aligned logical block" and used for Linux
> blk_queue_alignment_offset()) for q->limits.discard_alignment?

Maybe but I'm not sure. I had looked at the code of QEMU
(commit 5c1ee569660d4a205dced9cb4d0306b907fb7599) but it apparently 
always sets 0 for virtio_blk_config->topology.alignment_offset.
I don't have a hardware which requires discard_alignment either so I 
cannot test it.

I'd like to leave this patch as is since I cannot deny the possibility 
that the host has a different alignment offset for discarding and other 
operations.
