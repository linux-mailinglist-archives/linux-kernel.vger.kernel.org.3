Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A553C04A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239400AbiFBVJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiFBVJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:09:21 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96203584B;
        Thu,  2 Jun 2022 14:09:18 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aede9.dynamic.kabel-deutschland.de [95.90.237.233])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E9B1461EA1923;
        Thu,  2 Jun 2022 23:09:15 +0200 (CEST)
Message-ID: <1880b7a7-2353-c381-5afb-1d4224eb223b@molgen.mpg.de>
Date:   Thu, 2 Jun 2022 23:09:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: Non-working serial console
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <d8e9f4fe-e8dc-67aa-e240-f2f5f1dfca2f@molgen.mpg.de>
In-Reply-To: <d8e9f4fe-e8dc-67aa-e240-f2f5f1dfca2f@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 02.06.22 um 18:50 schrieb Paul Menzel:

> Since a while I noticed, output to the serial console with 
> `console=ttyS0,115200n8` does not work with the attached configuration 
> `defconfig-non-working-serial.txt` created by `make savedefconfig`. 
> Only, when with `earlyprintk=ttyS0,115200,keep` the serial console 
> starts working. I am able to reproduce it in QEMU. It’s reproducible 
> with Linus’ latest master branch.
> 
>      $ git log --oneline --no-decorate -1
>      8ab2afa23bd19 Merge tag 'for-5.19/fbdev-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev
>      $ qemu-system-x86_64 --version
>      QEMU emulator version 5.1.0
>      Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
>      $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
> 
> With `earlyprintk=` it works:
> 
>      $ qemu-system-x86_64 -kernel arch/x86/boot/bzImage -append "earlyprintk=serial console=ttyS0,115200n8" -serial file:/dev/shm/kernel.txt -curses
> 
> Strangely, I found a different configuration, where it works, but I 
> didn’t see what configuration option makes the difference.
> 
> Can you reproduce the problem with `defconfig-no-working-serial.txt`?

It turns out, the non-working configuration build the serial 8250 driver 
as a module (`CONFIG_SERIAL_8250=m`) instead of building it into the 
Linux kernel. Building it into the Linux kernel and using 
`CONFIG_SERIAL_8250_CONSOLE=y` fixes my issue.

```
$ diff -u .config.old .config
--- .config.old 2022-05-31 18:40:31.329017225 +0200
+++ .config     2022-06-02 22:53:06.317175267 +0200
@@ -1814,6 +1814,7 @@

  CONFIG_UEFI_CPER=y
  CONFIG_UEFI_CPER_X86=y
+CONFIG_EFI_EARLYCON=y
  CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y
  # CONFIG_EFI_DISABLE_RUNTIME is not set
  # CONFIG_EFI_COCO_SECRET is not set
@@ -2554,11 +2555,13 @@
  #
  # Serial drivers
  #
-CONFIG_SERIAL_8250=m
+CONFIG_SERIAL_EARLYCON=y
+CONFIG_SERIAL_8250=y
  # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
  CONFIG_SERIAL_8250_PNP=y
  # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
  # CONFIG_SERIAL_8250_FINTEK is not set
+CONFIG_SERIAL_8250_CONSOLE=y
  CONFIG_SERIAL_8250_DMA=y
  # CONFIG_SERIAL_8250_PCI is not set
  CONFIG_SERIAL_8250_NR_UARTS=32
@@ -2575,7 +2578,8 @@
  #
  # CONFIG_SERIAL_KGDB_NMI is not set
  # CONFIG_SERIAL_UARTLITE is not set
-CONFIG_SERIAL_CORE=m
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
  CONFIG_CONSOLE_POLL=y
  # CONFIG_SERIAL_JSM is not set
  # CONFIG_SERIAL_LANTIQ is not set
@@ -2590,7 +2594,7 @@
  # CONFIG_SERIAL_SPRD is not set
   # end of Serial drivers

-CONFIG_SERIAL_MCTRL_GPIO=m
+CONFIG_SERIAL_MCTRL_GPIO=y
  # CONFIG_SERIAL_NONSTANDARD is not set
  # CONFIG_N_GSM is not set
  # CONFIG_NOZOMI is not set
```

The question is, if `earlyprintk=ttyS0,115200(,keep)` worked before with 
`CONFIG_SERIAL_8250=m`, why the driver is needed, and `console=ttyS0,…` 
cannot fall back to the earlyprintk driver.


Kind regards,

Paul
