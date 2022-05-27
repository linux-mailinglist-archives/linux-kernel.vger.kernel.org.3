Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAE536314
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351588AbiE0NCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbiE0NCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:02:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06244B7CC
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:02:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u23so6827775lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y9dRzSEE6qIZVHgcjwE6BybELU2ejo/ROH1wde8bWlw=;
        b=WOw2OdJ8j2sliEnbDhaeP5MFvVJkvTBecIJZTae5CUAVwMd2FfoH7MKBEBWkmvGFqA
         yhYMM7C3uuOCtNV+NyhKmgRvYwLwOkMqe7JeiBIZTZ6cjCEUYF4cpvXj1nWAjzMmkdAM
         o5BzE98QC7u9v7B+TIrwoa+zbdacZfQhJ6X7FFgUUImxjjFxz6Y+LP7MpV8hQ7bFclvz
         cX6aUPtreI07BUIATuwFNtH9VAC8kuKT9pkeuuGGlRAHXOol4t+STwowma5wSCE4OPvl
         5R4pPZUx1FddliKY5DBuTUe+MAhgjxOsBIfhv4QtXlBe7z/gKOGst5KfXyYOs5T42MbB
         EzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y9dRzSEE6qIZVHgcjwE6BybELU2ejo/ROH1wde8bWlw=;
        b=Ec41yPtfiaszpY32ZSMH8IhvXu2TZYm6DHKDyif11Ama8+96tLqPRhOq6fkGA49MdM
         5Pn5Pf2AABdZSLRUpyp+nhDmc5CAW44kNcdP/gqeix6yV/0qf8GCC7FD2NNGhaWQj1Et
         3pfpef7FcTdelb5Sm0zkHnnbHtc2704Wl4cYzaJJarDoTBe1+Li8ZFjogSTvH87cqfYP
         x6c7CrMIWBAOWUUW5Iz9OQ8x/saUJnObtu3oUTP8ElmGdwLTuIJEZmOCCQY5PNFfL6xD
         7pmbyr87oGkZjVN3HnX7wJSh7jTlQ/P0sLqS3Jmc/zqzcKHOeRCR30fqfVyJoz1MpWza
         LvVQ==
X-Gm-Message-State: AOAM530n3d28FN0Vg0OOEM0a9GtE1yF6fTD+9hcHOsmIWtmIls154EP5
        Zz/5FW35iF1MLjjb1n4T1zVqM+zm0ybtt4x3yCCpBQ==
X-Google-Smtp-Source: ABdhPJx8pz5RVwGsd3SOgzFwcWxkjBf6tw9WxTmsFEBs+UaymELbFzH+09+ZQKOha64sC+sz67rCzyMqGglHmiBs3n0=
X-Received: by 2002:a19:7106:0:b0:478:68b5:86d9 with SMTP id
 m6-20020a197106000000b0047868b586d9mr19573199lfc.417.1653656517697; Fri, 27
 May 2022 06:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000d0437b05dffdd1de@google.com>
In-Reply-To: <000000000000d0437b05dffdd1de@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 27 May 2022 15:01:46 +0200
Message-ID: <CACT4Y+Y8DOKJtwhRsyNT7G26C3Fx_oeibpXn43Ks0RtYYdZG3g@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes test error: lost connection to test machine
To:     syzbot <syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com>
Cc:     aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2022 at 14:55, syzbot
<syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    c932edeaf6d6 riscv: dts: microchip: fix gpio1 reg propert=
y..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux=
.git fixes
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1418add5f0000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daa6b5702bdf14=
a17
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2c5da6a0a16a0c4=
f34aa
> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, =
GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: riscv64
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+2c5da6a0a16a0c4f34aa@syzkaller.appspotmail.com

The CONFIG_KASAN_VMALLOC allows riscv kernel to boot, but now Go
processes started crashing with:

1970/01/01 00:06:55 fuzzer started
runtime: lfstack.push invalid packing: node=3D0xffffff5908a940 cnt=3D0x1
packed=3D0xffff5908a9400001 -> node=3D0xffff5908a940
fatal error: lfstack.push
runtime stack:
runtime.throw({0x30884c, 0xc})
/usr/local/go/src/runtime/panic.go:1198 +0x60
runtime.(*lfstack).push(0xdb3850, 0xffffff5908a940)
/usr/local/go/src/runtime/lfstack.go:30 +0x1a8

Go runtime tries to shove some data into the upper 16 bits of pointers
assuming they are unused.
However, the original pointer node=3D0xffffff5908a940 suggest riscv now
has 56-bit users-space address space?
Documentation/riscv/vm-layout.rst claims 48-bit pointers:
"
The RISC-V privileged architecture document states that the 64bit addresses
"must have bits 63=E2=80=9348 all equal to bit 47, or else a page-fault exc=
eption will
occur.":
...
   0000000000000000 |    0       | 0000003fffffffff |  256 GB |
user-space virtual memory, different per mm
"
