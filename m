Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC5B52E077
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343546AbiESXVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbiESXVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:21:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEFE14036
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:21:10 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a19so6304396pgw.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kpcaFu2Grj3rJcr9fVTMJmzIBcQDCk+9HIRbaNZm7ag=;
        b=dgwAp6p5UVKXqytRmhZ1xPv7E1Uuy2jTyHIje25Pt6cUHl3vk08V3YIBUKfESx73aD
         n4Rq08eRIhocwnpZemZwshzKNpBLoVQR7fCApC3SMUb6GvAyPhjPqOZyXdeFFZj4dD8m
         jNfySat5am9+ITA9yASdKoMMbavmybLJQg9u3AN1JtY4f1AH2ypzSBBHTqVgwFP53eGh
         lV32ZeImZ9ZwP1+h+76t1b2Q2CvNIeFsMurtH5ZcUdEdexwyUUjPHOGYHv+YomKUeBBz
         Za+26l/HzRXSHLWntMFqlTiZ4oD8kam/hYTQ1gi1kbf1GSxlvfvudrCsKsguGx9R8P31
         N1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kpcaFu2Grj3rJcr9fVTMJmzIBcQDCk+9HIRbaNZm7ag=;
        b=qqxZ/XNtNzxhL5DBt3OCGOCPSp3aec8eATM8iE81yN8yc5fKnVyyH2ZNIEqNIQsOJi
         a9RSQdpbl+KlWKEMRIU5/UiotRQBFafcS4tNOjxKGiXPMaO3v5pI7IU/pzvh3Rqx8qLi
         9SCYAboXM19KSOCNeE9l0zUpEhjjw1rsoeusbSGWg+m0NDVbUwtXXEVEkGSRZNxTY642
         4xizXqL3UHr6yWaHbnOop+M9EyMge72+5+um09BnnM8fVubB9Yk2Xf4LmVTI1iyVMsqY
         r23xVNgkOTdLOCVDizbgwFrfpij6cI3FYLje1aJK45K1ZUuXy+ThzIAIHJGrstLWQc3N
         hNkg==
X-Gm-Message-State: AOAM533fIrEzXd3NNY0V3sUxnGQLWwdPcnnNhQ0iv9Jg7DZeVHE3bv5B
        QLq+JiKSB1PRLu9O399Ok5iI4grdGT8SBA==
X-Google-Smtp-Source: ABdhPJwP1fnbHQwIB07GMIaunjCKpOdvcmhq2NMzpE3KG08xrmF0DvA0N7XJSVUkVpLHXtupdxynyg==
X-Received: by 2002:a05:6a00:1914:b0:50e:128e:ef42 with SMTP id y20-20020a056a00191400b0050e128eef42mr7150907pfi.65.1653002470234;
        Thu, 19 May 2022 16:21:10 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902b68900b0016162e01553sm4216175pls.168.2022.05.19.16.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:21:09 -0700 (PDT)
Message-ID: <962b6921-b047-2694-23e7-62b23f061895@kernel.dk>
Date:   Thu, 19 May 2022 17:21:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519193133.194138-2-axboe@kernel.dk> <YobOxLKnRDyYChXS@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobOxLKnRDyYChXS@zx2c4.com>
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

On 5/19/22 5:12 PM, Jason A. Donenfeld wrote:
> Hi Jens,
> 
> On Thu, May 19, 2022 at 01:31:32PM -0600, Jens Axboe wrote:
>>  	for (;;) {
>>  		chacha20_block(chacha_state, output);
>>  		if (unlikely(chacha_state[12] == 0))
>>  			++chacha_state[13];
>>  
>>  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
>> -		left = copy_to_user(ubuf, output, block_len);
>> -		if (left) {
>> -			ret += block_len - left;
>> +		block_len = copy_to_iter(output, block_len, to);
>> +		if (!block_len)
>>  			break;
>> -		}
>>  
>> -		ubuf += block_len;
>>  		ret += block_len;
>>  		len -= block_len;
>> -		if (!len)
>> -			break;
>>  
>>  		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
>>  		if (ret % PAGE_SIZE == 0) {
>>  			if (signal_pending(current))
>>  				break;
>>  			cond_resched();
>>  		}
>>  	}
> 
> This isn't quite the same, is it? Before, it would immediately break
> out of the loop on any short copy. Now, it will only break out on a
> zero copy, which means it's possible that ret % PAGE_SIZE == 0, and
> there'll be an unnecessary cond_resched() before copy_to_iter() runs
> again and then breaks.

True, we could just make that:

copied = copy_to_iter(output, block_len, to);
if (copied != block_len)
	...

if that's important. Doesn't seem like it would, if you're passing in
invalid memory ranges. Maybe that ret check makes it so that it is
indeed important. I'll make the changes and send out a v2.

-- 
Jens Axboe

