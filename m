Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE68B478542
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 07:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhLQGoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 01:44:12 -0500
Received: from mail-lf1-f46.google.com ([209.85.167.46]:41738 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhLQGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 01:44:11 -0500
Received: by mail-lf1-f46.google.com with SMTP id cf39so2586390lfb.8;
        Thu, 16 Dec 2021 22:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=fJUE8k2+qpHDPc4B6+jQ9Hnyt7WdEWRQUyO5Bymsaf8=;
        b=BG9v8GAgJgPqIe7DO2hOxzFn4s3QpQ1scgvLR6O/beHMQqTlYmUB/GMladROnt2zjf
         Rh8AYTYVkoPnQt9hZWrC+d5MXMBOPzfibOkRCAeGM1//wpO6g+nNXsWpbWDR7ENVLi5g
         76rZ40a4P+i68DnLxOqKLmcE35kg1ZKnhLljikvmlHIbUzr0/NaU/QTeRWvMChsakbwO
         l5OPIgHu8pS7UudU2meBWNodILN+L6pHoZndwQiwWwJSr4gmD9OB1zBYrrNoQoIMd+0W
         /2//70pUdkHANfi2b/gCS1Q1AaCMyvelaYtniMaPvwM+JwtJyYqPnZ1Pl+RF77n2QUrO
         KHSA==
X-Gm-Message-State: AOAM5326LT4CFo0YBQMVeD+pBk5oraO34IGgivtkqbiuA55TSwWoQrbs
        IiXIkOYMZBhkANfROZbOTZo=
X-Google-Smtp-Source: ABdhPJxHrH2xosVVOFH0R8QnnEyKiwxocG5OBOcL66n2+ouZn2N5TUdBTPH6I/4v9bKWYqd2OqzTBA==
X-Received: by 2002:ac2:4857:: with SMTP id 23mr384894lfy.217.1639723449744;
        Thu, 16 Dec 2021 22:44:09 -0800 (PST)
Received: from [10.68.32.65] (broadband-109-173-81-86.ip.moscow.rt.ru. [109.173.81.86])
        by smtp.gmail.com with ESMTPSA id b28sm130017lff.305.2021.12.16.22.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 22:44:09 -0800 (PST)
Message-ID: <aac18497-f420-a04a-16ab-c3e2149904b5@linux.com>
Date:   Fri, 17 Dec 2021 09:44:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     "Dae R. Jeong" <threeearcat@gmail.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     yjkwon@kaist.ac.kr
References: <YbbKf6fU7y3GGZum@archdragon>
From:   Denis Efremov <efremov@linux.com>
Subject: Re: WARNING in schedule_bh
In-Reply-To: <YbbKf6fU7y3GGZum@archdragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> So, for me, concurrent execution of floppy_shutdown() and
> fd_locked_ioctl() is suspicious. Could you please check the above
> scenario is reasonable?
> 

Thank you for the analysis. You are right and concurrent execution
of floppy_shutdown() and fd_locked_ioctl() looks suspicious. I know about
this warning more than 2 years already since I wrote syzkaller descriptions
for the floppy. I can only wonder why did it take so long for the syzbot
to find it.
However, this bug is not reproducible on real hardware. I would prefer not
to touch the code significantly unless there is a security reason for it.
The pros here are that bugs should be fixed. The cons here are that changing
the code more-or-less significantly is hard to test on real hardware
(there was a regression in UAPI of floppy not so long ago, it took almost
half of a year before it was reported and it took another couple of months
before distros released kernels with a fix); floppy driver contains
undocumented/poorly-documented hacks (e.g. O_ACCMODE
https://github.com/google/syzkaller/commit/3ea5a3451b2bfa90a3b73397273560f17d587efc#diff-07b38a9cc5b8b1eed725414265f033c41abffbbe537567799ed678dfe9c49d7a);
/dev/fd0 is accessible only by root/disk user on most of the distros nowadays;
races are highly likely not reproducible on real hardware because floppy
devices are slow; from the functional point of view the driver worked with
this bug almost 10 years (maybe more) and I doubt it's possible to
face this bug during normal workflow (without direct intention to trigger it);
I think that usage of floppies inside VMs is limited to some specific
workflows and I doubt it's really broad.
If you see an easy way to fix this issue, please send a patch.

Thanks,
Denis
