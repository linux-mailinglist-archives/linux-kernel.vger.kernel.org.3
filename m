Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9453F53D63A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 11:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbiFDJVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 05:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiFDJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 05:21:18 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C236377EB;
        Sat,  4 Jun 2022 02:21:16 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aeb34.dynamic.kabel-deutschland.de [95.90.235.52])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4BA5961EA1938;
        Sat,  4 Jun 2022 11:21:13 +0200 (CEST)
Message-ID: <477007d7-e573-56dd-90de-877eeebd5c4c@molgen.mpg.de>
Date:   Sat, 4 Jun 2022 11:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Non-working serial console
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <d8e9f4fe-e8dc-67aa-e240-f2f5f1dfca2f@molgen.mpg.de>
 <1880b7a7-2353-c381-5afb-1d4224eb223b@molgen.mpg.de>
 <YpsgHpRfz0JQcm9D@kroah.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <YpsgHpRfz0JQcm9D@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,


Am 04.06.22 um 11:04 schrieb Greg KH:
> On Thu, Jun 02, 2022 at 11:09:15PM +0200, Paul Menzel wrote:

>> Am 02.06.22 um 18:50 schrieb Paul Menzel:
>>
>>> Since a while I noticed, output to the serial console with
>>> `console=ttyS0,115200n8` does not work with the attached configuration
>>> `defconfig-non-working-serial.txt` created by `make savedefconfig`.
>>> Only, when with `earlyprintk=ttyS0,115200,keep` the serial console
>>> starts working. I am able to reproduce it in QEMU. It’s reproducible
>>> with Linus’ latest master branch.
>>>
>>>       $ git log --oneline --no-decorate -1
>>>       8ab2afa23bd19 Merge tag 'for-5.19/fbdev-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>>>       $ qemu-system-x86_64 --version
>>>       QEMU emulator version 5.1.0
>>>       Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
>>>       $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
>>>
>>> With `earlyprintk=` it works:
>>>
>>>       $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "earlyprintk=serial console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
>>>
>>> Strangely, I found a different configuration, where it works, but I
>>> didn’t see what configuration option makes the difference.
>>>
>>> Can you reproduce the problem with `defconfig-no-working-serial.txt`?
>>
>> It turns out, the non-working configuration build the serial 8250 driver as
>> a module (`CONFIG_SERIAL_8250=m`) instead of building it into the Linux
>> kernel. Building it into the Linux kernel and using
>> `CONFIG_SERIAL_8250_CONSOLE=y` fixes my issue.
> 
> That makes sense, you need the console to be able to properly send data
> out to it :)

Indeed.

I am still confused, that `earlyprintk=ttyS0,115200,keep` works though 
despite `CONFIG_SERIAL_8250=m`. Doesn’t that mean, that Linux 
nevertheless contains some code to initialize the serial console, and 
send data to it?

> Was this a Kconfig change somewhere recently that we messed up the
> defaults for?  Any chance you can use 'git bisect' to track down the
> offending change?

No, I guess I made the change several months back to make the Linux 
kernel image smaller to decrease the boot time. (I have to do 
measurements again.)


Kind regards,

Paul
