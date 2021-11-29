Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A96C4461FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379878AbhK2S5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhK2SzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:55:00 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BE0C0613B5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:16:58 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id i13so14839946qvm.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 07:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jq5oOPhY/iB44DAIfswhDk95czYrY9t9eYR4gWeeYM=;
        b=tiJFJpCBSA19Kv/qzrogVcGHdv1x+f6uC9F4DxV3I1GaY7hjR6I7/B9hZwexG4UDFc
         kWi9SWAPTsb6z+IqXbYBhluEuEyR6cCojllFMO8cVxvOPKgx7bdAmn+lR2tPm7OUlvA3
         ui1l5yS5+juiQfCxI8517OMc9TU1YDQauYac6VpeMgPbi7+byylEGpmECnNP4GqoS915
         2vPkiCLIsEu/ctPeOHBOmgk1peA4HOer3CO7ZaDpb0zcTY3PSI+hmPfcvUPVejW/5VBF
         EkVU6WjPBgt77eMaQom3fr1oIiDW4g5F6iassYUi4fJXYPIEI4PHRoas6jA0iREc9+da
         VKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jq5oOPhY/iB44DAIfswhDk95czYrY9t9eYR4gWeeYM=;
        b=ORMgNWgstBcOxDanryjs+MqphJ7dvDPHia/zK+7HsCjyln+Ekyjd7f8lL5uNxhado7
         XGFWsnz64ZHGnoDhusMUEsYeCWqKV+sw00V/CniseurTiikMIsKlihdjWZl3odk06EmW
         7kuYLWSjnFBFdev4M/SidNlPb9KkGw0uITdC3XQUf71wqFf10AMgBsWGxMcTcdrR0Iwl
         O+roq14JqDGMnJvORuHb3Mig8Rso3C2qvKxqjH9ocKNjjkckUfUjmLiriDDzzC/jzbCU
         chirkpFcOrYg0tI/9xcc30NBTLVPcEhtTO2puBbIqNyK72f1ECa6wAs5QAOutXPiC3gk
         ag8Q==
X-Gm-Message-State: AOAM531ICMahUWINWb6yeg9D/pPLJ/yfB3/1mYNFg8+33uGOwVcXG7tF
        zFxqFRgpXSLQtpiHUiTaXyQyz1mLsykS9KTukwl1Lg==
X-Google-Smtp-Source: ABdhPJyEQAUpuRocdQM02pgyLE2j6mGdcZDlSQzQ7qyGBnVTSyy4rs+VDwkRATa8bX1tV1vIZ7DI/5zRUw5Hm17e03Y=
X-Received: by 2002:a05:6214:5190:: with SMTP id kl16mr42648616qvb.36.1638199017434;
 Mon, 29 Nov 2021 07:16:57 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a0d53f05d1c72a4c@google.com> <20211129114713.at2mo64hgnlmkx3x@wittgenstein>
In-Reply-To: <20211129114713.at2mo64hgnlmkx3x@wittgenstein>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 29 Nov 2021 16:16:21 +0100
Message-ID: <CAG_fn=UGPTizsqgvYNnVkPK9TeXhyyi8f92Qnpy=cN7S4JzeCw@mail.gmail.com>
Subject: Re: [syzbot] KMSAN: uninit-value in from_kuid
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     syzbot <syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, cxfcosmos@gmail.com,
        ebiederm@xmission.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 12:47 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sat, Nov 27, 2021 at 07:50:27AM -0800, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    425295055ce6 kmsan: core: address comments to kmsan-che=
cks.h
> > git tree:       https://github.com/google/kmsan.git master
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1640209ab00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D2d142cdf420=
4061
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddfac92a50024b=
54acaa4
> > compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.=
git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Deb=
ian) 2.35.2
> > userspace arch: i386
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+dfac92a50024b54acaa4@syzkaller.appspotmail.com
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: uninit-value in map_id_up_base kernel/user_namespace.c:335 =
[inline]
> > BUG: KMSAN: uninit-value in map_id_up kernel/user_namespace.c:365 [inli=
ne]
> > BUG: KMSAN: uninit-value in from_kuid+0x51d/0xbd0 kernel/user_namespace=
.c:413
> >  map_id_up_base kernel/user_namespace.c:335 [inline]
> >  map_id_up kernel/user_namespace.c:365 [inline]
> >  from_kuid+0x51d/0xbd0 kernel/user_namespace.c:413
> >  p9pdu_vwritef+0x15ab/0x5120 net/9p/protocol.c:398
> >  p9pdu_writef+0x23a/0x280 net/9p/protocol.c:539
> >  p9pdu_vwritef+0x21f0/0x5120 net/9p/protocol.c:490
> >  p9_client_prepare_req+0xa4b/0xff0 net/9p/client.c:709
> >  p9_client_rpc+0x278/0x1410 net/9p/client.c:740
> >  p9_client_setattr+0x115/0x2c0 net/9p/client.c:1899
> >  v9fs_vfs_setattr_dotl+0x7e2/0xd70 fs/9p/vfs_inode_dotl.c:590
> >  notify_change+0x1fe3/0x2170 fs/attr.c:410
> >  vfs_utimes+0x8aa/0xc70 fs/utimes.c:65
> >  do_utimes_path fs/utimes.c:98 [inline]
> >  do_utimes fs/utimes.c:144 [inline]
> >  __do_sys_utime32 fs/utimes.c:247 [inline]
> >  __se_sys_utime32+0x386/0x520 fs/utimes.c:235
> >  __ia32_sys_utime32+0x91/0xc0 fs/utimes.c:235
> >  do_syscall_32_irqs_on arch/x86/entry/common.c:114 [inline]
> >  __do_fast_syscall_32+0x96/0xf0 arch/x86/entry/common.c:180
> >  do_fast_syscall_32+0x34/0x70 arch/x86/entry/common.c:205
> >  do_SYSENTER_32+0x1b/0x20 arch/x86/entry/common.c:248
> >  entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
> >
> > Uninit was stored to memory at:
> >  v9fs_vfs_setattr_dotl+0x58a/0xd70 fs/9p/vfs_inode_dotl.c:567
>
> That's a bug in the 9P2000.L implementation of .setattr.
> It copies struct iattr values without checking ia_valid. That's causing
> uninitalized memory to be copied. I sent a fix to 9p for this.
>
> Christian

Christian,

Do you think it makes sense to request a CVE for this issue?
If so, were you going to request one? Otherwise I can do that.

--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
