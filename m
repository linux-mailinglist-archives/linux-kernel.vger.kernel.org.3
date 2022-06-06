Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C4453DF1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351880AbiFFAmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 20:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351840AbiFFAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 20:42:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2455422B35
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 17:42:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v19so16782251edd.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 17:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I7xCsl+LsrWw/kJQv30wr9Ryoz1F7lkRXyZdtKnCpm0=;
        b=LdZXB4ad8APxIdK/VzYw9XHEaeflm4L67/zsWh/Ylx5NWpNB0PMLIDTdn5HF4O6bBv
         AOV4tB7glRUd7Fu/cL6rLvJUSR4D5FExMc+Xx2oqhml7ZqfxeDVDtIwoaqoBUb3W5Kxz
         JjFCJWg9Bb/z8nqHcd1yRCkm3pi3TwQs3DSA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I7xCsl+LsrWw/kJQv30wr9Ryoz1F7lkRXyZdtKnCpm0=;
        b=0iX0NlDCopzczkBlRLrUlI1HD3vyELZaWv8bmfK1xU2kwbDtRjgW3gtWY0xWtb5DSY
         IK5DuK0U3kTMQ7utJrTTVSvOT7n/tdqsbhyQVU3FmsGYZBcxM18WRs00vTJZwSAOTmXI
         8d4gBY9W29jQxiIquUyDijiu++RtMrk7dfnYd4XIocbPx7/9rbziL4K6ZdXq2NDyutIH
         MZIWNiPe3aYPyebKjGVrWghuG/Ph6DyVGq4LQik8ZnadKrg9vBzgSIT9Ncixelq+Qaf5
         7G0Kvap1kS0xv4OlL3mS409pMi2TPcqLBUGTfl7uTJ3f9yf7D+BUX2fZvIj+qzsySb2c
         +kqQ==
X-Gm-Message-State: AOAM53345TZa91GcFCPxMv2DZzFs9jGlYy33ZjgestUgJ8BXStoXQ6li
        NXl8i4V3WJm6tKhWB5LBwld8EYjb2gNmpT23XuM=
X-Google-Smtp-Source: ABdhPJxUp4lM0cOtHQLjfRXG5x8KYKo9YEol0mjVRwUgyEynFSLF5VUX9L0gOjBHlaan72wE9WM3jA==
X-Received: by 2002:aa7:c44b:0:b0:42d:d107:7e7a with SMTP id n11-20020aa7c44b000000b0042dd1077e7amr23650186edr.261.1654476170388;
        Sun, 05 Jun 2022 17:42:50 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id y17-20020a170906525100b006ff9e36cfeesm5587603ejm.196.2022.06.05.17.42.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 17:42:50 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h5so17860066wrb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 17:42:49 -0700 (PDT)
X-Received: by 2002:a5d:6da6:0:b0:20f:bc8a:9400 with SMTP id
 u6-20020a5d6da6000000b0020fbc8a9400mr18763663wrs.274.1654476169406; Sun, 05
 Jun 2022 17:42:49 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 17:42:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
Message-ID: <CAHk-=wgZt-YDSKfdyES2p6A_KJoG8DwQ0mb9CeS8jZYp+0Y2Rw@mail.gmail.com>
Subject: Linux 5.19-rc1
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

So the last two weeks were _fairly_ normal, although I will gripe and
moan a bit about how many late pull requests I got. The second week
started out very calm, but that was sadly only because a _lot_ of
people left their final pull request pretty late. Not very pleasant at
all.

But what does make me pretty pleased is that pretty much all of the
pull requests were signed tags. I still don't technically _require_
signatures for pulls from kernel.org, but I've been (not very subtly)
encouraging people to use them, and we're getting there. It's just
good hygiene.

And to cap off the good news, this is the first merge window when
Andrew participated all through git, and the first time in basically
Linux history when I didn't have a single patch-bomb to apply (I still
do individual random patches, and expect to always do them, but no
more "big series of raw patches").

So on the whole it's all very good.

Anyway, apart from those three "process" issues, things look perfectly
normal. Judging by the merge window, this release is going to be on
the bigger side, but certainly not breaking any records, and nothing
looks particularly odd or crazy. The diffstat is skewed by yet another
drop of generated AMD GPU register descriptor headers, but I guess
even that is "normal" by now. Certainly not a new thing. And if you
ignore that drivers/gpu/drm/amd/include/ subdirectory, the stats look
like they tend to do: roughly 60% drivers,  with the rest being
architecture updates, tooling, documentation and some relatively minor
core kernel updates (filesystems, mm, networking etc. Oh, and the core
module handling got split up into more manageable pieces rather than
one big file).

One thing of note is how the long-time ARM generic kernel work (aka
"multiplatform") is pretty much done after 10+ years. Congrats to
everybody involved. The StrongARM platforms remain with their separate
kernels, and are expected to stay so, but compared to where things
were a decade ago, this is a pretty big step.

So hey, let's start calming things down and testing this all.

                      Linus

---

 Luis Chamberlain (1):
    modules updates

Al Viro (4):
    file descriptor updates
    mount handling updates
    vfs pathname updates
    file descriptor fix

Alex Williamson (1):
    vfio updates

Alexandre Belloni (2):
    i3c updates
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (6):
    MM updates
    misc updates
    hotfixes
    more MM updates
    delay-accounting update
    mm hotfixes

Anna Schumaker (1):
    NFS client updates

Ard Biesheuvel (2):
    EFI updates
    more EFI updates

Arnaldo Carvalho de Melo (3):
    perf tool updates
    more perf tools updates
    more perf tools updates

Arnd Bergmann (11):
    32-bit ARM SoC updates
    ARM DT updates
    ARM driver updates
    ARM defconfig updates
    ARMv4T/v5 multiplatform support
    asm-generic updates
    more ARM multiplatform updates
    more ARM SoC updates
    asm-generic fixes
    initial Loongarch architecture code
    yet more ARM multiplatform updates

Bartosz Golaszewski (2):
    gpio updates
    gpio fixes

Bjorn Andersson (2):
    remoteproc updates
    rpmsg updates

Bjorn Helgaas (2):
    pci updates
    pci fixes

Borislav Petkov (18):
    EDAC updates
    AMD SEV-SNP support
    x86 RAS updates
    Intel TDX support
    x86 CPU feature updates
    x86 asm updates
    x86 build updates
    x86 cleanups
    core x86 updates
    x86 fpu updates
    x86 mm fixlet
    x86 platform updates
    x86 kdump fixlet
    x86 APIC updates
    x86 splitlock updates
    misc x86 updates
    x86 microcode loader update
    x86 vdso update

Casey Schaufler (1):
    smack update

Catalin Marinas (2):
    arm64 updates
    arm64 fixes

Christian Brauner (1):
    fs idmapping updates

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Corey Minyard (1):
    IPMI update

Damien Le Moal (3):
    ata updates
    zonefs updates
    zonefs fix

Dan Williams (2):
    libnvdimm and DAX updates
    cxl updates

Darrick Wong (1):
    iomap updates

Dave Airlie (2):
    drm updates
    more drm updates

Dave Chinner (2):
    xfs updates
    more xfs updates

Dave Hansen (1):
    x86 SGX updates

David Kleikamp (1):
    jfs updates

David Sterba (1):
    btrfs updates

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominik Brodowski (1):
    pcmcia updates

Eric Biederman (3):
    ipc sysctl namespace updates
    kthread updates
    ptrace_stop cleanups

Eric Biggers (2):
    fscrypt updates
    fsverity updates

Gao Xiang (2):
    erofs (and fscache) updates
    more erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    SPDX updates
    staging driver updates
    tty and serial driver updates
    USB / Thunderbolt updates
    char / misc / other smaller driver subsystem updates
    driver core updates

Greg Ungerer (1):
    m68knommu updates

Guenter Roeck (1):
    hwmon updates

Guo Ren (1):
    arch/csky updates

Gustavo Silva (3):
    Wstringop-overflow fixes
    misc hardening updates
    checkpatch update

Hans de Goede (1):
    x86 platform driver updates

Heiko Carstens (2):
    s390 updates
    more s390 updates

Helge Deller (3):
    parisc architecture updates
    fbdev fixes and updates
    more parisc architecture updates

Herbert Xu (1):
    crypto updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (4):
    locking updates
    objtool updates
    perf events updates
    scheduler updates

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (2):
    networking updates
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    writeback and ext2 cleanups
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Donenfeld (1):
    random number generator updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jens Axboe (13):
    io_uring updates
    io_uring xattr support
    io_uring socket() support
    io_uring 'more data in socket' support
    io_uring NVMe command passthrough
    writeback fix
    cdrom updates
    block updates
    block driver updates
    more io_uring updates
    block fixes
    block request execute cleanups
    more block driver updates

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

Jonathan Corbet (2):
    documentation updates
    documentation fixes

Juergen Gross (2):
    xen updates
    more xen updates

Kees Cook (4):
    kernel hardening updates
    seccomp updates
    execve updates
    kernel hardening fix

Konstantin Komarov (1):
    ntfs3 updates

Lee Jones (1):
    MFD updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (1):
    sysctl updates

Mark Brown (5):
    regmap updates
    regulator updates
    spi updates
    spi fixes
    regulator fix

Masahiro Yamada (2):
    Kbuild updates
    more Kbuild updates

Matthew Wilcox (1):
    page cache updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa architecture updates

Michael Ellerman (1):
    powerpc updates

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Micka=C3=ABl Sala=C3=BCn (1):
    Landlock updates

Miguel Ojeda (1):
    clang-format updates

Mike Rapoport (1):
    memblock test suite updates

Mike Snitzer (2):
    device mapper updates
    device mapper fixes

Miklos Szeredi (1):
    overlayfs updates

Mimi Zohar (1):
    IMA updates

Miquel Raynal (1):
    mtd updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Bonzini (1):
    kvm updates

Paul McKenney (3):
    nolibc library updates
    LKMM update
    RCU update

Paul Moore (1):
    selinux updates

Pavel Machek (1):
    LED updates

Petr Mladek (3):
    printk updates
    printk fixup
    livepatching cleanup

Rafael Wysocki (7):
    ACPI updates
    power management updates
    thermal control updates
    device properties framework updates
    more ACPI updates
    additional thermal control update
    more power management updates

Richard Weinberger (2):
    UML updates
    JFFS2, UBI and UBIFS updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    Kselftest updates
    KUnit updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (3):
    cifs client updates
    ksmbd server updates
    cifs client fixes

Steven Rostedt (2):
    tracing updates
    tracing tool updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (2):
    cgroup updates
    workqueue update

Thierry Reding (2):
    pwm updates
    hardware timestamping subsystem

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (16):
    irqpoll update
    debugobjects fixlet
    CPU hotplug updates
    interrupt handling updates
    timer and timekeeping updates
    x86 PCI irq routing updates
    objtool fixes
    perf fixlet
    perf fixes
    scheduler fix
    clockevent/clocksource updates
    x86 boot update
    x86 cleanups
    x86 microcode updates
    x86 mm cleanup
    x86 SGX fix

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (1):
    MMC updates

Vineet Gupta (1):
    ARC updates

Vinod Koul (1):
    dmaengine updates

Vlastimil Babka (1):
    slab updates

Wei Liu (1):
    hyperv updates

Wim Van Sebroeck (1):
    watchdog updates

Wolfram Sang (1):
    i2c updates

Yury Norov (1):
    bitmap updates
