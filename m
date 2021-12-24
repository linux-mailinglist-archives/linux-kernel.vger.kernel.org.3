Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120CB47F012
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 17:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353222AbhLXQSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353212AbhLXQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 11:18:29 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED549C061401;
        Fri, 24 Dec 2021 08:18:28 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l17so7946577qtk.7;
        Fri, 24 Dec 2021 08:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dtx9MDs9abBmFPzeb1I43UGsECeVKzNTwQ5TQE2OV/c=;
        b=e8Nlmjlw9kNwqdvt8Nq78LEvgDlWQSSC5UhpHqjKEsMYPfSO8RP4dDOgjqyzN7KiT9
         Ha84dC/qJTJ8F+F7Uf3zJ6MZt2Zhv46PAP7jG7WA6evt8YANz1uiZPJl3NY+F5niK6Ye
         NsQAlrRoaIXFMHKgb5rrGwAM7XX29vu9IGuVK3aNKkSbdKXoxJ2cbH0J4kQ2KnLd0hOG
         BZIX3uSxjOsrTW+8sEMWXW58sdZtjLBP784VyLasT2rg8Gu3ltQ1MgmaSocOrw7aq0hh
         v/a/TPfcW8xlsd/mq2Eio7XX1XtMGPMYtr5e9Gw1pTXf+STkrXK3LSRXzvN4wptVE3Os
         Ha7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dtx9MDs9abBmFPzeb1I43UGsECeVKzNTwQ5TQE2OV/c=;
        b=Rs7hy6hgkRymRPd0TR81x2iAtCEqtSjMP5ouVgCv+5yoEf1qV1cqhnIhi6Ok9mEuvw
         4EdFde2G0JFmhui71nKuErWIYN9HkYHUVLDADVaznLaeX79JowlHYCj5VRDGD0BqFBee
         J7ElsnE/N2E7vYCOmJYPmel8p+Gk9nsBZvHq5YPB4B87oEY/UTp2Pgg4w18XeD4tCxI5
         TKB2oaZkEhFEd/5nlXD9NTwNod+hMxc3mw9aD46J+XCAmBgwT0/3EVRVwrPz37Ro+aDS
         75gSk6vTvewf6NkwuWke67iSWafx9vzwObf6m/6pjy9Q3kDPXKK+Bh0Khu+gbjASpG01
         bICQ==
X-Gm-Message-State: AOAM533BDHXDJ4tq3yXMHX24ibC8wj1d7/GfNPr3FPKQWOLQXQajrkS+
        ECZ3vdDR+LUgK9ngKYh3OQ0=
X-Google-Smtp-Source: ABdhPJzfVpIVWHBWyvE6BCLZi0U0Z/fknJBC2xtLfIzJIw5l0Kd4WsqLISlD+/o1oEMFbCFrg7bOJA==
X-Received: by 2002:ac8:5743:: with SMTP id 3mr6131443qtx.440.1640362708148;
        Fri, 24 Dec 2021 08:18:28 -0800 (PST)
Received: from [192.168.1.49] (c-67-187-90-124.hsd1.ky.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id h6sm3582636qko.122.2021.12.24.08.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 08:18:27 -0800 (PST)
Subject: Re: [PATCH] of: unittest: Fix out of bounds array access when id < 0
From:   Frank Rowand <frowand.list@gmail.com>
To:     Yin Xiujiang <yinxiujiang@kylinos.cn>, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211221092830.680839-1-yinxiujiang@kylinos.cn>
 <96165b43-4be2-644c-dfc9-42173fcfc775@gmail.com>
Message-ID: <df6e9b2b-073d-a8a6-daef-92da2fb0eda9@gmail.com>
Date:   Fri, 24 Dec 2021 10:18:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <96165b43-4be2-644c-dfc9-42173fcfc775@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/22/21 1:06 PM, Frank Rowand wrote:
> On 12/21/21 4:28 AM, Yin Xiujiang wrote:
>> In of_unittest_untrack_overlay if id is less than 0 then
>> overlay_id_bits will be out of bounds. And it is also mentioned
>> in bugzilla as a bug report:
>> https://bugzilla.kernel.org/show_bug.cgi?id=214867
>>
>> Fix this bug by tiggering WARN_ON()
> 
> This patch is just papering over the underlying problems.
> 
> The tracking of overlay ids in unittest.c depends on some
> expectations of the expected range of values of id to be
> tracked.  The resulting implementation is a bit fragile.
> Let me take a look at whether I can create an alternate
> implementation of id tracking.

I am going to totally replace the id tracking with a more
robust version that resolves several issues.  Patch should
be done on Monday or Tuesday.

-Frank

> 
> -Frank
> 
>>
>> Reported-by: Erhard F. <erhard_f@mailbox.org>
>> Signed-off-by: Yin Xiujiang <yinxiujiang@kylinos.cn>
>> ---
>>  drivers/of/unittest.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 5b85a2a3792a..094f9f4444d0 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1907,7 +1907,7 @@ static int overlay_first_id = -1;
>>  
>>  static long of_unittest_overlay_tracked(int id)
>>  {
>> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>>  		return 0;
>>  	return overlay_id_bits[BIT_WORD(id)] & BIT_MASK(id);
>>  }
>> @@ -1918,7 +1918,7 @@ static void of_unittest_track_overlay(int id)
>>  		overlay_first_id = id;
>>  	id -= overlay_first_id;
>>  
>> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>>  		return;
>>  	overlay_id_bits[BIT_WORD(id)] |= BIT_MASK(id);
>>  }
>> @@ -1928,7 +1928,7 @@ static void of_unittest_untrack_overlay(int id)
>>  	if (overlay_first_id < 0)
>>  		return;
>>  	id -= overlay_first_id;
>> -	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS))
>> +	if (WARN_ON(id >= MAX_UNITTEST_OVERLAYS || id < 0))
>>  		return;
>>  	overlay_id_bits[BIT_WORD(id)] &= ~BIT_MASK(id);
>>  }
>>
> 

