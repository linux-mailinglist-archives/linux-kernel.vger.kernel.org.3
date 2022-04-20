Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E277508236
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359812AbiDTHed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356242AbiDTHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:34:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF853338AB;
        Wed, 20 Apr 2022 00:31:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D4DAB81D49;
        Wed, 20 Apr 2022 07:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED4C7C385A9;
        Wed, 20 Apr 2022 07:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650439901;
        bh=Gaa/kKlQJ1FZzJzU//2sD+rws3+4VoYKDAstnglOxLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KzbmApoCTqXK1O3oM3GyEcjozjtNIABT3CpFhb4STIN1XPXY3rl2WkwJvMyMGEGQA
         Czz/kvS89Mx/Fgxo4Ty+rSNUTMckCSKLS219iKzR36zKkWyUOH4Eou4GPXMebiRjCy
         jiVn6UqvHmNV5BRPYlEiVJ1Ai8Af/vxoirKye0DkkXj0DF/ROgx8ilWgSGO8haSQUn
         GEaALLypW10Vl6Cc5BWi2cnLPgm1eNoZiRaH1IOwKR54ttwG4+/FjdEnO/E7gQHyf6
         Cf20nKY98g9nq63ukKyD+2mRS0cHhgfNrAlKkHdoLAq4NdtdNOsGGQORdXKRu8XZnq
         HH7m2YfwW76nA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e2afb80550so1139221fac.1;
        Wed, 20 Apr 2022 00:31:40 -0700 (PDT)
X-Gm-Message-State: AOAM532zVaWfOrSBjjOxzJdSPzu++7PUvSY5ZXwxQsqq9Uvywl3YiP7f
        GBvXsyF1E9xoANRmKZOD7BPYBxK0DyjqBGns+9w=
X-Google-Smtp-Source: ABdhPJynajv3K6AdbTR66x16tS+6R53JFDVzu1p0IAT/68oZB2y+PB3uPGIU0m+ilSMwbTvCOiCV4egJ4cUxv0EEA1E=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr1036835oap.228.1650439900047; Wed, 20
 Apr 2022 00:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
In-Reply-To: <CA+G9fYuACgY2hcAgh_LwVb9AURjodMJbV6SsJb90wj-0aJKUOw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 20 Apr 2022 09:31:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
Message-ID: <CAMj1kXFKzi14UCoiDOMwS5jyNz61_UzxGXm+ke0EWEt4nn6E1g@mail.gmail.com>
Subject: Re: [next] arm: boot failed - PC is at cpu_ca15_set_pte_ext
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        max.krummenacher@toradex.com, Shawn Guo <shawnguo@kernel.org>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Christoph Hellwig <hch@lst.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 at 12:59, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Linux next 20220419 boot failed on arm architecture qemu_arm and BeagleBoard
> x15 device.
>
> kernel crash log from x15:
> -----------------
> [    6.866516] 8<--- cut here ---
> [    6.869598] Unable to handle kernel paging request at virtual
> address f000e62c
> [    6.876861] [f000e62c] *pgd=82935811, *pte=00000000, *ppte=00000000
> [    6.883209] Internal error: Oops: 807 [#3] SMP ARM
> [    6.888000] Modules linked in:
> [    6.891082] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G      D W
>   5.18.0-rc3-next-20220419 #1
> [    6.899993] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    6.906127] PC is at cpu_ca15_set_pte_ext+0x4c/0x58
> [    6.911041] LR is at handle_mm_fault+0x60c/0xed0
> [    6.915679] pc : [<c031f26c>]    lr : [<c04cfeb8>]    psr: 40000013
> [    6.921966] sp : f000dde8  ip : f000de44  fp : a0000013
> [    6.927215] r10: 00000000  r9 : 00000000  r8 : c1e95194
> [    6.932464] r7 : c3c95000  r6 : befffff1  r5 : 00000081  r4 : c29d8000
> [    6.939025] r3 : 00000000  r2 : 00000000  r1 : 00000040  r0 : f000de2c
> [    6.945587] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [    6.952758] Control: 10c5387d  Table: 8020406a  DAC: 00000051
> [    6.958526] Register r0 information: 2-page vmalloc region starting
> at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> [    6.969299] Register r1 information: non-paged memory
> [    6.974365] Register r2 information: NULL pointer
> [    6.979095] Register r3 information: NULL pointer
> [    6.983825] Register r4 information: slab task_struct start
> c29d8000 pointer offset 0
> [    6.991729] Register r5 information: non-paged memory
> [    6.996795] Register r6 information: non-paged memory
> [    7.001861] Register r7 information: slab vm_area_struct start
> c3c95000 pointer offset 0
> [    7.010009] Register r8 information: non-slab/vmalloc memory
> [    7.015716] Register r9 information: NULL pointer
> [    7.020446] Register r10 information: NULL pointer
> [    7.025238] Register r11 information: non-paged memory
> [    7.030426] Register r12 information: 2-page vmalloc region
> starting at 0xf000c000 allocated at kernel_clone+0x94/0x3b0
> [    7.041259] Process swapper/0 (pid: 1, stack limit = 0xfaff0077)
> [    7.047302] Stack: (0xf000dde8 to 0xf000e000)
> [    7.051696] dde0:                   c29d8000 00000cc0 c20a1108
> c2065fa0 c1e09f50 b6db6db7
> [    7.059906] de00: c195bf0c 17c0f572 c29d8000 c3c95000 00000cc0
> 000befff befff000 befffff1
> [    7.068115] de20: 00000081 c3c3afb8 c3c3afb8 00000000 00000000
> 00000000 00000000 00000000
> [    7.076324] de40: 00000000 17c0f572 befff000 c3c95000 00002017
> befffff1 00002017 00002fb8
> [    7.084564] de60: c2d04000 00000081 c29d8000 c04c6790 c20d01d4
> 00000000 00000001 c20ce440
> [    7.092773] de80: c1e10bcc fffff000 00000000 c2a45680 eeb33cc0
> c29d8000 00000000 c2d04000
> [    7.100982] dea0: befffff1 f000df18 00000000 00002017 c20661a0
> c04c77e8 f000df18 00000000
> [    7.109222] dec0: 00000000 c1d95c40 00000002 c20661e0 00000000
> 00000001 00000000 c04c7ad0
> [    7.117431] dee0: 00000011 c2d02a00 00000001 befffff1 c29d8000
> 00000000 00000011 c2a30010
> [    7.125640] df00: c29d8000 c0524c24 f000df18 00000000 00000000
> 2cd9e000 c1d95c40 17c0f572
> [    7.133850] df20: 00000000 c2d02a00 0000000b 00000ffc 00000000
> befffff1 00000000 c0524f74
> [    7.142089] df40: c1e0e394 c2d02a00 c209a71c 38e38e39 c29d8000
> bee00008 c2d02a00 c2a30000
> [    7.150299] df60: c1e0e394 c1e0e420 00000000 00000000 00000000
> c05266bc c209a000 c1944c60
> [    7.158508] df80: 00000000 00000000 00000000 c129d2b4 c209a000
> c1e0e394 00000000 c12b5600
> [    7.166748] dfa0: 00000000 c12b5518 00000000 c0300168 00000000
> 00000000 00000000 00000000
> [    7.174957] dfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    7.183166] dfe0: 00000000 00000000 00000000 00000000 00000013
> 00000000 00000000 00000000
> [    7.191406] Code: 13110001 12211b02 13110b02 03a03000 (e5a03800)

This decodes to

   0: 13110001 tstne r1, #1
   4: 12211b02 eorne r1, r1, #2048 ; 0x800
   8: 13110b02 tstne r1, #2048 ; 0x800
   c: 03a03000 moveq r3, #0
  10:* e5a03800 str r3, [r0, #2048]! ; 0x800 <-- trapping instruction

and R0 points into the stack. So we are updating a PTE that is located
on the stack rather than in a page table somewhere, which seems very
odd. However, this could be a latent bug that got uncovered by the
VMAP stacks changes.

Unfortunately, the vmlinux.xz file I downloaded from the link below
seems to be different from the one that produced the crash, given that
the LR address of c04cfeb8 does not seem to correspond with
handle_mm_fault+0x60c/0xed0.

Can you please double check the artifacts?



> metadata:
>   git_ref: master
>   git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git_sha: 634de1db0e9bbeb90d7b01020e59ec3dab4d38a1
>   git_describe: next-20220419
>   kernel-config: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/config
>   System.map:  https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/System.map
>   vmlinux.xz: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R/vmlinux.xz
>   build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/519362851
>   build: https://builds.tuxbuild.com/280TXP6P7tIBfnowvFY4wobXp3R
>   toolchain: gcc-10
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>
> [1] https://lkft.validation.linaro.org/scheduler/job/4921995#L2616
> [2] https://lkft.validation.linaro.org/scheduler/job/4922061#L552
