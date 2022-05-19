Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591E152E074
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343490AbiESXTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234213AbiESXTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:19:34 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77C3F74A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:19:33 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so10000022pjp.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HkpLX5d+0MkqzwvQ+3AzHLCEwixfF+WafpJiNTDl1Es=;
        b=CFUdPM7hPWEqCmvntb3hYKm7lunX0hbEt78+UwJQUB3/uulVfQ3Jkhlbx2FjPY1sjS
         8GBVHdJrYhD+u2PSOY+WnKMBKW5X/djPknhbdSXfcgNbJn1udy7GKyJ/dEg+uyHqS2gA
         t+HFd+SUX45W7uMf0YnyR+u8mLbhbqWu8W3PpWf/dpiDDItFPh4ehpmDKc/U7MJiflu5
         x1QscZl0If66fGcoTLjTN3fAu56rICItFmb1fwU2mKZwmS59cKb6SLEa8j0cXNU2SWKc
         ZuBXAA2KlnPQQ6387jFGK5E4hLUswusf2vAKHmgrecl+oUidaSWkjD0a/fatJAn56ZYW
         A5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HkpLX5d+0MkqzwvQ+3AzHLCEwixfF+WafpJiNTDl1Es=;
        b=Mq5QXaRnx2paop8ME381mcXMycKoaa4b87Qa/icfD+QrWqo14LY6vborn+92z+M3yV
         C7kRblj4WB8UocN+TGfh/fPqMoURAfYIL3sD6sudAbdWpEIJP/IgtVi1oBxec7WDOWud
         rI9WKjQY2JI3SI/x/MccrCNHZ/BMi4krDlTOU0/NhULYhb7DhIfsmCr8+86AcUvWtJl/
         XOJBOZEUZxpHwoqZR9ZCjp/aY8mP1C5vSq0OA6NLeKPwEXQnu6Ch/m7muVTZDI7jKXBx
         +oU/PVarw+WfC8SVxmoD/8fVoMjNZXiQ1nBf7Ot/BSb8MFVl0IaygZIv8GciwL3yxSEX
         1NNA==
X-Gm-Message-State: AOAM532Amhjblg7rPxr2V3iOqlNZNXJZlNmhbYvNh9lWFxt1lvsoXf2D
        d0ECvaOuWvbmzm5XM2YQZzgA4A==
X-Google-Smtp-Source: ABdhPJxRXPXhEkrDtQM7lD68+YgXNqr3oKWQQYmLAK3DQ7t1D+O9A2edXs39rm7tiEvPX9tpsPDHig==
X-Received: by 2002:a17:902:d4c4:b0:161:bfc2:8e83 with SMTP id o4-20020a170902d4c400b00161bfc28e83mr6921147plg.57.1653002373237;
        Thu, 19 May 2022 16:19:33 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a5-20020a62d405000000b0050dc7628163sm232437pfh.61.2022.05.19.16.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:19:32 -0700 (PDT)
Message-ID: <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
Date:   Thu, 19 May 2022 17:19:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <YoajCafKmgUbbaY0@zx2c4.com> <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk>
 <YobPB27Ozl7uqUEu@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobPB27Ozl7uqUEu@zx2c4.com>
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

On 5/19/22 5:13 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 02:49:13PM -0600, Jens Axboe wrote:
>>> There's a lot of attention in random.c devoted to not leaving any output
>>> around on the stack or in stray buffers. The explicit use of
>>> copy_to_user() makes it clear that the output isn't being copied
>>> anywhere other than what's the user's responsibility to cleanup. I'm
>>> wondering if the switch to copy_to_iter() introduces any buffering or
>>> gotchas that you might be aware of.
>>
>> No, it's just a wrapper around copying to the user memory pointed to by
>> the iov_iter. No extra buffering or anything like that. So I think it
>> should be fine in that respect, and it actually cleans up the code a bit
>> imho since the copy_to_iter() since the return value of "bytes copied"
>> is easier to work with than the "bytes not copied".
> 
> Alright, that's good to hear. So even for kernel->kernel writes, the
> argument is that what ever buffers are used in the process are the same
> ones that the user would be hitting anyway by calling write() on the
> destination if this roundtripped through userspace, so nothing changes?

The source and destination for the copies are exactly the same with the
change as before, so no changes there. The non-user copy is a different
helper.

-- 
Jens Axboe

