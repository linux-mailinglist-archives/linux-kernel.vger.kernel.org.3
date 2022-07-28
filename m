Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC5583FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiG1NaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiG1NaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:30:21 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3F1EAEC;
        Thu, 28 Jul 2022 06:30:19 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id c3so1913908pfb.13;
        Thu, 28 Jul 2022 06:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RdplHWE21v7uW0csMEy8w+746Uk8pAL1Z4Zo/u66MRc=;
        b=iPYRA0sQxRtHZ8dg4SXVqqJI/tiCu+BUxBEAjQXBblo0ze8KW5zjIW0+6zlfVTsego
         STQdaHV7gbfVE17hcnruDgIK+cK32gzCpdE1myLmUC+jZ6vhaxpm7Dv4uP0/vNC0M9YJ
         GukXwdGcIB2WbbMw1hJngWOFm0z/2Nlsg3RmJwJj8rrkDzIfMspQ8T9stbBs+Ue41vkf
         f0/66rCSnlSEtt6uXNXuUdJGjXCLb7KJeSzkRGEXLEY0SKGtbqifqn6/RcuI70qGWcn1
         /LKEkXg0IRHkk/KcGQQ9G/dmFbGqAn75fRAvTUTbmHq8wvtJODo4mT3mVbLZYwqjzx8h
         OnxA==
X-Gm-Message-State: AJIora/nHjGFSngHmrjVG8ghMDn2Vedcl4OXFb7aO3/jq+sXqLTYJSRU
        PR3b+38qqJrbc3qHKOLW+L4=
X-Google-Smtp-Source: AGRyM1sEeS4b6mgBviJJaeM6ot/oR6bsjRTH3rUY3cbgsPHiPvABhB/Is7CL9HzuiOI0PM2NkdpFeg==
X-Received: by 2002:a63:1a56:0:b0:41b:3ef0:4eb1 with SMTP id a22-20020a631a56000000b0041b3ef04eb1mr8174445pgm.207.1659015019399;
        Thu, 28 Jul 2022 06:30:19 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id b2-20020a170903228200b0016a7d9e6548sm1273348plh.262.2022.07.28.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 06:30:18 -0700 (PDT)
Message-ID: <6ac6c0b3-ca3a-27da-0b8f-b4c39671bdab@acm.org>
Date:   Thu, 28 Jul 2022 06:30:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/11] support non power of 2 zoned device
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>,
        damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
        snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc:     matias.bjorling@wdc.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, pankydev8@gmail.com,
        jaegeuk@kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org
References: <CGME20220727162246eucas1p1a758799f13d36ba99d30bf92cc5e2754@eucas1p1.samsung.com>
 <20220727162245.209794-1-p.raghav@samsung.com>
 <51255650-ddc2-4f3d-52e5-14007b9ff538@acm.org>
 <e0606903-c007-43f1-538f-b70ee607be0a@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <e0606903-c007-43f1-538f-b70ee607be0a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 04:57, Pankaj Raghav wrote:
> Hi Bart,
> 
> On 2022-07-28 01:19, Bart Van Assche wrote:
>> On 7/27/22 09:22, Pankaj Raghav wrote:
>>> This series adds support to npo2 zoned devices in the block and nvme
>>> layer and a new **dm target** is added: dm-po2z-target. This new
>>> target will be initially used for filesystems such as btrfs and
>>> f2fs that does not have native npo2 zone support.
>>
>> Should any SCSI changes be included in this patch series? From sd_zbc.c:
>>
>>      if (!is_power_of_2(zone_blocks)) {
>>          sd_printk(KERN_ERR, sdkp,
>>                "Zone size %llu is not a power of two.\n",
>>                zone_blocks);
>>          return -EINVAL;
>>      }
>>
> I would keep these changes out of the current patch series because it
> will also increase the test scope. I think once the block layer
> constraint is removed as a part of this series, we can work on the SCSI
> changes in the next cycle.

That's fine with me.

Thanks,

Bart.
