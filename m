Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6EF5AC5E8
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 20:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIDS3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 14:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiIDS26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 14:28:58 -0400
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8230548
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 11:28:55 -0700 (PDT)
Received: (wp-smtpd smtp.tlen.pl 34374 invoked from network); 4 Sep 2022 20:28:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1662316131; bh=RMbg8JoOTW9l4AYVWEZ+YFzFJD8KFu2BndOpYJRW1Cw=;
          h=To:From:Subject;
          b=Tr+NF08r1TL2k8sMMNh7Fgh5V/B6HDJ+JQSpSnE3pzk637FgF7oeDRk5lMX4UmVpR
           SthKBi24B+HO68FWGKvwptm5V24O1hIl8D52IcsnrEfxw41N1yhUk5y2g0wF4lYNwT
           gNHOTekpjX/yqUS++60RuwU/6RLcUUYOAiJsoWUA=
Received: from aaey104.neoplus.adsl.tpnet.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[83.4.128.104])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 4 Sep 2022 20:28:51 +0200
Message-ID: <fbd28a8c-858d-8891-f6be-a5c2ca3131da@o2.pl>
Date:   Sun, 4 Sep 2022 20:28:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Content-Language: en-GB
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org, adrian.hunter@intel.com,
        martin.petersen@oracle.com, bvanassche@acm.org, jaegeuk@kernel.org,
        michael.christie@oracle.com, hch@lst.de, ming.lei@redhat.com,
        hare@suse.de, john.garry@huawei.com
From:   =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>
Subject: [Bisected] Disconnecting pendrive with opened files causes trouble on
 6.0.0-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: be67303d4fa038a8d3bd0e6b3f824a8e
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [oQIx]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Linux 6.0.0-rc3, disconnecting a mounted pendrive with opened files causes these symptoms:

- "task kworker/X blocked for more than Y seconds" warnings (see below) are repeatedly printed in dmesg,
- after reconnecting the pendrive (or possibly other USB devices), it is not detected,
- the login screen (Gnome on Ubuntu 20.04) freezes for some time (around 20s), due to a hang in colord-sane.

These symptoms disappear after closing the opened files (and perhaps also directories) on the pendrive.

I am aware that disconnecting a pendrive with a mounted filesystem is unwise, but many people do so
nonetheless.

I have bisected this down to
commit 16728aaba62e ("scsi: core: Make sure that hosts outlive targets")

With the previous
commit fe442604199e ("scsi: core: Make sure that targets outlive devices")
the problem does not happen.

To reproduce:

1. Plug a pendrive into a USB port (checked with a pendrive formatted with a FAT32 filesystem).
2. Mount it, open a file on this pendrive with the "less" command-line program.
3. Optionally suspend the system to RAM.
4. Disconnect the pendrive.
5. Resume the system, if it was suspended.

Warnings from dmesg:

[   76.212690] usb 1-3.4.3: USB disconnect, device number 6
[   76.219765] device offline error, dev sdc, sector 2049 op 0x1:(WRITE) flags 0x100000 phys_seg 1 prio class 2
[   76.219791] Buffer I/O error on dev sdc1, logical block 1, lost async page write
[  242.764446] INFO: task kworker/0:7:1701 blocked for more than 120 seconds.
[  242.764463]       Tainted: G            E      6.0.0-rc3mj6 #239
[  242.764470] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  242.764474] task:kworker/0:7     state:D stack:    0 pid: 1701 ppid:     2 flags:0x00004000
[  242.764488] Workqueue: usb_hub_wq hub_event
[  242.764504] Call Trace:
[  242.764507]  <TASK>
[  242.764514]  __schedule+0x2c5/0xcd0
[  242.764527]  schedule+0x5d/0xf0
[  242.764535]  scsi_remove_host+0x163/0x1b0
[  242.764547]  ? var_wake_function+0x60/0x60
[  242.764559]  usb_stor_disconnect+0x50/0xd0 [usb_storage]
[  242.764571]  usb_unbind_interface+0x8c/0x240
[  242.764581]  device_remove+0x64/0x70
[  242.764590]  device_release_driver_internal+0xd1/0x160
[  242.764599]  device_release_driver+0x12/0x20
[  242.764608]  bus_remove_device+0xde/0x150
[  242.764616]  device_del+0x192/0x3e0
[  242.764621]  ? usb_remove_ep_devs+0x1f/0x30
[  242.764632]  usb_disable_device+0xab/0x240
[  242.764639]  usb_disconnect+0xc7/0x260
[  242.764647]  ? set_port_feature+0x37/0x40
[  242.764656]  hub_event+0xeb0/0x17c0
[  242.764668]  ? __schedule+0x2cd/0xcd0
[  242.764675]  ? queue_rcu_work+0x2c/0x40
[  242.764684]  process_one_work+0x21c/0x3c0
[  242.764693]  worker_thread+0x4a/0x3b0
[  242.764703]  ? process_one_work+0x3c0/0x3c0
[  242.764711]  kthread+0xcf/0xf0
[  242.764719]  ? kthread_complete_and_exit+0x20/0x20
[  242.764728]  ret_from_fork+0x22/0x30
[  242.764737]  </TASK>

The kernel is tainted AFAIK because of the following:

[    0.442486] backlight: module verification failed: signature and/or required key missing - tainting kernel
[...]
[    0.446462] Loading compiled-in X.509 certificates
[    0.447431] Loaded X.509 cert 'Build time autogenerated kernel key: cbf6b5d58385db4124f3ddd5fa0457b112415dcb'

The module was loaded before the signing keys were processed - which is an unrelated bug, present since a long time.


System information:
- Ubuntu 20.04 amd64,
- HP 17-by0001nw laptop,
- problem happens also when using an external USB 3.0 UNITEK hub.

Greetings,

Mateusz Jończyk

