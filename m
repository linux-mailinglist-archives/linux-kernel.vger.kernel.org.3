Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039BC55AB9E
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiFYQl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiFYQl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:41:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1E140DE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:41:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 136so90983pfy.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CiiTdw5nwmdQxjSzvtjOG6uYyrass8pWwqawj8avJ5Y=;
        b=ZdlS1l2K0yddb8XT+8VtvNpjN/CVImDLEORZgY0s7okUSI8qLcWyCyaDjOJJDeX6MR
         x9/ddt1ZSDs5dOI5/CTqFNN9tdyhRRqsHxq/Adk41okptoPxOTvPCBdEDz4viCdXmOFs
         O7yPMl00IseDazDTQszNOg232uVglii7zgJPHi9Sp+zWDwvBbCARyNINUZiap/yzOu3o
         Nv9yBqvGpew70x+p1YWq5qBXreAi1u2qWT642bK3rucMDI5nVjuHZZPSu2F5suQ1i/8N
         z8n0zlESYixxHA2a/W4PHTkLBiHoyIOk9SL5dBOzGj6InF7BAulw4JAvmCr3kxJELEus
         iATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CiiTdw5nwmdQxjSzvtjOG6uYyrass8pWwqawj8avJ5Y=;
        b=2nsNjvXop0Y5DYIc5sF2siG0P/LRPq5A2qcIGdpQFeq0UFAN37X+uJY+OFk6r2P4fT
         nAMzGBjPcovdpdsdtbuj2EM/03bZd5J6A1yN/TvIYCLRkDrLmgceuIwcJ3S9lw6F13kJ
         2dto13yXCbmBNn3Be6MzDSrYxf8GyDVIOaoDpM9Urye2e3BLi85JPgEg++YV0qRLcU7E
         XhJnptfn9slhjwfQbASpv1U+HUpIEc3NSzjJlWWUETD8DEGoSNpnTCTpY1i3tu034vHd
         UQAsphP1gK5oW6g2yK0tUY24sPr0o0e/GrAxhr2bKzVSoPrQid2B4VPlLcp9bov+mltP
         Wcug==
X-Gm-Message-State: AJIora/vYwtOYtQMspR3lIKJHgpHbNIqrZ+fN2U5d17Nnz/9K6747UlV
        FTFPbpAUNn3Mpixq912hhNDiJQ==
X-Google-Smtp-Source: AGRyM1v6j4RljEVxbpJQWTZMu9/slUMnYX4ovCKePTMsCQFjvJ6ScH+OgvZLnPFz5pi6lG06tqjFuQ==
X-Received: by 2002:a63:6c42:0:b0:3fe:465:7a71 with SMTP id h63-20020a636c42000000b003fe04657a71mr4186781pgc.101.1656175285444;
        Sat, 25 Jun 2022 09:41:25 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id be19-20020a056a001f1300b005254c71df0esm3803232pfb.86.2022.06.25.09.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 09:41:24 -0700 (PDT)
Message-ID: <7e14a11b-225e-13c4-35ff-762eafd20b70@kernel.dk>
Date:   Sat, 25 Jun 2022 10:41:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH -next v5 4/8] blk-throttle: fix io hung due to config
 updates
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>, tj@kernel.org
Cc:     ming.lei@redhat.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220528064330.3471000-1-yukuai3@huawei.com>
 <20220528064330.3471000-5-yukuai3@huawei.com>
 <20220622172621.GA28246@blackbody.suse.cz>
 <f5165488-2461-8946-593f-14154e404850@huawei.com>
 <20220623162620.GB16004@blackbody.suse.cz>
 <75b3cdcc-1aa3-7259-4900-f09a2a081716@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <75b3cdcc-1aa3-7259-4900-f09a2a081716@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/22 2:36 AM, Yu Kuai wrote:
> ? 2022/06/24 0:26, Michal Koutn? ??:
>> On Thu, Jun 23, 2022 at 08:27:11PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
>>>> Here we may allow to dispatch a bio above current slice's
>>>> calculate_bytes_allowed() if bytes_skipped is already >0.
>>>
>>> Hi, I don't expect that to happen. For example, if a bio is still
>>> throttled, then old slice is keeped with proper 'bytes_skipped',
>>> then new wait time is caculated based on (bio_size - bytes_skipped).
>>>
>>> After the bio is dispatched(I assum that other bios can't preempt),
>>
>> With this assumptions it adds up as you write. I believe we're in
>> agreement.
>>
>> It's the same assumption I made below (FIFO everywhere, i.e. no
>> reordering). So the discussed difference shouldn't really be negative
>> (and if the assumption didn't hold, so the modular arithmetic yields
>> corerct bytes_skipped value).
> Yes, nice that we're in aggreement.
> 
> I'll wait to see if Tejun has any suggestions.

I flushed more emails from spam again. Please stop using the buggy
huawei address until this gets resolved, your patches are getting lost
left and right and I don't have time to go hunting for emails.

-- 
Jens Axboe

