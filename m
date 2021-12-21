Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918DC47C2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbhLUPZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239302AbhLUPZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:25:07 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DC1C061401
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:25:07 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q5so1580850ioj.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1nswmIXvkrgdGsozU3iZx920lgYKsqE2KdHTmx1sEkY=;
        b=tlEICRYnaczk+jXexMQbyT6UB86cUJhvbNq6yjDPnzv8/uG1ta2zkMxPBmL5I6ildh
         /t8JmErPIszZfzjnxhOgktmM9nnSaLgUbHk5KmKEdQkc6KDfLBma4yBZpNwt0Hfvhtvc
         smp2HPUxWngwO/s5rMo5kWXNMBcQCqWkZa2z6vH3VtdCrZbB17YdeZxrQdf9cdcLNSQ+
         P+cQBs7uCSzQHKNNT3nwFl01CEN4Qlm6cq/rYnZ1Vprhd0daXmj0huImLelXjBVKE3Bj
         1wBFKAE51b/Hpu5+LUs6vFASW3WJwgvhq3naazQLVNTQd9vFC2su+MiDs4SnOL+uZBpH
         m6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1nswmIXvkrgdGsozU3iZx920lgYKsqE2KdHTmx1sEkY=;
        b=2asRjv0hDW8I/cesyQ/bgdKrwjUBhe3ig4FKGhnud4hMn6U9r8KgW0iCxUGknugtk2
         bgokeOp9voyrug0/ARrS6qLNfTQUfvRcl6hW8rIoeUcCmwaGjzx5EazAJWA5q71tgCCu
         ywLMDWNMU4vqgK6Te5aOykLLT2MQF+tkeavV5fiW9as92GqdvYVbRbemala9vnGFovCQ
         h4jBexfJ2W7UTiCQsBkcjHy1P36QBmc4tyfK0DEFAW8t2IMdA4PFSvIW5L5xEg6cTe+Y
         l7/V8JuzyZ9NyVK+xSrOJF5p0pNKmo92o92Qxcscl1jvgIl5vgQiWrYQs5ysDJPG4h1u
         nReQ==
X-Gm-Message-State: AOAM531TKRYcr4zt+XgZgQGLHdYzdrS7hYAckaYAa1NPfVt7ejAqZHy9
        D9PcnTTqkaB8OWKoV8kQXn9vow==
X-Google-Smtp-Source: ABdhPJxK104GzhXJnT+gHzCxZmWtbC6T7ciYqYcYMTLp6Mxau8YEuA532kQe83FSc/UZ+crXL0wcPg==
X-Received: by 2002:a05:6638:4129:: with SMTP id ay41mr2154729jab.23.1640100306190;
        Tue, 21 Dec 2021 07:25:06 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c22sm10425970ioz.15.2021.12.21.07.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 07:25:05 -0800 (PST)
Subject: Re: [syzbot] general protection fault in set_task_ioprio
To:     Eric Dumazet <edumazet@google.com>,
        syzbot <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     changbin.du@intel.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yajun Deng <yajun.deng@linux.dev>
References: <000000000000c70eef05d39f42a5@google.com>
 <00000000000066073805d3a4f598@google.com>
 <CANn89i++5O_4_j3KO0wAiJHkEj=1zAeAHv=s9Lub_B6=cguwXQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e3a30c8c-3f1a-47b5-57e7-1b456bbc8719@kernel.dk>
Date:   Tue, 21 Dec 2021 08:25:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CANn89i++5O_4_j3KO0wAiJHkEj=1zAeAHv=s9Lub_B6=cguwXQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/21/21 3:44 AM, Eric Dumazet wrote:
> On Tue, Dec 21, 2021 at 1:52 AM syzbot
> <syzbot+8836466a79f4175961b0@syzkaller.appspotmail.com> wrote:
>>
>> syzbot has bisected this issue to:
>>
>> commit e4b8954074f6d0db01c8c97d338a67f9389c042f
>> Author: Eric Dumazet <edumazet@google.com>
>> Date:   Tue Dec 7 01:30:37 2021 +0000
>>
>>     netlink: add net device refcount tracker to struct ethnl_req_info
>>
> 
> Unfortunately this commit will be in the way of many bisections.
> 
> Real bug was added in
> 
> commit 5fc11eebb4a98df5324a4de369bb5ab7f0007ff7
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Dec 9 07:31:29 2021 +0100
> 
>     block: open code create_task_io_context in set_task_ioprio
> 
>     The flow in set_task_ioprio can be simplified by simply open coding
>     create_task_io_context, which removes a refcount roundtrip on the I/O
>     context.
> 
>     Signed-off-by: Christoph Hellwig <hch@lst.de>
>     Reviewed-by: Jan Kara <jack@suse.cz>
>     Link: https://lore.kernel.org/r/20211209063131.18537-10-hch@lst.de
>     Signed-off-by: Jens Axboe <axboe@kernel.dk>

There are only really 5 patches in between the broken commit and the one
that fixes it, and it only affects things trying to set the ioprio with
a dead task. Is this a huge issue? I don't see why this would cause a
lot of bisection headaches.

-- 
Jens Axboe

