Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAF3590679
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235865AbiHKSmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiHKSmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 412C397D4F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660243351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1N+sfudTifSbHYKxE9qrlKzOedXyqPZF8dt12A/wwZ0=;
        b=gBibRswCvrrhVssO4wzyX8dfaT/sGWJAJDPPoqeOYOsGQZJNrb5O9MRoJ+ODPp6dum41oW
        di4FQUrpQgelNomPznKnolMMXImFNAhQ5flENaM3HR6pK8CfzUlgfiRhvlUf7y5TxBYyAA
        Ef7/DRmttYVUcxoFyPpqo+pzXRtm+tM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-327-PEPENu_BObmfqcRd8d-b6w-1; Thu, 11 Aug 2022 14:42:30 -0400
X-MC-Unique: PEPENu_BObmfqcRd8d-b6w-1
Received: by mail-ed1-f72.google.com with SMTP id g8-20020a056402424800b0043e81c582a4so11484392edb.17
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:42:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1N+sfudTifSbHYKxE9qrlKzOedXyqPZF8dt12A/wwZ0=;
        b=L5Wx1droNr1Yh6S0fP9yLmdnrQwAdk41d+nNACfCarx9l0H3RPUQo61WRxUjGlOiQK
         5NCnX1nHJD7eLqvUeyJwHGH5AB1x9ZWHHN6ypN5tIkWeYwcJ+NNhvjkwL4xtCg9enTur
         pR+R9o4R1W834pLP2kbcjQL+NCWumK8+DS9ioMfuAc0rZ6BPh7kFDgMaQ9SApjILZcWZ
         JF4WtH4J3a78TNgVFUxMYjxPx1a1UTvSmzh6oxfrMJuxfbMAQd+lc+tCTTF+t0zWkOrF
         uT/iLOX2zBXKicI9NHvyf4OLR9GQuMcABSmGvZfNFe/iME1s8Nl0eXKLTFdJxyA0Tb/l
         wxJA==
X-Gm-Message-State: ACgBeo3NNsb/w3qaYTPCcAxyS+CMba2NzQnlHCK9D7/oDOICo5w0+Gpz
        59DhGl358slK/sPeL/grka8dg11dj/mMBy5yqQrbOHAzRLIx1AwNgz+c9NNJzmT/ieZR+CzIGe0
        ZnS/q3h+M8PiCjSPhVZJtNjVU
X-Received: by 2002:a17:906:4fc6:b0:731:137:8656 with SMTP id i6-20020a1709064fc600b0073101378656mr268660ejw.582.1660243349063;
        Thu, 11 Aug 2022 11:42:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5DYRpr7HFJH/ifHNf55/xClsMWmSBMBVBK/FNBiruL/xrRpCO6iCiJrjPDBgKW3RfIxncBRQ==
X-Received: by 2002:a17:906:4fc6:b0:731:137:8656 with SMTP id i6-20020a1709064fc600b0073101378656mr268644ejw.582.1660243348803;
        Thu, 11 Aug 2022 11:42:28 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-178.retail.telecomitalia.it. [79.46.200.178])
        by smtp.gmail.com with ESMTPSA id h12-20020aa7c94c000000b00440ced0e117sm101543edt.58.2022.08.11.11.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 11:42:28 -0700 (PDT)
Date:   Thu, 11 Aug 2022 20:42:22 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Zhang chunchao <chunchao@nfschina.com>
Cc:     Zhang chunchao <chunchao@nfschina.com>, asml.silence@gmail.com,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com
Subject: Re: [PATCH] Modify the return value ret to EOPNOTSUPP when
 initialized to reduce repeated assignment of errno
Message-ID: <20220811184222.ey2nwpk2flrd6hzm@sgarzare-redhat>
References: <20220811075638.36450-1-chunchao@nfschina.com>
 <20220811150242.giygjmy4vimxtrzg@sgarzare-redhat>
 <8f3d1bf5-48f6-411d-674e-1568e3841d75@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <8f3d1bf5-48f6-411d-674e-1568e3841d75@kernel.dk>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 09:41:38AM -0600, Jens Axboe wrote:
>On 8/11/22 9:02 AM, Stefano Garzarella wrote:
>> On Thu, Aug 11, 2022 at 03:56:38PM +0800, Zhang chunchao wrote:
>>> Remove unnecessary initialization assignments.
>>>
>>> Signed-off-by: Zhang chunchao <chunchao@nfschina.com>
>>> ---
>>> io_uring/io_uring.c | 3 +--
>>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
>>> index b54218da075c..8c267af06401 100644
>>> --- a/io_uring/io_uring.c
>>> +++ b/io_uring/io_uring.c
>>> @@ -3859,14 +3859,13 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>>>         void __user *, arg, unsigned int, nr_args)
>>> {
>>>     struct io_ring_ctx *ctx;
>>> -    long ret = -EBADF;
>>> +    long ret = -EOPNOTSUPP;
>>>     struct fd f;
>>>
>>>     f = fdget(fd);
>>>     if (!f.file)
>>>         return -EBADF;
>>>
>>> -    ret = -EOPNOTSUPP;
>>>     if (!io_is_uring_fops(f.file))
>>>         goto out_fput;
>>>
>>
>> What about remove the initialization and assign it in the if branch?
>> I find it a bit easier to read.
>>
>> I mean something like this:
>>
>> --- a/io_uring/io_uring.c
>> +++ b/io_uring/io_uring.c
>> @@ -3859,16 +3859,17 @@ SYSCALL_DEFINE4(io_uring_register, unsigned int, fd, unsigned int, opcode,
>>                 void __user *, arg, unsigned int, nr_args)
>>  {
>>         struct io_ring_ctx *ctx;
>> -       long ret = -EBADF;
>> +       long ret;
>>         struct fd f;
>>
>>         f = fdget(fd);
>>         if (!f.file)
>>                 return -EBADF;
>>
>> -       ret = -EOPNOTSUPP;
>> -       if (!io_is_uring_fops(f.file))
>> +       if (!io_is_uring_fops(f.file)) {
>> +               ret = -EOPNOTSUPP;
>>                 goto out_fput;
>> +       }
>>
>>         ctx = f.file->private_data;
>>
>>
>> Otherwise remove the initialization, but leave the assignment as it is now.
>
>Generally the kernel likes to do:
>
>err = -EFOO;
>if (something)
>	goto err_out;
>
>rather than put it inside the if clause. I guess the rationale is it
>makes it harder to forget to init the error value. I don't feel too

ah, thanks for pointing this out! Make sense to me, but I hope recent 
compilers can spot that kind of issue :-)

>strongly, I'm fine with your patch too. Can you send it as a real patch?

@Zhang: if you want, feel free to change your patch following the 
suggestions and send a new version, otherwise I can send mine of course.

Thanks,
Stefano

