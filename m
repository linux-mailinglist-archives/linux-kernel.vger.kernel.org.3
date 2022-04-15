Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4075022CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 06:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349694AbiDOE60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 00:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349688AbiDOE4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 00:56:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A303710F0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:53:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id r18so8420985ljp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 21:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v2IHx3Qbgo3wM3/tOigomzLjD7v6BY2hlPBqUcu4Brs=;
        b=WA645uXAq8uzUS58O9L0qm/3eEl4U6ZixnBiBCalf+eeTjC0p1XzE35Hpdh3fSz7EP
         kJRdvPJh3nArYX64LSaxJzsjCvanYkoy8PSp1MIdZEiv4VQy9hpg6qGP67f3bL4KIrJP
         SmqDH5NJWUrqNQpA+cNWQBAzvl0s6I/RNCPasYC2exyDC/PQTZOVFnsMW1qO1QckF9Cr
         eIcYPbks3kAh38ZjN5Vho//fz/T2IRS8PqXCeuafNtB9T4TZhmWc+WJvfEYA1qckvmOd
         JH1bhDpCCoPjyMXC8Msbnys+CCm6OSoe3KMcODvaawDKtmyoRRNRzW3xEi1SsTK7O0Tk
         e79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v2IHx3Qbgo3wM3/tOigomzLjD7v6BY2hlPBqUcu4Brs=;
        b=W24sj/9oCEBeNxdibtx4kMVC7EgZgjKlVG5xy5uaDap44Cx2aZiN2LbSWziYHpO8PZ
         Rc71dS/WnJhqf3gi3yKRxdPU8IMshVxPsswBHalyzWFCBBFHDThkBL80PEXdXii+4kNz
         Wt64tdyN6QBgvq185CForoR+WheQ0y76H8NHgZPPaZmrZdFg8CetUHd4AhrVnkQNv9KX
         n7pir9IeU3XXvVeiMDmpyluJJ5c3V18S65JK5iHO7ZjUZ+d6m28n3nyd8GO78Z5RlsXf
         WSvzkGCf9R+vddRE3WFj2CphU5zof9ngj/1ZE9vKsmBUIDlr6JgO2CJzL04GPPc9+1Nf
         ZN/Q==
X-Gm-Message-State: AOAM531j/aPoaLE0uNYiSvsBHCZcPlekYay1yPTgCZm/PKOJpHgN5crv
        932hALU5cnJD8gOfZ+5DrpwwO3IUsVvWJ64HmL4Z3w==
X-Google-Smtp-Source: ABdhPJyMKLAknTpEqNiOsM8G4x8qCf78+X/p03s7TvJlmBITtJTWR0D+rx0cBX1ozLuRUjW1hvSeuesOng3qFvVZeTo=
X-Received: by 2002:a2e:b6c3:0:b0:249:9b61:656f with SMTP id
 m3-20020a2eb6c3000000b002499b61656fmr3441389ljo.266.1649998437283; Thu, 14
 Apr 2022 21:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220412033335.1384230-1-apatel@ventanamicro.com> <4c4c7a.17284.1802b8c14cc.Coremail.panqinglin2020@iscas.ac.cn>
In-Reply-To: <4c4c7a.17284.1802b8c14cc.Coremail.panqinglin2020@iscas.ac.cn>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 15 Apr 2022 10:23:44 +0530
Message-ID: <CAK9=C2V0kiV1_12kMDxv6d4nsQZ81-9W5=JifLhNaiZMoHJyuQ@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: mm: Fix set_satp_mode() for platform not having Sv57
To:     =?UTF-8?B?5r2Y5bqG6ZyW?= <panqinglin2020@iscas.ac.cn>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
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

On Fri, Apr 15, 2022 at 10:18 AM =E6=BD=98=E5=BA=86=E9=9C=96 <panqinglin202=
0@iscas.ac.cn> wrote:
>
> Hi Anup,
>
> &gt;
> &gt; When Sv57 is not available the satp.MODE test in set_satp_mode() wil=
l
> &gt; fail and lead to pgdir re-programming for Sv48. The pgdir re-program=
ming
> &gt; will fail as well due to pre-existing pgdir entry used for Sv57 and =
as
> &gt; a result kernel fails to boot on RISC-V platform not having Sv57.
> &gt;
> &gt; To fix above issue, we should clear the pgdir memory in set_satp_mod=
e()
> &gt; before re-programming.
> &gt;
> &gt; Fixes: 011f09d12052 ("riscv: mm: Set sv57 on defaultly")
> &gt; Reported-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> &gt; Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> &gt; ---
> &gt;  arch/riscv/mm/init.c | 1 +
> &gt;  1 file changed, 1 insertion(+)
> &gt;
> &gt; diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> &gt; index 9535bea8688c..b0793dc0c291 100644
> &gt; --- a/arch/riscv/mm/init.c
> &gt; +++ b/arch/riscv/mm/init.c
> &gt; @@ -718,6 +718,7 @@ static __init void set_satp_mode(void)
> &gt;            if (!check_l4) {
> &gt;                    disable_pgtable_l5();
> &gt;                    check_l4 =3D true;
> &gt; +                  memset(early_pg_dir, 0, PAGE_SIZE);
> &gt;                    goto retry;
> &gt;            }
> &gt;            disable_pgtable_l4();
> &gt; --
>
>
> I find it that the set_satp_mode function is in .init.text section which =
begins at 0x80800000.
> And its pgd_index in both Sv48 and Sv57 will be 0. So it may not be neces=
sary to clear the
> early_pg_dir when the kernel find Sv57 is not supported? And may I get th=
e steps of reproduction
> from you?

We can't assume that it will be the same pgd_index for Sv48 and Sv57.

For example, some hypothetical SoC might have RAM starting after 1TB space.

We should ensure that early_pg_dir is cleaned entirely for detecting the ne=
xt
mode.

Regards,
Anup

>
> Yours,
> Qinglin
> </apatel@ventanamicro.com></mchitale@ventanamicro.com>
