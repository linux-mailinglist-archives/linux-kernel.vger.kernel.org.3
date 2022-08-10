Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3E58EFD9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiHJP5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiHJP4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:56:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C4B5C376
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:55:46 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o184so8325601oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc;
        bh=zGSMwXozXJkSnWlNwxu1Xycubh/JEp8JG+trBiocv7E=;
        b=TfRbV0X3ibGUpZZU0i8WeHBnJsmYu4asoziO3EsI7Tmto7QJDEELLQl1/gQwZ3vdyJ
         rfWg2I6w09N4taDR7L1xRxGKh6MIZNNDqvj82sCdU8KhZD1jurejRsVcsJ5Phbxnb2t5
         UCUZicKvMKrJK4GpXC3LhHgpj/Pqn4rYrSEM8/J9QRnAfKGqr/v6fukIuGKTcfegku9W
         6VlsdU4Jl3wL6uLeYdPUYMZzelhEaKJ9N5h7kEsoqfYbW5/LUEY3Ym+rmWQYKY54HiIz
         0eLBGSRZNRUPJyrKHwiYZZKeiTlH0y8/LSgJHktc4I5n0m++pCtbueUDOtAaCqA2aPhA
         ojVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc;
        bh=zGSMwXozXJkSnWlNwxu1Xycubh/JEp8JG+trBiocv7E=;
        b=qfjVu7si9hruD8KslXUoCK0qir/6ZHz1hX872V1sfHL9iS+Gu/Mk9N8gVsSlVe34WN
         Xy7xeMn7VuyH5V4bnAQxQ0F0ldtKOn1qTmodScPGgKLD6IdwCIFYijfQ2rsAVeqUffvS
         a6luanUUGicTfUTm+3kzKlouKbOXZOYp6kcBVlXoY47tw6eMDnQXE7Xtu5Wd8PrP7RF8
         T8Hdn/sbzh2n+oDlFo0n+rhNkzSbfs1RbwGDBHERbwS1vziQVd5LE4anO8NCGDC6bG/c
         KLdhRvkSscTDttKfl2DB/r6mxn2kiSB1FvnzMlsGkd6rM84rxQdK904hhBrPKMXbEE/8
         6M2g==
X-Gm-Message-State: ACgBeo1O4aHUEYAXp5IC5305SVbNWwi3LEZNkuZ/Qv6r6y8w/6IDndZR
        C9LZz39NXnvN07pvgyjaXOaDbw==
X-Google-Smtp-Source: AA6agR6O91x+Vo1hQhEzkko2wUJkj58XtoSRVQVCws021XLqHTOsNgZWCCK8mZ/0j9RffDe1kX6itA==
X-Received: by 2002:a05:6808:1153:b0:33a:f8c5:2d2e with SMTP id u19-20020a056808115300b0033af8c52d2emr1761358oiu.86.1660146944572;
        Wed, 10 Aug 2022 08:55:44 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b0063512ec38easm717541otv.54.2022.08.10.08.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:55:44 -0700 (PDT)
Date:   Wed, 10 Aug 2022 08:55:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Zdenek Kabelac <zkabelac@redhat.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, chris@chris-wilson.co.uk,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: i915: crash with 5.19-rc2
In-Reply-To: <f0dd80b2-97e1-c320-8517-7ebdb027f58a@redhat.com>
Message-ID: <4a204620-7639-c844-455-10e55b372bcf@google.com>
References: <584ae788-05e3-5824-8c85-cbb833677850@redhat.com> <f0dd80b2-97e1-c320-8517-7ebdb027f58a@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-355110041-1660146943=:1841"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-355110041-1660146943=:1841
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Aug 2022, Zdenek Kabelac wrote:
> Dne 22. 06. 22 v 13:18 Zdenek Kabelac napsal(a):
> > Hello
> >
> > While somewhat oldish hw (T61, 4G, C2D) - I've now witnessed new crash =
with
> > Xorg:
> >
> > (happened while reopening iconified Firefox window=C2=A0 - running 'sta=
ndard'
> > rawhide -nodebug kernel 5.19.0-0.rc2.21.fc37.x86_64)
> >
>=20
> Hello
>=20
>=20
> Ok, I think I now know what is behind this BUG/crash of intel graphics=C2=
=A0 -=C2=A0
> interestingly it took me a few weeks to realize this.
>=20
> So I've actually installed with some Rawhide update 'zram-generator' pack=
age
> to use=C2=A0 zram swap to help with memory of Firefox & Thunderbird a bit=
 with this
> 4G RAM laptop. All worked fine. However side effect of usage of ZRAM swap=
ping
> became actually this occasional=C2=A0 kernel BUG hitting.
>=20
> When I've stopped using=C2=A0 Zram swap=C2=A0 -=C2=A0 it now runs for 2 w=
eeks without a
> single deadlock - with single or dual screen monitor setup with many susp=
ends
> & resumes in between.
>=20
> So I'm likely 100% sure that=C2=A0=C2=A0 ZRAM usage is triggering this is=
sue.=C2=A0=C2=A0 While I
> know this laptop is old and likely with low memory and so on - no sure if=
 it's
> worth to solve it - maybe good enough solution is to issue a warning user
> should no comibine this old piece with ZRAM - but I'm all open to do some
> testing for fix - although I still don't have a simple triggering path fo=
r
> this issue to happen within short period of time.
>=20
> Maybe driver is missing tomark some pages as pined into memory so ZRAM ca=
n't
> swap them out ?.
>=20
>=20
> > =C2=A0page:00000000577758b3 refcount:0 mapcount:0 mapping:0000000000000=
000
> > index:0x1 pfn:0x1192cc
> > =C2=A0flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> > =C2=A0raw: 0017ffffc0000000 ffffe683c47171c8 ffff8fa3f79377a8 000000000=
0000000
> > =C2=A0raw: 0000000000000001 0000000000000000 00000000ffffffff 000000000=
0000000
> > =C2=A0page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
> > =C2=A0------------[ cut here ]------------
> > =C2=A0kernel BUG at mm/shmem.c:708!
> > =C2=A0invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > =C2=A0CPU: 1 PID: 42896 Comm: Xorg Not tainted 5.19.0-0.rc2.21.fc37.x86=
_64 #1
> > =C2=A0Hardware name: LENOVO 6464CTO/6464CTO, BIOS 7LETC9WW (2.29 ) 03/1=
8/2011
> > =C2=A0RIP: 0010:shmem_add_to_page_cache+0x48e/0x500
> > =C2=A0Code: 01 0f 84 0a fc ff ff 48 8d 4a ff 31 d2 48 39 cb 0f 85 ff fb=
 ff ff e9
> > f6 fb ff ff 48 c7 c6 70 01 64 bb 48 89 df e8 f2 99 01 00 <0f> 0b 48 c7 =
c6 a0
> > 1b 64 bb 48 89 df e8 e1 99 01 00 0f 0b 48 8b 13
> > =C2=A0RSP: 0018:ffff9ce7c047f6b0 EFLAGS: 00010286
> > =C2=A0RAX: 000000000000003f RBX: ffffe683c464b300 RCX: 0000000000000000
> > =C2=A0RDX: 0000000000000001 RSI: ffffffffbb67b8e8 RDI: 00000000ffffffff
> > =C2=A0RBP: 0000000000023f97 R08: ffffffffbca122a0 R09: 64656b636f6c5f74
> > =C2=A0R10: 747365745f6f696c R11: 6f6621284f494c4f R12: 00000000001120d4
> > =C2=A0R13: ffff8fa2c6ae7890 R14: ffffe683c464b300 R15: 0000000000000001
> > =C2=A0FS:=C2=A0 00007fc1cea31380(0000) GS:ffff8fa3f7900000(0000)
> > knlGS:0000000000000000
> > =C2=A0CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > =C2=A0CR2: 00007f6972e228c8 CR3: 0000000104ba8000 CR4: 00000000000006e0
> > =C2=A0Call Trace:
> > =C2=A0<TASK>
> > =C2=A0shmem_swapin_folio+0x274/0x980
> > =C2=A0shmem_getpage_gfp+0x234/0x990
> > =C2=A0shmem_read_mapping_page_gfp+0x36/0xf0
> > =C2=A0shmem_sg_alloc_table+0x11b/0x250 [i915]

Sorry, I never noticed your original report in June.

This is not a bug in zram or i915, but what Matthew fixes in
https://lore.kernel.org/lkml/20220730042518.1264767-1-willy@infradead.org/

I am a little surprised to see it hitting i915, since I had thought it
could only affect gma500: but looks like 965gm has similar limitations,
and so I expect that's what's on your laptop there.

Hugh
--0-355110041-1660146943=:1841--
