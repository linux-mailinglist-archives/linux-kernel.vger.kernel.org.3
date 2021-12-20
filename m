Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF847B11F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 17:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbhLTQdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 11:33:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbhLTQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 11:33:14 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32E7C06173E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:33:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id x6so13889774iol.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3y3ZdzFgGAR1E/AaB8gqHxACx/fgP2N34Knou9lpjtk=;
        b=hqzGSYuC7wPQmzYN/AXyRjf2vTckJfNumqkFL5+8wWwpUkQWPdqum68/xsisk4dFzS
         xdrW/rUdYpNddkooTfxbUCufKv28PyGYsgoe4WvaybmZwSSHQg23GM/8/f2Ol1Nyq8we
         fknO1BvT1m5zJiDqTOaGbZjKtsc9ELdEJx3iR0Y65paa4/MD3Ti1zsrIWdtkLZCzEmA9
         jE7tjztPkjFL5etePZpHEVFe1OtxmqXB3v/6GgBr08u/qdLSCGFJhjdOFFzaE6So7tC9
         D6XDzCQf3po1elwKkkfpihceDFxbZ+IsmEoaF/s2x2PCbMuHQClsGd3s+/ZuTrYG5Afo
         5I6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3y3ZdzFgGAR1E/AaB8gqHxACx/fgP2N34Knou9lpjtk=;
        b=YsIKcOzw4jYu0FhrWhWNe9p+y493RMHzTV/1pYmyzycoZ3fcKzE3ofdz6/ZlV9Nm/E
         s30PQ6okxhau5+YDUfumk0THwLJdBQqIGy13s6ymTX7MRTlw4BFJLRh69jiEeDwN5Yo7
         ScVzOY6+k5CgJ4g8LPqf1FcARmCzGkzUwDCTThv7XhKiSeN7O34vXjtOgfKtcBrpoqca
         3sm4pVGWvqzs6AiGbmcwgQZWzRdV/NICI44feP1WqqjmGjj7XABhAdONmzVfd0Bpk8W6
         VDrba6toF2fER46PsqvfgNvpIDpyn5pvQ1PAhY33Pm6IQy8sRVZq2Dl3GPemuRfKFcRp
         53vA==
X-Gm-Message-State: AOAM530nYArZlGiqwFJm47m7uFE+/zBv6qmZMeEbM5biKc2ukp/18T+a
        VM57wqBoUDXbQuWopXljsL6g9KcFwlzdIQ==
X-Google-Smtp-Source: ABdhPJzQPMLTftdafFpdN9TE+Gkm65iOSMK91N8RDy/Vf1PcatP90M7X4n9+g5UvAIWIVwNw20TAZw==
X-Received: by 2002:a05:6638:22d0:: with SMTP id j16mr4879118jat.166.1640017993036;
        Mon, 20 Dec 2021 08:33:13 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m6sm9753671ilh.4.2021.12.20.08.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:33:12 -0800 (PST)
Subject: Re: [PATCH] paride: fix up build warning on mips platforms
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tim@cyberelk.net
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130084626.3215987-1-gregkh@linuxfoundation.org>
 <YcCo8+jTG3b+5GTA@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4915ba81-28b1-6008-62f2-50316177fd46@kernel.dk>
Date:   Mon, 20 Dec 2021 09:33:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YcCo8+jTG3b+5GTA@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/20/21 9:01 AM, Greg Kroah-Hartman wrote:
> On Tue, Nov 30, 2021 at 09:46:26AM +0100, Greg Kroah-Hartman wrote:
>> MIPS include files define "PC" so when building the paride driver the
>> following build warning shows up:
>>
>> 	rivers/block/paride/bpck.c:32: warning: "PC" redefined
>>
>> Fix this by undefining PC before redefining it as is done for other
>> defines in this driver.
>>
>> Cc: Tim Waugh <tim@cyberelk.net>
>> Cc: Jens Axboe <axboe@kernel.dk>
>> Cc: linux-block@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  drivers/block/paride/bpck.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/paride/bpck.c b/drivers/block/paride/bpck.c
>> index f5f63ca2889d..d880a9465e9b 100644
>> --- a/drivers/block/paride/bpck.c
>> +++ b/drivers/block/paride/bpck.c
>> @@ -28,6 +28,7 @@
>>  
>>  #undef r2
>>  #undef w2
>> +#undef PC
>>  
>>  #define PC			pi->private
>>  #define r2()			(PC=(in_p(2) & 0xff))
>> -- 
>> 2.34.1
>>
> 
> Given the lack of objections to this, I'll just take it through one of
> my trees for 5.17-rc1.

Sorry about that, got lost. I can queue it  up too, or you can add my
acked-by, either is fine.

-- 
Jens Axboe

