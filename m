Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142E75926F5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiHNXlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:41:53 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB187670
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:41:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a89so7714016edf.5
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc;
        bh=204cexW5W4h8Wy28AGTKRLG4WH3BESQwjchrPEyuknE=;
        b=ccaqsfUwmsA6Hm6Z/PjKAPHzYggi68dAwtT/HldEel6Fazp20l6umaMwlGFCasMn+y
         7BIsFevb31Mw1l8F4zpiWnKUm+pEmdMhZuhon7ZIWd/I4jkzOcFiq/k2snyh6ZhxiIdJ
         iIexcCesvPZvRhE9k3c4k+GayySw3Ea1Q3EEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc;
        bh=204cexW5W4h8Wy28AGTKRLG4WH3BESQwjchrPEyuknE=;
        b=7ol3KkxwX8nqIlfARLzUU7xK1c1l8FXD/X0x8ipgKYCo/zoNFusPLJy4U6IgYfxn8B
         fvokWt6KtWprcQLwOfZBPG46C2St+YkBKMIpCSrSkXdidsHGD4VUQgWqpKBgZry2T4ld
         6qqWuv/dWXd6fqRD706/Fos6H+aUQJMOAP0HmZAqCp4RujQXTr1LEAR5ZE9xkMss8nQL
         AKZtSOFAHZG7jVa1fp9vXSue8UzLG+3rwvz8n/qYiMnatgMkVns+mi8BQQf9Mlwrp7RP
         OkInSW8EfR+/Ac2Nsff82fM0V7P6SSvBAEnx1v4ZaN0njWwCmMB1jqoTjXRrONRIPMzl
         bGew==
X-Gm-Message-State: ACgBeo1Tw9haeqAydbWnpyUoXYOdNfKaR39kH5B4SqUU2ajVZl8x2M9c
        bVb6FF5YY5l1Hpxu9cs4ORR+ZnscrZ7bJTux
X-Google-Smtp-Source: AA6agR5IZ9J8klmEWOk7M+6x06sJxfDoCvB4iinJn+krOSwyTPUx55sKCZtgnlkQR3D+ANkRmLE9zw==
X-Received: by 2002:aa7:d5c8:0:b0:442:b0c5:1fba with SMTP id d8-20020aa7d5c8000000b00442b0c51fbamr12257007eds.237.1660520510348;
        Sun, 14 Aug 2022 16:41:50 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id fu17-20020a170907b01100b0073095265adesm3389656ejc.165.2022.08.14.16.41.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Aug 2022 16:41:49 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id l22so7308425wrz.7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 16:41:49 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr7050030wrw.281.1660520509258; Sun, 14
 Aug 2022 16:41:49 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 14 Aug 2022 16:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
Message-ID: <CAHk-=wgRFjPHV-Y_eKP9wQMLFDgG+dEUHiv5wC17OQHsG5z7BA@mail.gmail.com>
Subject: Linux 6.0-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So here we are, two weeks later, and the merge window has closed.

People are chasing down one active bug, and I'm sure there are others
hiding that just need more people to do testing, but that's kind of
the point of rc1: all the big changes have been merged, and now we
need to calm it down and chase down any problems.

Despite the major number change, there's nothing fundamentally
different about this release - I've long eschewed the notion that
major numbers are meaningful, and the only reason for a "hierarchical"
numbering system is to make the numbers easier to remember and
distinguish. Which is why when the minor number gets to around 20 I
prefer to just increment the major number instead and reset to
something smaller.

"Nothing fundamentally different about this release" obviously doesn't
mean there aren't lots of changes, though. There's about 13.5k
non-merge commits in here (and 800+ merges), so 6.0 looks to be
another fairly sizable release.

I actually was hoping that we'd get some of the first rust
infrastructure, and the multi-gen LRU VM, but neither of them happened
this time around. There's always more releases. But there's a lot of
continued development pretty much all over the place, with the
"shortlog" being much too long to post and thus - as always for rc1
notices - below only contains my "merge log". You can definitely get a
kind of high-level overview by just scanning that, but obviously it's
worth once again pointing out that the people mentioned in the merge
log are just the maintainers I pull from, and there's more than 1700
developers involved when you start looking at the full details in the
git tree.

And, once again, this is one of those releases where you should not
look at the diffstat too closely, because more than half of it is yet
another AMD GPU register dump. And the Habanalabs Gaudi2 people want
to play in that space too, but they don't reach quite the same lofty
results that the AMD GPU people  have become so famous for. I'm sure
it's just a matter of time.

The CPU people also show up in the JSON files that describe the perf
events, but they look absolutely tiny compared to the 'asic_reg'
auto-generated GPU and AI hardware definitions.

So just avert your eyes from those parts if you decide that you
actually want to look at the diffs themselves. Once you do that, the
stats look pretty normal, with roughly 60% driver updates (all over,
but gpu, networking and sound are the big updates - again, that's
pretty much par for the course). The rest is a mix of arch updates,
filesystems, tooling, and just random changes all over.

In all its glory (so all those AMD GPU hardware definitions etc included), it's

 13099 files changed, 1280295 insertions(+), 341210 deletions(-)

just because I was curious and looked.

Oh, and after I had already decided to call this kernel 6.0, a few
Chinese developers piped up and pointed out that "5.20" is a more
wholesome version of the Western "4.20" internet-famous number. So if
you want to call this "Linux 5.20", go right ahead. Because the kernel
version  numbers really are entirely made up and have no intrinsic
meaning.

But whatever you call it, please help test this, so that we can get it
all in shape for the final release (hopefully early October).

                 Linus

---

Al Viro (9):
    vfs namei updates
    vfs lseek updates
    vfs dcache updates
    vfs iov_iter updates
    copy_to_iter_mc fix
    9p iov_iter fix
    more iov_iter updates
    /proc/mounts fix
    vfs lseek fix

Alex Williamson (2):
    VFIO updates
    another VFIO update

Alexander Gordeev (1):
    s390 updates

Alexandre Belloni (1):
    RTC updates

Andreas Gruenbacher (1):
    gfs2 updates

Andrew Morton (3):
    MM updates
    misc updates
    remaining MM updates

Ard Biesheuvel (2):
    EFI updates
    efivars sysfs interface removal

Arnaldo Carvalho de Melo (2):
    perf tools updates
    more perf tool updates

Arnd Bergmann (8):
    ARM SoC updates
    ARM SoC drivers
    ARM DT updates
    ARM SoC defconfig updates
    ARM new SoC support
    ARM boardfile deprecation
    more ARM SoC updates
    asm-generic updates

Bartosz Golaszewski (1):
    gpio updates

Bjorn Andersson (4):
    hwspinlock updates
    rpmsg updates
    remoteproc updates
    rpmsg fixes

Bjorn Helgaas (1):
    pci updates

Borislav Petkov (11):
    RAS update
    x86 vmware cleanup
    x86 cleanup
    x86 mm updates
    x86 fpu update
    x86 cpu updates
    misc x86 updates
    x86 core updates
    x86 build updates
    x86 kdump updates
    x86 eIBRS fixes

Casey Schaufler (1):
    msack updates

Christian Brauner (3):
    fs idmapping updates
    acl updates
    setgid updates

Christoph Hellwig (1):
    dma-mapping updates

Chuck Lever (1):
    nfsd updates

Damien Le Moal (2):
    zonefs update
    ATA updates

Dan Williams (1):
    cxl updates

Darrick Wong (4):
    iomap updates
    xfs updates
    more iomap updates
    more xfs updates

Dave Airlie (2):
    drm updates
    drm fixes

Dave Hansen (1):
    x86 SGX updates

David Howells (2):
    AFS fixes
    fscache updates

David Sterba (2):
    btrfs updates
    affs fix

David Teigland (1):
    dlm updates

Dmitry Torokhov (1):
    input updates

Dominique Martinet (1):
    9p updates

Eric Biggers (1):
    fsverity update

Gao Xiang (1):
    erofs updates

Geert Uytterhoeven (1):
    m68k updates

Greg KH (6):
    char / misc driver updates
    driver core / kernfs updates
    USB / Thunderbolt updates
    staging driver updates
    SPDX updates
    tty / serial driver updates

Greg Ungerer (1):
    m68knommu fixes

Guenter Roeck (2):
    hwmon updates
    hwmon fixes

Guo Ren (1):
    csky updates

Gustavo Silva (1):
    uapi flexible array update

Hans de Goede (1):
    x86 platform driver updates

Hans-Christian Noren Egtvedt (1):
    AVR32 updates

Helge Deller (2):
    parisc updates
    fbdev updates

Herbert Xu (1):
    crypto updates

Huacai Chen (1):
    LoongArch updates

Ilya Dryomov (1):
    ceph updates

Ingo Molnar (8):
    scheduler updates
    locking updates
    perf events updates
    perf fixes
    scheduler fixes
    x86 fixes
    x86 fix
    timer fixes

Jaegeuk Kim (1):
    f2fs updates

Jakub Kicinski (1):
    networking fixes

James Bottomley (2):
    SCSI updates
    more SCSI updates

Jan Kara (2):
    ext2 and reiserfs updates
    fsnotify updates

Jarkko Sakkinen (1):
    tpm updates

Jason Donenfeld (1):
    random number generator updates

Jason Gunthorpe (1):
    rdma updates

Jassi Brar (1):
    mailbox updates

Jeff Layton (1):
    file locking updates

Jens Axboe (7):
    io_uring updates
    io_uring buffered writes support
    io_uring zerocopy support
    block updates
    block driver updates
    io_uring fixes
    block fixes

Jiri Kosina (1):
    HID updates

Joerg Roedel (1):
    iommu updates

John Johansen (1):
    AppArmor updates

Jon Mason (1):
    NTB updates

Jonathan Corbet (1):
    documentation updates

Juergen Gross (2):
    xen updates
    more xen updates

Julia Lawall (1):
    coccinelle semantic patch updates

Kees Cook (4):
    pstore updates
    seccomp update
    execve updates
    hardening updates

Lee Jones (2):
    MFD updates
    backlight updates

Len Brown (1):
    turbostat updates

Linus Walleij (1):
    pin control updates

Luis Chamberlain (2):
    module updates
    sysctl updates

Mark Brown (3):
    regmap updates
    regulator updates
    spi updates

Masahiro Yamada (1):
    Kbuild updates

Matthew Wilcox (2):
    XArray/IDR updates
    folio updates

Mauro Carvalho Chehab (1):
    media updates

Max Filippov (1):
    xtensa updates

Micah Morton (1):
    SafeSetID updates

Michael Ellerman (2):
    powerpc updates
    powerpc fixes

Michael Tsirkin (1):
    virtio updates

Michal Simek (1):
    microblaze updates

Mike Rapoport (1):
    memblock updates

Mike Snitzer (3):
    device mapper updates
    more device mapper updates
    device mapper fixes

Miklos Szeredi (2):
    overlayfs update
    fuse updates

Mimi Zohar (1):
    integrity updates

Namjae Jeon (1):
    exfat updates

Palmer Dabbelt (2):
    RISC-V updates
    more RISC-V updates

Paolo Abeni (1):
    networking changes

Paolo Bonzini (2):
    kvm updates
    more kvm updates

Paul McKenney (2):
    RCU updates
    nolibc updates

Paul Moore (3):
    selinux updates
    audit updates
    LSM update

Pavel Machek (1):
    LED updates

Petr Mladek (2):
    printk updates
    livepatching update

Rafael Wysocki (6):
    ACPI updates
    power management updates
    thermal control updates
    more thermal control updates
    more power management updates
    more ACPI updates

Richard Weinberger (2):
    UML updates
    MTD updates

Rob Herring (2):
    devicetree updates
    devicetree fixes

Russell King (1):
    ARM updates

Sebastian Reichel (1):
    power supply and reset updates

Shuah Khan (2):
    KUnit updates
    Kselftest updates

Stafford Horne (1):
    OpenRISC updates

Stephen Boyd (1):
    clk updates

Steve French (3):
    cifs updates
    ksmbd updates
    more cifs updates

Steven Rostedt (2):
    real time analysis tool (rtla) updates
    tracing updates

Takashi Iwai (2):
    sound updates
    sound fixes

Ted Ts'o (1):
    ext4 updates

Tejun Heo (1):
    cgroup updates

Thierry Reding (1):
    pwm updates

Thomas Bogendoerfer (1):
    MIPS updates

Thomas Gleixner (2):
    timer updates
    irq updates

Trond Myklebust (1):
    NFS client updates

Tzung-Bi Shih (1):
    chrome platform updates

Ulf Hansson (1):
    MMC updates

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

Wolfram Sang (2):
    i2c updates
    more i2c updates

Yury Norov (1):
    bitmap updates
