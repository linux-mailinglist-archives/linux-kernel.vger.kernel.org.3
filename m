Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A685970FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 16:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiHQOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236541AbiHQOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 10:22:34 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAB88FD5E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:32 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p184so7339248iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Me5Eblpo77OL8yVoImUGgcZR3F3DnEB+a6/Z40BtEUw=;
        b=h2zL1ufdtgJJFFU+85KTEoC4O6YSNXK2JjaJPFWG36R7ur2vGdkcOVcYxNWZXJhUmz
         MdICl+1GPugAWr/Oi42oFCG7TN3IMujkNRDCNEKiBSEnEB/xbwWM6HAJUHCKFsdqtU08
         kQFHHK+7GYYAwWSTo4gRNLdJGVr0WJtoDLP/quB08ODjfQGsB5B6+QRiOteonJXRpk8u
         cxtDinQBhgntFAkMz0CmELxo/Nvd6rknf9Lbh7yH5aXf4OcecbHY/k6VTL8OfvVAfHot
         GxWX5yCxgJjEx7zuMdKJSjf4Tsb/ne3/pnEAsXVdyiNxg/M3XCH9DcGVjROOLd+eMRck
         Tk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Me5Eblpo77OL8yVoImUGgcZR3F3DnEB+a6/Z40BtEUw=;
        b=oHADti5gpzyYq8rsQhtXFu3ojMe4/25zsiEWKxVoPAbESzrPRo799OUbvmIG34307+
         T30E+iZAlnTw/zZ704HurkqpPdLom8qfPYC2NyDcEWdVMceNS2xjsacyFUsle3P143Xw
         Kq027M6vwJ1+QLZW9mL2xUN29L0ouTDqKev5js6aXyPqLlWwfGi+UJ7UodjQhGsuPjBL
         3TTNabTvTtXSKjpT8JnbBOJtJEHSk2lveV4Fqgenp/CJ3XI5gXb31E6IWaimvvNbVh2P
         tlK4ewNFsaCoazEjIcPmzszI+YanUy9oSQCidxTRZhnmMNo+TGqP0Jr6o7FODSbhdnL3
         4acQ==
X-Gm-Message-State: ACgBeo1FuHXZOELBaRwLzmjewCME6u/lQgIgi8ILG8ZCKCQJ29yge88Y
        FZ5fxMW5gQMTJEaLfOqmnirGpg==
X-Google-Smtp-Source: AA6agR7HQdtIfxPCr3oiJs2lcxa3+I+ci/q1ohQUdF0E5/wMxrEqfrF8MtdZR4Wj8edFWr6lWGHbLA==
X-Received: by 2002:a05:6602:3cc:b0:678:eb57:5eb with SMTP id g12-20020a05660203cc00b00678eb5705ebmr10575715iov.125.1660746152190;
        Wed, 17 Aug 2022 07:22:32 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z20-20020a027a54000000b003429446e53dsm5645789jad.43.2022.08.17.07.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 07:22:31 -0700 (PDT)
Message-ID: <408038f9-654c-611a-2c48-c1b5d660a6a7@kernel.dk>
Date:   Wed, 17 Aug 2022 08:22:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: KASAN: null-ptr-deref Write in io_file_get_normal
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiacheng Xu <578001344xu@gmail.com>, linux-kernel@vger.kernel.org,
        asml.silence@gmail.co, io-uring@vger.kernel.org,
        security@kernel.org
References: <CAO4S-mdVW5GkODk0+vbQexNAAJZopwzFJ9ACvRCJ989fQ4A6Ow@mail.gmail.com>
 <YvvD+wB64nBSpM3M@kroah.com> <5bf54200-5b12-33b0-8bf3-0d1c6718cfba@kernel.dk>
 <YvyPe7cKY2sLzbJt@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YvyPe7cKY2sLzbJt@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 12:49 AM, Greg KH wrote:
> On Tue, Aug 16, 2022 at 10:57:39AM -0600, Jens Axboe wrote:
>> On 8/16/22 10:21 AM, Greg KH wrote:
>>> On Wed, Aug 17, 2022 at 12:10:09AM +0800, Jiacheng Xu wrote:
>>>> Hello,
>>>>
>>>> When using modified Syzkaller to fuzz the Linux kernel-5.15.58, the
>>>> following crash was triggered.
>>>
>>> As you sent this to public lists, there's no need to also cc:
>>> security@k.o as there's nothing we can do about this.
>>
>> Indeed...
>>
>>> Also, random syzbot submissions are best sent with a fix for them,
>>> otherwise it might be a while before they will be looked at.
>>
>> Greg, can you cherrypick:
>>
>> commit 386e4fb6962b9f248a80f8870aea0870ca603e89
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Thu Jun 23 11:06:43 2022 -0600
>>
>>     io_uring: use original request task for inflight tracking
>>
>> into 5.15-stable? It should pick cleanly and also fix this issue.
>>
>> -- 
>> Jens Axboe
>>
>>
> 
> Thanks, will do after this next round of releases go out.

Thanks Greg.

-- 
Jens Axboe


