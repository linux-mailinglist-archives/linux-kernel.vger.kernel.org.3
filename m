Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC48654D9EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358664AbiFPFpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358723AbiFPFpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:45:51 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0C5B88F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:45:50 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id x9so264692vsg.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f3mQL/OJn2hHrWnYrnODSjMNsBnHIx074Y+WX87KAgU=;
        b=n3+xTygTBjLD9xLxE1fiUFliU+Wla5QbizTVJhvSPPftZoF5tcVxE8kCaNm4/TYwf0
         8moHlhROnEI/9Z/C2z8kCY8harS/SWK2HVrkJIP3rGUCF3csWZ/b/MQqImIm1NR4vXXd
         0VvvmnHEKu9hMzl2Y13XfGWEAlceJnnJcrXZDYNmnrwz3atu7do+C49fiLremCPx1jLB
         TpVdwj5zFa4ltt1ifrv8uPXrSYR+eUEL8scQhtElmPPvRlTDteA/EobXZ9rLlZBkOG/0
         FSk/gIXs1FTvtXPScJodbQkgCKnAuwidtysiLvXJ0Wp4mYFqMqix0YBi0163sRI7Lqqy
         XiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f3mQL/OJn2hHrWnYrnODSjMNsBnHIx074Y+WX87KAgU=;
        b=nlFmF/3icq6rzAd/oHc7BG0sJw5VIECHbOQ1kvocLN+pIyeg5C0/4/twQeRqgLm2i3
         1WwWqKzd1QxR6MTeZCJMrAnw0qL+OtFi9+fmc1fB8c86eCynBjnjKSzrUPhjffhTYSue
         XqiPxTnNHQ9k2w1KXKZR72l1ex0vgDR4eSeAJgzxOBTFrw88ZUB3RGzJbpsTsWru7XbT
         UTDeJDTDFCIwaGgeL8a2gzOFwZHmkdM1WBLJEsmsjiTR+ZMzxkC5shzKkiVtA0EZUDJG
         Dthliy5kgC1Rj59GsGF5OdssUVoYXR6yK/4Bh8oKUrzIuwzfC+pxPw7q7OAgwFYXfTNE
         g00g==
X-Gm-Message-State: AJIora/K7k0gOrtSNjRdegsEOFsl+dN+tzGkGQYlOLnlSA/ugeH2w+iA
        BoLA8s7bVPD4ArouMbfLCIHjJpdLEJoeObHrvv9Idg==
X-Google-Smtp-Source: AGRyM1vRafXBXoM3ca309NV7Lyl7pTIavaVDWwzsZtpf1lV/jUEagmb483Pv72Dw0kpXA4IPI2pykf7H3Cts2km3zdY=
X-Received: by 2002:a05:6102:3e23:b0:34b:b6b0:2ae7 with SMTP id
 j35-20020a0561023e2300b0034bb6b02ae7mr1690724vsv.81.1655358349275; Wed, 15
 Jun 2022 22:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver> <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver> <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver> <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
 <20220616025557.euz6z5rlh7fqewy2@revolver> <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
In-Reply-To: <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 23:45:13 -0600
Message-ID: <CAOUHufbNR6NsYX_fd+_6WaiNkewyfWuDN-9KnPBOdxaPTks-8w@mail.gmail.com>
Subject: Re: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
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

On Wed, Jun 15, 2022 at 9:02 PM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 15, 2022 at 8:56 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> >
> > * Yu Zhao <yuzhao@google.com> [220615 21:59]:
> > > On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > > >
> > > > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> > > >
> > > > ...
> > > >
> > > > > > Yes, I used the same parameters with 512GB of RAM, and the kernel with
> > > > > > KASAN and other debug options.
> > > > >
> > > > > Sorry, Liam. I got the same crash :(
> > > >
> > > > Thanks for running this promptly.  I am trying to get my own server
> > > > setup now.
> > > >
> > > > >
> > > > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything)
> > > > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
> > > > > 55140693394d maple_tree: Make mas_prealloc() error checking more generic
> > > > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
> > > > > 4d4472148ccd maple_tree: Change spanning store to work on larger trees
> > > > > ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
> > > > > spanning writes
> > > > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()
> > > > >
> > > > > ==================================================================
> > > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > > Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303
> > > > >
> > > > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0-smp-DEV #1
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  dump_stack_lvl+0xc5/0xf4
> > > > >  print_address_description+0x7f/0x460
> > > > >  print_report+0x10b/0x240
> > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > >  kasan_report+0xe6/0x110
> > > > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > >  kasan_check_range+0x2ef/0x310
> > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > > >  memcpy+0x44/0x70
> > > > >  mab_mas_cp+0x2d9/0x6c0
> > > > >  mas_spanning_rebalance+0x1a3e/0x4f90
> > > >
> > > > Does this translate to an inline around line 2997?
> > > > And then probably around 2808?
> > >
> > > $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> > > mab_mas_cp+0x2d9/0x6c0:
> > > mab_mas_cp at lib/maple_tree.c:1988
> > > $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> > > mas_spanning_rebalance+0x1a3e/0x4f90:
> > > mast_cp_to_nodes at lib/maple_tree.c:?
> > > (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> > > $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> > > mas_wr_spanning_store+0x16c5/0x1b80:
> > > mas_wr_spanning_store at lib/maple_tree.c:?
> > >
> > > No idea why faddr2line didn't work for the last two addresses. GDB
> > > seems more reliable.
> > >
> > > (gdb) li *(mab_mas_cp+0x2d9)
> > > 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> > > (gdb) li *(mas_spanning_rebalance+0x1a3e)
> > > 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tree.c:2801).
> > > quit)
> > > (gdb) li *(mas_wr_spanning_store+0x16c5)
> > > 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tree.c:4030).
> >
> >
> > Thanks.  I am not having luck recreating it.  I am hitting what looks
> > like an unrelated issue in the unstable mm, "scheduling while atomic".
> > I will try the git commit you indicate above.
>
> Fix here:
> https://lore.kernel.org/linux-mm/20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org/

A seemingly new crash on arm64:

KASAN: null-ptr-deref in range [0x0000000000000000-0x000000000000000f]
pc : __hwasan_check_x2_67043363+0x4/0x34
lr : mas_wr_walk_descend+0xe0/0x2c0
sp : ffffffc0164378d0
x29: ffffffc0164378f0 x28: 13ffff8028ee7328 x27: ffffffc016437a68
x26: 0dffff807aa63710 x25: ffffffc016437a60 x24: 51ffff8028ee1928
x23: ffffffc016437a78 x22: ffffffc0164379e0 x21: ffffffc016437998
x20: efffffc000000000 x19: ffffffc016437998 x18: 07ffff8077718180
x17: 45ffff800b366010 x16: 0000000000000000 x15: 9cffff8092bfcdf0
x14: ffffffefef411b8c x13: 0000000000000001 x12: 0000000000000002
x11: ffffffffffffff00 x10: 0000000000000000 x9 : efffffc000000000
x8 : ffffffc016437a60 x7 : 0000000000000000 x6 : ffffffefef8246cc
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffeff0bf48ee
x2 : 0000000000000008 x1 : ffffffc0164379b8 x0 : ffffffc016437998
Call trace:
 __hwasan_check_x2_67043363+0x4/0x34
 mas_wr_store_entry+0x178/0x5c0
 mas_store+0x88/0xc8
 dup_mmap+0x4bc/0x6d8
 dup_mm+0x8c/0x17c
 copy_mm+0xb0/0x12c
 copy_process+0xa44/0x17d4
 kernel_clone+0x100/0x2cc
 __arm64_sys_clone+0xf4/0x120
 el0_svc_common+0xfc/0x1cc
 do_el0_svc_compat+0x38/0x5c
 el0_svc_compat+0x68/0xf4
 el0t_32_sync_handler+0xc0/0xf0
 el0t_32_sync+0x190/0x194
Code: aa0203e0 d2800441 141e931d 9344dc50 (38706930)
