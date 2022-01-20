Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D88494DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbiATMLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:11:44 -0500
Received: from mail-4316.protonmail.ch ([185.70.43.16]:12935 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiATMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:11:43 -0500
Date:   Thu, 20 Jan 2022 12:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1642680701;
        bh=vKnJ+ofI06qoB9HnFKYZwsk5Xo8ocDD+ZmIklk+nuOY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=Zhrz12q2AoZYfhP26mj3ox1khlE1cTDPQ8YP9jWHlefCIIng0YqTOEanl3+SS7R7X
         B6gkFp1EgX1pHdPcCwscU9FGde2jGWNrIsj1/ZO5v9jegJd1CVzC3ZZo5vBldwz3Qr
         lraAV5X4Lo4Q9XmQcrYVFTJHtPmTjKiQ2SgpbO509tL8pt9zDmB3eA68q1JFpselqQ
         Uu+DMqPn5Vt9/Nxygh6yZQ7aOCeMEqaAziAnH7r4Pxqmh8ggF5h4gJcAP0oZOtvmM/
         xLryowX9KowbLzd6dKek0YjJHo0sOj3UnsjfSdTtlaBEXlPlxFHzJDoJ2qQvlibiMa
         9sch4eHwVFtIg==
To:     Stephen Boyd <sboyd@kernel.org>
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@protonmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, alyssa@rosenzweig.io,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Reply-To: =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@protonmail.com>
Subject: Re: [PATCH v2 2/3] clk: clk-apple-nco: Add driver for Apple NCO
Message-ID: <ED361B6C-0BE2-4FDD-AF29-497E14A183A6@protonmail.com>
In-Reply-To: <20220120053810.71C17C340E0@smtp.kernel.org>
References: <20220118191839.64086-1-povik+lin@protonmail.com> <20220118191839.64086-3-povik+lin@protonmail.com> <20220120053810.71C17C340E0@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

thanks for the review.

> On 20. 1. 2022, at 6:38, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Martin Povi=C5=A1er (2022-01-18 11:21:10)
>> diff --git a/drivers/clk/clk-apple-nco.c b/drivers/clk/clk-apple-nco.c
>> new file mode 100644
>> index 000000000000..593f5b5ce5b7
>> --- /dev/null
>> +++ b/drivers/clk/clk-apple-nco.c


>> +static u32 nco_div_translate(struct nco_tables *tbl, unsigned int div)
>> +{
>> +       unsigned int coarse =3D div / 4;
>> +
>> +       if (WARN_ON(nco_div_out_of_range(div)))
>
> Maybe worth knowing which clk is out of range?

This can only happen when nco_div_translate is used wrong, which should nev=
er
happen with the code as-is, so I wouldn't think it is worth expanding on.

>> +
>> +static int nco_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                               unsigned long parent_rate)
>> +{
>> +       struct nco_channel *chan =3D to_nco_channel(hw);
>> +       unsigned long flags;
>> +       u32 div;
>> +       s32 inc1, inc2;
>> +       bool was_enabled;
>> +
>> +       div =3D 2 * parent_rate / rate;
>> +       inc1 =3D 2 * parent_rate - div * rate;
>> +       inc2 =3D -((s32) (rate - inc1));
>
> Is the cast necessary?

Answering that prompted me to get back to reading some C specification and =
now
I am confident in moving away from signed types here and in nco_recalc_rate
altogether.

>>
>> +
>> +static unsigned long nco_recalc_rate(struct clk_hw *hw,
>> +                               unsigned long parent_rate)
>> +{

>> +
>> +       /* Scale both sides of division by incbase to maintain precision=
 */
>> +       incbase =3D inc1 - inc2;
>> +
>> +       return div_u64(((u64) parent_rate) * 2 * incbase,
>> +                       ((u64) div) * incbase + inc1);
>
> Why is the divisor casted to 64 bits? div_u64() takes a u32 divisor so
> if it's going to overflow 32 bits we're in trouble.

Yeah, we need div64_u64, great you caught that.

>> +       struct nco_tables *tbl;
>> +       unsigned int nchannels;
>> +       int ret, i;
>> +
>> +       regs =3D devm_platform_get_and_ioremap_resource(pdev, 0, &regs_r=
es);
>> +       if (IS_ERR(regs))
>> +               return PTR_ERR(regs);
>> +
>> +       if (resource_size(regs_res) < NCO_CHANNEL_REGSIZE)
>> +               return -EINVAL;
>> +       nchannels =3D (resource_size(regs_res) - NCO_CHANNEL_REGSIZE)
>> +                       / NCO_CHANNEL_STRIDE + 1;
>
> Is this some sort of DIV_ROUND_UP()?

Almost. I will shop around for a macro replacement.

Martin
