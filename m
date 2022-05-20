Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B4F52E182
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344199AbiETBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344210AbiETBGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:06:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61522BCC
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:06:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id i8so6139866plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oQsGBHyg4anWhL9luyNRj4RxEeeygNWGDSk1a1ys5Tk=;
        b=MNGMyo/iFIrtWF+ECjFPBilsERxattchuXUT025XovM9k07HVR3RMo4VWOOU+cEPCD
         ZJU13q/OhRwAfhb0DkD0zanT9Ee8X6EOg4a+AG9tuNPXRSnt/mMzUn92eKl0FarYUaru
         FsjiCOLqzKAyrzNSOmxVVRSh3lYS5EUWvCrZrkK6/tNcJyOeLtsjZ6kGAM4Jprjc4lkZ
         JW2/KxbQqyo964jn+6p6lRfujN03/at+gow//h7gTd2+rl5kcn0zLk1vwFhQwDuOOhM/
         /RnVWMyIWjE7Lx4ABkL4SGtg0HomDaQQ9ynsUPSjGNwinJw1F0+qpJ3mli6qpAJp2VTm
         bmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oQsGBHyg4anWhL9luyNRj4RxEeeygNWGDSk1a1ys5Tk=;
        b=iuZneZ58JzPLXl2qNQruld9+WYTsY1H6o9A90V6OWmgNyFmgGYSfGMkyT9Gu5Lomjn
         QfCm7nwfYOQjZoFWkvFAjqQtMIGJBqZUzAU9zMqctWnUQJzdWlhWiFdKTqUbIyDcAaRm
         AqPTFCQcm/B0pVaBYffREqw/+o1w8q6TX0EAOpdW0PhMslfeeqEdzNfoOiYM+kmZ9wkg
         t62eboz0F3lDwfmOmaxbffqwwU88lZ1Ph3XClbMOZpyJyjlJIeqPwHyUaN13QIuKv4WN
         gjPwmcLeYL4vfGWVayp7RuvvjPUBZElLHdAF1YiRq4kAOnGV3lw/GGmL5panAYu9nHBM
         zyDQ==
X-Gm-Message-State: AOAM53173nvta3bgOsme7/Gwlw7Vh4QACEgp3cayS9ffM+UtIDPD+KiE
        +jY2a7IyKHDkZoivGCv2l5UOgg==
X-Google-Smtp-Source: ABdhPJz3u5e4/xj2hM37upFEiwGVZ7O6bXtKDVpC84G3mV+nWP9TNVSQvt7BYFSUW4xR+17smPosuQ==
X-Received: by 2002:a17:90b:4d11:b0:1dc:ec4f:a19c with SMTP id mw17-20020a17090b4d1100b001dcec4fa19cmr8587931pjb.117.1653008759671;
        Thu, 19 May 2022 18:05:59 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 194-20020a6306cb000000b003db7de758besm4190792pgg.5.2022.05.19.18.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 18:05:59 -0700 (PDT)
Message-ID: <8f890747-c37f-2fd4-2428-4a9ffc865cac@kernel.dk>
Date:   Thu, 19 May 2022 19:05:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
References: <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
 <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
 <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
 <03c7d6c9-0c86-d4b6-357d-d51be0143c80@kernel.dk>
 <CAHmME9qVQNkx-0J8rq_0ZVaSR+-eEgOUtcZhvq5dAY4-kJxSAA@mail.gmail.com>
 <13899409-e81b-8689-3380-249de46c0b6f@kernel.dk> <YobldmDn6pU9mr4f@zx2c4.com>
 <84d073aa-9937-1a58-dd7a-b1828874c21a@kernel.dk> <YoboEokc00YACuha@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoboEokc00YACuha@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 7:00 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 06:56:12PM -0600, Jens Axboe wrote:
>> On 5/19/22 6:48 PM, Jason A. Donenfeld wrote:
>>> sendfile() returns -EINVAL even with your patches. Only splicing to pipes
>>> seems to work.
>>
>> Huh, that really should work. Are you trying to sendfile() to random? If
>> so, you need that last write_iter patch too, and add the splice_write as
>> I mentioned.
>  
> No, I've only tried the read side so far. I made a little program:
> 
> #include <sys/sendfile.h>
> #include <stdio.h>
> 
> int main(int argc, char *argv[])
> {
>         ssize_t s = sendfile(1, 0, NULL, 0xffff);
>         fprintf(stderr, "ret: %zd\n", s);
>         return 0;
> }
> 
> Then I ran `./a.out < /dev/urandom > /dev/null`. Fails. OTOH, if I
> replace /dev/urandom with an ordinary file, it succeeds.

Yeah I reproduced the same, doing it the other way works fine. Curious
enough to see what it is, looking into it.

-- 
Jens Axboe

