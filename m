Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27C4CCF72
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiCDIBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbiCDIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:01:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953FA17927B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:00:23 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nQ2rM-0002tk-Lw; Fri, 04 Mar 2022 09:00:20 +0100
Message-ID: <b8c15e35-62a7-37db-f414-8cef445f91bc@leemhuis.info>
Date:   Fri, 4 Mar 2022 09:00:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Content-Language: en-US
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Saravana Kannan <saravanak@google.com>,
        Daniels Umanovskis <du@axentia.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1646380823;8393d37f;
X-HE-SMSGID: 1nQ2rM-0002tk-Lw
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding the regression report below to regzbot, the Linux
kernel regression tracking bot; all text you find below is compiled from
a few templates paragraphs you might have encountered already already
from similar mails.]

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easily accessible to everyone.

CCing the regression mailing list, as it should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

Thanks for the report.

To be sure below issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced f9aa460672c9
#regzbot title memory corruption on Atmel SAMA5D31
#regzbot ignore-activity

Reminder for developers: when fixing the issue, please add a 'Link:'
tags pointing to the report (the mail quoted above) using
lore.kernel.org/r/, as explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'. This allows the bot to connect
the report with any patches posted or committed to fix the issue; this
again allows the bot to show the current status of regressions and
automatically resolve the issue when the fix hits the right tree.

I'm sending this to everyone that got the initial report, to make them
aware of the tracking. I also hope that messages like this motivate
people to directly get at least the regression mailing list and ideally
even regzbot involved when dealing with regressions, as messages like
this wouldn't be needed then. And don't worry, if I need to send other
mails regarding this regression only relevant for regzbot I'll send them
to the regressions lists only (with a tag in the subject so people can
filter them away). With a bit of luck no such messages will be needed
anyway.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.



On 03.03.22 01:29, Peter Rosin wrote:
> Hi!
> 
> I'm seeing a weird problem, and I'd like some help with further
> things to try in order to track down what's going on. I have
> bisected the issue to
> 
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 
> The symptoms are that I get (seemingly) random memory corruption
> when processing large amounts of data (compared to system size).
> I have two known reproducers, but I'm sure there are more if I
> keep digging. One is to do this:
> 
> $ dd if=/dev/urandom of=testfile bs=1024 count=40000
> 40000+0 records in
> 40000+0 records out
> 40960000 bytes (41 MB, 39 MiB) copied, 19.7759 s, 2.1 MB/s
> $ for i in 1 2 3 4; do cat testfile | sha256sum; done
> d8c85f816e08baa5ad27050bf0413e11a09f325fb0a8843b7b2b45b9333ab542  -
> f223c1cbb6dbecb02d1741e7991dc98cd8d5b40ffee05bb32dc2c15eb73d6b1f  -
> d6f3e7f3d325c67e83a6104934dd8a7c891ebfd9a2cf59633dbe97fb2cbb9c81  -
> cf8ada47e7e2fee299314440b225ba83fca3cef1f6286adc160a5d4f207caccd  -
> 
> It is harder to tickle the problem if I redirect the testfile to
> sha256sum w/o involving cat or give the file as an argument to
> sha256sum. I can also get things to behave better by getting rid
> of a bunch of USB interrupts by doing the following:
> 
> $ echo 100 > /sys/bus/usb-serial/devices/ttyUSB0/latency_timer
> $ echo 100 > /sys/bus/usb-serial/devices/ttyUSB1/latency_timer
> $ echo 100 > /sys/bus/usb-serial/devices/ttyUSB2/latency_timer
> $ echo 100 > /sys/bus/usb-serial/devices/ttyUSB3/latency_timer
> 
> With the lower interrupt pressure I get this:
> 
> $ for i in 1 2 3 4; do cat testfile | sha256sum; done
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 4f9173f63cb2e13d1470e59e1b5c657f3b0f4f2e9a55ab6facffbb03f34ce04d  -
> 
> Nice. However, I need the latency to be lower than the default
> 16ms, 3ms could perhaps work in theory, but preferably 1ms, so
> the above 100ms is far off. The initial hash run was with latency
> set to 1ms, which makes it easy to trigger the issue. The latency
> timer setting is for this driver: drivers/usb/serial/ftdi_sio.c
> 
> And also, that does not help with the other reproducer, namely
> to copy that same random testfile with scp to a working system...
> 
> $ scp testfile peda@xyzzy:testfile1
> testfile                                      100%   39MB   2.0MB/s   00:19
> $ scp testfile peda@xyzzy:testfile2
> testfile                                      100%   39MB   2.1MB/s   00:18
> $ scp testfile peda@xyzzy:testfile3
> testfile                                      100%   39MB   2.1MB/s   00:18
> $ scp testfile peda@xyzzy:testfile4
> testfile                                      100%   39MB   2.1MB/s   00:19
> 
> ...and then perform the sha256sum on that xyzzy host instead:
> 
> $ sha256sum testfile?
> 39dc3a7d05483ae7a2c64c5ed2e8e6108287bf4ddf124a2f0c1a9d0221f9ac66  testfile1
> 9597ef542e7cce879872a027d9ec591feb5fc766aeaec47d58eff6e8c6ab3206  testfile2
> c6104a700b1d6f13eb1de84b5a91a1846a3e1576e052d51a664d2e2711a3869d  testfile3
> 60b9c240cb331bad530c3c1d766f50d53a24e01831bfc04e48f329b738521310  testfile4
> $ sha256sum testfile?
> 39dc3a7d05483ae7a2c64c5ed2e8e6108287bf4ddf124a2f0c1a9d0221f9ac66  testfile1
> 9597ef542e7cce879872a027d9ec591feb5fc766aeaec47d58eff6e8c6ab3206  testfile2
> c6104a700b1d6f13eb1de84b5a91a1846a3e1576e052d51a664d2e2711a3869d  testfile3
> 60b9c240cb331bad530c3c1d766f50d53a24e01831bfc04e48f329b738521310  testfile4
> 
> Same output every time. Of course. xyzzy is a working system...
> Converting these files to hex (hexdump -C) and diffing yields this:
> 
> $ diff -u0 testfile1.hex testfile2.hex
> --- testfile1.hex       2022-03-02 23:56:38.273149516 +0100
> +++ testfile2.hex       2022-03-03 00:00:57.912747033 +0100
> @@ -8658,2 +8658,2 @@
> -00021d10  08 2a dd c6 c8 0f 0d e2  4c 1e 46 21 f9 89 a2 54  |.*......L.F!...T|
> -00021d20  23 8c 4f f1 46 f1 61 05  ee f2 d2 ee 56 79 4f 28  |#.O.F.a.....VyO(|
> +00021d10  7b c8 d2 0b f4 ca 5f ba  61 b3 93 04 59 8f ed bf  |{....._.a...Y...|
> +00021d20  2a f8 fb 0c ad 0e 23 2a  3e cf d3 10 02 ef 04 b9  |*.....#*>.......|
> @@ -20592,2 +20592,2 @@
> -000506f0  1f 6c ca 6b a6 2a 39 a6  1f bd b0 67 5b 22 1a dd  |.l.k.*9....g["..|
> -00050700  8b 6d 86 7c 87 37 ee a8  46 4d e5 79 0e 3e 96 e6  |.m.|.7..FM.y.>..|
> +000506f0  ad e6 d5 65 e6 dc c1 a3  e2 ba c9 e2 61 39 5f 5f  |...e........a9__|
> +00050700  bf eb 8e 5c 08 f1 f2 89  3c 57 c5 07 b9 f4 91 fc  |...\....<W......|
> @@ -461019,2 +461019,2 @@
> -00708da0  0d 49 c3 e8 57 06 20 5a  c1 27 74 29 f8 83 af 69  |.I..W. Z.'t)...i|
> -00708db0  94 4d 5b 71 9f 3e e5 d2  91 cc cb cd aa ff 44 8b  |.M[q.>........D.|
> +00708da0  d3 b4 96 d6 40 8d 79 67  69 68 fd 10 b4 15 82 e6  |....@.ygih......|
> +00708db0  5f f4 10 92 ae 39 9d 92  42 88 44 3b be 35 38 33  |_....9..B.D;.583|
> @@ -902788,2 +902788,2 @@
> -00dc6830  f2 41 23 1b ec 54 d5 fe  f0 33 51 f7 d2 fc bf bd  |.A#..T...3Q.....|
> -00dc6840  e5 1f 58 df 24 2f e3 dc  65 87 b2 27 12 86 d1 9a  |..X.$/..e..'....|
> +00dc6830  44 82 94 b5 c9 26 08 42  bd 89 e1 96 41 66 8a b5  |D....&.B....Af..|
> +00dc6840  a5 34 46 5e fd 1b c1 73  86 33 24 fd 4d e1 e1 68  |.4F^...s.3$.M..h|
> @@ -931900,2 +931900,2 @@
> -00e383b0  ee 64 c5 6f 38 44 5b 31  41 e1 2c 64 49 d5 f8 ad  |.d.o8D[1A.,dI...|
> -00e383c0  fb 85 52 4f 00 1f 80 7a  f3 de ee 8e db ac d5 bb  |..RO...z........|
> +00e383b0  4b 4d 29 a1 0a 99 8f f7  32 71 8c de 23 ca a0 f1  |KM).....2q..#...|
> +00e383c0  e2 af e3 c4 a0 95 d3 1c  ed 58 c4 c5 30 da 56 b9  |.........X..0.V.|
> @@ -1170109,2 +1170109,2 @@
> -011dabc0  6a 7c 0c 3c 86 1a b6 48  50 d7 98 68 0c 01 e3 1c  |j|.<...HP..h....|
> -011dabd0  a3 a8 b0 f2 62 21 86 b9  d1 52 9d 74 9e 26 42 51  |....b!...R.t.&BQ|
> +011dabc0  5b 1a 9e 23 ae 58 42 68  83 58 df d6 c1 57 6b b0  |[..#.XBh.X...Wk.|
> +011dabd0  ec d5 50 8b 76 5e 96 b4  49 21 f7 e4 b7 8f a3 45  |..P.v^..I!.....E|
> @@ -1880164,2 +1880164,2 @@
> -01cb0630  1c 74 74 16 75 b4 de f7  ce 4b 5e 4d 97 d6 36 d4  |.tt.u....K^M..6.|
> -01cb0640  44 d9 fd 69 c5 d0 f0 a6  c6 44 26 53 7f 91 f3 62  |D..i.....D&S...b|
> +01cb0630  73 bc 40 ce f8 9d 99 91  1b 14 8b a8 52 2a 7b 39  |s.@.........R*{9|
> +01cb0640  6b ff f5 c5 02 b9 ab c2  c2 08 5e e7 3a 5e 69 c4  |k.........^.:^i.|
> 
> Grepping (some of the above) for duplicates yields this:
> 
> $ egrep "0  (08 2a dd|23 8c 4f|7b c8 d2|2a f8 fb)" testfile1.hex
> 00020d40  7b c8 d2 0b f4 ca 5f ba  61 b3 93 04 59 8f ed bf  |{....._.a...Y...|
> 00020d50  2a f8 fb 0c ad 0e 23 2a  3e cf d3 10 02 ef 04 b9  |*.....#*>.......|
> 00021d10  08 2a dd c6 c8 0f 0d e2  4c 1e 46 21 f9 89 a2 54  |.*......L.F!...T|
> 00021d20  23 8c 4f f1 46 f1 61 05  ee f2 d2 ee 56 79 4f 28  |#.O.F.a.....VyO(|
> $ egrep "0  (08 2a dd|23 8c 4f|7b c8 d2|2a f8 fb)" testfile2.hex
> 00020d40  7b c8 d2 0b f4 ca 5f ba  61 b3 93 04 59 8f ed bf  |{....._.a...Y...|
> 00020d50  2a f8 fb 0c ad 0e 23 2a  3e cf d3 10 02 ef 04 b9  |*.....#*>.......|
> 00021d10  7b c8 d2 0b f4 ca 5f ba  61 b3 93 04 59 8f ed bf  |{....._.a...Y...|*
> 00021d20  2a f8 fb 0c ad 0e 23 2a  3e cf d3 10 02 ef 04 b9  |*.....#*>.......|*
> 
> $ egrep "0  (1f 6c ca|8b 6d 86|ad e6 d5|bf eb 8e)" testfile1.hex
> 0004f6f0  1f 6c ca 6b a6 2a 39 a6  1f bd b0 67 5b 22 1a dd  |.l.k.*9....g["..|
> 0004f700  8b 6d 86 7c 87 37 ee a8  46 4d e5 79 0e 3e 96 e6  |.m.|.7..FM.y.>..|
> 000506f0  1f 6c ca 6b a6 2a 39 a6  1f bd b0 67 5b 22 1a dd  |.l.k.*9....g["..|*
> 00050700  8b 6d 86 7c 87 37 ee a8  46 4d e5 79 0e 3e 96 e6  |.m.|.7..FM.y.>..|*
> $ egrep "0  (1f 6c ca|8b 6d 86|ad e6 d5|bf eb 8e)" testfile2.hex
> 0004f6f0  1f 6c ca 6b a6 2a 39 a6  1f bd b0 67 5b 22 1a dd  |.l.k.*9....g["..|
> 0004f700  8b 6d 86 7c 87 37 ee a8  46 4d e5 79 0e 3e 96 e6  |.m.|.7..FM.y.>..|
> 000506f0  ad e6 d5 65 e6 dc c1 a3  e2 ba c9 e2 61 39 5f 5f  |...e........a9__|
> 00050700  bf eb 8e 5c 08 f1 f2 89  3c 57 c5 07 b9 f4 91 fc  |...\....<W......|
> 
> $ egrep "0  (0d 49 c3|94 4d 5b|d3 b4 96|5f f4 10 92)" testfile1.hex
> 00707dd0  d3 b4 96 d6 40 8d 79 67  69 68 fd 10 b4 15 82 e6  |....@.ygih......|
> 00707de0  5f f4 10 92 ae 39 9d 92  42 88 44 3b be 35 38 33  |_....9..B.D;.583|
> 00708da0  0d 49 c3 e8 57 06 20 5a  c1 27 74 29 f8 83 af 69  |.I..W. Z.'t)...i|
> 00708db0  94 4d 5b 71 9f 3e e5 d2  91 cc cb cd aa ff 44 8b  |.M[q.>........D.|
> $ egrep "0  (0d 49 c3|94 4d 5b|d3 b4 96|5f f4 10 92)" testfile2.hex
> 00707dd0  d3 b4 96 d6 40 8d 79 67  69 68 fd 10 b4 15 82 e6  |....@.ygih......|
> 00707de0  5f f4 10 92 ae 39 9d 92  42 88 44 3b be 35 38 33  |_....9..B.D;.583|
> 00708da0  d3 b4 96 d6 40 8d 79 67  69 68 fd 10 b4 15 82 e6  |....@.ygih......|*
> 00708db0  5f f4 10 92 ae 39 9d 92  42 88 44 3b be 35 38 33  |_....9..B.D;.583|*
> 
> I.e. testfile1 is (probably) corrupted at 000506f0..70f while
> testfile2 is (probably) corrupted at 00021d10..2f and 00708da0..bf
> (correpted lines marked with hand-made asterisks above)
> 
> If I keep grepping like this, the pattern is similar both within
> these files and within testfile3 and testfile4. I.e. with
> corruptions in 32-byte blocks at (seemingly) random positions
> in the files. The corruption is always 16-byte-aligned and the bad
> data seems to be a copy from exactly one page up in the file.
> 
> As stated above, I have bisected the issue to patch
> 
> f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> 
> which was added between v5.10-rc3 and v5.10-rc4. Every kernel I have
> tried with that patch applied have exhibited the issue, and I have
> had no trouble like this with any kernel without that patch. Apart
> from a whole bunch of kernels prior to v5.10-rc3, that includes some
> later kernels with the patch reverted (along with the dependent
> followup 2d09e6eb4a6f). The latest I have tried is 5.11.22. Those
> two patches does not revert cleanly in 5.12 (and thereafter) so I
> have not tried anything beyond 5.11 with the patch reverted.
> 
> I fail to understand how that patch might cause this issue. I have
> compared boot messages before and after the patch and there is no
> (significant) difference. Everything seems to happen in the same
> order with the same result. But that comparison is of course limited
> to what is logged.
> 
> In some random attempt I tried to disable the D-Cache bit, and that
> makes it all very slow but it also (seemingly) fixes the issue. But
> that may of course be due to vastly different timings.
> 
> Some background:
> 
> We have a "Linea" CPU module, with a design based on the Atmel (now
> Microchip) SAMA5D31 evaluation board. This CPU module is used on e.g.
> our TSE-850 for which there is a device tree in
>     arch/arm/boot/dts/at91-tse850-3.dts
> It has a nand flash for the rootfs and 64 MB RAM. The 40 MB random
> testfile is thus big enough to cause page cache churn.
> 
> We have used this module in thousands of delivered units (however,
> not that many TSE-850) and have never observed anything like this
> before. But that has been with older kernels. 4.13.<something> and
> 4.15.<something> was what we were on until this recent activity.
> 
> We're now developing a new product (preliminary device tree included)
> and the trusty old CPU module was used again and a fresh new kernel
> was built for it. I then started to notice this issue and have tried
> to include as much relevant data as possible. If you need more data
> or would like me to test something, please ask.
> 
> I'm stumped.
> 
> Cheers,
> Peter

-- 
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
CC the regression list and tell regzbot about the issue, as that ensures
the regression makes it onto the radar of the Linux kernel's regression
tracker -- that's in your interest, as it ensures your report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include 'Link:' tag in the patch descriptions pointing to all reports
about the issue. This has been expected from developers even before
regzbot showed up for reasons explained in
'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'.
