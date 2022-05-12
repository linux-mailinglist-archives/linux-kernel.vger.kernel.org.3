Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D952515C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 17:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356008AbiELPgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 11:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356004AbiELPgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 11:36:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C025C283
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so785308wrc.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 08:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=en7uzZk89o5hiivHxHfeVnKjtCja2ainFuPxfO59LJI=;
        b=IMzreN6mpfvDJ7SDc6lwv2jKc96texJOTvhPVBk52GlqyMl1FGxxf6T5IIeRo5Kqac
         efDy9w7j3bmlF0L0HzNbH81bNcJMZgRSpsTPt/vihNNNPVH3n3s2orO+/NaMm8VSpCmE
         QMnZ926A3Or6BMlO4dyXNcQowOht8RYkLEFghKF9dEOgmdRMQ4Fd2X1qo/MByTNGKolo
         VgnhuzSbYhKrpQoL7pOK87aCCyh+JxwnkJC+mLxOHZ6mF0NIkcabR/Ln0aHbvoZOuG9K
         a6NcvYDxEA3v4DUtP8d0GcIyz7skG3IDlu+Hux9m1sU1Tr6I/ouaOI8CVpamOwfE6HH/
         cZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=en7uzZk89o5hiivHxHfeVnKjtCja2ainFuPxfO59LJI=;
        b=lrjb18b+EqXHr59pS7K/2uw5Fdkwg8PW0NHukSIhBCZci69oq2/J/cCMIEBSNdRgyn
         3rLa/h0carRKvc9SnzRZwGRl2sdHF+5PHiRMekRznl2uudakCTzT14G1LJxTPl+pGho4
         yhIaONACsHQHs8GcFx+S8bpcKZ0yy2Me8v22yli8K77hrbBEhdsdsP2b7XTFdN3fxskz
         ZXW/SEg/TgA62CzylqJoV+odO+th2/VPLMtMTfAQ6i3+qIgH2pT65LgJbk85D3CLf8QD
         wrpqkXplLhUK5zq72SNLzvizGI/lGQHQ44SAgUDuT8Lmuk++DC3rnpdj9T1skMnG7dEz
         Y0yQ==
X-Gm-Message-State: AOAM5311PEXh3aTtzThdC8GQCd+geuKSIAU/MyxGP+oDbr4PKV7V1fuB
        xJCKSi6LGCvHzSBLd53L6VoR1Wy7SDF7QwxcTvxCEQ==
X-Google-Smtp-Source: ABdhPJwsP4fnvpNb9Kz5Vr1C+7g8TOLYnj9DUFzPUdTfvI/li/yFAn6LhCXOZ20Ez7Okhijet9CC7BSvcnhiYu5zenQ=
X-Received: by 2002:a05:6000:12d1:b0:20a:d901:3828 with SMTP id
 l17-20020a05600012d100b0020ad9013828mr197269wrx.313.1652369773255; Thu, 12
 May 2022 08:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220511201107.2311757-1-atishp@rivosinc.com> <CAAhSdy3mbGdK9LrLxZX0JL0mQxP5FrFUuneX1cQS2SABpO=7dw@mail.gmail.com>
 <23274575.ouqheUzb2q@diego>
In-Reply-To: <23274575.ouqheUzb2q@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 12 May 2022 21:06:01 +0530
Message-ID: <CAAhSdy3t6cnfR02kfHvnKdCcDPvyX4jwccV7qkR_=-dV_m0aGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: Fix counter restart during overflow for RV32
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Atish Patra <atishp@rivosinc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        DTML <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 6:12 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Donnerstag, 12. Mai 2022, 06:44:12 CEST schrieb Anup Patel:
> > On Thu, May 12, 2022 at 1:41 AM Atish Patra <atishp@rivosinc.com> wrote=
:
> > >
> > > Pass the upper half of the initial value of the counter correctly
> > > for RV32.
> > >
> > > Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
> > >
> > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > ---
> > >  drivers/perf/riscv_pmu_sbi.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sb=
i.c
> > > index a1317a483512..24cea59612be 100644
> > > --- a/drivers/perf/riscv_pmu_sbi.c
> > > +++ b/drivers/perf/riscv_pmu_sbi.c
> > > @@ -526,7 +526,7 @@ static inline void pmu_sbi_start_overflow_mask(st=
ruct riscv_pmu *pmu,
> > >                         max_period =3D riscv_pmu_ctr_get_width_mask(e=
vent);
> > >                         init_val =3D local64_read(&hwc->prev_count) &=
 max_period;
> > >                         sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_ST=
ART, idx, 1,
> > > -                                 flag, init_val, 0, 0);
> > > +                                 flag, init_val, init_val >> 32, 0);
> >
> > This should be under "#if __riscv_xlen =3D=3D 32".
>
> What's the difference between using CONFIG_32BIT
> and checking the __riscv_xlen flag value?

It's one and the same.

>
> CONFIG_32BIT seems to be a bit the more kernel'ish
> way to do this, but it looks like most SBI parts check the
> __riscv_xlen instead.

I agree with you. We should prefer "#ifdef CONFIG_32BIT"
in this case to match the kernel coding style.

Currently, OpenSBI does not have CONFIG_xyz defines so
over there we use "#if __riscv_xlen =3D=3D 32".

Regards,
Anup

>
>
> In any case, looking at the opensbi-side of the call,
> this fix is abviously correct, so
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>
>
