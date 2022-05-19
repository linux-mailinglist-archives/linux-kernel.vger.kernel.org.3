Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA09752DEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240490AbiESUtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiESUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:49:17 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB008720B
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:49:15 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r27so7006653iot.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mMPAhWg1RWJo61kI7nAEiWELzMoAFv3kbKia1PRtMv4=;
        b=WLcVOYIwhY+m1Ti6O3IurRE9R2/jzKn5pnWH3QfjQdm8CqSEp1EdUX0gWDyNn6uvU4
         5PX3JkX4q4Q+gnj8mr9ndvYzyJGnTYww4/ncO2mM9Tjr1+z3hXNUyIJ4eMrOJdwINz5W
         GkZUljsoSOoofvJ0ixo6jFhe94wXprr6Q8YMihLTq0UOeDvpESTq0gq8hl7D6NjVW5Lo
         yT1vuj+3RxeAqAXyMxIo5cUQGY/FJYwAv8vpgiybyXA3yzakr/Fmh5BciJXwufii/OhC
         Z19Fr1SxCMtKrB3C7DNpy5kEtQ5n4DZFTOGisfvxMqqJ4GiUJfiKgnKtrIe8YHhhDAgj
         00CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mMPAhWg1RWJo61kI7nAEiWELzMoAFv3kbKia1PRtMv4=;
        b=hPEAoRlDUe7J1sLvZaKOt/u/vPk3M2xKr90RV0v4k7qF4ic9vRLlABtM3jfEsm7ND3
         uhj7vdzGh4+TkceMTLZFyuc6WnF2ohmU7GNzogIUY22WbleTnIUDTHBc2MXTtsJZY73u
         ZH4KfM3YST204CygdOLNlNYP9weUM8lqJ3dqrflTtKi7ISlJiUaYc1fFbLizTMxAgAwY
         ZlOvcGbqojTbCq6vurJdbjJgr+iy0VDvwirqxmMKRF1lFZEZSL6VJ3denrFz945RBU9n
         lgrxjHOzTrO5JkSXNNixVyv/hwcHGJmNj3fGcZkMjlj0AoEcpUkBYm9mOuug72xt2g7u
         0UCg==
X-Gm-Message-State: AOAM533BULC9d3eFh2XKdmdLCVhTH7YB7cjp+bfdbNBL349PlInERoW2
        10m4AoLpbngl0yOgTYpFDaCIFg==
X-Google-Smtp-Source: ABdhPJz9azVkX+Nvvac5Qn6eCOWQnlSUdDNcm/0M78G6sKthSHIYmT9BB1Q6ie/P6wdZcUTKGgVLfQ==
X-Received: by 2002:a05:6602:2d8d:b0:649:f82b:c877 with SMTP id k13-20020a0566022d8d00b00649f82bc877mr3401323iow.66.1652993355302;
        Thu, 19 May 2022 13:49:15 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w9-20020a023949000000b0032b3a78175esm178525jae.34.2022.05.19.13.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 13:49:14 -0700 (PDT)
Message-ID: <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
Date:   Thu, 19 May 2022 14:49:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YoajCafKmgUbbaY0@zx2c4.com>
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

On 5/19/22 2:05 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 01:31:31PM -0600, Jens Axboe wrote:
>> Hi,
>>
>> We recently had a failure on a kernel upgrade because splice no longer
>> works on random/urandom. This is due to:
>>
>> 6e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
> 
> Thanks for this. I'd noticed this a few months ago and assumed it has
> just always been that way, and hadn't gotten to looking at what was up.
> 
> I'll take a look at these patches in detail when I'm home in a few
> hours, but one thing maybe you can answer more easily than my digging
> is:

Sounds good, thanks!

> There's a lot of attention in random.c devoted to not leaving any output
> around on the stack or in stray buffers. The explicit use of
> copy_to_user() makes it clear that the output isn't being copied
> anywhere other than what's the user's responsibility to cleanup. I'm
> wondering if the switch to copy_to_iter() introduces any buffering or
> gotchas that you might be aware of.

No, it's just a wrapper around copying to the user memory pointed to by
the iov_iter. No extra buffering or anything like that. So I think it
should be fine in that respect, and it actually cleans up the code a bit
imho since the copy_to_iter() since the return value of "bytes copied"
is easier to work with than the "bytes not copied".

> Also you may need to rebase this on the random.git tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git

OK, I will rebase it on that branch, not a problem.

-- 
Jens Axboe

