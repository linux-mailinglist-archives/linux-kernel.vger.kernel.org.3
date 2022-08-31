Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227735A75AD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiHaFXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiHaFX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:23:26 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDB2B6D72
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:23:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z72so11034102iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=rW4IQ+xjfRGsn6d/leXF4ApTBgqpSiBCGDBfRzUGS+g=;
        b=mTdRK943io74C39RB7AOeX0pTzIzNk9KHFsdhRSS7UXdjybw6YeSMrgbAsnwXzTAoY
         jXMBHrsV4W77kuZQOdG0ykGmPJqVtNbbBUQvfesR55OLJFUT5VZbtMDKtH94fJ1RI539
         8Rt2h0ugwl8qfT8p+C6C4rnXkyx2WhokXuAewpEVxy62Ia5FBqBQBL2GVQFmrtYXxCe/
         WB9N+Q4OPOjCU7BR3JSSIfSRSBI/0iKI+fTqtILHhJTPCtN7lD6wzhtbtVM4+37UiX/M
         DsH3PJdFkBVSozZ/72e7v8aiiX3lNZSMWMmdg9OBRlZdMb2LZ39NffLpGosqhT/dxgEU
         Tb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=rW4IQ+xjfRGsn6d/leXF4ApTBgqpSiBCGDBfRzUGS+g=;
        b=j3pDxFk8+maA4GFGEYL7VoXiWowZ0cBJzbj0z750DwK7axqEPy/KpgKzyKJTM6FHUX
         uJ23DN5q+BPQMOvxzctkzqOctW6D0JJujibT5l6SCke6lPBmJKgrP49o2+mqL06ZJFxT
         q5c0UOvkVQnZK9H88wh4kfUBlMmM8UvAnEgCmeIeuJBaRFOlNaYuDE9RF3dTVFjvkARa
         eXd8LOMbE4tP6Ir9Yh+ZtcVcU0K8m/AsWaKEwr6012uzHZif9p7C8NkBp/zuY2GpMk4P
         GBW4C+g5U6+3v+UwaET0+b+3c2V9OYV3xgho88PlubUzIBUf93sFaWpCFrUbuNq3Zk9V
         HTfQ==
X-Gm-Message-State: ACgBeo3/Tl2Yr6PSsq59/nm8JyyY5vZTWebKZN7uCTnKsH+vAG21VY4Q
        /3atymqzErj0TIYvfHM9TanUsgjR4wNGCfODsBrj4YSE
X-Google-Smtp-Source: AA6agR6axZJPbqDTTuhQksx5GAmJ4iOhDb5mUHuLTv855yduTm19vd2Lu6I5XKDIbABtpxfR7TDmDu++/lxyPo+qKh0=
X-Received: by 2002:a02:294a:0:b0:349:fb9e:b5e0 with SMTP id
 p71-20020a02294a000000b00349fb9eb5e0mr14284324jap.115.1661923373032; Tue, 30
 Aug 2022 22:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220829062202.3287-1-zong.li@sifive.com> <20220830082620.1680602-1-ben.dooks@sifive.com>
 <fdec1b72-27f3-96e6-5e19-d54ded4aea68@microchip.com> <cefcf96f-5bcc-d134-fbe5-d1169313b6f3@codethink.co.uk>
In-Reply-To: <cefcf96f-5bcc-d134-fbe5-d1169313b6f3@codethink.co.uk>
From:   Zong Li <zongbox@gmail.com>
Date:   Wed, 31 Aug 2022 13:22:41 +0800
Message-ID: <CA+ZOyajWRUFppg26O1XHfRuJHWB3jk-=-i=FBV9XYgHgshuwQA@mail.gmail.com>
Subject: Re: [PATCH] soc: sifive: ccache: reduce printing on init
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     Conor.Dooley@microchip.com, ben.dooks@sifive.com,
        zong.li@sifive.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Dooks <ben.dooks@codethink.co.uk> =E6=96=BC 2022=E5=B9=B48=E6=9C=8831=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A81:04=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 30/08/2022 17:30, Conor.Dooley@microchip.com wrote:
> > On 30/08/2022 09:26, Ben Dooks wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
> >>
> >> The driver prints out 6 lines on startup, which can easily be redcued
> >> to two lines without losing any information.
> >>
> >> Note, to make the types work better, uint64_t has been replaced with
> >> ULL to make the unsigned long long match the format in the print
> >> statement.
> >>
> >> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> >> ---
> >>   drivers/soc/sifive/sifive_ccache.c | 25 +++++++++++--------------
> >>   1 file changed, 11 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/soc/sifive/sifive_ccache.c b/drivers/soc/sifive/s=
ifive_ccache.c
> >> index 46ce33db7d30..65a10a6ee211 100644
> >> --- a/drivers/soc/sifive/sifive_ccache.c
> >> +++ b/drivers/soc/sifive/sifive_ccache.c
> >> @@ -76,20 +76,17 @@ static void setup_sifive_debug(void)
> >>
> >>   static void ccache_config_read(void)
> >>   {
> >> -       u32 regval, val;
> >> -
> >> -       regval =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >> -       val =3D regval & 0xFF;
> >> -       pr_info("CCACHE: No. of Banks in the cache: %d\n", val);
> >> -       val =3D (regval & 0xFF00) >> 8;
> >> -       pr_info("CCACHE: No. of ways per bank: %d\n", val);
> >> -       val =3D (regval & 0xFF0000) >> 16;
> >> -       pr_info("CCACHE: Sets per bank: %llu\n", (uint64_t)1 << val);
> >> -       val =3D (regval & 0xFF000000) >> 24;
> >> -       pr_info("CCACHE: Bytes per cache block: %llu\n", (uint64_t)1 <=
< val);
> >> -
> >> -       regval =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> >> -       pr_info("CCACHE: Index of the largest way enabled: %d\n", regv=
al);
> >> +       u32 cfg;
> >> +
> >> +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_CONFIG);
> >> +
> >> +       pr_info("CCACHE: %u banks, %u ways, sets/bank=3D%llu, bytes/bl=
ock=3D%llu\n",
> >> +               (cfg & 0xff), (cfg >> 8) & 0xff,
> >> +               1ULL << ((cfg >> 16) & 0xff),
> >
> > This is just BIT_ULL((cfg >> 16) & 0xff), no?
> > Would be nice too if these were defined, so you'd have something
> > like BIT_ULL((cfg >> SETS_PER_BANK_SHIFT) & 0xff)
> >
> > I do like the cleanup of the uint64_t & cutting down on the prints
> > though :) Again, it'd be nice if you and Zong could collaborate on
> > a combined v2.
>
> I think even BIT_UL() would do here, if someone is going to make a
> cache bigger than 2GiB we'll probably be quite old by then, so v2
> might have the last two values down as %lu.
>

Hi Ben,
Thanks for your suggestion, If you don't mind, I will take this into
my V2 patchset.

> > Thanks,
> > Conor.
> >
> >> +               1ULL << ((cfg >> 24) & 0xff));
> >> +
> >> +       cfg =3D readl(ccache_base + SIFIVE_CCACHE_WAYENABLE);
> >> +       pr_info("CCACHE: Index of the largest way enabled: %d\n", cfg)=
;
> >>   }
> >>
> >>   static const struct of_device_id sifive_ccache_ids[] =3D {
> >> --
> >> 2.35.1
> >>
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>
> --
> Ben Dooks                               http://www.codethink.co.uk/
> Senior Engineer                         Codethink - Providing Genius
>
> https://www.codethink.co.uk/privacy.html
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
