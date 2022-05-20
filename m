Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5852E314
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbiETDZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiETDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:25:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53A611AFC0
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:25:34 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bh5so6339847plb.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oIvOnBi1zfzgJcgYX6B3AAYIMu7O4TOTP0MAscTgQD4=;
        b=ZAasFmyKC1bCtYFDeeM598RQyVmV1chlTdFSHPZjgX1QKOySQ9CePCDE/VKPQk8gTF
         Efza7Z/0cFBEEqdPhkCvfIRqWFnYIKt65Jr732qAogW+KR20BZ3EFSptZQkl156JCGkD
         lC1VCoxc3ojGRwhT5oSyckTLf+zB+NkJ1/WGJzs9THRub/3c4qHg5OkkUgvmUEjC3Pcu
         T27vTPMtykTR4nCM2/LvjISM0YiZXg10h93pzH+Zvn9U6kYGJuETi75QlwKwbAsJx6sw
         a3uc4/pFa0Rrn14LQ0De5MMa+jP9r1MIV3mHbKsOsVRk8WoFxcZedp4TgFIumZNLF2RU
         eUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oIvOnBi1zfzgJcgYX6B3AAYIMu7O4TOTP0MAscTgQD4=;
        b=uzV/aAN7LL/5bPv7ZXVdsvZJsCkSyXEnbE0dSoXGN2hOBeBLesvRFO9piO/tF/2cZ0
         SM7dFH9V1tPSSJqw5iNXhIUzC7lN+L2en6X+yXShmFQQqC67x0AEqXJZ9H/CANzx8Fd4
         5Gp5q82kR5NR2g2Xwlx2QiE3QCVVi72l88E9zeNXgUsl1inzvEmGIKgSzOkRJjdXMJXp
         PtTD/nc0AtjUtHjyHzaqE6aLHZXmogPzFLfMn6/sFQtteq2ZgMf3Dw2bbDbGDBWVz1m7
         FrOY8y6inad29Y7DKDz+4OeuWSOI+0pk/IQJEst2GOIqD7pQqLkuGJMeU5IYa3+1/m7g
         3APg==
X-Gm-Message-State: AOAM530ad6h4krwjIVZCXcHq7N3d5PCqsvLRKETH06NNXf3u05I6/9M7
        jdHlQ5x8+cEMtOTRAJVN4kDc1vSSCfhWVw==
X-Google-Smtp-Source: ABdhPJxGIaHJIehw0yYD2H3oiND/gRVQaYMV1bSf2rca78U6rOB7y3HypvNrkKyEMQNts49hBhWs9A==
X-Received: by 2002:a17:902:74c5:b0:161:5061:9d93 with SMTP id f5-20020a17090274c500b0016150619d93mr7595309plt.171.1653017134123;
        Thu, 19 May 2022 20:25:34 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016189ed82c4sm4470814plk.79.2022.05.19.20.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 20:25:33 -0700 (PDT)
Message-ID: <e70dfd3b-c2a6-d830-e3a0-6a25f0da9256@kernel.dk>
Date:   Thu, 19 May 2022 21:25:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] random: convert to using fops->write_iter()
Content-Language: en-US
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <f871a510-d262-bc98-757e-204976e1b82c@kernel.dk>
 <YocEddeThi8VUcKb@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YocEddeThi8VUcKb@zeniv-ca.linux.org.uk>
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

On 5/19/22 9:01 PM, Al Viro wrote:
> On Thu, May 19, 2022 at 05:43:15PM -0600, Jens Axboe wrote:
> 
>> -static int write_pool(const char __user *ubuf, size_t len)
>> +static size_t write_pool(struct iov_iter *iter)
>>  {
>>  	size_t block_len;
>>  	int ret = 0;
>>  
>> -	while (len) {
>> -		block_len = min(len, sizeof(block));
>> -		if (copy_from_user(block, ubuf, block_len)) {
>> -			ret = -EFAULT;
>> +	while (iov_iter_count(iter)) {
>> +		block_len = min(iov_iter_count(iter), sizeof(block));
>> +		if (!copy_from_iter(block, block_len, iter)) {
>> +			if (!ret)
>> +				ret = -EFAULT;
>>  			goto out;
>>  		}
> 
> Feed it a buffer with only 1 byte mapped, watch it'll pass to mix_pool_bytes().
> And see how much of 'block' has been used uninitialized...

I don't follow? Buffer with 1 byte, iter setup with 1 byte. We copy 1 byte,
and we pass 1 byte to mix_pool_bytes(). What am I missing?

> And why bother with that min thing, anyway?
> 
> 	ssize_t ret = 0;
> 
> 	while (iov_iter_count(iter)) {
> 	  	u8 block[BLAKE2S_BLOCK_SIZE];
> 		size_t copied = copy_from_iter(block, sizeof(block), iter);
> 		if (!copied) {
> 			if (!ret)
> 				ret = -EFAULT;
> 			break;
> 		}
> 		mix_pool_bytes(block, copied);
> 		ret += copied;
> 	}
> 	return ret;
> 
> and be done with that...

Agree, that does look better, the min() part could've been killed with
the conversion indeed.

>> @@ -1382,11 +1378,16 @@ static long random_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
>>  			return -EINVAL;
>>  		if (get_user(size, p++))
>>  			return -EFAULT;
>> -		retval = write_pool((const char __user *)p, size);
>> +
>> +		iov.iov_base = p;
>> +		iov.iov_len = size;
>> +		iov_iter_init(&iter, WRITE, &iov, 1, size);
> 
> That'd be
> 		import_single_range(WRITE, p, size, &iov, &iter);

Yep that'd be a simpler equivalent.

-- 
Jens Axboe

