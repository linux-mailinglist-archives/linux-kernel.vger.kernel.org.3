Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93D04D6FA2
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 16:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiCLPJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 10:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiCLPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 10:09:28 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0C03E0DF;
        Sat, 12 Mar 2022 07:08:21 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 25so15906609ljv.10;
        Sat, 12 Mar 2022 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RMVbKUWJoamB63L91lhDISjUh7OaK8vRX+H8kEUqYOE=;
        b=EjkTLmpAHX67yQM2n/+sUQihO7Fulp+NNSqyOGypiVqBU/dAfqzJF3yz8HT6KR1MbM
         GbENIMt439W67jP7Ntb+BkGHnMo9kayaET6+DFIFeSGDqY0a4X6X2e64Iz21lINOcd5W
         PyShUvDMFe0NgQlxbgDEu0llHvdFFxtK+T8M5sI7KEsihHIXPMNXNY0w6KP9XFNTsEYy
         Aa9TAVhg3KWM3Fp8DkirQ2DoWkiGeKG3GRaLAtTIQvEmpoWnHrjkL5oA81tawkZFv6xY
         xoaRDfEy0TUl4dJ/cLNgCaMc38U83SJpd58Xlc6c9+agu8xlCfgUxURP1im6jmjhpcUN
         1fuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RMVbKUWJoamB63L91lhDISjUh7OaK8vRX+H8kEUqYOE=;
        b=rUXvms/8THLgUxB7rLanRTu7xlAyW4WUquRa91LuXYxb/zwxyaLOoHBIRxohm5zV++
         uGkcy2jgTqVe8cZ6SmNfx9FA7KPWL2xYz9JlA1Fz2oGIc3y3krtRXb8j7S89XJRL1Hik
         cKXRxWTQZzcw/mEoF+ORW0Gg8pJrOiIF3Ddc9uZGAdPpr2Zl/jVU4STj6hzZeRbnY26F
         QHWJTcmKTfdDucCWuWCPEErsF6wUtR7RN17cv7FeQExO8g0WKSzzbgNInnvjaCORNP2b
         ytCM6K4KJBb4/detvradC1iRZaD2YTmH8MVb63H6ZSoqNwwsNa01FDDq2VkuLXC1rQ8A
         WJng==
X-Gm-Message-State: AOAM530p1rRdqFHSwaXq/YWZuWy2xtuEPWLjX9Ye1yVTRBfhGiAD+3aT
        RD72JXtHPn21JUQhQtofN8w=
X-Google-Smtp-Source: ABdhPJzxT/GTuOUsrm+q1hjLcJeKu+0aFdKY79wyvFZTM9ptYNfnnAfkSB/maO55BFKdInm9jU8OMg==
X-Received: by 2002:a2e:871a:0:b0:246:ee2:1109 with SMTP id m26-20020a2e871a000000b002460ee21109mr8909285lji.165.1647097699713;
        Sat, 12 Mar 2022 07:08:19 -0800 (PST)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id o1-20020a2e7301000000b002461808ad8bsm2408984ljc.102.2022.03.12.07.08.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 07:08:19 -0800 (PST)
Message-ID: <d17aef8a-adbe-9d90-3173-60eb2f0828a5@gmail.com>
Date:   Sat, 12 Mar 2022 18:08:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] memory leak in usb_get_configuration
Content-Language: en-US
To:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, pavel.hofman@ivitera.com,
        rob@robgreener.com, syzkaller-bugs@googlegroups.com
References: <000000000000351b8605d9d1d1bf@google.com>
 <Yiu4tCONfHVH1Qfv@rowland.harvard.edu>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <Yiu4tCONfHVH1Qfv@rowland.harvard.edu>
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

On 3/12/22 00:01, Alan Stern wrote:
> On Wed, Mar 09, 2022 at 03:54:24PM -0800, syzbot wrote:
>> Hello,
>> 
>> syzbot found the following issue on:
>> 
>> HEAD commit:    0014404f9c18 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=15864216700000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3f0a704147ec8e32
>> dashboard link: https://syzkaller.appspot.com/bug?extid=f0fae482604e6d9a87c9
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a63dbe700000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e150a1700000
>> 
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+f0fae482604e6d9a87c9@syzkaller.appspotmail.com
>> 
>> BUG: memory leak
>> unreferenced object 0xffff88810c0289e0 (size 32):
>>   comm "kworker/1:2", pid 139, jiffies 4294947862 (age 15.910s)
>>   hex dump (first 32 bytes):
>>     09 02 12 00 01 00 00 00 00 09 04 00 00 00 d0 bb  ................
>>     3a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  :...............
>>   backtrace:
>>     [<ffffffff82c98127>] kmalloc include/linux/slab.h:586 [inline]
>>     [<ffffffff82c98127>] usb_get_configuration+0x1c7/0x1cd0 drivers/usb/core/config.c:919
>>     [<ffffffff82c863f9>] usb_enumerate_device drivers/usb/core/hub.c:2398 [inline]
>>     [<ffffffff82c863f9>] usb_new_device+0x1a9/0x2e0 drivers/usb/core/hub.c:2536
>>     [<ffffffff82c88ea4>] hub_port_connect drivers/usb/core/hub.c:5358 [inline]
>>     [<ffffffff82c88ea4>] hub_port_connect_change drivers/usb/core/hub.c:5502 [inline]
>>     [<ffffffff82c88ea4>] port_event drivers/usb/core/hub.c:5660 [inline]
>>     [<ffffffff82c88ea4>] hub_event+0x1364/0x21a0 drivers/usb/core/hub.c:5742
>>     [<ffffffff8126a41f>] process_one_work+0x2bf/0x600 kernel/workqueue.c:2307
>>     [<ffffffff8126ad49>] worker_thread+0x59/0x5b0 kernel/workqueue.c:2454
>>     [<ffffffff81274705>] kthread+0x125/0x160 kernel/kthread.c:377
>>     [<ffffffff810021ef>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> 
> The console log shows that this is connected to gspca_dev_probe.  Let's
> see who's calling it...
> 

The execution path is more complicated. I've done some debugging, but no 
luck with root case... Just want to share what I found and maybe it will 
help.

Firsly syzbot connects carl9170 device (usb ids from the log). 
carl9170_usb_probe() calls usb_reset_device() which fails with -19. If I 
remove this usb_reset_device() call then issue is no more reproducible.

Then 2 other probes are called: usbtest and spca501. spca501 calls 
gspca_dev_probe(), but it fails early and I do not suspect this driver.
usbtest probe function also looks correct, so I do not suspect this 
driver as well.

Looks like the issue either in usb_reset_device() call or somewhere in 
usb internals




With regards,
Pavel Skripkin
