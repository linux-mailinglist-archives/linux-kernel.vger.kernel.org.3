Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714352EF49
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350878AbiETPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiETPch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:32:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9454B163285
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:32:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id gg20so8367536pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=0ntU8sTmh5Ep5NJhOAETphIL9u6IXcDTJKCNORkCS/I=;
        b=IKc2NKSf1AUEAsbPlWcIgEDiTqTFpPbUl+OkjQdAxhQM3dSMjE3zWizyiQid4mkJN1
         zgus02O69yK+ROby49I8jIDf9v++Wn3KJWCcEd4BeOBYXORAWs5yMs2ORAIgxiCUYQRY
         SH777deBLEd7dKDpCCz6E6aQ9q9+V9kG5jG22JmHpNNsD5m3kfzFQGRhdnAfxjNSk63t
         P1jWp9gTOWCzpG+SwE0SHN26XImKPyVLFiff5hNNaNc5t2+GTRI6H1+XVOIxFtCNJdT9
         dml5v2KPvLuxxcd1bpgFwJqrABSlxVHv7ptcb9WVjYpXvKDSkmXvg7w9BjeaNFyz5WX3
         z6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0ntU8sTmh5Ep5NJhOAETphIL9u6IXcDTJKCNORkCS/I=;
        b=UJlTs8Nd78zmQBsH++EtfEP80t4PizWJvzKmRrYflhQRAXqYww5ALvv06Z+6iietlG
         d+I6YIcz4gehkeqX1fbaeET3y1mzpTlpV62Qfj/oyiY7Ub4JY0IDWu2jRcZ2qI2mLHar
         u4TZrzDK3hD7CRTAN0yQY6Is/KzC2QU0WK3mlMG1x+U5jzN2UjHLbVbTUDgwzoQSZ8d4
         e3NGZRd/KhbXmlotFlGOjtBdpAhZkXjuHnjH+sFG5491aGFi6QVIjbt86EqeIwRFx4bX
         li7LQi2mCA1V9fyfr/s8y3vdi775hHL1ANdz0mtTHrzHFAYqzaLAwV+q0Itz1y/QKO3o
         MUSQ==
X-Gm-Message-State: AOAM532w0+So4CPzLXXtBtv3qwVqDIhazERTnymz4bK6ObAtNTk3ISFj
        m5j0yS5qw/njWNltkieQKpi+6A==
X-Google-Smtp-Source: ABdhPJwITIqqh6qsh8GVu9M878qMLPuGX+511kDWzKH7A1OzGtisIeWBFyjPeGSfqYFcswfyRjOhtw==
X-Received: by 2002:a17:903:153:b0:161:eaba:5b2a with SMTP id r19-20020a170903015300b00161eaba5b2amr5617477plc.30.1653060756026;
        Fri, 20 May 2022 08:32:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm1776081pjg.37.2022.05.20.08.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 08:32:35 -0700 (PDT)
Message-ID: <f3878dfd-67f7-9a01-8dcf-7202bf5f3918@kernel.dk>
Date:   Fri, 20 May 2022 09:32:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] char/mem: only use {read,write}_iter, not the old
 {read,write} functions
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20220520135030.166831-1-Jason@zx2c4.com>
 <YoevH5YFLcBBfsB0@zeniv-ca.linux.org.uk>
 <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
In-Reply-To: <f35d7a15-0cbf-1663-15af-eae37a90d0ff@kernel.dk>
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

On 5/20/22 9:11 AM, Jens Axboe wrote:
> On 5/20/22 9:09 AM, Al Viro wrote:
>> On Fri, May 20, 2022 at 03:50:30PM +0200, Jason A. Donenfeld wrote:
>>> Currently mem.c implements both the {read,write}_iter functions and the
>>> {read,write} functions. But with {read,write} going away at some point
>>> in the future,
>>
>> Not likely to happen, unfortunately.
>>
>>> and most kernel code made to prefer {read,write}_iter,
>>> there's no point in keeping around the old code.
>>
>> Profile and you'll see ;-/
> 
> Weren't you working on bits to get us to performance parity there?
> What's the status of that?

Totally unscientific test on the current kernel, running:

dd if=/dev/zero of=/dev/null bs=4k status=progress

With the current tree, I get 8.8GB/sec, and if I drop fops->read() for
/dev/zero, then I get 8.6GB/sec. That's 1%, which isn't nothing, but
it's also not a huge loss for moving us in the right direction.

Looking at a perf diff, it's mostly:

               +0.34%  [kernel.kallsyms]  [k] new_sync_read
               +0.33%  [kernel.kallsyms]  [k] init_sync_kiocb
               +0.07%  [kernel.kallsyms]  [k] iov_iter_init
               +0.80%  [kernel.kallsyms]  [k] iov_iter_zero

with these being gone after switch to ->read_iter():

     0.63%             [kernel.kallsyms]  [k] read_zero
     0.13%             [kernel.kallsyms]  [k] __clear_user

Didn't look closer, but I'm assuming this is _mostly_ tied to needing to
init 48 bytes of kiocb for each one. There might be ways to embed a
sync_kiocb inside the kiocb for the bits we need there, at least that
could get us down to 32 bytes.

> It really is an unfortunate situation we're currently in with two
> methods for either read or write, with one being greatly preferred as we
> can pass in non-file associated state (like IOCB_NOWAIT, etc) but the
> older variant being a bit faster. It lives us in a bad place, imho.

And splice etc, for example...

-- 
Jens Axboe

