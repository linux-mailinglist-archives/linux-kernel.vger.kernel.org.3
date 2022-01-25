Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C56349BDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbiAYVLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:11:16 -0500
Received: from qproxy3-pub.mail.unifiedlayer.com ([67.222.38.20]:46754 "EHLO
        qproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233050AbiAYVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:11:06 -0500
Received: from gproxy1-pub.mail.unifiedlayer.com (gproxy1-pub.mail.unifiedlayer.com [69.89.25.95])
        by qproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 5B8FA802AD0A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:11:06 +0000 (UTC)
Received: from cmgw11.mail.unifiedlayer.com (unknown [10.0.90.126])
        by progateway3.mail.pro1.eigbox.com (Postfix) with ESMTP id A171F10047048
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 21:11:05 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id CT5ln5dgywm8iCT5ln50IG; Tue, 25 Jan 2022 21:11:05 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=DpSTREz+ c=1 sm=1 tr=0 ts=61f06769
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10:nop_charset_1
 a=DghFqjY3_ZEA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=eFWqtd3rAAAA:8
 a=tBb2bbeoAAAA:8 a=h0uksLzaAAAA:8 a=W-_n0kkjAAAA:8 a=BouTL1r6kgS_ZzKWE9cA:9
 a=QEXdDO2ut3YA:10:nop_charset_2 a=OmE4rGSwGH90ucjH_eFs:22
 a=Oj-tNtZlA1e06AYgeCfH:22 a=MSi_79tMYmZZG2gvAgS0:22 a=qeNa2pbTr82C0GpJEZFS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KWOkGwXKalirvDlhGoXrr7N1kHlpsTkkyxGyIlZUW2I=; b=auTzbuQjEdMeBZq+n+7UshnKHn
        8OJLxyeBzFQZy+YI8z2/oLmbC1X3sHbP15V/gzHdE2ZvqXMm38deynzur5qpBWfPbNX7I+W/4Z77G
        IhkHRFNUiQG9z3gYhKTiEhaL1;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:51656 helo=[10.0.1.23])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <re@w6rz.net>)
        id 1nCT5k-0049Qa-N6; Tue, 25 Jan 2022 14:11:04 -0700
Message-ID: <1200181c-9380-5405-0b37-4fbc49f6c095@w6rz.net>
Date:   Tue, 25 Jan 2022 13:11:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 6/6] RISC-V: Do not use cpumask data structure for
 hartid bitmap
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20220120090918.2646626-1-atishp@rivosinc.com>
 <20220120090918.2646626-7-atishp@rivosinc.com>
 <CAMuHMdXJoREF7jZaYWrDUjJqKUSCd82qDVaMEo7VO38ok8J-AA@mail.gmail.com>
 <CAOnJCULjqeL9Q27n=g19ALbOivzid6pc_gYv6JUF4iP=64kJ-Q@mail.gmail.com>
 <CAMuHMdWBF0XXXQLfAH81F=BczjsDeQFU454_A2C_-qLPKJGpiQ@mail.gmail.com>
From:   Ron Economos <re@w6rz.net>
In-Reply-To: <CAMuHMdWBF0XXXQLfAH81F=BczjsDeQFU454_A2C_-qLPKJGpiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1nCT5k-0049Qa-N6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.23]) [73.162.232.9]:51656
X-Source-Auth: re@w6rz.net
X-Email-Count: 12
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 12:52, Geert Uytterhoeven wrote:
> Hi Atish,
>
> On Tue, Jan 25, 2022 at 9:17 PM Atish Patra <atishp@atishpatra.org> wrote:
>> On Tue, Jan 25, 2022 at 12:12 PM Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Thu, Jan 20, 2022 at 10:12 AM Atish Patra <atishp@rivosinc.com> wrote:
>>>> Currently, SBI APIs accept a hartmask that is generated from struct
>>>> cpumask. Cpumask data structure can hold upto NR_CPUs value. Thus, it
>>>> is not the correct data structure for hartids as it can be higher
>>>> than NR_CPUs for platforms with sparse or discontguous hartids.
>>>>
>>>> Remove all association between hartid mask and struct cpumask.
>>>>
>>>> Reviewed-by: Anup Patel <anup@brainfault.org> (For Linux RISC-V changes)
>>>> Acked-by: Anup Patel <anup@brainfault.org> (For KVM RISC-V changes)
>>>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>>> Thanks for your patch, which is now commit 26fb751ca37846c9 ("RISC-V:
>>> Do not use cpumask data structure for hartid bitmap") in v5.17-rc1.
>>>
>>> I am having an issue with random userspace SEGVs on Starlight Beta
>>> (which needs out-of-tree patches).  It doesn't always manifest
>>> itself immediately, so it took a while to bisect, but I suspect the
>>> above commit to be the culprit.
>> I have never seen one before during my testing. How frequently do you see them?
>> Does it happen while running anything or just idle user space results
>> in SEGVs randomly.
> Sometimes they happen during startup (lots of failures from systemd),
> sometimes they happen later, during interactive work.
> Sometimes while idle, and something runs in the background (e.g. mandb).
>
>> Do you have a trace that I can look into ?
> # apt update
> [  807.499050] apt[258]: unhandled signal 11 code 0x1 at
> 0xffffff8300060020 in libapt-pkg.so.6.0.0[3fa49ac000+174000]
> [  807.509548] CPU: 0 PID: 258 Comm: apt Not tainted
> 5.16.0-starlight-11192-g26fb751ca378-dirty #153
> [  807.518674] Hardware name: BeagleV Starlight Beta (DT)
> [  807.524077] epc : 0000003fa4a47a0a ra : 0000003fa4a479fc sp :
> 0000003fcb4b39b0
> [  807.531383]  gp : 0000002adcef4800 tp : 0000003fa43287b0 t0 :
> 0000000000000001
> [  807.538603]  t1 : 0000000000000009 t2 : 00000000000003ff s0 :
> 0000000000000000
> [  807.545887]  s1 : 0000002adcf3cb60 a0 : 0000000000000003 a1 :
> 0000000000000000
> [  807.553167]  a2 : 0000003fcb4b3a30 a3 : 0000000000000000 a4 :
> 0000002adcf3cc1c
> [  807.560390]  a5 : 0007000300060000 a6 : 0000000000000003 a7 :
> 1999999999999999
> [  807.567654]  s2 : 0000003fcb4b3a28 s3 : 0000000000000002 s4 :
> 0000003fcb4b3a30
> [  807.575039]  s5 : 0000003fa4baa810 s6 : 0000000000000010 s7 :
> 0000002adcf19a40
> [  807.582363]  s8 : 0000003fcb4b4010 s9 : 0000003fa4baa810 s10:
> 0000003fcb4b3e90
> [  807.589606]  s11: 0000003fa4b2a528 t3 : 0000000000000000 t4 :
> 0000003fa47906a0
> [  807.596891]  t5 : 0000000000000005 t6 : ffffffffffffffff
> [  807.602302] status: 0000000200004020 badaddr: ffffff8300060020
> cause: 000000000000000d
>
> (-dirty due to Starlight DTS and driver updates)
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --

I'm not sure if it's related, but I'm also seeing a systemd segfault on 
boot with the HiFive Unmatched and 5.17.0-rc1. I don't have the dmesg 
dump, but here's the journalctl dump. It was built before the tag, so it 
says 5.16.0.

Jan 23 02:41:50 riscv64 systemd-udevd[551]: mmcblk0p12: Failed to wait 
for spawned command '/usr/bin/unshare -m /usr/bin/snap auto-import 
--mount=/dev/mmcblk0p12': Invalid argument
Jan 23 02:41:50 riscv64 systemd-udevd[412]: mmcblk0p12: Process 
'/usr/bin/unshare -m /usr/bin/snap auto-import --mount=/dev/mmcblk0p12' 
terminated by signal SEGV.
Jan 23 02:41:50 riscv64 kernel: systemd-udevd[551]: unhandled signal 11 
code 0x1 at 0x0000000003938700 in udevadm[3fa7eee000+b1000]
Jan 23 02:41:50 riscv64 kernel: CPU: 2 PID: 551 Comm: systemd-udevd Not 
tainted 5.16.0 #1
Jan 23 02:41:50 riscv64 kernel: Hardware name: SiFive HiFive Unmatched 
A00 (DT)
Jan 23 02:41:50 riscv64 kernel: epc : 0000003fa7f14104 ra : 
0000003fa7f14102 sp : 0000003fe3da5320
Jan 23 02:41:50 riscv64 kernel:  gp : 0000003fa7fc3ef8 tp : 
0000003fa79f8530 t0 : 0000003fe3da38f0
Jan 23 02:41:50 riscv64 kernel:  t1 : 0000003fa7f0425c t2 : 
0000000000000000 s0 : 0000003fcd046d88
Jan 23 02:41:50 riscv64 kernel:  s1 : 0000003fcd046d60 a0 : 
ffffffffffffffff a1 : 0000003fcd0cb330
Jan 23 02:41:50 riscv64 kernel:  a2 : 0000003fcd043028 a3 : 
0000000000000007 a4 : c98b6a1813e46d00
Jan 23 02:41:50 riscv64 kernel:  a5 : ffffffffffffffff a6 : 
fefefefefefefeff a7 : 0000000000000039
Jan 23 02:41:50 riscv64 kernel:  s2 : 0000000000000000 s3 : 
ffffffffffffffea s4 : 0000000000000000
Jan 23 02:41:50 riscv64 kernel:  s5 : 0000003fe3da5378 s6 : 
ffffffffffffffea s7 : 0000000003938700
Jan 23 02:41:50 riscv64 kernel:  s8 : 0000003fe3da53e0 s9 : 
0000003fe3da53d8 s10: 0000003fa7fc200c
Jan 23 02:41:50 riscv64 kernel:  s11: 0000000000081000 t3 : 
0000003fa7db3822 t4 : 0000000000000000
Jan 23 02:41:50 riscv64 kernel:  t5 : 0000003fe3da38c8 t6 : 000000000000002a
Jan 23 02:41:50 riscv64 kernel: status: 0000000200004020 badaddr: 
0000000003938700 cause: 000000000000000d
Jan 23 02:41:50 riscv64 systemd-udevd[412]: mmcblk0p12: Failed to wait 
for spawned command '/usr/bin/unshare -m /usr/bin/snap auto-import 
--mount=/dev/mmcblk0p12': Input/output error
Jan 23 02:41:50 riscv64 systemd-udevd[412]: mmcblk0p12: Failed to 
execute '/usr/bin/unshare -m /usr/bin/snap auto-import 
--mount=/dev/mmcblk0p12', ignoring: Input/output error

I'll try removing this patch.

Ron

