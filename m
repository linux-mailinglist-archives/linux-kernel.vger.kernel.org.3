Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7E449E99B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiA0SE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiA0SE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:04:57 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB17C061714;
        Thu, 27 Jan 2022 10:04:57 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id o9-20020a9d7189000000b0059ee49b4f0fso3345678otj.2;
        Thu, 27 Jan 2022 10:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0MWgBwuFL4bMgDWBlsd5cBxotnzVd3qUph/jiLEUMGQ=;
        b=ILnNMzMhAnB3hgu70Fhpe71b+o8P3wc0j9w6QBIYz6/vrMh5/YTAjXyXXpPNP2CG5E
         jZWPhGuS4Whb392qMAnvQJOQAgR1qmtz+QFh44yz3CLZGznK9xcw1Q26rCuXdGgYNmZg
         LR+HS3gKvCEs6o56fd2GZX3WBOOMTd3lUrlMD37FtiJip1kbsSDKUu8w/2z8OyUuB+Q7
         uQHE0yyTCakS5mIX2tUqBo0I0IsQ/mDN02JJ4dItf4gDCYLHr2DNorTcbd9RDg+J1PCJ
         8YW3vwATtdMtcAfCFRgrrIAW1Gvp1aADBmzUf90mZgVCM55f32XNk9gtNUZfb6XfoTlQ
         L0bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0MWgBwuFL4bMgDWBlsd5cBxotnzVd3qUph/jiLEUMGQ=;
        b=qubINg2Yzs3VlDwppTnnckXf2MIRN5PNpQyNFZrBbQgQ/JViqfQQ1gs8dKkKtHYzo+
         pJ93uMgQVGmk2fvVRMOXUe08xEy1sPRvM4F+HLI0pR2to2ClZG+mCRL50yDswwWuCjP1
         XHBbc5aQDemQms4gTOkkWxiH56Zfe7FqVzogrAh1plXrxwaAmoN2JlQtAzhrD/FdKToh
         fAamAQ+LFY778neL4Fqb8GPQ/YxkbWqZlCOptoVuOux7n/lNInFfLJ8cbhHqHwhtcBB+
         ujwpvzoqqn4gfu6Yf662iuklcrFXB9Xv+H1nrNMmeQJTmJmB17SaP6f6fIBh86Bs0n88
         EupQ==
X-Gm-Message-State: AOAM533osfqLZzG4uJHRHp7bCXgD1gLYOY+rJDhUeg0i9gT6x4sMDshf
        58hhOe+g/ArRnevIqIhYdrQmXy/ZcEw4Fw==
X-Google-Smtp-Source: ABdhPJy3scIXFV1jSDUAg8TFF7F6zJz/+T+KpReVyS/U0lrh1YpiSp3w/1cpQezOcNasNmasDPoqzg==
X-Received: by 2002:a05:6830:1d65:: with SMTP id l5mr2737688oti.56.1643306696957;
        Thu, 27 Jan 2022 10:04:56 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q18sm2680586otf.54.2022.01.27.10.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 10:04:56 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <30d998f5-15d5-c867-3c45-49aba1fb8fbc@roeck-us.net>
Date:   Thu, 27 Jan 2022 10:04:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next V5] blk-mq: fix tag_get wait task can't be awakened
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Laibin Qiu <qiulaibin@huawei.com>
Cc:     ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        andriy.shevchenko@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220113025536.1479653-1-qiulaibin@huawei.com>
 <20220127013238.GA1478141@roeck-us.net>
 <bb1c7c15-ef4e-8c2f-4c01-758bf186e010@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <bb1c7c15-ef4e-8c2f-4c01-758bf186e010@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:28, Jens Axboe wrote:
> On 1/26/22 6:32 PM, Guenter Roeck wrote:
>> Hi,
>>
>> On Thu, Jan 13, 2022 at 10:55:36AM +0800, Laibin Qiu wrote:
>>> In case of shared tags, there might be more than one hctx which
>>> allocates from the same tags, and each hctx is limited to allocate at
>>> most:
>>>          hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
>>>
>>> tag idle detection is lazy, and may be delayed for 30sec, so there
>>> could be just one real active hctx(queue) but all others are actually
>>> idle and still accounted as active because of the lazy idle detection.
>>> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
>>> forever on this real active hctx.
>>>
>>> Fix this by recalculating wake_batch when inc or dec active_queues.
>>>
>>> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
>>> Suggested-by: Ming Lei <ming.lei@redhat.com>
>>> Suggested-by: John Garry <john.garry@huawei.com>
>>> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>
>>
>> I understand this problem has been reported already, but still:
>>
>> This patch causes a hang in several of my qemu emulations when
>> trying to boot from usb. Reverting it fixes the problem. Bisect log
>> is attached.
>>
>> Boot logs are available at
>> https://kerneltests.org/builders/qemu-arm-aspeed-master/builds/230/steps/qemubuildcommand/logs/stdio
>> but don't really show much: the affected tests simply hang until they
>> are aborted.
> 
> This one got reported a few days ago, can you check if applying:
> 
> https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=10825410b956dc1ed8c5fbc8bbedaffdadde7f20
> 
> fixes it for you?
> 
Yes, it does.

Thanks,
Guenter
