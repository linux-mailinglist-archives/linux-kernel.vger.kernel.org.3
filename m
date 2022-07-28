Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2C583FF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiG1N3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiG1N3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:29:14 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214D5A89B;
        Thu, 28 Jul 2022 06:29:13 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id o3so1810616ple.5;
        Thu, 28 Jul 2022 06:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KVAZ1OoYcDPkaYDmhjB+rFFypTllysidvXvCw8//pAg=;
        b=TIO/Lk8cyxCJ9TzKrfNogBZ8UM7NZILH2WWqNUi1aAKvL6c36ixeCiA4hPXgZMOVRu
         H4BG6kAcbEksGZ4vrx4BARR8yEr1DMKfGOJwnD/vgQqvbOi6AvAOCDSamUrXyqx+2jRE
         HBDIcT/Rl5Gdg/XNyHrim7SMFaKV8wxIRoZXclyOhxr+pgt1ZmBr5eKDKdoIN/fSxUG8
         2ZOLKMO4N2z9bCBWlIug1/vD8HMqBNzrtveSTPwNBpKhG3304gssAEzNuWuPIeO0+xKC
         pQYivV00Gh77WotBdhSea5g+g4R3MLwAmettACMSiWKAfy4gMv8uaGQbHJVCJyVAqb6B
         DHOw==
X-Gm-Message-State: AJIora81ynit4j4fCXxez8iHrrkzcvrhnpHqMQ6w4OxTMmnb3y/VpAlS
        Vs4uHCqfUSEHJjeVBy0Hf+w=
X-Google-Smtp-Source: AGRyM1sVlJ4VxZdri5AJaXpK+abw9sqfSjFByJuWKJUf33Qsr5XtcruBoEo93wrUA8fG42N8cHOiXg==
X-Received: by 2002:a17:902:70c4:b0:16c:5306:9172 with SMTP id l4-20020a17090270c400b0016c53069172mr26736583plt.171.1659014952312;
        Thu, 28 Jul 2022 06:29:12 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id h1-20020aa796c1000000b0052b66304d54sm742466pfq.74.2022.07.28.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:29:11 -0700 (PDT)
Message-ID: <514f85ce-84fc-1186-7169-a29d7118e8cc@acm.org>
Date:   Thu, 28 Jul 2022 06:29:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162248eucas1p2ff8c3c2b021bedcae3960024b4e269e9@eucas1p2.samsung.com>
 <20220727162245.209794-3-p.raghav@samsung.com>
 <7984b969-9025-6b31-2645-da08daeefafb@acm.org>
 <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <eed7d9ee-fd7f-e57c-598e-909dbb0d2380@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 05:11, Pankaj Raghav wrote:
> On 2022-07-28 01:16, Bart Van Assche wrote:
>> The bdev_is_zone_start() name seems more clear to me than
>> bdev_is_zone_aligned(). Has there already been a discussion about which
>> name to use for this function?
>>
> The reason I did s/bdev_is_zone_start/bdev_is_zone_aligned is that this
> name makes more sense for also checking if a given size is a multiple of
> zone sectors for e.g., used in PATCH 9:
> 
> -		if (len & (zone_sectors - 1)) {
> +		if (!bdev_is_zone_aligned(bdev, len)) {
> 
> I felt `bdev_is_zone_aligned` fits the use case of checking if the
> sector starts at the start of a zone and also check if a given length of
> sectors also align with the zone sectors. bdev_is_zone_start does not
> make the intention clear for the latter use case IMO.
> 
> But I am fine with going back to bdev_is_zone_start if you and Damien
> feel strongly otherwise.
The "zone start LBA" terminology occurs in ZBC-1, ZBC-2 and ZNS but 
"zone aligned" not. I prefer "zone start" because it is clear, 
unambiguous and because it has the same meaning as in the corresponding 
standards documents. I propose to proceed as follows for checking 
whether a number of LBAs is a multiple of the zone length:
* Either use bdev_is_zone_start() directly.
* Or introduce a synonym for bdev_is_zone_start() with an appropriate 
name, e.g. bdev_is_zone_len_multiple().

Thanks,

Bart.
