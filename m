Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEED146F2ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 19:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243256AbhLIS0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 13:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242731AbhLIS0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 13:26:07 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD845C061A72;
        Thu,  9 Dec 2021 10:22:33 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id t26so13622738lfk.9;
        Thu, 09 Dec 2021 10:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QxWGzwiQK1H9THXhhSK1MS0BSvGH8EGX6peXdw0hns0=;
        b=O4VpfJBV9bqM4uCF3IFZ9LswiKvtA6fnK9DxckWyYKxCNIrMSW8y8rbDnYNrHlxAOK
         Mhq8P2Xb8G4zTnv5dn1HrTkdla0a6xhg+iZePUVCKUM8QNBY/gNzJJfUbsYBa/DDaCOj
         sjSuzKc9JStNjjN3nz8MOwjTt68i3YPRQZJJRcxtB/aQijcI6QInAE8kVvOOdgQgrDa3
         nnUGFST9r7CrW32JHiMNxpuMnBqeEU/a1xdep1bOBuGRAzQSUDSvbcDcCrkMTz0b1iGo
         bgoopPQ+V1L0hW/2ETX4hjay8g+fVhvKZQlnugDZfEWwYTDRMTNwik7cNu5k5OtEnsNn
         /IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QxWGzwiQK1H9THXhhSK1MS0BSvGH8EGX6peXdw0hns0=;
        b=r8dToj7jHydJ7dxB/7yvzBa5i7eeFftKAIxQXvEAlePVTF69BPL0K9/JDEO2e/FUKj
         VRCmTZi6bIR8X172G+B0rsXr/YwbmmBaGXmZjpI1aI49Firl/lmSy7MCcyDsHZtmPUHY
         w8GcaxPEanBssEcBZK/VLxS0yG6QiuDbqk++e+X8+IHCEg3/lCy+YCcvwecANxB5fJGI
         OplGKkuZUHkxz+4esRNxlA7RayBWh9/szCgH/TVgQmRtSOkRKIjGfrvdwMNvi1Na0MoT
         BghQPUpBIMhYE7IiJzZ9QxGKpKsWGDqqyMcT89Q/BMkx/xKoa0Hrd99k0APGkA4wjzDH
         pw/Q==
X-Gm-Message-State: AOAM530as0E3f00KKplGDf6/varsg/N6nN1rk2uZhJjAN4/Nrc3fm5Vm
        1qufX8JkzeyRQssl6TrMoOQ=
X-Google-Smtp-Source: ABdhPJxdnwXbD+UJp67OF+eJClo0r5F/dqDG4cmKZ1p7TKeK+wLIx2/o6A+8ucS2M3od9a+BtNKtLQ==
X-Received: by 2002:a05:6512:3f27:: with SMTP id y39mr7531588lfa.675.1639074152039;
        Thu, 09 Dec 2021 10:22:32 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.236])
        by smtp.gmail.com with ESMTPSA id n12sm58025lfq.3.2021.12.09.10.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 10:22:31 -0800 (PST)
Message-ID: <0c116de3-1e55-f888-2b4f-285484082085@gmail.com>
Date:   Thu, 9 Dec 2021 21:22:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [syzbot] INFO: task hung in r871xu_dev_remove
Content-Language: en-US
To:     syzbot <syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com>,
        Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000042e11e05d2b0b39b@google.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <00000000000042e11e05d2b0b39b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 09:27, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d598c3c46ea6 Merge 5.16-rc4 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=14cf0e55b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c6df5f09a0b9c823
> dashboard link: https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f39c1dad0b7db49ca4a8@syzkaller.appspotmail.com
> 
> INFO: task kworker/0:6:4133 blocked for more than 143 seconds.
>        Not tainted 5.16.0-rc4-syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:6     state:D stack:21848 pid: 4133 ppid:     2 flags:0x00004000
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>   <TASK>
>   context_switch kernel/sched/core.c:4972 [inline]
>   __schedule+0x931/0x2320 kernel/sched/core.c:6253
>   schedule+0xd2/0x260 kernel/sched/core.c:6326
>   schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6385
>   __mutex_lock_common kernel/locking/mutex.c:680 [inline]
>   __mutex_lock+0xa32/0x12f0 kernel/locking/mutex.c:740
>   unregister_netdev+0xe/0x20 net/core/dev.c:11138
>   r871xu_dev_remove+0x24f/0x2c0 drivers/staging/rtl8712/usb_intf.c:599

Seems like syz-executor ddosed the kernel. unregister_netdev() tries to 
lock rtnl and there are 8 mentions of rtnl_mutex in "Showing all locks 
held in the system" section.

Looks false-positive to me




With regards,
Pavel Skripkin
