Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE752E078
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343549AbiESXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343559AbiESXVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:21:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6E657B3D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:21:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so6506204pju.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8UOFKpBlVl67udR+va19FltTZxwf5dr1CAwPsKAWcf8=;
        b=I3/C3Iwr52u1ma3ooqmr93RnTeH1cdvDfV0lMBY7P7csxL1nmN1rVVxlaovF8MYTtZ
         u0Z9fGxyqocP6JD9SyidLnUkQF3xuPkP0usRS/igsCKNWMH/zENplRkL6zwkvmSyfblp
         hHl9crw7cunS1EO5vLvfWYGZlys3FhnXKKXo2gLVPMXf1T7/K8V367nJXgeX3DlBW9iE
         ZS71CNqq5EJ/oGrpa9j6ne05oAEIJYrvhE229D37iiM63kIsFmObkk++KnZrHwaLRdaB
         0mXb23078z/V7GNYUFssoSkWgQFvtR4PvgIzfvvy37f4rY0BAoKskiAq19F939643/bq
         WnDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8UOFKpBlVl67udR+va19FltTZxwf5dr1CAwPsKAWcf8=;
        b=Ye8bAU6mMidvIoPatZT7qRkIL14PCi+8/61mZqX4DvG6SkEVY1BSebaxsLVZceKchX
         3BFyB4478FIkrJXZNG9D0Crqkp21OJCIlvr9Gp/G5qHz0acCs/L06ibXtBV12e49jHjr
         mZpRd9ZOrBQPoytOZDUCOGKUEELDbt899UsWqwcWRP+9Qaf7K8WPwwj68/SDDkPo90Zr
         CHE3/C3/gdceq775cZAccFfCaZaFsJGw6k8UlXzl939u8s3o/HdCIdBpgeKIYRVaX5nM
         hNhvRFGbsmCQaAmoM7pPgmSrTLsWOuq/Pvy7Hd+HUEgbx8cYuqTg20ePAKa3w25gQCOA
         5aAg==
X-Gm-Message-State: AOAM530IQJMq12uoNwn/Meuyv/BE9qZCT3croz20RdPrk5JdEwnn9Rxp
        c/vTozTYPKWiEOH60PvnyMuz7w==
X-Google-Smtp-Source: ABdhPJz9Cw8oRP6kqq1kQDHezDhAedezHF4YXiRvOxU8OQ12SBHZh6MDWXmjzeMFfukp5OAQw1iwcQ==
X-Received: by 2002:a17:902:8645:b0:15f:2eb5:3d49 with SMTP id y5-20020a170902864500b0015f2eb53d49mr6875545plt.42.1653002494223;
        Thu, 19 May 2022 16:21:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b001613dfe1678sm4228322pll.273.2022.05.19.16.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 16:21:33 -0700 (PDT)
Message-ID: <8251e0d7-d506-16ea-7bc8-4c8bf098deea@kernel.dk>
Date:   Thu, 19 May 2022 17:21:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] random: convert to using fops->read_iter()
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     tytso@mit.edu, hch@lst.de, linux-kernel@vger.kernel.org
References: <20220519193133.194138-1-axboe@kernel.dk>
 <20220519193133.194138-2-axboe@kernel.dk> <YobOxLKnRDyYChXS@zx2c4.com>
 <YobQt1Fbae0KtEFw@zx2c4.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YobQt1Fbae0KtEFw@zx2c4.com>
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

On 5/19/22 5:20 PM, Jason A. Donenfeld wrote:
> On Fri, May 20, 2022 at 01:12:04AM +0200, Jason A. Donenfeld wrote:
>> Hi Jens,
>>
>> On Thu, May 19, 2022 at 01:31:32PM -0600, Jens Axboe wrote:
>>>  	for (;;) {
>>>  		chacha20_block(chacha_state, output);
>>>  		if (unlikely(chacha_state[12] == 0))
>>>  			++chacha_state[13];
>>>  
>>>  		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
>>> -		left = copy_to_user(ubuf, output, block_len);
>>> -		if (left) {
>>> -			ret += block_len - left;
>>> +		block_len = copy_to_iter(output, block_len, to);
>>> +		if (!block_len)
>>>  			break;
>>> -		}
>>>  
>>> -		ubuf += block_len;
>>>  		ret += block_len;
>>>  		len -= block_len;
>>> -		if (!len)
>>> -			break;
>>>  
>>>  		BUILD_BUG_ON(PAGE_SIZE % CHACHA_BLOCK_SIZE != 0);
>>>  		if (ret % PAGE_SIZE == 0) {
>>>  			if (signal_pending(current))
>>>  				break;
>>>  			cond_resched();
>>>  		}
>>>  	}
>>
>> This isn't quite the same, is it? Before, it would immediately break out
>> of the loop on any short copy. Now, it will only break out on a zero
>> copy, which means it's possible that ret % PAGE_SIZE == 0, and there'll
>> be an unnecessary cond_resched() before copy_to_iter() runs again and
>> then breaks.
> 
> Maybe something like the below would do the trick?
> 
> 
> static ssize_t get_random_bytes_user(struct iov_iter *to)
> {
> 	size_t block_len, copied, ret = 0, len = iov_iter_count(to);
> 	u32 chacha_state[CHACHA_STATE_WORDS];
> 	u8 output[CHACHA_BLOCK_SIZE];
> 
> 	if (!len)
> 		return 0;
> 
> 	/*
> 	 * Immediately overwrite the ChaCha key at index 4 with random
> 	 * bytes, in case userspace causes copy_to_user() below to sleep
> 	 * forever, so that we still retain forward secrecy in that case.
> 	 */
> 	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
> 	/*
> 	 * However, if we're doing a read of len <= 32, we don't need to
> 	 * use chacha_state after, so we can simply return those bytes to
> 	 * the user directly.
> 	 */
> 	if (len <= CHACHA_KEY_SIZE) {
> 		ret = copy_to_iter(&chacha_state[4], len, to);
> 		goto out_zero_chacha;
> 	}
> 
> 	for (;;) {
> 		chacha20_block(chacha_state, output);
> 		if (unlikely(chacha_state[12] == 0))
> 			++chacha_state[13];
> 
> 		block_len = min_t(size_t, len, CHACHA_BLOCK_SIZE);
> 		copied = copy_to_iter(output, block_len, to);
> 		ret += copied;
> 		if (block_len != copied)
> 			break;
> 		len -= copied;

Yep, that looks good! Do you still want a v2?

-- 
Jens Axboe

