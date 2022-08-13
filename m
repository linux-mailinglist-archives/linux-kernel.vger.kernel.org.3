Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5245919EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbiHMKpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239331AbiHMKpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:45:10 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644627FF9;
        Sat, 13 Aug 2022 03:45:09 -0700 (PDT)
Date:   Sat, 13 Aug 2022 10:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1660387504; x=1660646704;
        bh=mr68/NsAdXC+G9X9bG8jF/vpINHVnEQJpv90ExGKKdA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=sPTb7QdnrMFKFLTxJiv9LuHcKHXbKBlTYsJHejRrkAUAV5Vmpih9IN1+QZNDG4Za3
         ImsN0zxdTjD0AmiHohdOyBA42ulCa+cMR9Y6Nxed8ee01z7X6JNvTazf9IV9xakLI+
         LuQ31sYYBz1r1Y5kW+7lFK2CP7jprsDtqME8lSzDjeGTmWUSyIuChl06+HxZrpU667
         I/y763WUz1i4bHA3C9TXJLiw4rl1M7rUKhGEBknQMjZDRKDgn64BpeaVfDqsGKpGBh
         PQzjAZVRAUkXlpN8MvfKyaxXE/1jB0OYtWhXTc7yZ/YsOvP3g42wjJocCdFu0Oej0F
         RKC+f4Dekb9Aw==
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Miles Chen <miles.chen@mediatek.com>, yassine.oudjana@gmail.com,
        bgolaszewski@baylibre.com, chun-jie.chen@mediatek.com,
        devicetree@vger.kernel.org, ikjn@chromium.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sam.shih@mediatek.com,
        sboyd@kernel.org, tinghan.shen@mediatek.com, weiyi.lu@mediatek.com,
        wenst@chromium.org, ~postmarketos/upstreaming@lists.sr.ht
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: Re: [PATCH v2 4/4] clk: mediatek: Add drivers for MediaTek MT6735 main clock drivers
Message-ID: <lAB8fLfWTwUu6FUqPZWoKNEC0ZPYHnvo05u6BGriYQVjanlTzorHaZAflEbzoml-0UVZe-02r6CfzKwGdBCp7E0YeT_hF86P26r-Zeivda4=@protonmail.com>
In-Reply-To: <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
References: <NJC6CR.M4CF312LSXXV1@gmail.com> <20220520093501.28758-1-miles.chen@mediatek.com> <c7b98ee4-cd4f-d7b7-726d-1acd4fafd50a@collabora.com>
Feedback-ID: 6882736:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 20th, 2022 at 11:26 AM, AngeloGioacchino Del Regno <angelogi=
oacchino.delregno@collabora.com> wrote:

> Il 20/05/22 11:35, Miles Chen ha scritto:
>
> > > > Thanks for submitting this patch.
> > > >
> > > > I compare this with drivers/clk/mediatek/clk-mt7986-apmixed.c,
> > > > and other clk files are using macros to make the mtk_pll_data array
> > > > more readable.
> > >
> > > I'd actually argue that macros make it less readable. While reading
> > > other drivers I had a lot of trouble figuring out which argument
> > > is which field of the struct, and had to constantly go back to the
> > > macro definitions and count arguments to find it. Having it this
> > > way, each value is labeled clearly with the field it's in. I think
> > > the tradeoff between line count and readability here is worth it.
> >
> > It is easier for multiple developers to work together if we have a comm=
on style.
> >
> > How do you think?
>
>
> In my opinion, Yassine is definitely right about this one: unrolling thes=
e macros
> will make the code more readable, even though this has the side effect of=
 making
> it bigger in the source code form (obviously, when compiled, it's going t=
o be the
> exact same size).
>
> I wouldn't mind getting this clock driver in without the usage of macros,=
 as much
> as I wouldn't mind converting all of the existing drivers to open-code ev=
erything
> instead of using macros that you have to find in various headers... this =
practice
> was done in multiple drivers (clock or elsewhere), so I don't think that =
it would
> actually be a bad idea to do it here on MediaTek too, even though I'm not=
 aware of
> any rule that may want us to do that: if you check across drivers/clk/*, =
there's
> a big split in how drivers are made, where some are using macros (davinci=
, renesas,
> samsung, sprd, etc), and some are not (bcm, sunxi-ng, qcom, tegra, versat=
ile, etc),
> so it's really "do it as you wish"...
>
> ... but:
>
> Apart from that, I also don't think that it is a good idea to convert the=
 other
> MTK clock drivers right now, as this would make the upstreaming of MediaT=
ek clock
> drivers harder for some of the community in this moment... especially whe=
n we look
> at how many MTK SoCs are out there in the wild, and how many we have upst=
ream:
> something like 10% of them, or less.
>
> I see the huge benefit of having a bigger community around MediaTek platf=
orms as
> that's beneficial to get a way better support and solidity for all SoCs a=
s they
> are sharing the same drivers and same framework, and expanding the suppor=
t to more
> of them will only make it better with highly valuable community contribut=
ions.
>
>
> That said, Yassine, you should've understood that you have my full suppor=
t on
> unrolling these macros - but it's not time to do that yet: you definitely=
 know
> that MediaTek clock drivers are going through a big cleanup phase which i=
s, at
> this point, unavoidable... if we are able to get the aid of scripts (cocc=
i and
> others), that will make our life easier in this cleanup, and will also ma=
ke us
> able to perform the entire cleanup with less effort and in less overall t=
ime.
>
> With that, I'm sad but I have to support Miles' decision on this one, and=
 I also
> have to ask you to use macros in this driver.

I'm picking up this series again now after taking a long break to allow for
ongoing cleanup and refactoring work to settle down. I was going to make th=
is
change but then I couldn't find the PLL macro defined in any common header.
It seems that it is defined in every driver that uses it, with slight varia=
tions
in some of them. Should I just do the same, or would it be better to define=
 it
in clk-pll.h? Also, would now be a good time to unroll the macros in all dr=
ivers,
or is it still too soon?

Another thing: Since I've been out of touch with the cleanup work for a whi=
le,
it would be great if someone makes me aware of any pending cleanup patches =
that
I should know of so that I base my patches on them and avoid duplicating wo=
rk.

> ...
