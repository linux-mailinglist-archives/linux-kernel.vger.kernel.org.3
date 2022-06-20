Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD452551FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiFTPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiFTPGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:06:46 -0400
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011AD205F6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:44:22 -0700 (PDT)
Received: from iva5-e241271dfbce.qloud-c.yandex.net (iva5-e241271dfbce.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:7a1b:0:640:e241:271d])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 4CEF862388C;
        Mon, 20 Jun 2022 17:44:06 +0300 (MSK)
Received: from iva4-143b1447cf50.qloud-c.yandex.net (iva4-143b1447cf50.qloud-c.yandex.net [2a02:6b8:c0c:7511:0:640:143b:1447])
        by iva5-e241271dfbce.qloud-c.yandex.net (mxback/Yandex) with ESMTP id sKoReUKYOI-i4feduie;
        Mon, 20 Jun 2022 17:44:06 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1655736246;
        bh=NMjUm0hKKGFiUEHGHxxW3dzV2CiFvZwHVUmaKQNqE6w=;
        h=In-Reply-To:Subject:Cc:To:From:References:Date:Message-ID;
        b=qQvWfN4pzOGnTSxeAx3T0PKRT51/FhLw4Su8jW5wxqIF9c9Wu4T24yIKhf/C04v3l
         YSVVU+O+tAB0QU9HTnZQQDdFUnzGjMcH7x3Td19J4FDTplvJOImRZG0eUVDKRkB/1r
         v7yHpPpFaFU+mctBd3MOq07R7ycBGHF8MTfRX5p0=
Authentication-Results: iva5-e241271dfbce.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Received: by iva4-143b1447cf50.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id CiT7k0pAyn-i3MCG5TG;
        Mon, 20 Jun 2022 17:44:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Date:   Mon, 20 Jun 2022 17:44:02 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Atish Patra <atishp@atishpatra.org>, Will Deacon <will@kernel.org>,
        Sunil V L <sunilvl@ventanamicro.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>, linux@yadro.com,
        Nikita Shubin <n.shubin@yadro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/1] RISC-V: Create unique identification for SoC PMU
Message-ID: <20220620174402.1fb82fa4@redslave.neermore.group>
In-Reply-To: <CAMuHMdUoa9H3Nw7ctAbueeVOdJEo_D25niS7E07HWwV2H4Z9Qg@mail.gmail.com>
References: <20220619111115.6354-1-nikita.shubin@maquefel.me>
        <20220619111115.6354-2-nikita.shubin@maquefel.me>
        <CAMuHMdUoa9H3Nw7ctAbueeVOdJEo_D25niS7E07HWwV2H4Z9Qg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert!

On Mon, 20 Jun 2022 09:50:14 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Nikita,
>=20
> On Sun, Jun 19, 2022 at 1:11 PM Nikita Shubin
> <nikita.shubin@maquefel.me> wrote:
> > From: Nikita Shubin <n.shubin@yadro.com>
> >
> > Provide RISC-V SBI PMU id to distinguish different cores or SoCs via
> > "devices/platform/riscv-pmu/id" sysfs entry.
> >
> > The identification is generated as string of marchid, mimpid,
> > mvendorid in hex format separated by coma - "0x70032,0x70032,0x0".
> >
> > The CSRs are detailed in the RISC-V privileged spec [1].
> > [1] https://github.com/riscv/riscv-isa-manual
> >
> > Inspired-by: Jo=C3=A3o M=C3=A1rio Domingos <joao.mario@tecnico.ulisboa.=
pt>
> > Signed-off-by: Nikita Shubin <n.shubin@yadro.com> =20
>=20
> Thanks for your patch!
>=20
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c =20
>=20
> > --- a/drivers/perf/riscv_pmu_sbi.c
> > +++ b/drivers/perf/riscv_pmu_sbi.c
> > @@ -693,6 +693,28 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu
> > *pmu, struct platform_device *pde return 0;
> >  }
> >
> > +static ssize_t id_show(struct device *dev,
> > +                               struct device_attribute *attr, char
> > *buf) +{
> > +       int len;
> > +       struct riscv_pmu *pmu =3D container_of(dev_get_drvdata(dev),
> > struct riscv_pmu, pmu); +
> > +       len =3D sprintf(buf, "%s\n", pmu->pmuid);
> > +       if (len <=3D 0)
> > +               dev_err(dev, "invalid sprintf len: %d\n", len); =20
>=20
> How can this fail?
>=20
> Please use sysfs_emit() instead of sprintf(), and drop the error
> message.

Indeed, thank you for your comments.

Also i missed some explicit free:

> > +out_free_pmuid:
> > +       kfree(pmu->pmuid);

This is not needed.

>=20
> > +
> > +       return len;
> > +} =20
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>=20
> In personal conversations with technical people, I call myself a
> hacker. But when I'm talking to journalists I just say "programmer"
> or something like that. -- Linus Torvalds
