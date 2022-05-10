Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954895209E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiEJAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiEJAUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:20:23 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5220D29C82
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:16:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso770382pjg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 17:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pAjE/FGNfgdcYo2dCSU6dkt2Z0irtgo2y1079975rZQ=;
        b=A1KmbS0lGGlGxKT5sRTYEr//k90phAJXGi4XKVsjlftHnem42HFOpjp6OgCmyH2upk
         G1BtJT+d+2RTyy2jSw1qDE5oCVEFwwohOP6mSkbMYY+X7P0KauU1kz3gvbBYfkQZQyRf
         NZBInmNnxAJxBl/a7c4YxvujXWjHPQMX7KQSv03mPoPfGTBRjUt56p181IEtm7IYTanW
         DdrVDPorXLazHLF30JyK22w9O9cSMJYRi5r48kycl/DpdP4yuUtOLGo1qf1cKIpHirdm
         RnFBYxmVTxVZ2EYb9l/+OpatWiYY1YqU+9o582glhy0Uk3L1HbWsatk2XSw3rJzqrsd/
         uItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pAjE/FGNfgdcYo2dCSU6dkt2Z0irtgo2y1079975rZQ=;
        b=TRWmSvX/DZx3bPY29Qe2GsjBL4NnKSXabfPZqmTjzHpsrgUm6UYb0/cF9JzH7KCuEl
         M0UMOlpN+gYbqmsTajWbcQTD2GNtXAHGNcGFwb9r2SavvwOc4MlrW21LHY9zxRC8GtZx
         stgeCmCMEfb1FHZflyH89t8ot8etexiPySsnFrfXcsMgKdd/iQ0PA5h8OQ35pbe536/d
         0Y+0Xuu4uSvjdVriBjnb8S2f3W1d5CZskvPRX7agkbS6x72rglqs8r19jHwm4+YZgjzh
         H+O6gW+h9UmEI6OxvmbbEqrlgk2+H4EBaNCqlQUNb5PeOKZcWbOqPkWp7p1CHTBaC4Xl
         fM6A==
X-Gm-Message-State: AOAM532LlxCsz4PQy0U0qKHKQ/5dS2yI7j/NT3RjtZV3/4Ulzg85MOYC
        glqA2AXjeW7AMGnhQ3Qusz9RcSozHsY6ZEQNWwY=
X-Google-Smtp-Source: ABdhPJwnORiA/LCdOWDLeRmTlrj3rKUFPlQNpHnR9B8rbxM58w2vhHJv3HLIlr1dNIMOSju9lDA+q8lH54yMOTGRO7E=
X-Received: by 2002:a17:902:e851:b0:15e:93ac:41db with SMTP id
 t17-20020a170902e85100b0015e93ac41dbmr18298641plg.26.1652141784795; Mon, 09
 May 2022 17:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220427053220.719866-1-naoya.horiguchi@linux.dev>
 <CAHbLzko3=bHrsWNGdb0QZijN9oPg3pchbC2F9=_6Td+2xDczhA@mail.gmail.com> <20220509071447.GA123646@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220509071447.GA123646@hori.linux.bs1.fc.nec.co.jp>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 9 May 2022 17:16:12 -0700
Message-ID: <CAHbLzkppuTdA4d6EA=cng9PA9zXEM+dXjEbMxkxn=szF4b-Z5g@mail.gmail.com>
Subject: Re: ##freemail## Re: [PATCH v2] mm/hwpoison: use pr_err() instead of
 dump_page() in get_any_page()
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 12:14 AM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=E3=80=80=
=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Thu, Apr 28, 2022 at 10:25:33AM -0700, Yang Shi wrote:
> > On Tue, Apr 26, 2022 at 10:32 PM Naoya Horiguchi
> > <naoya.horiguchi@linux.dev> wrote:
> > >
> > > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > >
> > > The following VM_BUG_ON_FOLIO() is triggered when memory error event
> > > happens on the (thp/folio) pages which are about to be freed:
> > >
> > >   [ 1160.232771] page:00000000b36a8a0f refcount:1 mapcount:0 mapping:=
0000000000000000 index:0x1 pfn:0x16a000
> > >   [ 1160.236916] page:00000000b36a8a0f refcount:0 mapcount:0 mapping:=
0000000000000000 index:0x1 pfn:0x16a000
> > >   [ 1160.240684] flags: 0x57ffffc0800000(hwpoison|node=3D1|zone=3D2|l=
astcpupid=3D0x1fffff)
> > >   [ 1160.243458] raw: 0057ffffc0800000 dead000000000100 dead000000000=
122 0000000000000000
> > >   [ 1160.246268] raw: 0000000000000001 0000000000000000 00000000fffff=
fff 0000000000000000
> > >   [ 1160.249197] page dumped because: VM_BUG_ON_FOLIO(!folio_test_lar=
ge(folio))
> > >   [ 1160.251815] ------------[ cut here ]------------
> > >   [ 1160.253438] kernel BUG at include/linux/mm.h:788!
> > >   [ 1160.256162] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > >   [ 1160.258172] CPU: 2 PID: 115368 Comm: mceinj.sh Tainted: G       =
     E     5.18.0-rc1-v5.18-rc1-220404-2353-005-g83111+ #3
> > >   [ 1160.262049] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.15.0-1.fc35 04/01/2014
> > >   [ 1160.265103] RIP: 0010:dump_page.cold+0x27e/0x2bd
> > >   [ 1160.266757] Code: fe ff ff 48 c7 c6 81 f1 5a 98 e9 4c fe ff ff 4=
8 c7 c6 a1 95 59 98 e9 40 fe ff ff 48 c7 c6 50 bf 5a 98 48 89 ef e8 9d 04 6=
d ff <0f> 0b 41 f7 c4 ff 0f 00 00 0f 85 9f fd ff ff 49 8b 04 24 a9 00 00
> > >   [ 1160.273180] RSP: 0018:ffffaa2c4d59fd18 EFLAGS: 00010292
> > >   [ 1160.274969] RAX: 000000000000003e RBX: 0000000000000001 RCX: 000=
0000000000000
> > >   [ 1160.277263] RDX: 0000000000000001 RSI: ffffffff985995a1 RDI: 000=
00000ffffffff
> > >   [ 1160.279571] RBP: ffffdc9c45a80000 R08: 0000000000000000 R09: 000=
00000ffffdfff
> > >   [ 1160.281794] R10: ffffaa2c4d59fb08 R11: ffffffff98940d08 R12: fff=
fdc9c45a80000
> > >   [ 1160.283920] R13: ffffffff985b6f94 R14: 0000000000000000 R15: fff=
fdc9c45a80000
> > >   [ 1160.286641] FS:  00007eff54ce1740(0000) GS:ffff99c67bd00000(0000=
) knlGS:0000000000000000
> > >   [ 1160.289498] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   [ 1160.291106] CR2: 00005628381a5f68 CR3: 0000000104712003 CR4: 000=
0000000170ee0
> > >   [ 1160.293031] Call Trace:
> > >   [ 1160.293724]  <TASK>
> > >   [ 1160.294334]  get_hwpoison_page+0x47d/0x570
> > >   [ 1160.295474]  memory_failure+0x106/0xaa0
> > >   [ 1160.296474]  ? security_capable+0x36/0x50
> > >   [ 1160.297524]  hard_offline_page_store+0x43/0x80
> > >   [ 1160.298684]  kernfs_fop_write_iter+0x11c/0x1b0
> > >   [ 1160.299829]  new_sync_write+0xf9/0x160
> > >   [ 1160.300810]  vfs_write+0x209/0x290
> > >   [ 1160.301835]  ksys_write+0x4f/0xc0
> > >   [ 1160.302718]  do_syscall_64+0x3b/0x90
> > >   [ 1160.303664]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > >   [ 1160.304981] RIP: 0033:0x7eff54b018b7
> > >
> > > As shown in the RIP address, this VM_BUG_ON in folio_entire_mapcount(=
) is
> > > called from dump_page("hwpoison: unhandlable page") in get_any_page()=
.
> > > The below explains the mechanism of the race:
> > >
> > >   CPU 0                                       CPU 1
> > >
> > >     memory_failure
> > >       get_hwpoison_page
> > >         get_any_page
> > >           dump_page
> > >             compound =3D PageCompound
> > >                                                 free_pages_prepare
> > >                                                   page->flags &=3D ~P=
AGE_FLAGS_CHECK_AT_PREP
> > >             folio_entire_mapcount
> > >               VM_BUG_ON_FOLIO(!folio_test_large(folio))
> > >
> > > So replace dump_page() with safer one, pr_err().
> > >
> > > Fixes: 74e8ee4708a8 ("mm: Turn head_compound_mapcount() into folio_en=
tire_mapcount()")
> > > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > > ---
> > > ChangeLog v1 -> v2:
> > > - v1: https://lore.kernel.org/linux-mm/20220414235950.840409-1-naoya.=
horiguchi@linux.dev/T/#u
> > > - update caller side instead of changing dump_page().
> > > ---
> > >  mm/memory-failure.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > > index 35e11d6bea4a..0e1453514a2b 100644
> > > --- a/mm/memory-failure.c
> > > +++ b/mm/memory-failure.c
> > > @@ -1270,7 +1270,7 @@ static int get_any_page(struct page *p, unsigne=
d long flags)
> > >         }
> > >  out:
> > >         if (ret =3D=3D -EIO)
> > > -               dump_page(p, "hwpoison: unhandlable page");
> > > +               pr_err("Memory failure: %#lx: unhandlable page.\n", p=
age_to_pfn(p));
> >
> > I think dump_page() is helpful to tell the users more information
> > about the unhandlable page, I'm ok with this fix for now, but should
> > we consider having a memory failure safe dump_page() in the future?
>
> Yes, maybe that would be helpful not only in this unhandlable case, so so=
unds
> good to me.  But how do we handle folio's case?  And I'm not sure that th=
e full
> info in dump_page() is needed in a memory_failure-specific variant.

Off the top of my head, we just dump the raw information of the page
and the head page if it belongs to a large folio at the moment? This
may be just slightly different from dump_page().

>
> Thanks,
> Naoya Horiguchi
