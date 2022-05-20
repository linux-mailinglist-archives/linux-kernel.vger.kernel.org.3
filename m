Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFD52F0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351774AbiETQnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiETQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:43:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57B7117855A;
        Fri, 20 May 2022 09:43:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 077B91477;
        Fri, 20 May 2022 09:43:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.7.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF25E3F73D;
        Fri, 20 May 2022 09:43:30 -0700 (PDT)
Date:   Fri, 20 May 2022 17:43:26 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        tglx@linutronix.de, maz@kernel.org, axboe@kernel.dk,
        rafael@kernel.org, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-mm@kvack.org, len.brown@intel.com,
        pavel@ucw.cz, paulmck@kernel.org, bp@suse.de,
        keescook@chromium.org, songmuchun@bytedance.com,
        rdunlap@infradead.org, damien.lemoal@opensource.wdc.com,
        pasha.tatashin@soleen.com, tabba@google.com, ardb@kernel.org,
        tsoni@quicinc.com, quic_psodagud@quicinc.com,
        quic_svaddagi@quicinc.com
Subject: Re: [RFC 0/6] Bootloader based hibernation
Message-ID: <YofFLih8LML9U5rc@FVFF77S0Q05N>
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 18, 2022 at 01:18:35PM +0530, Vivek Kumar wrote:
> Kernel Hibernation
> 
> Linux Kernel has been already supporting hibernation, a process which
> involves freezing of all userspace tasks, followed by quiescing of all
> kernel device drivers and then a DDR snapshot is taken which is saved
> to disc-swap partition, after the save, the system can either shutdown
> or continue further. Generally during the next power cycle when kernel
> boots and after probing almost all of the drivers, in the late_init()
> part, it checks if a hibernation image is present in the specified swap
> slot, if a valid hibernation image is found, it superimposes the currently
> executing Kernel with an older kernel from the snapshot, moving further,
> it calls the restore of the drivers and unfreezes the userspace tasks.
> CONFIG_HIBERNATION and a designated swap partition needs to be present
> for to enable Hibernation.
> 
> Bootloader Based Hibernation:
> 
> Automotive usecases require better boot KPIs, Hence we are proposing a
> bootloader based hibernation restore.

At a high-level, I'm not a fan of adding new ways to enter the kernel, and for
the same reasons that the existing hibernate handover is deliberately *not* a
stable ABI, I don't think we should add an ABI for this. This is not going to
remain maintainable or compatible over time as the kernel evolves.

> Purpose of bootloader based hibernation is to improve the overall boot time
> till the first display frame is seen on the screen or a camera application
> can be launched from userspace after the power on reset key is pressed.

Can you break down the time taken for that today?

What does a cold boot look like?

What *exactly* are you trying to skip by using hibernation?

Thanks,
Mark.

> This RFC patchset
> implements a slightly tweaked version of hibernation in which the
> restoration of an older snapshot into DDR is being carried out from the
> bootloader (ABL) itself, by doing this we are saving some time
> (1 second measured on msm-4.14 Kernel) by not running a
> temporary kernel and figuring out the hibernation image at late_init().
> In order to achieve the same bootloader checks for the hibernation
> image at a very early stage from swap partition, it parses the image and
> loads it in the DDR instead of loading boot image form boot partition.
> Since we are not running the temporary kernel,which would have done some
> basic ARM related setup like, MMU enablement, EL2 setup, CPU setup etc,
> entry point into hibernation snapshot image directly from bootloader is
> different, on similar lines, all device drivers are now re-programming
> the IO-mapped registers as part of the restore callback (which is
> triggered from the hibernation framework) to bring back the HW/SW sync.
> 
> Other factors like, read-speed of the secondary storage device and
> organization of the hibernation image in the swap partition effects the
> total image restore time and the overall boot time. In our current
> implementation we have serialized the allocation of swap-partition's slots
> in kernel, so when hibernation image is being saved to disc, each page is
> not scattered across various swap-slot offsets, rather it in a serial
> manner. For example, if a DDR page at Page frame number 0x8005 is
> located at a swap-slot offset 50, the next valid DDR page at PFN 0x8005
> will be preset at the swap-slot offset 51. With this optimization in
> place, bootloader can utilize the max capacity of issuing a disc-read
> for reading a bigger chunk (~50 MBs at once) from the swap slot,
> and also parsing of the image becomes simpler as it is available
> contiguously.
> 
> 
> 
> Vivek Kumar (6):
>   arm64: hibernate: Introduce new entry point to kernel
>   PM: Hibernate: Add option to disable disk offset randomization
>   block: gendisk: Add a new genhd capability flag
>   mm: swap: Add randomization check for swapon/off calls
>   Hibernate: Add check for pte_valid in saveable page
>   irqchip/gic-v3: Re-init GIC hardware upon hibernation restore
> 
>  Documentation/admin-guide/kernel-parameters.txt |  11 ++
>  arch/arm64/kernel/hibernate.c                   |   9 ++
>  drivers/irqchip/irq-gic-v3.c                    | 138 ++++++++++++++++-
>  include/linux/blkdev.h                          |   1 +
>  kernel/power/snapshot.c                         |  43 ++++++++
>  kernel/power/swap.c                             |  12 +++
>  mm/swapfile.c                                   |   6 +-
>  7 files changed, 216 insertions(+), 4 deletions(-)
> 
> -- 
> 2.7.4
> 
