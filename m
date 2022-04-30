Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E040515C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiD3K25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbiD3K2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:28:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22C728E33
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:25:32 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id z8so10963026oix.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JT7iSzfJOXFUFWA+0JqQ/p1JuFeO6Flqe5Fq8PeVi7U=;
        b=O0Q2GAnkwLr8ErbjEVjhjVg89V7e3PXrJQtpLkgXmMlbshoCoZ+W3AxJ3nzX02y658
         wzuOtpjVyfTCXFctCdUCxkzEDo6Ffa+m+UG1UNo4eokysNdk7JYC9JYzbvNQH+0kQkoN
         Y2AaLel0AgGTFCXRcxKTe+cp9be0IUztkl0tqoRnHBwIwXKNeNHTj4QM2Y+nh+X9bkaj
         aIYcu68FcswvcIyVEvrRJNdT9mPaV2zymrU38nR8xpzc6lmQRYzq7duhMGAW3QgpHCrU
         YOj+63BUsqJrbXkMQ+MesYdWul9SYktBON8J2eDvz8P1Yc5XZB46xi5+BPsX8qoz4lhp
         R8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JT7iSzfJOXFUFWA+0JqQ/p1JuFeO6Flqe5Fq8PeVi7U=;
        b=WEQqszFSlxDKoOI4K7/3pm3vbmwyprvIHirbDsdTOiapmQAeEcisU80mGUWL/qIX+q
         tTfQfPUH9PetAAVlzG8QJw+A6kaFAAq31s+9frj7S0kfbR8ysFlXJoqNJVyIKkUo8PUC
         EqpXzcaJdgj6Q+Puj+WOuN7j8S21J0qSURAzvig6wMf5LQz7Ughv/Ddk7JlpGcsDPESP
         DM9k292BCLDillCzfAb6twRdy0lWC1ow71RFmBqjsPrby86yVj+7v0tA+RROAv6WnNQp
         vEQR0AsCBduXJTsd7pWrdc+EbvBjXMNbLpEnM7N9rEZ/aGyZm5xZ+9800IbOop8Gebse
         hD3w==
X-Gm-Message-State: AOAM530jea/FCL3mGngr0IcciZ9JD75vBARn9RP8s98d8G01fkObQhfM
        62fP6xJFhSiEuX44HpBDI5Av6a4NJMyk6g==
X-Google-Smtp-Source: ABdhPJy1JZBoiRSrnFHy7GfaKHce/WLkcye2T7Kf4qmZvcgq33wUcKLmS9GiOIxTpl4ALCeQuSgJ2Q==
X-Received: by 2002:a05:6808:1292:b0:325:e54f:6730 with SMTP id a18-20020a056808129200b00325e54f6730mr21055oiw.261.1651314332131;
        Sat, 30 Apr 2022 03:25:32 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id d19-20020a4ad353000000b0035eb4e5a6bfsm1773681oos.21.2022.04.30.03.25.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 03:25:31 -0700 (PDT)
Message-ID: <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
Date:   Sat, 30 Apr 2022 05:30:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/22 09:24, John Paul Adrian Glaubitz wrote:
> Hi Sergey!
> 
> On 4/27/22 20:46, Sergey Shtylyov wrote:
>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
>> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
>> at 0 -- modify that code to start the IRQ #s from 16 instead.
>> 
>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
> Maybe try getting it landed through Andrew Morton's tree?

As I told him in IRC, the problem is still that sh4 never gives me a shell
prompt with this patch applied. I just reconfirmed it against current git:

Freeing unused kernel image (initmem) memory: 124K
This architecture does not have kernel memory protection.
Run /init as init process
mountpoint: dev/pts: No such file or directory
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1

It makes it partway through the init script, but it hangs with qemu-system-sh4
stuck in a CPU-eating loop before finishing. Without the patch, I get a shell
prompt.

If you don't want to build the userspace from source with mkroot, the last
release's binary tarball is 4 megs and reproduced the problem just fine. First,
confirm it works as-shipped:

$ wget https://landley.net/toybox/downloads/binaries/mkroot/latest/sh4.tgz
...
$ tar xvf sh4.tgz
...
$ cd sh4
$ ./qemu-sh4.sh
...
printk: console [netcon0] enabled
netconsole: network logging started
Freeing unused kernel image (initmem) memory: 116K
This architecture does not have kernel memory protection.
Run /init as init process
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
random: fast init done
Type exit when done.
# exit
reboot: Restarting system

landley@driftwood:~/sub/sh4$

Once you've confirmed that works with your qemu-system-sh4 install, replace the
kernel using the config in that directory:

$ git clone ~/linux/linux linux
...
$ cd linux
$ patch -p1 -i ~/linux/sh4irq.eml
...
$ CROSS_COMPILE=~/mcm/ccc/sh4-linux-musl-cross/bin/sh4-linux-musl- make \
  ARCH=sh allnoconfig KCONFIG_ALLCONFIG=../miniconfig-sh4
...
$ CROSS_COMPILE=~/mcm/ccc/sh4-linux-musl-cross/bin/sh4-linux-musl- make \
  ARCH=sh -j $(nproc)
...
$ cp arch/sh/boot/zImage ..
$ cd ..
$ ./qemu-*.sh
...

and it hangs without ever saying "random: fast init done" or giving a prompt.

(You could also use the linux-fullconfig file to build your kernel, but you'll
have to say "n" to a bunch of make oldconfig questions.)

> Adrian

Rob
