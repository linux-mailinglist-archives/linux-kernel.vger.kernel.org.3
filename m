Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368985178BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 23:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387541AbiEBVGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 17:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348432AbiEBVG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 17:06:29 -0400
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 May 2022 14:02:58 PDT
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA11BC84;
        Mon,  2 May 2022 14:02:58 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 29DA720D16F2
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v3] sh: avoid using IRQ0 on SH3/4
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Landley <rob@landley.net>
CC:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
 <11021433-66c0-3c56-42bd-207a5ae8d267@physik.fu-berlin.de>
 <2ebef1ac-e5c5-980c-9413-22a6cccdfa1d@landley.net>
 <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <59faed1d-3878-ce75-9f62-aaf4338d0ad1@omp.ru>
Date:   Mon, 2 May 2022 23:56:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWN0vRYhK7O0MgOSCtisw3RDvp4vxSS2VF-9uGDdOEb7g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/22 11:37 AM, Geert Uytterhoeven wrote:

[...]
>>>> Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
>>>> and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
>>>> see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
>>>> at 0 -- modify that code to start the IRQ #s from 16 instead.
>>>>
>>>> The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
>>>> indeed use IRQ0 for the SMSC911x compatible Ethernet chip...
> 
>> As I told him in IRC, the problem is still that sh4 never gives me a shell
>> prompt with this patch applied. I just reconfirmed it against current git:
>>
>> Freeing unused kernel image (initmem) memory: 124K
>> This architecture does not have kernel memory protection.
>> Run /init as init process
>> mountpoint: dev/pts: No such file or directory
>> 8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
>>
>> It makes it partway through the init script, but it hangs with qemu-system-sh4
>> stuck in a CPU-eating loop before finishing. Without the patch, I get a shell
>> prompt.
> 
> I regularly test on qemu rts7751r2d, but couldn't produce your
> issue.  Until I tried "ifconfig eth0 up", which causes a lock-up.
> Interestingly, the 8139 irq was 112 with and without Sergey's patch,
> so there must be an irq remapping missing.
> 
> I also test regularly on landisk, where 8139 Ethernet works fine.
> Turns out landisk uses arch/sh/drivers/pci/fixups-landisk.c to fixup
> the irq...
> 
> arch/sh/include/mach-common/mach/r2d.h has:
> #define R2D_FPGA_IRQ_BASE       100
> Subtracting 16 here does not help.

   Why subtract when you contrariwise need to add? :-)

> With this (gmail-whitespace-damaged) patch:
> 
> --- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
> +++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
> @@ -31,9 +31,9 @@ static char lboxre2_irq_tab[] = {
>  int pcibios_map_platform_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
>  {
>         if (mach_is_lboxre2())
> -               return lboxre2_irq_tab[slot];
> +               return lboxre2_irq_tab[slot] - 16;

   This table contains the values #define'd via evt2irq(), so
shouldn't need to subtract anything...

>         else
> -               return rts7751r2d_irq_tab[slot];
> +               return rts7751r2d_irq_tab[slot] - 16;

   How about + 16?

>  }
> 
>  int pci_fixup_pcic(struct pci_channel *chan)
> 
> it no longer crashes, but ifconfig still fails:
> 
> / # ifconfig eth0 up
> ifconfig: ioctl 0x8914 failed: Invalid argument

   I'm still not sure you used the correct IRQ #s...

> Note that there are more implementations of pcibios_map_platform_irq()
> that do not use evt2irq(), and thus are probably broken by this patch.

   That doesn't sound encouraging... :-/

> Gr{oetje,eeting}s,
> 
>                         Geert

MBR, Sergey
