Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB0059B297
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 09:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiHUHet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 03:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiHUHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 03:34:46 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A08923BC0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 00:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661067261;
        bh=zPbDd3sofBdVqz7AZ/LI6Mb4b/JjNYd5j8i0s2KmCy8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=hkFF3LGZKPecS7YwQHctPtnDkulWRns6fBcBPEY98ZBf3O316NajhqT28loB9fyh+
         pcccTekcgOknQGzBaRgR6WvK0BpqsbgW1MfZ4BjHd4w8vWKJ2bTUHZVnFHkB5joehh
         8Obxx9MJQtxjZQN9EsuAJ5W4B++yoR7iAlyFWrWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.218.224]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1ouxgt2MLK-00VMaY; Sun, 21
 Aug 2022 09:34:21 +0200
Message-ID: <ca8052efe4d1357bc6ece0a45e8429de37e3ae03.camel@gmx.de>
Subject: regression bisect  --> 88f1669019bd " scsi: sd: Rework asynchronous
 resume support"
From:   Mike Galbraith <efault@gmx.de>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>, ericspero@icloud.com,
        jason600.groome@gmail.com
Date:   Sun, 21 Aug 2022 09:34:20 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+jbXnygXfKlPZ936oVuzaNMb/unYYsRErxK7bYYl4mkQWfMPmKo
 bxnwxGIe2AXtu0k2ghebNs03vZfu4PplxMPVfyON8B8qJEEQjyEy5HzYlRpnSwY2KDMGrUS
 GjNE1yh2aVSoO8C0sZqD5h5D2ysK8PlFjJEFlUdRHZYZVQN7vkCJ/xhwr3EvySYoJAzwyQW
 YrAp8fi4xXuwMhYOo+VQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7GEVBiu6t/w=:VTRByrctFmt4ms51fD2H9q
 VqLtuONIm0gVTliNzkHwyS192Lvre4RmrOPSeMmP8pX5C/PRzB9OL+R5YkyjS/C3fxDOSrW0F
 OgKgBw9UPq+kqRPCPpIb2b43jnk4+NSff+1+NDlokZupEk9Zz8zFvdWd0/QAw3eACqRleL93N
 9tkR9KGA6kHEWttNrQ2x9Esqp63MpEs1KtsesRCAILouYWbfdQylFaQdncDx9Dy1p2RvdvZAX
 rtQOzCWWAnyh/Ysbxh0aqE0BwDn6U7/VCm9Z4CKj0VJjDoCvDk/hrmngv451VVmk6DPgDiPJk
 zLsZDV+cdWKIXoYytQhtxUS6zcMEFiad6MgYiggG8MHahmQHEVv9czn9rHQDoIV+HgrwKN65o
 ncFQJjvhJY5iNVV01YgLEeFYl6RJQ9oHNPVL1SqbSAIoV2JLXQJCsRN8AdZbedXu8bUF236Y7
 xxp2sjG1mIrQvu5WIche96TUjgogHiUAvbbDn/yV3VnZpe9uXkNd8rgJbWG6nB37ksRA56+LA
 XLdv/FF/YnBTvexzHd/9+3F3tr/kLcd3I5tb8inRaksQiOJv01pICZAmphCrXJWMiO+YMMWyj
 oQ1e0FNCLD5cAt3AwUjcTI7bPKFN6/72BogSdcU+QTCfmHTimJQrQ12weU6GCG3WgjOaV1WKE
 cge3nKJlKhM8y0yj4vFGGaPyHpccbDCtOaiWFaE2U3Bpvg8yf/cxnDtYUJ4NxMxSJQbbiCatv
 oWx8exdiwzETKBtkbJah+u2Y89Iivp3bRrz/+0NEks+x5NT5fkjJWQ7lXDlPIJCfyd7umX53a
 7+0Jr9Zkphdq5oICHMrtTWOf/EPbZiEPXDWaJC12Ry4aCvVur4VlOPHXvDH6n/YrgC0eBvzMQ
 3IB0irquwsIH5bFIvHLDIyAhx6TM3V+B0bUfPo2JN/ixKgISDgH5Xk4vRoDpYNh6pKAciwelA
 PjJEhW+z28zFd3PQNl7VEwOkD0iukVyyGBQZRNPovgpvptn0HrP1U8aZQ8yivaYUXhX12EhE5
 zysLnN3uJfCa19uZ4f8ugj/z8PtWJzqrWhD3j5gwYBGsQ4dslWqUKVZFJHEzbs+GJ4TBg7pEq
 WhZwCqTC92hrsnSoBxsFgZTUHrWF6modHe3/GjaitF8yExF8uK1oYSeLQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

My box claims this patch is a dud for it, symptom being hang during
suspend _after_ a successful suspend/resume cycle. Revert at bisect
starting point and now HEAD (15b3f48a4339) confirms box's assertion.

git bisect start
# status: waiting for both good and bad commits
# good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
# bad: [50cd95ac46548429e5bba7ca75cc97d11a697947] Merge tag 'execve-v6.0-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect bad 50cd95ac46548429e5bba7ca75cc97d11a697947
# good: [798cd57cd5f871452461746032cf6ee50b0fd69a] drm/amd/display: restore code for plane with no modifiers
git bisect good 798cd57cd5f871452461746032cf6ee50b0fd69a
# bad: [033a94412b6065a21c2ede2f37867e747a84563f] Merge tag 'livepatching-for-5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/livepatching/livepatching
git bisect bad 033a94412b6065a21c2ede2f37867e747a84563f
# good: [8d9420ca9bd9bceddcfab3d0263d6a8e073396fe] Merge tag 'for-linus-2022080201' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect good 8d9420ca9bd9bceddcfab3d0263d6a8e073396fe
# bad: [746fc76b820dce8cbb17a1e5e70a1558db4d7406] Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
git bisect bad 746fc76b820dce8cbb17a1e5e70a1558db4d7406
# good: [31be1d0fbd950395701d9fd47d8fb1f99c996f61] Merge tag 'dmaengine-6.0-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine
git bisect good 31be1d0fbd950395701d9fd47d8fb1f99c996f61
# good: [328141e51e6fc79d21168bfd4e356dddc2ec7491] Merge tag 'mmc-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect good 328141e51e6fc79d21168bfd4e356dddc2ec7491
# good: [90c3ca3f247d1a95fc47232e9f0aef114becd605] scsi: mpt3sas: Remove flush_scheduled_work() call
git bisect good 90c3ca3f247d1a95fc47232e9f0aef114becd605
# bad: [c641ffdb5904df0dc249ef3f2d753e2a684779c6] scsi: ufs: core: Remove UIC_HIBERN8_ENTER_RETRIES
git bisect bad c641ffdb5904df0dc249ef3f2d753e2a684779c6
# good: [a2417db3679cffa67fbdc6c175cf68ffc86b8ac3] scsi: core: Shorten long warning messages
git bisect good a2417db3679cffa67fbdc6c175cf68ffc86b8ac3
# good: [fce54ed027577517df1e74b7d54dc2b1bd536887] scsi: hisi_sas: Limit max hw sectors for v3 HW
git bisect good fce54ed027577517df1e74b7d54dc2b1bd536887
# bad: [2f67dc7970bce3529edce93a0a14234d88b3fcd5] scsi: lpfc: Fix possible memory leak when failing to issue CMF WQE
git bisect bad 2f67dc7970bce3529edce93a0a14234d88b3fcd5
# bad: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi: sd: Rework asynchronous resume support
git bisect bad 88f1669019bd62b3009a3cebf772fbaaa21b9f38
# good: [158da6bcae7a66e631bbec458f35ea3bd0ac5d71] scsi: gvp11: Convert m68k WD33C93 drivers to DMA API
git bisect good 158da6bcae7a66e631bbec458f35ea3bd0ac5d71
# good: [90552cd2d1f962478f1bb426c686540cbd145bec] scsi: core: Move the definition of SCSI_QUEUE_DELAY
git bisect good 90552cd2d1f962478f1bb426c686540cbd145bec
# first bad commit: [88f1669019bd62b3009a3cebf772fbaaa21b9f38] scsi: sd: Rework asynchronous resume support

Crusty ole (but still loved;) box...

hwinfo --short:
cpu:
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3633 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3800 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3740 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3708 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3885 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 800 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 3688 MHz
                       Intel(R) Core(TM) i7-4790 CPU @ 3.60GHz, 800 MHz
keyboard:
                       Logitech Unifying Receiver
  /dev/input/event2    GreenAsia USB to PS/2 Adapter
  /dev/tty7            serial console
mouse:
                       Logitech Unifying Receiver
  /dev/input/mice      GreenAsia USB to PS/2 Adapter
printer:
                       Samsung Electronics SCX-4300 Series
monitor:
                       PHILIPS PHL 273V5
graphics card:
                       nVidia GM204 [GeForce GTX 980]
sound:
                       Intel 8 Series/C220 Series Chipset High Definition Audio Controller
                       nVidia GM204 High Definition Audio Controller
storage:
                       Intel 8 Series/C220 Series Chipset Family 6-port SATA Controller 1 [AHCI mode]
network:
  eth0                 Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
network interface:
  eth0                 Ethernet network interface
  br0                  Ethernet network interface
  lo                   Loopback network interface
disk:
  /dev/sdf             Generic Multi-Card
  /dev/sdd             WDC WD10EZEX-00B
  /dev/sdb             Samsung SSD 860
  /dev/sde             Samsung Portable SSD T5
  /dev/sdc             WDC WD10EZEX-00B
  /dev/sda             A SP900
                       Samsung Electronics Portable SSD T5
partition:
  /dev/sdd1            Partition
  /dev/sdd2            Partition
  /dev/sdb1            Partition
  /dev/sdb2            Partition
  /dev/sdb3            Partition
  /dev/sde1            Partition
  /dev/sde2            Partition
  /dev/sde3            Partition
  /dev/sdc1            Partition
  /dev/sdc2            Partition
  /dev/sdc3            Partition
  /dev/sda1            Partition
  /dev/sda2            Partition
  /dev/sda3            Partition
  /dev/sda4            Partition
  /dev/sda5            Partition
  /dev/sda6            Partition
usb controller:
                       Intel 8 Series/C220 Series Chipset Family USB EHCI #2
                       Intel 8 Series/C220 Series Chipset Family USB EHCI #1
                       Intel 8 Series/C220 Series Chipset Family USB xHCI
bios:
                       BIOS
bridge:
                       Intel 8 Series/C220 Series Chipset Family PCI Express Root Port #1
                       Intel H81 Express LPC Controller
                       Intel Xeon E3-1200 v3/4th Gen Core Processor PCI Express x16 Controller
                       Intel 4th Gen Core Processor DRAM Controller
                       Intel 8 Series/C220 Series Chipset Family PCI Express Root Port #3
hub:
                       Intel Integrated Rate Matching Hub
                       Linux Foundation 2.0 root hub
                       Linux Foundation 3.0 root hub
                       Linux Foundation 2.0 root hub
                       Intel Integrated Rate Matching Hub
                       Linux Foundation 2.0 root hub
memory:
                       Main Memory
unknown:
                       FPU
                       DMA controller
                       PIC
                       Keyboard controller
                       PS/2 Controller
                       Intel 8 Series/C220 Series Chipset Family MEI Controller #1
                       Intel 8 Series/C220 Series Chipset Family SMBus Controller
                       Logitech Unifying Receiver
                       Samsung Electronics SCX-4300 Series

