Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B8E505C56
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346085AbiDRQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238992AbiDRQXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:23:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C32ED46
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:20:36 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so17965808edu.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=elXW57Be0NdrpWiKMwVjW4SkRo4i694VaiaG7hyVIl4=;
        b=I0gFisojySowdcruWqGrwv8BEBkRmS4cmTZOEktl76aTgGdz1Nvl4BWn+e4yiG8QxA
         AkrmCqQ+9yEP363iPZPxqEU2/5PYVnsO7dIvJeHnqiyNl9lfnMuRXQTHC7MuIfZxZ65A
         2fo9zNDfacFqj6oz8puRJQovNkbmcZXqFCuRzsMZ70n2vYjKgaQjORRZhN/Oy3QeTq0u
         axyz0GDFlrcg6Q2eumKwrZQUU0loxqHUTlmbtEkVgzpYKhT4ovadVfpA3aDFP5RBgT4B
         O6EId24/SI1DhfxysdXMuZWEWbsSkY0HyzaBiN/c0q2GYqZ/aN2kckrpjbrLpbvU7pXw
         WwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=elXW57Be0NdrpWiKMwVjW4SkRo4i694VaiaG7hyVIl4=;
        b=TauK+yqRmGAfJyJTgKD7qiGdF5G2Koa05BVCVBgHZTWA8ci7xjJ5Cia1JypsIia7+z
         O+oktMqKmNvBHY5J2y2o6MtLwWqbHuZweRKAnAvV3bKBlo1293HYh1qqVrfnBxC3O7Ew
         7xqJdXOzBYQ0TxZoUsnMC4irUU6PPACllr/tXKEtG5O4tlXJHwOK7k9u8YaZxNez76Ml
         hnRGLgCA+yEdIClNpMPF3Esv751nezalokxoC74XVrmSzAgnxXrfmvrBazLFlMOFxezA
         Z15qe1QOj/qwj8Iel2H0ty5z8J+Mr8LEY33+yRAObb/b8Lof/A2I+GeCd0CfdlfXWazr
         yV6Q==
X-Gm-Message-State: AOAM531iZmQdTco3n+jTBS/DIZ8jH/c5njX+huGfPIt4YFsK7IBavKFm
        6k3l6RAb1aCsPh8LMcDxyUMKiRyGjw7Ldxx2XIAxEg==
X-Google-Smtp-Source: ABdhPJxr95S4Cz+dDACB9t3Y9pcQwabk5POhmJfmkYXWHP61HT1QjLu3qRzgMKRSijX9TJ6kp8g9crf/e2B28GnN1os=
X-Received: by 2002:a05:6402:644:b0:41d:77bb:d36d with SMTP id
 u4-20020a056402064400b0041d77bbd36dmr12575830edx.381.1650298835312; Mon, 18
 Apr 2022 09:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com> <1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com>
 <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
In-Reply-To: <ca13a4ec-17a6-8e29-e29e-39f9b47e78df@huawei.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 18 Apr 2022 12:20:00 -0400
Message-ID: <CA+CK2bDntHyMGg_R2m9WYovmxjYSHmZP1=pCxt-uVkTvD79oZw@mail.gmail.com>
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:47 AM Tong Tiangen <tongtiangen@huawei.com> wrot=
e:
>
>
>
> =E5=9C=A8 2022/4/18 17:28, Anshuman Khandual =E5=86=99=E9=81=93:
> > On 4/18/22 09:14, Tong Tiangen wrote:
> >> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> >>
> [...]
> >>   #endif
> >
> > Ran this series on arm64 platform after enabling
> >
> > - CONFIG_PAGE_TABLE_CHECK
> > - CONFIG_PAGE_TABLE_CHECK_ENFORCED (avoiding kernel command line option=
)
> >
> > After some time, the following error came up
> >
> > [   23.266013] ------------[ cut here ]------------
> > [   23.266807] kernel BUG at mm/page_table_check.c:90!
> > [   23.267609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> > [   23.268503] Modules linked in:
> > [   23.269012] CPU: 1 PID: 30 Comm: khugepaged Not tainted 5.18.0-rc3-0=
0004-g60aa8e363a91 #2
> > [   23.270383] Hardware name: linux,dummy-virt (DT)
> > [   23.271210] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   23.272445] pc : page_table_check_clear.isra.6+0x114/0x148
> > [   23.273429] lr : page_table_check_clear.isra.6+0x64/0x148
> > [   23.274395] sp : ffff80000afb3ca0
> > [   23.274994] x29: ffff80000afb3ca0 x28: fffffc00022558e8 x27: ffff800=
00a27f628
> > [   23.276260] x26: ffff800009f9f2b0 x25: ffff00008a8d5000 x24: ffff800=
009f09fa0
> > [   23.277527] x23: 0000ffff89e00000 x22: ffff800009f09fb8 x21: ffff000=
089414cc0
> > [   23.278798] x20: 0000000000000200 x19: fffffc00022a0000 x18: 0000000=
000000001
> > [   23.280066] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000=
000000003
> > [   23.281331] x14: 0000000000000068 x13: 00000000000000c0 x12: 0000000=
000000010
> > [   23.282602] x11: fffffc0002320008 x10: fffffc0002320000 x9 : ffff800=
009fa1000
> > [   23.283868] x8 : 00000000ffffffff x7 : 0000000000000001 x6 : ffff800=
009fa1f08
> > [   23.285135] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000=
000000000
> > [   23.286406] x2 : 00000000ffffffff x1 : ffff000080f2800c x0 : ffff000=
080f28000
> > [   23.287673] Call trace:
> > [   23.288123]  page_table_check_clear.isra.6+0x114/0x148
> > [   23.289043]  __page_table_check_pmd_clear+0x3c/0x50
> > [   23.289918]  pmdp_collapse_flush+0x114/0x370
> > [   23.290692]  khugepaged+0x1170/0x19e0
> > [   23.291356]  kthread+0x110/0x120
> > [   23.291945]  ret_from_fork+0x10/0x20
> > [   23.292596] Code: 91001041 b8e80024 51000482 36fffd62 (d4210000)
> > [   23.293678] ---[ end trace 0000000000000000 ]---
> > [   23.294511] note: khugepaged[30] exited with preempt_count 2
> >
> > Looking into file mm/page_table_check.c where this problem occured.
> >
> > /*
> >   * An enty is removed from the page table, decrement the counters for =
that page
> >   * verify that it is of correct type and counters do not become negati=
ve.
> >   */
> > static void page_table_check_clear(struct mm_struct *mm, unsigned long =
addr,
> >                                     unsigned long pfn, unsigned long pg=
cnt)
> > {
> >          struct page_ext *page_ext;
> >          struct page *page;
> >          unsigned long i;
> >          bool anon;
> >
> >          if (!pfn_valid(pfn))
> >                  return;
> >
> >          page =3D pfn_to_page(pfn);
> >          page_ext =3D lookup_page_ext(page);
> >          anon =3D PageAnon(page);
> >
> >          for (i =3D 0; i < pgcnt; i++) {
> >                  struct page_table_check *ptc =3D get_page_table_check(=
page_ext);
> >
> >                  if (anon) {
> >                          BUG_ON(atomic_read(&ptc->file_map_count));
> >                          BUG_ON(atomic_dec_return(&ptc->anon_map_count)=
 < 0);
> >                  } else {
> >                          BUG_ON(atomic_read(&ptc->anon_map_count));
> >   Triggered here =3D=3D=3D=3D>>  BUG_ON(atomic_dec_return(&ptc->file_ma=
p_count) < 0);
> >                  }
> >                  page_ext =3D page_ext_next(page_ext);
> >          }
> > }
> >
> > Could you explain what was expected during pmdp_collapse_flush() which =
when
> > failed, triggered this BUG_ON() ? This counter seems to be page table c=
heck
> > specific, could it just go wrong ? I have not looked into the details a=
bout
> > page table check mechanism.
> >
> > - Anshuman
> > .
>
> Hi Anshuman:
>
> Thanks for your job.
>
> Let me briefly explain the principle of page table check(PTC).
>
> PTC introduces the following struct for page mapping type count:
> struct page_table_check {
>          atomic_t anon_map_count;
>          atomic_t file_map_count;
> };
> This structure can be obtained by "lookup_page_ext(page)"
>
> When page table entries are set(pud/pmd/pte), page_table_check_set()  is
> called to increase the page mapping count, Also check for errors (eg:if
> a page is used for anonymous mapping, then the page cannot be used for
> file mapping at the same time).
>
> When page table entries are clear(pud/pmd/pte), page_table_check_clear()
>   is called to decrease the page mapping count, Also check for errors.
>
> The error check rules are described in the following documents:
> Documentation/vm/page_table_check.rst
>
> The setting and clearing of page table entries are symmetrical.
>
> Here __page_table_check_pmd_clear() trigger BUGON which indicates that
> the pmd entry file mapping count has become negative.
>
> I guess if PTC didn't detect this exception, would there have been any
> problems?

It is hard to tell what sort of problem has been detected. More
debugging is needed in order to understand it. A huge file entry is
being removed from the page table. However, at least one sub page of
that entry does not have a record that it was added as a file entry to
the page table. At Google we found a few internal security bugs using
PTCs. However, this being new on ARM64, it is possible that the bug is
in PTC/khugepaged itself.

Anshuman is it possible to repro your scenario in QEMU?

Thank you,
Pasha

>
> Thanks,
> Tong.
