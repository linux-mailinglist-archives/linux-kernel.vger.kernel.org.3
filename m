Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9374B6742
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiBOJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:16:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBOJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:16:56 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60BCB7F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:16:44 -0800 (PST)
Received: from [192.168.0.2] (ip5f5aee0e.dynamic.kabel-deutschland.de [95.90.238.14])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id D1C3261EA1928;
        Tue, 15 Feb 2022 10:16:41 +0100 (CET)
Message-ID: <5b3d6ad6-a506-7dae-0eb7-b7da080f6454@molgen.mpg.de>
Date:   Tue, 15 Feb 2022 10:16:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: BUG: KCSAN: data-race in add_device_randomness+0x20d/0x290
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
References: <e10b79cf-d6d5-ffcc-bce4-edd92b7cb6b9@molgen.mpg.de>
 <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHmME9pktmNpcBS_DJhJ5Z+6xO9P1wroQ9_gwx8KZMBxk1FBeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jason,


Thank you for your quick response, and sorry for the late reply.

Am 07.02.22 um 19:42 schrieb Jason A. Donenfeld:

> Thanks for the report. I assume that this is actually an old bug. Do
> you have a vmlinux or a random.o from this kernel you could send me to
> double check?

I had unfortunately already overwritten these files. I was unable to 
fully reproduce the same trace with a build from the same commit, and 
only got:

```
[…]
[   12.819273] BUG: KCSAN: data-race in _mix_pool_bytes+0x5d/0x1c0

[   12.822917] race at unknown origin, with read to 0xffffa21c07003009 
of 1 bytes by task 1035 on cpu 0:
[   12.823580]  _mix_pool_bytes+0x5d/0x1c0
[   12.823678]  add_device_randomness+0x97/0x290
[   12.823691]  release_task+0x231/0xb20
[   12.823735]  wait_consider_task+0x883/0x17d0
[   12.823755]  do_wait+0x35f/0x4d0
[   12.823768]  kernel_wait4+0xdb/0x180
[   12.823778]  __do_sys_wait4+0x85/0x90
[   12.823787]  __x64_sys_wait4+0x49/0x50
[   12.823797]  do_syscall_64+0x39/0x80
[   12.823819]  entry_SYSCALL_64_after_hwframe+0x44/0xae

[   12.824028] value changed: 0x56 -> 0xc1

[   12.824415] Reported by Kernel Concurrency Sanitizer on:
[   12.824688] CPU: 0 PID: 1035 Comm: postfix-script Not tainted 
5.17.0-rc2-00352-g90c9e950c0de #40
[   12.824705] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.15.0-1 04/01/2014
[…]
```

So instead of the former (used as subject line)

     add_device_randomness+0x20d/0x290

there is

     add_device_randomness+0x97/0x290

I uploaded `random.o` [1].


Kind regards,

Paul


[1]: https://owww.molgen.mpg.de/~pmenzel/random.o
