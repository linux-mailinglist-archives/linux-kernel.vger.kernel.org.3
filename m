Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240934D6FCC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiCLPqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiCLPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:46:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3FC66F97;
        Sat, 12 Mar 2022 07:45:14 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 3so19986553lfr.7;
        Sat, 12 Mar 2022 07:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VgGyPfPdGRxd5Rzakhi62CpS269x49H3AFDCeA+0hJw=;
        b=cIg9fEyLEUBg2/a8aJVzVjfGZayofPlgJHXcooB1nFx/WNBHOkQlE3Kff6o74kfMf5
         VOHcvCmZFgcYwEgWhpe8apGwa23ElwYNa2jMeMsZNh66yCg8WKQ+c8UcCHWkPUclsczf
         F7u80KrklMRPDpmcHcN0dzEgvewLCtEDuksMKQQP55pvMzsC/PDN0j7EF2ctXyx0EUeS
         CsySp/mL/IO6n3w6CnyNg8IW7QwsPJRBmyS7j4/OoJybmJNX+0Lzi36bATE2qRoC5Poo
         lnQ//k86iWWa9hzOE49VXCkL2pGlHCcCyapFz9ycg/kkg5adDjBqAgMRy3VUoKbIO97L
         qApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VgGyPfPdGRxd5Rzakhi62CpS269x49H3AFDCeA+0hJw=;
        b=3OWIaWP431H9cvAGqSahVHcE8tmrIu3oX4XlVriEV93q4IB1nMGiEMjo0jNyyIcjYB
         4zDY2X9b6nGY8NiHzSCoH9GU0BAs3N2Is8G6hcr8tFs5dar57wRlltThdSLHphRf2I4m
         X/l4ykv5z3tFcfPHf1YBflilJzLDcwa+od2a6dceLIGQOIPugVqHV80KcmB10BRLgGhr
         lnKK2kdPhn2KT6UF6gaAAuftkZaC4pex7YpXjiL9jBqgPxXsHGrv0yt/u4RFvBHRviu6
         WTMrSdC9R8pKEzk5EpCM5V3HwqxN8fRUuYnCG+Naf210ZjQsEfX9j/ZZKB4KKxtuhzMd
         QZWA==
X-Gm-Message-State: AOAM530O4+YLWEIQjmUjKJ3kGVOqGmRmaDNfFS+u1yADlwSPtZVboq3C
        J1zUzstuLsBkFzOhH1UhaJs=
X-Google-Smtp-Source: ABdhPJwNY0kgkAlFa32W2JnuP67YyNbMiIRJMpxTEG9ZY8fttwEp3IU2uml+nCXnLehzZYe3pp4ueQ==
X-Received: by 2002:a05:6512:108a:b0:448:6519:3bc1 with SMTP id j10-20020a056512108a00b0044865193bc1mr7765695lfg.679.1647099910566;
        Sat, 12 Mar 2022 07:45:10 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id i20-20020a056512225400b004487ec11344sm584470lfu.122.2022.03.12.07.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 07:45:10 -0800 (PST)
Message-ID: <d82e80ed-566d-9516-2cc2-60278b56ea8d@gmail.com>
Date:   Sat, 12 Mar 2022 18:45:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] memory leak in usb_get_configuration
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, syzkaller-bugs@googlegroups.com
References: <000000000000351b8605d9d1d1bf@google.com>
 <Yiu4tCONfHVH1Qfv@rowland.harvard.edu>
 <d17aef8a-adbe-9d90-3173-60eb2f0828a5@gmail.com>
 <Yiy7gEfSPZlfLHSY@rowland.harvard.edu>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Yiy7gEfSPZlfLHSY@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 3/12/22 18:25, Alan Stern wrote:
> On Sat, Mar 12, 2022 at 06:08:18PM +0300, Pavel Skripkin wrote:
>> Hi Alan,
>> 
>> On 3/12/22 00:01, Alan Stern wrote:
>> > On Wed, Mar 09, 2022 at 03:54:24PM -0800, syzbot wrote:
>> > > Hello,
>> > > 
>> > > syzbot found the following issue on:
>> > > 
>> > > HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
>> > > git tree:       upstream
>> > > console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
>> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
>> > > dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
>> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
>> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
>> > > 
>> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > > Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
>> > > 
>> > > BUG: memory leak
>> > > unreferenced object 0xffff88810c0289e0 (size 32):
>> > >   comm "kworker/1:2", pid 139, jiffies 4294947862 (age 15.910s)
>> > >   hex dump (first 32 bytes):
>> > >     09 02 12 00 01 00 00 00 00 09 04 00 00 00 d0 bb  ................
>> > >     3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  :...............
>> > >   backtrace:
>> > >     [<ffffffff82c98127>] kmalloc include/linux/slab.h:586 [inline]
>> > >     [<ffffffff82c98127>] usb_get_configuration+0x1c7/0x1cd0 drivers/usb/core/config.c:919
>> > >     [<ffffffff82c863f9>] usb_enumerate_device drivers/usb/core/hub.c:2398 [inline]
>> > >     [<ffffffff82c863f9>] usb_new_device+0x1a9/0x2e0 drivers/usb/core/hub.c:2536
>> > >     [<ffffffff82c88ea4>] hub_port_connect drivers/usb/core/hub.c:5358 [inline]
>> > >     [<ffffffff82c88ea4>] hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
>> > >     [<ffffffff82c88ea4>] port_event drivers/usb/core/hub.c:5660 [inline]
>> > >     [<ffffffff82c88ea4>] hub_event+0x1364/0x21a0 drivers/usb/core/hub.c:5742
>> > >     [<ffffffff8126a41f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>> > >     [<ffffffff8126ad49>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
>> > >     [<ffffffff81274705>] kthread+0x125/0x160 kernel/kthread.c:377
>> > >     [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>> > 
>> > The console log shows that this is connected to gspca_dev_probe.  Let's
>> > see who's calling it...
>> > 
>> 
>> The execution path is more complicated. I've done some debugging, but no
>> luck with root case... Just want to share what I found and maybe it will
>> help.
>> 
>> Firsly syzbot connects carl9170 device (usb ids from the log).
>> carl9170_usb_probe() calls usb_reset_device() which fails with -19. If I
>> remove this usb_reset_device() call then issue is no more reproducible.
>> 
>> Then 2 other probes are called: usbtest and spca501. spca501 calls
>> gspca_dev_probe(), but it fails early and I do not suspect this driver.
>> usbtest probe function also looks correct, so I do not suspect this driver
>> as well.
>> 
>> Looks like the issue either in usb_reset_device() call or somewhere in usb
>> internals
> 
> Okay, thanks for the information.
> 
> Is there any reason for carl9170_usb_probe to do a reset?  I can't
> imagine why that would be needed.  Maybe the simplest solution is just
> to remove the reset.
> 

Can't say. The code was added 12 years ago

> Unfortunately, that won't tell us where the extra reference is coming
> from.  Here's one thing you could do if you want to continue your
> debugging: At the start of the probe routines for carl9170, usbtest, and
> spca501, add code to print in the kernel log the reference count value
> for the usb_device and usb_interface.  Maybe you'll be able to see where
> the refcount goes up.
> 

Unfortunately refcount for dev and inf stays the same at the beginning 
of each probe function:

6 for dev
3 for inf


With regards,
Pavel Skripkin
