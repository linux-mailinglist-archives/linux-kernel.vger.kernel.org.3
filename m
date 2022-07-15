Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE1E576303
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbiGONos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGONop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A95147BAE
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:44:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C8EF623D5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA350C34115;
        Fri, 15 Jul 2022 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657892682;
        bh=8BPiocY7scDyLEcAlQjPC++udc/2v52MfXgPwsWJmaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/7omktuc5K9bv7/vVtx7s2hZGuEbq0x4Dh4gwEpveYMluuJqTFobMI6tTQq11MLB
         gIQ9PaLyEE9Muo+wlE9HzsHn1dKUYJC7GRQWYiJQ52ZMnxahn1VyzKEraFZtTIW/h6
         1FuC6wRdT1JG5zL75xUh52YjQ27H+tseApcbggAtffCJre2UsHzQJVRw7N3Ivn0kqK
         yBF60fvKOtN94xRY7MzDB95QGSINMLmbfbknA1Z4mEjxXOkqiWApUvyyyNd0/K06uX
         6FgysEEhgFN/3+LHriZH+Kloq/Td8aj4sdmOX18TkCAxSkScaj6bIcdEuxzoQ6DJiw
         U1ooy1Ii1DwUQ==
Date:   Fri, 15 Jul 2022 21:35:43 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com,
        vincenzo.frascino@arm.com, alexandre.ghiti@canonical.com,
        Atish Patra <atishp@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v4 0/2] use static key to optimize pgtable_l4_enabled
Message-ID: <YtFtL3+/3FNkalZ5@xhacker>
References: <CAAhSdy0mkwacNMVa_jFZmZ+NRPBa1TpKUQGpzr6Z9_wfoq1R4g@mail.gmail.com>
 <mhng-17913c13-57bd-42f9-9136-b4eb9632253c@palmer-mbp2014>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-17913c13-57bd-42f9-9136-b4eb9632253c@palmer-mbp2014>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 08:48:25PM -0700, Palmer Dabbelt wrote:
> On Sat, 25 Jun 2022 21:33:07 PDT (-0700), anup@brainfault.org wrote:
> > On Sat, May 21, 2022 at 8:13 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> > > 
> > > The pgtable_l4|[l5]_enabled check sits at hot code path, performance
> > > is impacted a lot. Since pgtable_l4|[l5]_enabled isn't changed after
> > > boot, so static key can be used to solve the performance issue[1].
> > > 
> > > An unified way static key was introduced in [2], but it only targets
> > > riscv isa extension. We dunno whether SV48 and SV57 will be considered
> > > as isa extension, so the unified solution isn't used for
> > > pgtable_l4[l5]_enabled now.
> > > 
> > > patch1 fixes a NULL pointer deference if static key is used a bit earlier.
> > > patch2 uses the static key to optimize pgtable_l4|[l5]_enabled.
> > > 
> > > [1] http://lists.infradead.org/pipermail/linux-riscv/2021-December/011164.html
> > > [2] https://lore.kernel.org/linux-riscv/20220517184453.3558-1-jszhang@kernel.org/T/#t
> > > 
> > > Since v3:
> > >  - fix W=1 call to undeclared function 'static_branch_likely' error
> > > 
> > > Since v2:
> > >  - move the W=1 warning fix to a separate patch
> > >  - move the unified way to use static key to a new patch series.
> > > 
> > > Since v1:
> > >  - Add a W=1 warning fix
> > >  - Fix W=1 error
> > >  - Based on v5.18-rcN, since SV57 support is added, so convert
> > >    pgtable_l5_enabled as well.
> > > 
> > > 
> > > 
> > > Jisheng Zhang (2):
> > >   riscv: move sbi_init() earlier before jump_label_init()
> > >   riscv: turn pgtable_l4|[l5]_enabled to static key for RV64
> > 
> > I have tested both these patches on QEMU RV64 and RV32.
> > 
> > Tested-by: Anup Patel <anup@brainfault.org>
> > 
> > Thanks,
> > Anup
> 
> Thanks for testing these.  Unfortunatly they're failing for me under my
> kasan+sparsemem-vmemmap config, which looks like a defconfig with
> 
>    CONFIG_KASAN=y
>    # CONFIG_FLATMEM_MANUAL is not set
>    CONFIG_SPARSEMEM_MANUAL=y
>    CONFIG_SPARSEMEM=y
>    # CONFIG_SPARSEMEM_VMEMMAP is not set

Hi Palmer,

Thank you for the hint, I find the reason: SPARSEMEM is the key, KASAN
doesn't matter. To fix this issue, we need to move
riscv_finalise_pgtable_lx() after sparse_init(). I will send out a
newer version soon.

> 
> Nothing's really jumping out and I'm not sure that's a super compelling
> configuration, but IIRC it's found a handful of issues before so I'm not
> sure it's sane to just toss it.
> 
> I've put this all on the riscv-pgtable_static_key branch of
> kernel.org/palmer/linux .  If nobody has the time to look then I'll try and
> give it another shot, but I'm pretty buried right now so happy to have the
> help.

Let me know if you want a seperate patch against
riscv-pgtable_static_key branch.

Thanks

> 
> > 
> > > 
> > >  arch/riscv/include/asm/pgalloc.h    | 16 ++++----
> > >  arch/riscv/include/asm/pgtable-32.h |  3 ++
> > >  arch/riscv/include/asm/pgtable-64.h | 60 ++++++++++++++++++---------
> > >  arch/riscv/include/asm/pgtable.h    |  5 +--
> > >  arch/riscv/kernel/cpu.c             |  4 +-
> > >  arch/riscv/kernel/setup.c           |  2 +-
> > >  arch/riscv/mm/init.c                | 64 ++++++++++++++++++-----------
> > >  arch/riscv/mm/kasan_init.c          | 16 ++++----
> > >  8 files changed, 104 insertions(+), 66 deletions(-)
> > > 
> > > --
> > > 2.34.1
> > > 
