Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6045A45F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiH2JWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiH2JWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:22:30 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ADE52E45
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:22:29 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bj12so14408483ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=l9SqLnHlXPzeQYrMBEs42moyjzbzWjc4jKKVIUFPcTo=;
        b=fOfYBTkFV79tTpaxBFa8ZibSbLO3WAJ0ut5n82kiCi9cZSxYbKGt1tygx2u/yd+hfD
         KOSXbTNma9erhCy5T5Mt/GQESvDwBUaFIXCltzq6CmgQjLY/rmFAlU6+Rq47QQtAFZ32
         z8yhnei0KPZd9anIMAExRyyjNkk1+7KSmxbsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=l9SqLnHlXPzeQYrMBEs42moyjzbzWjc4jKKVIUFPcTo=;
        b=1kM3+fuZGtTlIfRiksL6dy4IwrINlHeOVril/CBbDifAc9aLFcqJy0BWRpBmbtHoXk
         WybuvFl9bc8O6g/hQowYP+Oy7jFwavEeczQB5PC5wuVCdOqdvfxfGqAWKAxG77IUMD7r
         ZOHzBZEZGURXvpKEa3W32fVTKhp21+VpDU6dx84yf5oq1/9Rfi808dmqIgyy7h+rCJA8
         5buJikO4JR92UA+LT8nmJo/iHYbQZLW5VmsZYERBLy1t1tx1yNcTlpSPgGZnrQlgOmyz
         1Q3FKZah4M8+bwqKCHRo6xBHmvHluTi9e3zAG6ALhvH6UulQS8BgU8ERD91lcxQE9yrh
         TohQ==
X-Gm-Message-State: ACgBeo1b4aCouXynaRI052kKGUUPm/U8yGTUq00EWHDVzwm+hFtX2cwD
        aSYjMsu7Njmp/nCXI9ZOFDLWxgIql6WxB2VfFAajnA==
X-Google-Smtp-Source: AA6agR7oNcuhcpmWl7FUDBl51a2rIYfRLUMwk1GMql0boXUCeCL93C2trZgtL6SrrEidHgeoFO7WewPvdeZk8LQ86aE=
X-Received: by 2002:a17:907:60c7:b0:739:52ba:cbd0 with SMTP id
 hv7-20020a17090760c700b0073952bacbd0mr13119859ejc.152.1661764948017; Mon, 29
 Aug 2022 02:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220822081424.1310926-1-wenst@chromium.org> <20220822081424.1310926-2-wenst@chromium.org>
 <12115951.O9o76ZdvQC@steina-w>
In-Reply-To: <12115951.O9o76ZdvQC@steina-w>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 29 Aug 2022 17:22:16 +0800
Message-ID: <CAGXv+5E788T01XJF-dYRW6ZB5-TTU_L5=0hT3AQ0g+zA=LzG2w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] clk: core: Honor CLK_OPS_PARENT_ENABLE for
 clk gate ops
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= 
        <nfraprado@collabora.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2022 at 8:28 PM Alexander Stein
<alexander.stein@ew.tq-group.com> wrote:
>
> Hi everybody,
>
> Am Montag, 22. August 2022, 10:14:23 CEST schrieb Chen-Yu Tsai:
> > In the previous commits that added CLK_OPS_PARENT_ENABLE, support for
> > this flag was only added to rate change operations (rate setting and
> > reparent) and disabling unused subtree. It was not added to the
> > clock gate related operations. Any hardware driver that needs it for
> > these operations will either see bogus results, or worse, hang.
> >
> > This has been seen on MT8192 and MT8195, where the imp_ii2_* clk
> > drivers set this, but dumping debugfs clk_summary would cause it
> > to hang.
> >
> > Fixes: fc8726a2c021 ("clk: core: support clocks which requires parents
> > enable (part 2)") Fixes: a4b3518d146f ("clk: core: support clocks which
> > requires parents enable (part 1)") Signed-off-by: Chen-Yu Tsai
> > <wenst@chromium.org>
> > Reviewed-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> >  drivers/clk/clk.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 7fc191c15507..9b365cd6d14b 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -196,6 +196,9 @@ static bool clk_core_rate_is_protected(struct clk_c=
ore
> > *core) return core->protect_count;
> >  }
> >
> > +static int clk_core_prepare_enable(struct clk_core *core);
> > +static void clk_core_disable_unprepare(struct clk_core *core);
> > +
> >  static bool clk_core_is_prepared(struct clk_core *core)
> >  {
> >       bool ret =3D false;
> > @@ -208,7 +211,11 @@ static bool clk_core_is_prepared(struct clk_core *=
core)
> > return core->prepare_count;
> >
> >       if (!clk_pm_runtime_get(core)) {
> > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +                     clk_core_prepare_enable(core->parent);
> >               ret =3D core->ops->is_prepared(core->hw);
> > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +                     clk_core_disable_unprepare(core->parent);
> >               clk_pm_runtime_put(core);
> >       }
> >
> > @@ -244,7 +251,13 @@ static bool clk_core_is_enabled(struct clk_core *c=
ore)
> >               }
> >       }
> >
> > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +             clk_core_prepare_enable(core->parent);
> > +
> >       ret =3D core->ops->is_enabled(core->hw);
> > +
> > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +             clk_core_disable_unprepare(core->parent);
> >  done:
> >       if (core->rpm_enabled)
> >               pm_runtime_put(core->dev);
> > @@ -812,6 +825,9 @@ int clk_rate_exclusive_get(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
> >
> > +static int clk_core_enable_lock(struct clk_core *core);
> > +static void clk_core_disable_lock(struct clk_core *core);
> > +
> >  static void clk_core_unprepare(struct clk_core *core)
> >  {
> >       lockdep_assert_held(&prepare_lock);
> > @@ -835,6 +851,9 @@ static void clk_core_unprepare(struct clk_core *cor=
e)
> >
> >       WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core-
> >name);
> >
> > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +             clk_core_enable_lock(core->parent);
> > +
> >       trace_clk_unprepare(core);
> >
> >       if (core->ops->unprepare)
> > @@ -843,6 +862,9 @@ static void clk_core_unprepare(struct clk_core *cor=
e)
> >       clk_pm_runtime_put(core);
> >
> >       trace_clk_unprepare_complete(core);
> > +
> > +     if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +             clk_core_disable_lock(core->parent);
> >       clk_core_unprepare(core->parent);
> >  }
> >
> > @@ -891,6 +913,9 @@ static int clk_core_prepare(struct clk_core *core)
> >               if (ret)
> >                       goto runtime_put;
> >
> > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +                     clk_core_enable_lock(core->parent);
> > +
> >               trace_clk_prepare(core);
> >
> >               if (core->ops->prepare)
> > @@ -898,6 +923,9 @@ static int clk_core_prepare(struct clk_core *core)
> >
> >               trace_clk_prepare_complete(core);
> >
> > +             if (core->flags & CLK_OPS_PARENT_ENABLE)
> > +                     clk_core_disable_lock(core->parent);
> > +
> >               if (ret)
> >                       goto unprepare;
> >       }
>
>
> Unfortunately this completely locks up my i.MX8M Plus based board during =
early
> boot.
> I'm currently running on next-20220826 using arch/arm64/boot/dts/freescal=
e/
> imx8mp-tqma8mpql-mba8mpxl.dts
> Reverting this patch gets my board booting again. dmesg until hard lockup
> below.

The standard logs don't have anything to go on. Could you add some printk
calls to the clk core around the areas this patch touchs? That would help.

Could you also provide a dump of /sys/kernel/debug/clk/clk_summary? That
would help to understand the clock tree.


Thanks
ChenYu
