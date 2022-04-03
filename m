Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBBD4F0CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 00:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376525AbiDCWQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 18:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiDCWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 18:16:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6B03982E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 15:14:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z12so13985307lfu.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=x7lM774TBGSC83ZunTZ4B/iiv0KPLUJ8vFO7IFNblXo=;
        b=cDH0fcGNkUdygBV0T7ufcvG+sPCtW7CBTFOkfFjeW97kCMzgLP74eLbAr3ubJV/Syb
         YdAsdkULMPs2JyLVPhmNI51Ou1f/Nc5ZNPd+LhEhsc605hwnKfKEulX5/8ZcPIKErmke
         iqMeqHA3HKbROo0cra93PMoKV6hhqwF8APZ2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=x7lM774TBGSC83ZunTZ4B/iiv0KPLUJ8vFO7IFNblXo=;
        b=JbtTiPWsULEtkWrQeeTEjS6k1qcMk/1jgo88HCaiqVVOOY2hk+fXCJewndT9F1XADX
         hOUAJ5MkNjvi/ClkZwLFG5+I4qsNaJDqvRERj82tZ7z99CHrrZOPLuLadHmGV9pc/cqw
         Y1dj2s8ZOkBpU0Aj+GpKd1xbc+mx529parHYDJ2m3YbiAD4a/IcG8NSLg81tc/zTn62w
         F2cfSGerjZWXEpLU5pL/QXTWHXTdwBVInkw8d8GFheRE13yoP9dmYoxCc7817Z3geURN
         mJvzebkyO5zhZqbmVtklN8KTlQkjZT8XeWHeVOFfQsEZNqdUX+j//89O/L5BsqHGBkul
         CzYA==
X-Gm-Message-State: AOAM5317OsXEPOTbZF8U5AsBgKkcnxYXevlLTxUikg3hX4Mzmjvsh/69
        3O96Ft9ZEb2GtLUIT3RwYbXjPjlCWqpksQYR
X-Google-Smtp-Source: ABdhPJzDZoMjNp++cncJ6epmRfMwNrraiQcF2hjxa8Uhi4GHb0NcX2EVkUIja+M/0GzqXONCvhNM8Q==
X-Received: by 2002:ac2:4194:0:b0:442:ed9e:4a25 with SMTP id z20-20020ac24194000000b00442ed9e4a25mr19843303lfh.629.1649024077154;
        Sun, 03 Apr 2022 15:14:37 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h14-20020a05651c158e00b00247fda7844dsm877782ljq.90.2022.04.03.15.14.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 15:14:36 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 5so14056069lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 15:14:36 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr20547287lfb.435.1649024076113; Sun, 03
 Apr 2022 15:14:36 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Apr 2022 15:14:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
Message-ID: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
Subject: Linux 5.18-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, two weeks later, and the merge window is closed.

The full diffstat isn't useful, because this is another of those
occasional releases where the AMD drm driver adds those generated
register definitions, so the diff is absolutely dominated by register
definitions for DCN 3.1.x and MP 13.0.x register definitions. Don't
even go look - you'll go blind.

Another fairly big chunk of it (but nowhere _near_ the AMD GPU
register definitions) is the updates for various Intel performance
monitoring event tables.

But if you ignore those two areas, things look fairly normal. At that
point, it's about 60%driver updates - with GPU updates are still
fairly sizable, but now no longer so dominant as to hide everything
else. And all the other usual suspects too: networking, sound, media,
scsi, pinctrl, clk, etc..

The rest is fairly spread out  documentation and devicetree bindings
(maybe I should just count that against drivers), architecture updates
(biggest part of the diff: nds32 is gone, but there's all the usual
x86, arm, arm64, powerpc, parisc, mips and riscv updates). Tooling
updates (perf and selftests), and of course all the core kernel
updates (filesystem, core, networking, VM).

As always, there's _way_ too many changes to list individually, and
you're just getting the usual mergelog appended.

In fact, at least in pure commits, this has been a bigger merge window
than we've had in some time. But let's hope it's all smooth sailing
this release.

Sure, that will happen.

Go test, please,
              Linus

---

Al Viro (1):
    vfs updates

Alex Williamson (1):
    VFIO updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (2):
    iomap fixlet
    gfs2 fixes

Andrew Morton (4):
    updates
    more updates
    yet more updates
    still more updates

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tools updates

Arnd Bergmann (6):
    asm-generic updates
    ARM defconfig updates
    ARM SoC updates
    ARM driver updates
    ARM devicetree updates
    ARM SoC fixes

Bartosz Golaszewski (2):
    gpio updates
    gpio fixes

Benson Leung (1):
    chrome platform updates

Bjorn Andersson (3):
    rpmsg updates
    hwspinlock updates
    remoteproc updates

Bjorn Helgaas (2):
    pci updates
    pci fix

Borislav Petkov (10):
    EDAC updates
    x86 cpu feature updates
    misc x86 updates
    x86 Kconfig fix
    x86 paravirt improvement
    x86 SEV fix
    x86 SGX updates
    x86 confidential computing updates
    x86 cleanups
    RAS updates

Brian Cain (1):
    hexagon update

Casey Schaufler (1):
    smack update

Christian Brauner (2):
    mount_setattr updates
    mount attributes PREEMPT_RT update

Christoph Hellwig (2):
    dma-mapping updates
    more dma-mapping updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI updates

Damien Le Moal (1):
    ata updates

Dan Williams (3):
    CXL (Compute Express Link) updates
    DAX updates
    libnvdimm updates

Daniel Thompson (1):
    kgdb update

Darrick Wong (3):
    xfs updates
    xfs fixes
    vfs fix

Dave Airlie (2):
    drm updates
    drm fixes

Dave Kleikamp (1):
    jfs updates

David Howells (2):
    watch_queue fixes
    netfs updates

David Sterba (1):
    btrfs updates

Dmitry Torokhov (1):
    input updates

Eric Biederman (3):
    tasklist_lock optimizations
    shm ucounts fix
    ptrace cleanups

Eric Biggers (1):
    fscrypt updates

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (5):
    USB/Thunderbolt updates
    char/misc and other driver updates
    driver core updates
    staging driver updates
    tty/serial driver updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Gustavo Silva (1):
    flexible-array transformations

Hans de Goede (1):
    x86 platform driver updates

Helge Deller (3):
    parisc architecture updates
    fbdev updates
    more parisc architecture updates

Herbert Xu (2):
    crypto updates
    crypto fixes

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (3):
    x86 perf event updates
    locking updates
    scheduler updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (3):
    networking updates
    networking fixes
    more networking updates

James Bottomley (1):
    SCSI updates

Jan Kara (2):
    fsnotify updates
    reiserfs updates

Jarkko Sakkinen (1):
    tpm updates

Jason Donenfeld (2):
    random number generator updates
    random number generator fixes

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (12):
    io_uring updates
    io_uring statx fixes
    block updates
    block driver updates
    bio_alloc() cleanups
    NVMe write streams removal
    bio allocation fix
    block layer 64-bit data integrity support
    io_uring fixes
    block fixes
    block driver fixes
    block driver fix

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

Jonathan Corbet (2):
    documentation updates
    more documentation updates

Juergen Gross (1):
    xen updates

Kees Cook (8):
    execve updates
    pstore updates
    kernel hardening updates
    overflow updates
    bounds fixes
    FORTIFY_SOURCE updates
    array-bounds updates
    hardening updates

Lee Jones (2):
    MFD updates
    backlight updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    module update

Mark Brown (4):
    regmap updates
    regulator updates
    spi updates
    regulator fixes

Masahiro Yamada (3):
    Kbuild update for C11 language base
    Kbuild updates
    Kbuild fixes

Matthew Wilcox (4):
    folio updates
    filesystem folio updates
    XArray updates
    more filesystem folio updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    Xtensa updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    landlock updates

Miguel Ojeda (1):
    auxdisplay updates

Mike Rapoport (1):
    memblock updates

Mike Snitzer (2):
    device mapper updates
    device mapper fixes

Mimi Zohar (1):
    integrity subsystem updates

Miquel Raynal (1):
    MTD updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (3):
    RISC-V updates
    more RISC-V updates
    RISC-V fix

Paolo Bonzini (2):
    kvm updates
    kvm fixes

Paul McKenney (2):
    RCU updates
    memory model doc update

Paul Moore (2):
    selinux updates
    audit update

Pavel Machek (1):
    LED updates

Peter Zijlstra (1):
    x86 CET-IBT (Control-Flow-Integrity) support

Petr Mladek (2):
    printk updates
    livepatching updates

Rafael Wysocki (7):
    ACPI updates
    power management updates
    thermal control updates
    PnP update
    more power management updates
    device properties code update
    more ACPI updates

Richard Weinberger (2):
    JFFS2, UBI and UBIFS updates
    UML updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (3):
    ARM updates
    ARM updates
    ARM fixes

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    Kselftest updates
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (2):
    clk updates
    clk fix

Steve French (3):
    cfis updates
    more cifs updates
    ksmbd updates

Steven Rostedt (4):
    RTLA tracing tool updates
    tracing updates
    trace event string verifier fix
    more tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    workqueue updates
    cgroup updates

Tetsuo Handa (1):
    tomoyo update

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (2):
    MIPS updates
    MIPS fixes

Thomas Gleixner (6):
    x86 PASID support
    core process handling RT latency updates
    timer and timekeeping updates
    interrupt updates
    RT signal fix
    x86 fixes

Trond Myklebust (1):
    NFS client updates

Ulf Hansson (1):
    MMC updates

Vasily Gorbik (2):
    s390 updates
    more s390 updates

Vinod Koul (1):
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Will Deacon (1):
    arm64 updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates
