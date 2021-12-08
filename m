Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA0546CA51
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238562AbhLHB47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:56:59 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:59388 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhLHB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:56:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52703CE1EEC;
        Wed,  8 Dec 2021 01:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86282C341C5;
        Wed,  8 Dec 2021 01:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638928404;
        bh=U/UJTyPUQ/j2KXlTSFmG0qmTq16ORRf5unzrrXXVJDc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NbDLuQ2cSZVJpzmuRYhvCB/OsGgbiz8UvZJoRIREKVSZylxTjFtF/4TQYPDZem3RG
         DKpuuZvhyRuvRKFahshXHNU8x8ZGz1AbqYP1xthE/QVY1MV0YQkfDdghtdbUrhPjPk
         FHR+xQYOAQHgWYPvjzBdvuRMyIFTNUYNXWvzZTZEObVYZ+CNomaBdj+cYXWoDGK4/6
         0xkrgxFXXWDafSRLx2KxZ1G5p9CKj3uNEEA+RHTfcCwsm0qXvPJy5Z6HgZ49BeEB+N
         bW/BnBUcuoWoIHWU1aYtN3YKoEy3viH6zJ/TAisNqKayRplp5ks30aMw0DT6fj3kxU
         hIXsMA8vBbB+g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
References: <20211109043438.4639-1-quic_mdtipton@quicinc.com>
Subject: Re: [PATCH] clk: Fix children not voting entire parent chain during init
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Tipton <quic_mdtipton@quicinc.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>, mturquette@baylibre.com
Date:   Tue, 07 Dec 2021 17:53:23 -0800
User-Agent: alot/0.9.1
Message-Id: <20211208015324.86282C341C5@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mike Tipton (2021-11-08 20:34:38)
> If a child's parent is set by calling __clk_init_parent() while the
> parent is still being registered in __clk_register(), then it can result
> in the child voting its direct parent without those votes propagating up
> the entire parent chain.

More details please!

>=20
> __clk_register() sets hw->core before grabbing the prepare_lock and
> before initializing hw->core->parent. Since hw->core is used indirectly
> by __clk_init_parent(), then children can find their parents before
> they're fully initialized. If children vote for their parents during
> this window, then those votes won't propagate past the direct parent.

Is the crucial detail that's missing here the fact that we now let
__clk_init_parent() find a struct clk_hw before that clk has been
published to the clk tree in __clk_core_init()? I can see the following
scenario

	struct clk_hw clkBad;
	struct clk_hw clkA;

	clkA.init.parent_hws =3D { &clkBad }

	clk_hw_register(&clkA);

And now clkA has a reference to clkBad in the clk tree but the clk isn't
published to the clk tree yet. Except, clk_core_fill_parent_index() will
fail to find the parent because hw->core isn't set yet. So now I'll
write up a two CPU scenario to try to clarify.


  CPU0                                     CPU1
  ----                                     ----
  struct clk_hw clkBad;
  struct clk_hw clkA;
 =20
  clkA.init.parent_hws =3D { &clkBad };
 =20
  clk_hw_register(&clkA)                   clk_hw_register(&clkBad)
                                            __clk_register()
					     hw->core =3D core
					     ...
   __clk_register()
    __clk_core_init()
     clk_prepare_lock()
     __clk_init_parent()
      clk_core_get_parent_by_index()
       clk_core_fill_parent_index()
        if (entry->hw) {
	 parent =3D entry->hw->core;
	 <boom>

>=20
> This can happen when:
>     1. CRITICAL clocks are enabled in __clk_core_init().
>     2. Reparenting enabled orphans in clk_core_reparent_orphans_nolock().

I didn't really follow these two points. I guess you're saying this is a
problem if we're enabling critical clks and the parents aren't
registered yet or we're reparenting a whole subtree into the clk tree
but they're still technically orphans because the parent isn't
registered.

>=20
> Fix this by not setting hw->core until we've already grabbed the
> prepare_lock in __clk_core_init(). This prevents orphaned children from
> finding and voting their parents before the parents are fully
> initialized.
>=20
> Fixes: fc0c209c147f ("clk: Allow parents to be specified without string n=
ames")

Thanks! Looks correct. It would be good to describe how this commit
broke it though. Something like:

When parent clks could only be found via string name we had to wait
until the parent clk was added to a list in __clk_core_init() before we
could find it, but after commit fc0c209c147f ("clk: Allow parents to be
specified without string names") the parent clk can be found once we set
hw->core in __clk_register().

> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
>=20
> This is very difficult to reproduce. We can't reproduce it at all
> internally, in fact. But some customers are able to reproduce it fairly
> easily and this patch fixes it for them.

This doesn't instill very much confidence in the fix if you can't
reproduce it and can't describe the scenario where it happens. It would
have helped signal boost the patch if the customers could reply to the
list indicating this fixes things for them with tested-by tags :(

>=20
>  drivers/clk/clk.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f467d63bbf1e..af562af9d54d 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -3418,6 +3418,13 @@ static int __clk_core_init(struct clk_core *core)
> =20
>         clk_prepare_lock();
> =20
> +       /*
> +        * Set hw->core after grabbing the prepare_lock to prevent race
> +        * conditions with orphans finding and voting their parents befor=
e the
> +        * parents are fully initialized.

Let's make this comment better by talking about
clk_core_fill_parent_index() only caring if hw->core is set to a
non-NULL value. "race conditions" is nebulous.

> +        */
> +       core->hw->core =3D core;
> +
>         ret =3D clk_pm_runtime_get(core);
>         if (ret)
>                 goto unlock;
> @@ -3582,8 +3589,10 @@ static int __clk_core_init(struct clk_core *core)
>  out:
>         clk_pm_runtime_put(core);
>  unlock:
> -       if (ret)
> +       if (ret) {
>                 hlist_del_init(&core->child_node);
> +               core->hw->core =3D NULL;
> +       }
> =20
>         clk_prepare_unlock();
> =20
> @@ -3847,7 +3856,6 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
>         core->num_parents =3D init->num_parents;
>         core->min_rate =3D 0;
>         core->max_rate =3D ULONG_MAX;
> -       hw->core =3D core;
> =20
>         ret =3D clk_core_populate_parent_map(core, init);
>         if (ret)
> @@ -3865,7 +3873,7 @@ __clk_register(struct device *dev, struct device_no=
de *np, struct clk_hw *hw)
>                 goto fail_create_clk;
>         }
> =20
> -       clk_core_link_consumer(hw->core, hw->clk);
> +       clk_core_link_consumer(core, hw->clk);
> =20
>         ret =3D __clk_core_init(core);
>         if (!ret)

Let me see if I can fix this up on application.
