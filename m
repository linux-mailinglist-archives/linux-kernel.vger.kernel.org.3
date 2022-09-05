Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4C5AD019
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 12:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbiIEK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 06:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiIEK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 06:27:17 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B714F62E4;
        Mon,  5 Sep 2022 03:27:15 -0700 (PDT)
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1oV9Jx-0001WI-TV; Mon, 05 Sep 2022 12:27:13 +0200
Message-ID: <59c57de8-580e-a761-e69c-7b1bdbfb8dd4@leemhuis.info>
Date:   Mon, 5 Sep 2022 12:27:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [Bisected] Disconnecting pendrive with opened files causes
 trouble on 6.0.0-rc3 #forregzbot
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <fbd28a8c-858d-8891-f6be-a5c2ca3131da@o2.pl>
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <fbd28a8c-858d-8891-f6be-a5c2ca3131da@o2.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1662373635;54257e65;
X-HE-SMSGID: 1oV9Jx-0001WI-TV
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWIMC: this mail is primarily send for documentation purposes and for
regzbot, my Linux kernel regression tracking bot. These mails usually
contain '#forregzbot' in the subject, to make them easy to spot and filter.

[TLDR: I'm adding this regression report to the list of tracked
regressions; all text from me you find below is based on a few templates
paragraphs you might have encountered already already in similar form.]

Hi, this is your Linux kernel regression tracker. CCing the regression
mailing list, as it should be in the loop for all regressions, as
explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 04.09.22 20:28, Mateusz Jończyk wrote:
> Hello,
> 
> On Linux 6.0.0-rc3, disconnecting a mounted pendrive with opened files causes these symptoms:
> 
> - "task kworker/X blocked for more than Y seconds" warnings (see below) are repeatedly printed in dmesg,
> - after reconnecting the pendrive (or possibly other USB devices), it is not detected,
> - the login screen (Gnome on Ubuntu 20.04) freezes for some time (around 20s), due to a hang in colord-sane.
> 
> These symptoms disappear after closing the opened files (and perhaps also directories) on the pendrive.
> 
> I am aware that disconnecting a pendrive with a mounted filesystem is unwise, but many people do so
> nonetheless.
> 
> I have bisected this down to
> commit 16728aaba62e ("scsi: core: Make sure that hosts outlive targets")
> 
> With the previous
> commit fe442604199e ("scsi: core: Make sure that targets outlive devices")
> the problem does not happen.
> 
> To reproduce:
> 
> 1. Plug a pendrive into a USB port (checked with a pendrive formatted with a FAT32 filesystem).
> 2. Mount it, open a file on this pendrive with the "less" command-line program.
> 3. Optionally suspend the system to RAM.
> 4. Disconnect the pendrive.
> 5. Resume the system, if it was suspended.
> 
> Warnings from dmesg:
> 
> [   76.212690] usb 1-3.4.3: USB disconnect, device number 6
> [   76.219765] device offline error, dev sdc, sector 2049 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 2
> [   76.219791] Buffer I/O error on dev sdc1, logical block 1, lost async page write
> [  242.764446] INFO: task kworker/0:7:1701 blocked for more than 120 seconds.
> [  242.764463]       Tainted: G            E      6.0.0-rc3mj6 #239
> [  242.764470] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  242.764474] task:kworker/0:7     state:D stack:    0 pid: 1701 ppid:     2 flags:0x00004000
> [  242.764488] Workqueue: usb_hub_wq hub_event
> [  242.764504] Call Trace:
> [  242.764507]  <TASK>
> [  242.764514]  __schedule+0x2c5/0xcd0
> [  242.764527]  schedule+0x5d/0xf0
> [  242.764535]  scsi_remove_host+0x163/0x1b0
> [  242.764547]  ? var_wake_function+0x60/0x60
> [  242.764559]  usb_stor_disconnect+0x50/0xd0 [usb_storage]
> [  242.764571]  usb_unbind_interface+0x8c/0x240
> [  242.764581]  device_remove+0x64/0x70
> [  242.764590]  device_release_driver_internal+0xd1/0x160
> [  242.764599]  device_release_driver+0x12/0x20
> [  242.764608]  bus_remove_device+0xde/0x150
> [  242.764616]  device_del+0x192/0x3e0
> [  242.764621]  ? usb_remove_ep_devs+0x1f/0x30
> [  242.764632]  usb_disable_device+0xab/0x240
> [  242.764639]  usb_disconnect+0xc7/0x260
> [  242.764647]  ? set_port_feature+0x37/0x40
> [  242.764656]  hub_event+0xeb0/0x17c0
> [  242.764668]  ? __schedule+0x2cd/0xcd0
> [  242.764675]  ? queue_rcu_work+0x2c/0x40
> [  242.764684]  process_one_work+0x21c/0x3c0
> [  242.764693]  worker_thread+0x4a/0x3b0
> [  242.764703]  ? process_one_work+0x3c0/0x3c0
> [  242.764711]  kthread+0xcf/0xf0
> [  242.764719]  ? kthread_complete_and_exit+0x20/0x20
> [  242.764728]  ret_from_fork+0x22/0x30
> [  242.764737]  </TASK>
> 
> The kernel is tainted AFAIK because of the following:
> 
> [    0.442486] backlight: module verification failed: signature and/or required key missing - tainting kernel
> [...]
> [    0.446462] Loading compiled-in X.509 certificates
> [    0.447431] Loaded X.509 cert 'Build time autogenerated kernel key: cbf6b5d58385db4124f3ddd5fa0457b112415dcb'
> 
> The module was loaded before the signing keys were processed - which is an unrelated bug, present since a long time.
> 
> 
> System information:
> - Ubuntu 20.04 amd64,
> - HP 17-by0001nw laptop,
> - problem happens also when using an external USB 3.0 UNITEK hub.
> 
> Greetings,
> 
> Mateusz Jończyk
> 

Thanks for the report. To be sure below issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, my Linux kernel regression
tracking bot:

#regzbot ^introduced 16728aaba62e
#regzbot title scsi: core: Disconnecting pendrive with opened files
suddenly causes trouble
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply -- ideally with also
telling regzbot about it, as explained here:
https://linux-regtracking.leemhuis.info/tracked-regression/

Reminder for developers: When fixing the issue, add 'Link:' tags
pointing to the report (the mail this one replies to), as explained for
in the Linux kernel's documentation; above webpage explains why this is
important for tracked regressions.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.
