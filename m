Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6152F005
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbiETQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351337AbiETQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:06:10 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B34A901
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:06:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id q18so7720985pln.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5/R5bCf9OwP510/pDmYW2FFlspx1kD44TYqDeemy0+4=;
        b=kj8F3oF04Q9cLGw74VEVRn5irZvHe5KFHraSHeY77+cYi4kjVw8MvBAdi2Oan4E3/Z
         Ru/89bmGcEsg0mWcm1h2qt3d+EAH7vChfHLMkTFOv9lyrq+pnxTLu6BEAwciq+9vE+dj
         1PmX3SLwn2L1+6q/S/4VUVw5OFzL1zQqyy8iDmWOxQ/U2N2KyUFlCcofesFVn1ZIwKIM
         rF20hYFKGDyhOmcICka4Q8dTCawON4VO4xbl/+LrZc7EFgjs3j1Z0hj8pGZuTykjiYFx
         dFaDuFv3m22dHuTzJ+KLT3XIpnY6LqaPyqLr6mSvmp3n3n/6Y8V+PuHGscR+UakzmfaO
         YNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5/R5bCf9OwP510/pDmYW2FFlspx1kD44TYqDeemy0+4=;
        b=ovPbr87dMIGyB++Y++5pj8Tigo65MUMtJVBdrCvMTAynDKsWLmPOkP32swI1yN5w1Z
         /lwmNx21wcl87c+1RVlwTKvuWKPwM1LAywcmkPil1AexHC3yBaH0jeWS1wp7nqWjgDg1
         mOgnwPzEwsYUFqXWaqsqkayI3O2nabt3lgYeuUCpsMOR8gE4GstnE//g9vtNuHwQSMFk
         siBqlt5T93/AbGK/8D7iBM1ZE/tTsxhBqZ4czPJozag6R7IIGFMcEQXawHg7lFSmDwr3
         c+WpwSrkQn6qyy0Gxm9gRMF53B/tpnMxRD8I8JOUv0j7AXGbjZ8ZunQaSZMDUMua447O
         zV+g==
X-Gm-Message-State: AOAM530uazAYSwFdyE3jGZBO/ytI0BaVazCI2eN9gDbzI9jKVSqdNqcK
        Vj2oeGR9t1wmxrXmuJtl8AtqhA==
X-Google-Smtp-Source: ABdhPJwH39QfgiguHNPaK0KPDtD1T/94hq0odQeT5/vu9w0UEfRsxg0jeL2FeIHSHBm104XH+2JlPQ==
X-Received: by 2002:a17:902:ef45:b0:156:1858:71fc with SMTP id e5-20020a170902ef4500b00156185871fcmr10073381plx.23.1653062768465;
        Fri, 20 May 2022 09:06:08 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id f11-20020a62380b000000b005184640c939sm1986005pfa.207.2022.05.20.09.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 09:06:07 -0700 (PDT)
Message-ID: <bcef12c5-35b5-f6a8-24c8-d190f87c3cff@kernel.dk>
Date:   Fri, 20 May 2022 10:06:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/3] random: convert to using iters, for Al Viro
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20220520094459.116240-1-Jason@zx2c4.com>
 <Yoey+FOYO69lS5qP@zx2c4.com> <bbdeeca7-9c99-e661-6596-f04ea783a30b@kernel.dk>
 <Yoe2PPA/pzqhf+GZ@zx2c4.com> <0a6ed6b9-0917-0d83-5c45-70ff58fad429@kernel.dk>
 <Yoe52RaMayvgodVW@zx2c4.com> <79024675-9a4a-cb2b-a0ed-91067ef05783@kernel.dk>
 <Yoe7ykNXjUerhywY@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yoe7ykNXjUerhywY@zx2c4.com>
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

On 5/20/22 10:03 AM, Jason A. Donenfeld wrote:
>> Then I'd say there are only two options:
>>
>> - Add a helper that provides splice for something that only has
>>   read/write set.
> 
> That'd be fine with me, but wouldn't it involve bringing back set_fs(),
> because of the copy_to_user() in there?

I haven't even looked into whether it's currently feasible or not, just
mentioning it as a potential option. But the better one is definetely
the next one...

>> - Just accept that we're 3% slower reading from /dev/urandom for now,
>>   and maybe 1-2% for small reads. Can't really imagine this being a huge
>>   issue, how many high throughput /dev/urandom read situations exist in
>>   the real world?
> 
> An option three might be that eventually the VFS overhead is worked out
> and read_iter() reaches parity. One can hope, I guess.

And that will certainly happen, especially as we have other paths that
don't really have the choice, they have to use the iterator versions.
And if we can get a bit closer, then that also opens the door more
generic conversions so we can kill ->read/->write for almost all cases
(except those weirdo ones that Al pointed out).

-- 
Jens Axboe

