Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B79E252C0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbiERQ4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240630AbiERQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:55:58 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C491900A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:55:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so4971040ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RcN5J0ur4waoOrpP5dEneSJvtTucrgzrBX0vuvDNzg=;
        b=jqT/3rdeSfMtEpH8kcA4/nn+EfeZSUuf8LPPqhLKI9etfw6hQt/jE/5RB9+wAn7N+Z
         Ehawr2Lnj8Xy/V9rEAUasHDJAEfZoSITtIIF1X9hmH3oDXIBNzCPI0/8wWj68x+PdNBs
         CYcJUtEpJeYfXt4e7pO3nCwPPYgiL7h53DO5Fuujh2Y6lzOqlHXACtVhqvzimDu3Oual
         tfhtqDL4wOAzaNxnKSix47hX+w5GxeHrTuVV+uT6Gaq249kr69g+Sjjj703raStyIOke
         zlWbjfU2A5GEbVZtSf4efh8q1kIlRtND9i+ESBSanFHpCYBuGyVgZ0dkOIm+//g3Sp7O
         /xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RcN5J0ur4waoOrpP5dEneSJvtTucrgzrBX0vuvDNzg=;
        b=VUbKK93uqGZhj/+EanO5kNPAjpaaykEQ2g69pn/5wigD0hL7EB2K9uHiAzlWx+IXbK
         sb/ds1r1y3XTqTtgDzJJ5/f193rsUv5+HiY09MLJYW5hBFFFPpUQfAhPNYDmwEMfEiaX
         CkMdTuMP6NP+CrBaucEEo5e20gksEpbqWW4M9ZWNRu7mvhq+RtPH1pwFsTxUS9jAIrTZ
         WZT2ipww3BBX9h8HKIPZKOXxIMaqEhWEAYQENJw4mc1SA2DJ7Bxzt/1cFg0YVq2wz3e+
         Ct4yN1cost0V4ijTqVyDF1swkCjFPTu8qvqb/JblPv6Hv365di69OIIzn6PUF8ShRTRv
         YMzg==
X-Gm-Message-State: AOAM5329/k30hDGWVDX0EOMHI/UgCRZOoUfg5nWyYjdDA6AbFEbE5cq5
        bhWa/Z3FJ3KQwB2ISgLb9Hxil8HbDBeqSvA3mPUpAA==
X-Google-Smtp-Source: ABdhPJzoDOL5onqSCpBWW4lu7fFIE11dPS6M11PWkiCu5oUw/XsvL6IBRO8qySJCvzfyvrHLY+M/j+7SW0BKghv5pwQ=
X-Received: by 2002:a17:907:1c8a:b0:6e9:2a0d:d7b7 with SMTP id
 nb10-20020a1709071c8a00b006e92a0dd7b7mr479411ejc.572.1652892954798; Wed, 18
 May 2022 09:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
In-Reply-To: <1652860121-24092-1-git-send-email-quic_vivekuma@quicinc.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 18 May 2022 12:55:18 -0400
Message-ID: <CA+CK2bDDphX6ANu_=8SPTy7gbB5aajtE3uVLGZrpaczZQKw4QA@mail.gmail.com>
Subject: Re: [RFC 0/6] Bootloader based hibernation
To:     Vivek Kumar <quic_vivekuma@quicinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        len.brown@intel.com, Pavel Machek <pavel@ucw.cz>,
        paulmck@kernel.org, Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        damien.lemoal@opensource.wdc.com, Fuad Tabba <tabba@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, tsoni@quicinc.com,
        quic_psodagud@quicinc.com, quic_svaddagi@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivek,

Interesting stuff.

On Wed, May 18, 2022 at 3:49 AM Vivek Kumar <quic_vivekuma@quicinc.com> wrote:
>
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
> bootloader based hibernation restore. Purpose of bootloader based
> hibernation is to improve the overall boot time till the first display
> frame is seen on the screen or a camera application can be launched from
> userspace after the power on reset key is pressed. This RFC patchset
> implements a slightly tweaked version of hibernation in which the
> restoration of an older snapshot into DDR is being carried out from the
> bootloader (ABL) itself, by doing this we are saving some time
> (1 second measured on msm-4.14 Kernel) by not running a
> temporary kernel and figuring out the hibernation image at late_init().

I wonder where most of the time is spent? Is it initializing struct
pages? Potentially we could enlighten bootloader to determine whether
hibernation image is stored or not on the swap device, and change boot
parameter for the kernel accordingly. The booting kernel would know
from the very beginning of boot that it will eventually resume a
hibernated image, and therefore skip some of initilization parts, and
perhaps limit amount of memory that it initializes.

> In order to achieve the same bootloader checks for the hibernation
> image at a very early stage from swap partition, it parses the image and
> loads it in the DDR instead of loading boot image form boot partition.
> Since we are not running the temporary kernel,which would have done some
> basic ARM related setup like, MMU enablement, EL2 setup, CPU setup etc,

What boot loader is used? I suspect bootloader enables MMU to load the
hibernated image into memory, otherwise the performance would be very
poor. After the image is loaded, and prior to jumping into the entry
address of loaded image the MMU is probably disabled.

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

This optimization seems generic enough that it would benefit both
types of resume: from bootloader and from kernel.

Thanks,
Pasha

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
