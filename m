Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81C059B4BC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiHUO6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 10:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiHUO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 10:58:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DA56568;
        Sun, 21 Aug 2022 07:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB2D7B80D84;
        Sun, 21 Aug 2022 14:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C939C43144;
        Sun, 21 Aug 2022 14:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661093897;
        bh=GzHlPdU+t+7DtU8s+ZQkqJLPYJa2D5QllpBgFvrmGaw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f/InbUJweAfp1LwZGHesZqt6a4G8zsWb4eQ8hwBY+fB8ZNzuv2+o+WZHLNeTfA4WO
         tP4Obzfca17jnLVlGgFOFqxNd6GFR4jnIKswxHiVPRByKR0FyyfEjvUWSnMKafFXQ4
         QOr40w20RSDAD9EvrDPFMMrXNqdtlQCXpnGEoCR3w5CIY8AdxOD/JFzlCAcvspGNEm
         DVW630OZ50JWDkTiPs1UE7dtpdaCNgkS+cAO/JlCROhsav5Fnx6kPk1iKt/dCeUOfS
         RZB0YxyQZs+ZabqVHYJ21sh7i3kcM3kQyE6cLB3Q80qen46LSIsGqGB9qTe2iH9WI3
         DNgxHvxgpF3Bw==
Received: by mail-pj1-f54.google.com with SMTP id r15-20020a17090a1bcf00b001fabf42a11cso9000965pjr.3;
        Sun, 21 Aug 2022 07:58:17 -0700 (PDT)
X-Gm-Message-State: ACgBeo1UzReVqDkROWqIcvulnkUnBnVpiaaxctKQ499dF6GT+/QjCwdX
        +b4iybb37ZGKGYbqs43Zl0O8nek38JbGC+MxySk=
X-Google-Smtp-Source: AA6agR5Jfm9mVjshWjpFq8OKc54hNg+6T+J3SLoca3TFw2LF4khEc2uAuPslbwwXSbPSAHiGS5rHKpQKorBBpPqiG2g=
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id
 e13-20020a056102390d00b0038778b9bf9cmr6025080vsu.43.1661093886384; Sun, 21
 Aug 2022 07:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220819014406.32266-1-wangkefeng.wang@huawei.com> <YwIc7qbCWpIVKR2j@arm.com>
In-Reply-To: <YwIc7qbCWpIVKR2j@arm.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 21 Aug 2022 22:57:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4qffsU0Tmb7_b0iQh7x3Bks2vVrmmvL+0Z0CVaVggsYg@mail.gmail.com>
Message-ID: <CAAhV-H4qffsU0Tmb7_b0iQh7x3Bks2vVrmmvL+0Z0CVaVggsYg@mail.gmail.com>
Subject: Re: [PATCH] kernel: exit: cleanup release_thread()
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@quicinc.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For LoongArch parts:

Acked-by: Huacai Chen <chenhuacai@kernel.org>

On Sun, Aug 21, 2022 at 7:54 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 19, 2022 at 09:44:06AM +0800, Kefeng Wang wrote:
> > Only x86 has own release_thread(), introduce a new weak
> > release_thread() function to clean empty definitions in
> > other ARCHs.
> >
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> [...]
> >  arch/arm64/include/asm/processor.h      | 3 ---
> >  arch/arm64/kernel/process.c             | 4 ----
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
