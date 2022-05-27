Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E9A53664C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353212AbiE0REY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242354AbiE0REW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:04:22 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A2C13B8E5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:04:20 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y32so7813216lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 10:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JndZRADLXoEuYMpvl6NdPiIxcR5VqDmpIIChLC/ZdPA=;
        b=jEmtTD8nJpoym6G/1dadazSPFlgrgg6DZNN5zOCjLiCfw6d8ocYBtrpT+L91hDi5ls
         MK+LqAaKftVfqu7tNHaZez5fXiQaw+2gDiXhvREfUjms97LiKfXY/TqpfBMjPEXInmm8
         ZH/l7b4t64H/njj5p1L+Bwj4dyldFESGz/6+yJhssRObXyTXd3VR4f/A2hfSRimpRVo0
         W1AXleA5CmPZReHghbqvJOdVaWOv5VBVt5CsGspqvr/dReJQEJ/zDpgabY0CYys5TNXj
         KOzxKgNuQv72aHWHHmXIu0hZzbZDLW4bs+TuK1G29Cu5tbEjXE65wGX6pp9Lf3Iiq0ar
         H1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JndZRADLXoEuYMpvl6NdPiIxcR5VqDmpIIChLC/ZdPA=;
        b=3qYvniqYLSYegk/VzcLBhW19z1xhft3dmHfpOpvF47Azzwb80eOZSg9xzlJFTiVDvO
         avUZBAgUrLahaNhiJslIIU13ZqQqy184OtfRU2CUVulslCOkpinl636IgvmxwT0MXF4E
         JyEL88FfGws9UjqBQBwTvNf+TokamIhFVJ1UE+4SDQMA95g5RXOQ0hyQVoByjAE8ANJ8
         mpS48dcqcXRteNknm7HddixTFNjlAD7qyDDBBxzsurhSS8sIUBjxPCSaKPYB+K8feDKz
         HXjkxHAsqYzZZfDARvoyo6LMXOdQIZNwpOf8YomK6GN/uA/d5iBZl6T2BFTup9XupXbm
         2hmg==
X-Gm-Message-State: AOAM531x3vKuQkBV01j0ZOJrzJqtv+0EiLRjbhSYgsjUZqK8NPJ3qY58
        sgC+wSo/vgFY6hlEvO6gA2KMcKmpNxNCPfiwKB1r/w==
X-Google-Smtp-Source: ABdhPJzIBmaH3vQMV7prGP7HMUkHtZXnxABZMHGnnlf/r1rHICt0d45Yypwh/FvQC87EOBiPfYlbt4gXCmgiGGdwmdU=
X-Received: by 2002:a05:6512:3c94:b0:477:ba25:de54 with SMTP id
 h20-20020a0565123c9400b00477ba25de54mr30752000lfv.137.1653671058843; Fri, 27
 May 2022 10:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0437b05dffdd1de@google.com> <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
 <36f4745f-0e47-4f49-8f4e-ff7544f163d8n@googlegroups.com> <CACT4Y+Zy7wLdeRCa+ZH-swo9ut=U6pEk4rP461QE1m-gT6s-uQ@mail.gmail.com>
 <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com>
In-Reply-To: <a55430c3-a0bc-4af6-b7e2-20f2e0d091b2n@googlegroups.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 19:04:07 +0200
Message-ID: <CACT4Y+ar18tcxx0tOthV0JBrmWsLXtXAjXVFX4sac5k1UGJ7Lw@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 27 May 2022 at 16:01, Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
> On Friday, May 27, 2022 at 3:55:24 PM UTC+2 Dmitry Vyukov wrote:
>>
>> On Fri, 27 May 2022 at 15:50, Alexandre Ghiti
>> <alexand...@canonical.com> wrote:
>> > On Friday, May 27, 2022 at 3:02:01 PM UTC+2 Dmitry Vyukov wrote:
>> >>
>> >> On Fri, 27 May 2022 at 14:55, syzbot
>> >> <syzbot+2c5da6...@syzkaller.appspotmail.com> wrote:
>> >> >
>> >> > Hello,
>> >> >
>> >> > syzbot found the following issue on:
>> >> >
>> >> > HEAD commit: c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg prop=
erty..
>> >> > git tree: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
.git fixes
>> >> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1418add=
5f00000
>> >> > kernel config: https://syzkaller.appspot.com/x/.config?x=3Daa6b5702=
bdf14a17
>> >> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2c5da6a0a=
16a0c4f34aa
>> >> > compiler: riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
>> >> > userspace arch: riscv64
>> >> >
>> >> > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
>> >> > Reported-by: syzbot+2c5da6...@syzkaller.appspotmail.com
>> >>
>> >> The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now Go
>> >> processes started crashing with:
>> >>
>> >> 1970/01/01 00:06:55 fuzzer started
>> >> runtime: lfstack.push invalid packing: node=3D0xffffff5908a940 cnt=3D=
0x1
>> >> packed=3D0xffff5908a9400001 -> node=3D0xffff5908a940
>> >> fatal error: lfstack.push
>> >> runtime stack:
>> >> runtime.throw({0x30884c, 0xc})
>> >> /usr/local/go/src/runtime/panic.go:1198 +0x60
>> >> runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
>> >> /usr/local/go/src/runtime/lfstack.go:30 +0x1a8
>> >>
>> >> Go runtime tries to shove some data into the upper 16 bits of pointer=
s
>> >> assuming they are unused.
>> >> However, the original pointer node=3D0xffffff5908a940 suggest riscv n=
ow
>> >> has 56-bit users-space address space?
>> >
>> >
>> > Yes, sv57 was merged recently.
>> >
>> >>
>> >> Documentation/riscv/vm-layout.rst claims 48-bit pointers:
>> >> "
>> >> The RISC-V privileged architecture document states that the 64bit add=
resses
>> >> "must have bits 63=E2=80=9348 all equal to bit 47, or else a page-fau=
lt exception will
>> >> occur.":
>> >
>> >
>> > Thanks for pointing that, I extracted that from the specification befo=
re sv57 was specified, I'll fix that.
>> >
>> > The current kernel code will use sv57 as it is supported and advertise=
d by qemu, and to my knowledge, you can't downgrade to sv48 unless by re-co=
mpiling qemu using the following:
>> >
>> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> > index 6dbe9b541f..a64b50ed75 100644
>> > --- a/target/riscv/csr.c
>> > +++ b/target/riscv/csr.c
>> > @@ -637,7 +637,7 @@ static const char valid_vm_1_10_64[16] =3D {
>> > [VM_1_10_MBARE] =3D 1,
>> > [VM_1_10_SV39] =3D 1,
>> > [VM_1_10_SV48] =3D 1,
>> > - [VM_1_10_SV57] =3D 1
>> > + [VM_1_10_SV57] =3D 0
>> > };
>> >
>> > /* Machine Information Registers */
>> >
>> >> ...
>> >> 0000000000000000 | 0 | 0000003fffffffff | 256 GB |
>> >> user-space virtual memory, different per mm
>> >> "
>>
>> There is no kernel config to force SV48/39, right?
>
>
> No, we rely on what the hardware advertises, if it supports sv57, we'll g=
o for sv57, if not, we'll try sv48...etc. I had some patches to force the d=
owngrade by using the device tree but they never got merged though.

+original CC list

FTR sent Go runtime change to support SV57:
https://go-review.googlesource.com/c/go/+/409055
