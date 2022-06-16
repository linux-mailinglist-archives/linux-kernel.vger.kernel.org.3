Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8F54D8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356579AbiFPDDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357633AbiFPDDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:03:34 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F3A5908A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:03:33 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n4so57472vsm.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK4aJf4dNKPPG+yrUWwtkRmADyYs8/1P16jxzY6zkAo=;
        b=hJOf7+nGrqydnUcuaV8uAn8kgR5hGvqhYHn2L2vBeA+YlPLCGHdHmqHfMv2uc4MobD
         xMgdlBHLPI8q58KyiRhiuYprVFQAx/DZ4/r4OUbwP8T39aqJLVz74ZUhUA3T4fZao2rz
         kQZfrx1WYOtj7+vqPerH1bPla7mnuFs2VnIlFXG1WRkwryNOsLfmKYFrhBk/FRa3a793
         cfIkV6fFzV9+UWXiFE3g8JZR4x4eQHgJOL0dzl3yWON0B8muxtauDfOh7dMJtLSZYPlU
         E4fLmPrtbDDSeNwmn2tP3ZyYBTAEfgsjnDN5+SiC4+RHrSPzzXSBCgc+0JuOsGUJQIX8
         RLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK4aJf4dNKPPG+yrUWwtkRmADyYs8/1P16jxzY6zkAo=;
        b=yhshSbUHtWcnPrIcZT/sbQXtO1YnqZmeQbVV5XBxkfMPg/xHc6vd8gwvP3bFyCl41Q
         8eDK02iYhni8c51JfXNq/Ce8XR8SpTAqujvpRK+vo2Co8arjRLgZVSYuh7XClNimge11
         OgzvjI7dsBrZfmaSXJOy6wKO8gzzJXstIPmmZMOiPrRR+jhmbrPw/5t1YCnOqPXcRBBL
         af/HfDBiClIZPMvXZTKwCrarRVlRkYsjY2BX0VvkabkLI6oAQ85tSOVkwLN2Y0TXTIiY
         pd0dwfJJQFku8Nzk28AbZvVUbA85Xu6A3M14INrYQPt9fdTIxv2RF6aFGDFyY3fdqq9s
         1FBA==
X-Gm-Message-State: AJIora/fb0oDn1GI/MXcVazSV9UoAkF1Li683NC6r67JxJFZ0AyX+0+e
        x7F9l91faEB4OmjWR2EA6Dj9vwp9rGf1FnNQymSedQ==
X-Google-Smtp-Source: AGRyM1v1X3hcxC/hdemLGne774q7m11lOSax/ov6+bStIC/IJdsxP1W987QqVdf/p2/NMGVsGMmOhJWqr1J+zO6Urk0=
X-Received: by 2002:a05:6102:214c:b0:34b:b31d:1a50 with SMTP id
 h12-20020a056102214c00b0034bb31d1a50mr1268700vsg.41.1655348612359; Wed, 15
 Jun 2022 20:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <Yp4uD8uWB3rit/Ee@qian> <CAOUHufZk+3xCqK38CuVdWg_ZiWaLyke+Y+=CYJpraET6nKQ=yQ@mail.gmail.com>
 <CAOUHufbOz66HPebrCuJXfnfapY0qxu42-1Ppbti86Yii-GYsAQ@mail.gmail.com>
 <20220615142508.mtp65w6tdiurtvcn@revolver> <CAOUHufaoZ99qkBfsRWwCAx6fspL5KJYgCGe=nOVR07_2dF6URQ@mail.gmail.com>
 <20220615185500.i5bzt7srzm6q72na@revolver> <CAOUHufY5dBrNc81oDnmKSyRY2d3=e0CZJiXaOUBs=LFoUBDJUg@mail.gmail.com>
 <CAOUHufZa9G2VDHLPsNmp3yRyXqYCE-3-nT6P7+uf-gbgyOHXYQ@mail.gmail.com>
 <20220616014956.6jgxvbzh4ld3c32q@revolver> <CAOUHufZtq0PDiGXBvLV=POraK-4dfnQ9UNmsafHhJmzxAhzrfw@mail.gmail.com>
 <20220616025557.euz6z5rlh7fqewy2@revolver>
In-Reply-To: <20220616025557.euz6z5rlh7fqewy2@revolver>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 15 Jun 2022 21:02:56 -0600
Message-ID: <CAOUHufb04ej_R32qWgah1Oqds_KpEgL+=d0SysE=pfCM7wovxQ@mail.gmail.com>
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

On Wed, Jun 15, 2022 at 8:56 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Yu Zhao <yuzhao@google.com> [220615 21:59]:
> > On Wed, Jun 15, 2022 at 7:50 PM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > > * Yu Zhao <yuzhao@google.com> [220615 17:17]:
> > >
> > > ...
> > >
> > > > > Yes, I used the same parameters with 512GB of RAM, and the kernel with
> > > > > KASAN and other debug options.
> > > >
> > > > Sorry, Liam. I got the same crash :(
> > >
> > > Thanks for running this promptly.  I am trying to get my own server
> > > setup now.
> > >
> > > >
> > > > 9d27f2f1487a (tag: mm-everything-2022-06-14-19-05, akpm/mm-everything)
> > > > 00d4d7b519d6 fs/userfaultfd: Fix vma iteration in mas_for_each() loop
> > > > 55140693394d maple_tree: Make mas_prealloc() error checking more generic
> > > > 2d7e7c2fcf16 maple_tree: Fix mt_destroy_walk() on full non-leaf non-alloc nodes
> > > > 4d4472148ccd maple_tree: Change spanning store to work on larger trees
> > > > ea36bcc14c00 test_maple_tree: Add tests for preallocations and large
> > > > spanning writes
> > > > 0d2aa86ead4f mm/mlock: Drop dead code in count_mm_mlocked_page_nr()
> > > >
> > > > ==================================================================
> > > > BUG: KASAN: slab-out-of-bounds in mab_mas_cp+0x2d9/0x6c0
> > > > Write of size 136 at addr ffff88c35a3b9e80 by task stress-ng/19303
> > > >
> > > > CPU: 66 PID: 19303 Comm: stress-ng Tainted: G S        I       5.19.0-smp-DEV #1
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl+0xc5/0xf4
> > > >  print_address_description+0x7f/0x460
> > > >  print_report+0x10b/0x240
> > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > >  kasan_report+0xe6/0x110
> > > >  ? mast_spanning_rebalance+0x2634/0x29b0
> > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > >  kasan_check_range+0x2ef/0x310
> > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > >  ? mab_mas_cp+0x2d9/0x6c0
> > > >  memcpy+0x44/0x70
> > > >  mab_mas_cp+0x2d9/0x6c0
> > > >  mas_spanning_rebalance+0x1a3e/0x4f90
> > >
> > > Does this translate to an inline around line 2997?
> > > And then probably around 2808?
> >
> > $ ./scripts/faddr2line vmlinux mab_mas_cp+0x2d9
> > mab_mas_cp+0x2d9/0x6c0:
> > mab_mas_cp at lib/maple_tree.c:1988
> > $ ./scripts/faddr2line vmlinux mas_spanning_rebalance+0x1a3e
> > mas_spanning_rebalance+0x1a3e/0x4f90:
> > mast_cp_to_nodes at lib/maple_tree.c:?
> > (inlined by) mas_spanning_rebalance at lib/maple_tree.c:2997
> > $ ./scripts/faddr2line vmlinux mas_wr_spanning_store+0x16c5
> > mas_wr_spanning_store+0x16c5/0x1b80:
> > mas_wr_spanning_store at lib/maple_tree.c:?
> >
> > No idea why faddr2line didn't work for the last two addresses. GDB
> > seems more reliable.
> >
> > (gdb) li *(mab_mas_cp+0x2d9)
> > 0xffffffff8226b049 is in mab_mas_cp (lib/maple_tree.c:1988).
> > (gdb) li *(mas_spanning_rebalance+0x1a3e)
> > 0xffffffff822633ce is in mas_spanning_rebalance (lib/maple_tree.c:2801).
> > quit)
> > (gdb) li *(mas_wr_spanning_store+0x16c5)
> > 0xffffffff8225cfb5 is in mas_wr_spanning_store (lib/maple_tree.c:4030).
>
>
> Thanks.  I am not having luck recreating it.  I am hitting what looks
> like an unrelated issue in the unstable mm, "scheduling while atomic".
> I will try the git commit you indicate above.

Fix here:
https://lore.kernel.org/linux-mm/20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org/
