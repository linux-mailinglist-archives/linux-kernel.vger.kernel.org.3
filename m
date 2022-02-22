Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C744BF5CE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiBVK3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiBVK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:29:10 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772ED15A229
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:28:45 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id f2so658018ilq.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 02:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eS2A2SDIO/vp8PmlyWTYQFrSZtShYqNTX+yWJ9M+0YE=;
        b=DLkDqBLdcGNOzANvpMjGVxmycBjJ8eQh4h1LoBysLfd2y+YbDaXBykiqIcmdP5G8sL
         Ia0sqOOIwPTBZlBvMYfiZ1YH3LdwBPuDA7xIGGw3LXytjESyafL1BrBMU78Ark6gsWNs
         Lh+cDryQPwsMlv8MlvmFXNIL/SBVAw5YAfsh0wRwO7oFIMBPR1qfGK0Csn0LkENjfufS
         YiCxl9x9qyIBAHDu1XeffFwUiMU396z7WIEcaQEJo3+HA9FMuIQ0T0JAmoXhMgBXhixZ
         nef+txSPZ8AVffXJUYlytFS5sSVRylCtIopU549RgCWmTZCt8P9bqBzBFHQ4zZhOOJdR
         emHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eS2A2SDIO/vp8PmlyWTYQFrSZtShYqNTX+yWJ9M+0YE=;
        b=dcMBCerdzHkp0+zBnDtvee/XTgEDLXRttZvDdIHD1mvsoCKT+G1p3IkLPr8jwb+uDV
         skwkZEkiNk4f/PRzfeiSo4PFm1QhrdSsQOjXJCGmNipsWQ2b7tMScjiK4Tb2VL6KZnLs
         gVylpl3W7lSg1vsUV9t5Q5C1aC0FhPMEdIMwpde0gy7+Z/rse7tT5DlLHYRNrsT/GKW/
         so4O4l+hx9hvtL/irJJdvaSAOt8gTSKX0LDIl0i7WLtxgvOFpqUn3uYSMub74E0aUR2R
         Wken46/PUxYARz64w7nyE9W46F5vwEA103x9Nc+aiyldNqAlxI83YsrWnfK5i7pFpKG/
         xHpw==
X-Gm-Message-State: AOAM531AdQNzhUvKDgnzE62AzH1To2YoBZIJTkVU7RAVlmFEYYapCHks
        VLxmwU3ZUPVbebPC+++Tyf9HV3FMDBpAOUBebfJw0w==
X-Google-Smtp-Source: ABdhPJwZ8M29hMLuk1QpkBFpIL0BWV208pLSo5ryfETeW0mPZT8zIxdMPaMaJjkKgXCrzibMRiHMS/UGYcmgFxqLxFk=
X-Received: by 2002:a92:c241:0:b0:2b9:80f9:e2a with SMTP id
 k1-20020a92c241000000b002b980f90e2amr19663534ilo.208.1645525724716; Tue, 22
 Feb 2022 02:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com> <20220221161232.2168364-5-alexandre.ghiti@canonical.com>
In-Reply-To: <20220221161232.2168364-5-alexandre.ghiti@canonical.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Tue, 22 Feb 2022 11:28:33 +0100
Message-ID: <CANp29Y7M=wSLBE8m0-CHKtYPkqgcxNiUPEyRNv-VHeR5O2BTYQ@mail.gmail.com>
Subject: Re: [PATCH -fixes v2 4/4] riscv: Fix config KASAN && DEBUG_VIRTUAL
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Thanks for the series!

However, I still haven't managed to boot the kernel. What I did:
1) Checked out the riscv/fixes branch (this is the one we're using on
syzbot). The latest commit was
6df2a016c0c8a3d0933ef33dd192ea6606b115e3.
2) Applied all 4 patches.
3) Used the config from the cover letter:
https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
4) Built with `make -j32 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-`
5) Ran with `qemu-system-riscv64 -m 2048 -smp 1 -nographic -no-reboot
-device virtio-rng-pci -machine virt -device
virtio-net-pci,netdev=net0 -netdev
user,id=net0,restrict=on,hostfwd=tcp:127.0.0.1:12529-:22 -device
virtio-blk-device,drive=hd0 -drive
file=~/kernel-image/riscv64,if=none,format=raw,id=hd0 -snapshot
-kernel ~/linux-riscv/arch/riscv/boot/Image -append "root=/dev/vda
console=ttyS0 earlyprintk=serial"` (this is similar to how syzkaller
runs qemu).

Can you please hint at what I'm doing differently?

A simple config with KASAN, KASAN_OUTLINE and DEBUG_VIRTUAL now indeed
leads to a booting kernel, which was not the case before.
make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
./scripts/config -e KASAN -e KASAN_OUTLINE -e DEBUG_VIRTUAL
make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-

--
Best Regards,
Aleksandr

On Mon, Feb 21, 2022 at 5:17 PM Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> __virt_to_phys function is called very early in the boot process (ie
> kasan_early_init) so it should not be instrumented by KASAN otherwise it
> bugs.
>
> Fix this by declaring phys_addr.c as non-kasan instrumentable.
>
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
>  arch/riscv/mm/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 7ebaef10ea1b..ac7a25298a04 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -24,6 +24,9 @@ obj-$(CONFIG_KASAN)   += kasan_init.o
>  ifdef CONFIG_KASAN
>  KASAN_SANITIZE_kasan_init.o := n
>  KASAN_SANITIZE_init.o := n
> +ifdef CONFIG_DEBUG_VIRTUAL
> +KASAN_SANITIZE_physaddr.o := n
> +endif
>  endif
>
>  obj-$(CONFIG_DEBUG_VIRTUAL) += physaddr.o
> --
> 2.32.0
>
