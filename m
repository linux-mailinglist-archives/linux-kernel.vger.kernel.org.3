Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B914A3067
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 16:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbiA2P7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 10:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234453AbiA2P7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 10:59:51 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8588C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 07:59:50 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id jx6so27280318ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 07:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/CCF6n5t6qZ4a8TgvZ42oKHzBzgD3sxO5w4zNCjoMWs=;
        b=4+pqffPPt3gGk2+c9MU5yKTSNtqE1Z9V8JdvLf4aJDkdKkBBltImrAv/aHQD4hQ/Tg
         A8uwOeiZY1GxYLqmpx+OOsTl9IIovWvz5m40xhkVXNVaVplI9wJX6FqUlCD1BsBu+fr1
         SJ4NotCkbgZ9duGUzXqktu2IaPH2gp80OG9NHoesziFNebpMM8+BCVDZiogApBs4gcII
         HvlClyC9SfuLbDLLHsOpnM1YZJiVyX7jfxz5OluxllKtBSJRTshdM4FrZsFsbTFY2pi6
         HzgH/aaNYf2FizsCJks3vnoE61Wa6qR0L/yWS2r4tCkZuSBaKh0V9Xi7zw2S7JS5GTnA
         c6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/CCF6n5t6qZ4a8TgvZ42oKHzBzgD3sxO5w4zNCjoMWs=;
        b=TQTGx2TYvbU/nuvFwnAL1ky1Ufxfn2B+GLbaK3gPmSFibSnq3Cud5flJ6tsWoFvkr+
         VGLJCLkbeuVwtcDvcTrCErT3usNRt+6GkvGHqbPHLb026ryuCog0IASxVOs8AkJCkyTf
         8il/c221MrKyF5zY69XGi6r8ozhVbj84026W1LDBZ3pkiZVV6Z3gG0t8iCpOUtoraiOG
         RcDPWKRhnp2ZqecIiFhs55MNO4jpEpxz7HQ8f0ibs04DcvhNhCjKkUuBcrq1GxJRbi/6
         gr/h3soxUh/dKKanAU05Rnogo4sbas/he/O1YlEuzZ6JLrO+a2jGDxOMLP1l4o7pdBrg
         cdZA==
X-Gm-Message-State: AOAM532QSpPfMqWQPa30SrbeLAZYlcSXOoqRMdIYUFfHqa7BEeWCQlPJ
        //Vnhy2VsS44xpN4wma0Ve5L/Zo8tk0QEQ==
X-Google-Smtp-Source: ABdhPJyd3Az/46wy46//rY9N6F7qdXp17NZuUAsWYnYihQBEuf9IKFiaBR/bMBlwiJ9DJWr25PMzSg==
X-Received: by 2002:a17:907:3e20:: with SMTP id hp32mr10987004ejc.683.1643471989117;
        Sat, 29 Jan 2022 07:59:49 -0800 (PST)
Received: from ?IPV6:2003:d9:973c:5900:979:8d65:1f5e:4b79? (p200300d9973c590009798d651f5e4b79.dip0.t-ipconnect.de. [2003:d9:973c:5900:979:8d65:1f5e:4b79])
        by smtp.googlemail.com with ESMTPSA id k24sm9739361ejv.179.2022.01.29.07.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 07:59:48 -0800 (PST)
Message-ID: <56982041-c7ac-fc68-f5df-12a11d351ed6@colorfullife.com>
Date:   Sat, 29 Jan 2022 16:59:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] To fix the below failure of handling page fault caused by
 the invalid input from user.
Content-Language: en-US
To:     Dongyang Wang <dongyang.wang@windriver.com>
Cc:     akpm@linux-foundation.org, christian.brauner@ubuntu.com,
        dave@stgolabs.net, ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, varad.gautam@suse.com
References: <7de781c8-f71f-35e2-a335-f9b13de691db@colorfullife.com>
 <20220129150258.5896-1-dongyang.wang@windriver.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220129150258.5896-1-dongyang.wang@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dongyang,

On 1/29/22 16:02, Dongyang Wang wrote:
> Hi Manfred and Andrew,
>
> Thanks for your feedback.
>
>> Hi Dongyang,
>>
>> On 1/26/22 03:42, Andrew Morton wrote:
>>> On Tue, 18 Jan 2022 17:19:52 +0800 Dongyang Wang <dongyang.wang@windriver.com> wrote:
>>>
>>>> [786058.308965] Unable to handle kernel paging request at virtual address 01000004
>>>> [786058.316286] pgd = 38a99693
>>>> [786058.319080] [01000004] *pgd=07800003, *pmd=00000000
>>>> [786058.324056] Internal error: Oops: 206 [#1] PREEMPT SMP ARM
>>>> [786058.324100] CPU:  PID: Comm:  Tainted: G         C
>>>> [786058.324102] Hardware name:
>>>> [786058.324114] PC is at __copy_to_user_std+0x4c/0x3c4
>>>> [786058.324120] LR is at store_msg+0xc0/0xe8
>>>> [786058.324124] pc : [<c0c0587c>]    lr : [<c0871d04>]    psr: 20010013
>>>> [786058.324126] sp : c3503ec4  ip : 00000000  fp : b4c9a660
>>>> [786058.324129] r10: c4228dc0  r9 : c3502000  r8 : 00000ffc
>>>> [786058.324132] r7 : 01000000  r6 : 546d3f8b  r5 : b4911690  r4 : 00000ffc
>>>> [786058.324134] r3 : 00000000  r2 : 00000f7c  r1 : 01000004  r0 : b4911690
>>>> [786058.324139] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>> [786058.324142] Control: 30c5387d  Table: 0edc2040  DAC: 55555555
>>>> [786058.324145] Process  (pid: , stack limit = 0x25018bdf)
>> Why is process and pid: empty? Is this some kind of kernel process calling?
> The pid is 8369, it's a userspace app.
>
>>>> [786058.324148] Stack: (0xc3503ec4 to 0xc3504000)
>>>> [786058.324153] 3ec0:          b4911690 546d3f8b 01000000 00000ffc b4911690 00000ffc 00000000
>>>> [786058.324157] 3ee0: 00000ffc c0871d04 546d4f73 c3407801 c3503f28 c3407800 00000000 b49106a8
>>>> [786058.324161] 3f00: c4228dc0 c087abd4 00000002 b49106a8 617b9d03 00000000 00000000 c121d508
>>>> [786058.324165] 3f20: 00000000 bf06a1a8 d1b634cc 16b26e77 c5af5280 00000100 00000200 db806540
>>>> [786058.324170] 3f40: 00000001 c121d508 00000008 0000005c 00000000 00010008 b49106a8 c0601208
>>>> [786058.324173] 3f60: c3502000 00000040 b4c9a660 c087b474 c3503f78 c121d508 617b9d03 00000000
>>>> [786058.324177] 3f80: 2303d6cc 00000115 c0601208 c121d508 b4c9a660 b4c9a660 00000001 b49106a8
>>>> [786058.324181] 3fa0: 00000115 c06011dc b4c9a660 00000001 0000005c b49106a8 00010008 00000000
>>>> [786058.324185] 3fc0: b4c9a660 00000001 b49106a8 00000115 00000000 b4c9b400 00000000 b4c9a660
>>>> [786058.324189] 3fe0: 00000115 b4c9a650 b6b253bd b6b254b6 800d0030 0000005c 00000000 00000000
>>>> [786058.324201] [<c0c0587c>] (__copy_to_user_std) from [<c0871d04>] (store_msg+0xc0/0xe8)

I would search here: __copy_to_user_std should fail if the address is 
invalid.

For whatever reasons, it produces a page fault.

First: Is this reproducible? Does it fail immediately if you pass an 
invalid value to mq_timedreceive()?

https://elixir.bootlin.com/linux/v4.18.20/source/arch/arm/include/asm/uaccess.h#L464

It seems ARM has special optimizations (CONFIG_UACCESS_WITH_MEMCPY), and 
I cannot see if this is MMU or NO_MMU


> The kernel version is 4.18.

Ok.


--

     Manfred

