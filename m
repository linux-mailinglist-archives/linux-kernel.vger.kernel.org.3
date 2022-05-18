Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C359152B3D2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiERHtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiERHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:49:03 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA26C16594;
        Wed, 18 May 2022 00:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652860143; x=1684396143;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FFmn27BmEvRPFt+EeFCTjSFHWGKsjOHO+ZSlgAAGdKc=;
  b=sZn14dB8UT/oGLlyxLJGmK08ERAcPVTV5z4exdmaGvvz8NXHHPPMFrwy
   9CEHmkmo8g25qi3FqPVE1e57SkNLByBmDqWXX6qtGAUn84jL205ei318h
   ep9WBr4CRyvyO3IPpD4bfzyd9PK8dGBnC5y7yf6hDbQoK3/y3zP0gkjcq
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 00:49:02 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 00:49:01 -0700
Received: from blr-ubuntu-185.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 00:48:52 -0700
From:   Vivek Kumar <quic_vivekuma@quicinc.com>
To:     <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <axboe@kernel.dk>,
        <rafael@kernel.org>, <akpm@linux-foundation.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mm@kvack.org>
CC:     <len.brown@intel.com>, <pavel@ucw.cz>, <paulmck@kernel.org>,
        <bp@suse.de>, <keescook@chromium.org>, <songmuchun@bytedance.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <pasha.tatashin@soleen.com>, <tabba@google.com>, <ardb@kernel.org>,
        <tsoni@quicinc.com>, <quic_psodagud@quicinc.com>,
        <quic_svaddagi@quicinc.com>,
        Vivek Kumar <quic_vivekuma@quicinc.com>
Subject: [RFC 0/6] Bootloader based hibernation
Date:   Wed, 18 May 2022 13:18:35 +0530
Message-ID: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel Hibernation

Linux Kernel has been already supporting hibernation, a process which
involves freezing of all userspace tasks, followed by quiescing of all
kernel device drivers and then a DDR snapshot is taken which is saved
to disc-swap partition, after the save, the system can either shutdown
or continue further. Generally during the next power cycle when kernel
boots and after probing almost all of the drivers, in the late_init()
part, it checks if a hibernation image is present in the specified swap
slot, if a valid hibernation image is found, it superimposes the currently
executing Kernel with an older kernel from the snapshot, moving further,
it calls the restore of the drivers and unfreezes the userspace tasks.
CONFIG_HIBERNATION and a designated swap partition needs to be present
for to enable Hibernation.

Bootloader Based Hibernation:

Automotive usecases require better boot KPIs, Hence we are proposing a
bootloader based hibernation restore. Purpose of bootloader based
hibernation is to improve the overall boot time till the first display
frame is seen on the screen or a camera application can be launched from
userspace after the power on reset key is pressed. This RFC patchset
implements a slightly tweaked version of hibernation in which the
restoration of an older snapshot into DDR is being carried out from the
bootloader (ABL) itself, by doing this we are saving some time
(1 second measured on msm-4.14 Kernel) by not running a
temporary kernel and figuring out the hibernation image at late_init().
In order to achieve the same bootloader checks for the hibernation
image at a very early stage from swap partition, it parses the image and
loads it in the DDR instead of loading boot image form boot partition.
Since we are not running the temporary kernel,which would have done some
basic ARM related setup like, MMU enablement, EL2 setup, CPU setup etc,
entry point into hibernation snapshot image directly from bootloader is
different, on similar lines, all device drivers are now re-programming
the IO-mapped registers as part of the restore callback (which is
triggered from the hibernation framework) to bring back the HW/SW sync.

Other factors like, read-speed of the secondary storage device and
organization of the hibernation image in the swap partition effects the
total image restore time and the overall boot time. In our current
implementation we have serialized the allocation of swap-partition's slots
in kernel, so when hibernation image is being saved to disc, each page is
not scattered across various swap-slot offsets, rather it in a serial
manner. For example, if a DDR page at Page frame number 0x8005 is
located at a swap-slot offset 50, the next valid DDR page at PFN 0x8005
will be preset at the swap-slot offset 51. With this optimization in
place, bootloader can utilize the max capacity of issuing a disc-read
for reading a bigger chunk (~50 MBs at once) from the swap slot,
and also parsing of the image becomes simpler as it is available
contiguously.



Vivek Kumar (6):
  arm64: hibernate: Introduce new entry point to kernel
  PM: Hibernate: Add option to disable disk offset randomization
  block: gendisk: Add a new genhd capability flag
  mm: swap: Add randomization check for swapon/off calls
  Hibernate: Add check for pte_valid in saveable page
  irqchip/gic-v3: Re-init GIC hardware upon hibernation restore

 Documentation/admin-guide/kernel-parameters.txt |  11 ++
 arch/arm64/kernel/hibernate.c                   |   9 ++
 drivers/irqchip/irq-gic-v3.c                    | 138 ++++++++++++++++-
 include/linux/blkdev.h                          |   1 +
 kernel/power/snapshot.c                         |  43 ++++++++
 kernel/power/swap.c                             |  12 +++
 mm/swapfile.c                                   |   6 +-
 7 files changed, 216 insertions(+), 4 deletions(-)

-- 
2.7.4

