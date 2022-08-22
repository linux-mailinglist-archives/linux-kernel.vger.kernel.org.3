Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2759CC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 01:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238816AbiHVXuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 19:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiHVXuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 19:50:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7014E86F;
        Mon, 22 Aug 2022 16:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F3761388;
        Mon, 22 Aug 2022 23:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86203C433D6;
        Mon, 22 Aug 2022 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661212214;
        bh=tXNjbCxB6WYOWNNVp+WbEUxxjT5qLs6LlQxsR075G/Q=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W2hqZgq0oir8PTpr8YN0aZtc/2V8mZtvHtUEkLL+atV30eknq0sCDGPWusW8FN8st
         uVQMpVXVdOMIPViGj6f4DY1QVi0TlFl3bBJFQYgsdTFDOZdzUML4T4tRbfFR0issin
         NeH6HL20WXPBQDDVekGhLh/DfsJuh3Cpx3p1NvDg66nnE5Ca+WSax83si2pEhAalgH
         78NZKN/y5kFAd7NpeW9Ra9krI9dxaguugo36KmibSaB+2JIwWCB6UUiQYGy7svj7zN
         Od/AKUc1HcwjsbEynGjN6lVctbTpaenz0TjwCvdkSSrU3SSYJFuEbc87HmHYV8zjFu
         9nLmx33PFGUqw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
References: <20220624010550.582BBC341C7@smtp.kernel.org> <1659463787-25976-1-git-send-email-badolevishal1116@gmail.com>
Subject: Re: [PATCH v3] Common clock: To list active consumers of clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, chinmoyghosh2001@gmail.com,
        vimal.kumar32@gmail.com,
        Vishal Badole <badolevishal1116@gmail.com>,
        Mintu Patel <mintupatel89@gmail.com>
To:     Vishal Badole <badolevishal1116@gmail.com>
Date:   Mon, 22 Aug 2022 16:50:12 -0700
User-Agent: alot/0.10
Message-Id: <20220822235014.86203C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vishal Badole (2022-08-02 11:09:47)
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index f00d4c1..c96079f 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -102,6 +102,7 @@ struct clk {
>         unsigned long min_rate;
>         unsigned long max_rate;
>         unsigned int exclusive_count;
> +       unsigned int enable_count;
>         struct hlist_node clks_node;
>  };
> =20
> @@ -1008,6 +1009,10 @@ void clk_disable(struct clk *clk)
>                 return;
> =20
>         clk_core_disable_lock(clk->core);
> +
> +       if (clk->enable_count > 0)
> +               clk->enable_count--;
> +
>  }
>  EXPORT_SYMBOL_GPL(clk_disable);
> =20
> @@ -1169,10 +1174,16 @@ EXPORT_SYMBOL_GPL(clk_restore_context);
>   */
>  int clk_enable(struct clk *clk)
>  {
> +       int ret;
> +
>         if (!clk)
>                 return 0;
> =20
> -       return clk_core_enable_lock(clk->core);
> +       ret =3D clk_core_enable_lock(clk->core);
> +       if (!ret)
> +               clk->enable_count++;
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(clk_enable);

We'll want the above three hunks to be a different patch so we can
discuss the merits of tracking per user enable counts. Do you have a
usecase for this or is it "just for fun"? By adding a count we have more
code, and we waste more memory to track this stat. I really would rather
not bloat just because, so please elaborate on your use case.

> =20
> @@ -2953,28 +2964,41 @@ static void clk_summary_show_one(struct seq_file =
*s, struct clk_core *c,
>                                  int level)
>  {
>         int phase;
> +       struct clk *clk_user;
> +       int multi_node =3D 0;
> =20
> -       seq_printf(s, "%*s%-*s %7d %8d %8d %11lu %10lu ",
> +       seq_printf(s, "%*s%-*s %-7d %-8d %-8d %-11lu %-10lu ",
>                    level * 3 + 1, "",
> -                  30 - level * 3, c->name,
> +                  35 - level * 3, c->name,
>                    c->enable_count, c->prepare_count, c->protect_count,
>                    clk_core_get_rate_recalc(c),
>                    clk_core_get_accuracy_recalc(c));
> =20
>         phase =3D clk_core_get_phase(c);
>         if (phase >=3D 0)
> -               seq_printf(s, "%5d", phase);
> +               seq_printf(s, "%-5d", phase);
>         else
>                 seq_puts(s, "-----");
> =20
> -       seq_printf(s, " %6d", clk_core_get_scaled_duty_cycle(c, 100000));
> +       seq_printf(s, " %-6d", clk_core_get_scaled_duty_cycle(c, 100000));
> =20
>         if (c->ops->is_enabled)
> -               seq_printf(s, " %9c\n", clk_core_is_enabled(c) ? 'Y' : 'N=
');
> +               seq_printf(s, " %5c ", clk_core_is_enabled(c) ? 'Y' : 'N'=
);
>         else if (!c->ops->enable)
> -               seq_printf(s, " %9c\n", 'Y');
> +               seq_printf(s, " %5c ", 'Y');
>         else
> -               seq_printf(s, " %9c\n", '?');
> +               seq_printf(s, " %5c ", '?');
> +
> +       hlist_for_each_entry(clk_user, &c->clks, clks_node) {
> +               seq_printf(s, "%*s%-*s  %-4d\n",
> +                          level * 3 + 2 + 105 * multi_node, "",
> +                          30,
> +                          clk_user->dev_id ? clk_user->dev_id : "devicel=
ess",
> +                          clk_user->enable_count);
> +
> +               multi_node =3D 1;

This part that prints the dev_id might be useful and can be the first
patch in the series. In that same patch, please print the con_id so we
know which clk it is for the device. We should also improve of_clk_get()
so that the index is visible to the 'struct clk::con_id' somehow. Maybe
we can convert the integer index into a string and assign that to con_id
in that case as well.
