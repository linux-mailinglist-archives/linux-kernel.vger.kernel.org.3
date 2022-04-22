Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D8F50AEDD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 06:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443871AbiDVERq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 00:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiDVERj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 00:17:39 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4494EA0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:14:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2edbd522c21so72847597b3.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 21:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7jGqyYJMUVo08fKH+szIIQUXUxBVoUo95cPDD/inJ4=;
        b=I9zUiMzdx0x2AlBPle+xfx0YbHSjxYYQzMOxKnLzS5AN60wHrUGdTUNXRzRKZNWmRB
         9/3o8X4D7FM5xD5BeHyIcf8ZQ9PSZkS6eg6Sku3+6xyQH3NVx54VTYCYGsVZsyq3yAZz
         vrLRrZwZGIuU8vS6PrH96FzJkh+IepxJW45pY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7jGqyYJMUVo08fKH+szIIQUXUxBVoUo95cPDD/inJ4=;
        b=utaqEMvv4KYV6For2gZnpews5Iuq+e9eV+M/yDCzLERbxkz22XkSbwrLIDm4J3i24d
         Fyx3AV9HrOCThcJA9/6Rg0Tv9xH3UNZ++N5G/cNh3VL8YlYiehFLSdux+d/EL2gHfwas
         Y/JmBYP5HKFzOlcaj7vtHEkRUG+3bkyOQrS2sRzGrnaND9QiZ5gQcPXGwYldmqRirnca
         g1RVWizBO1tSgykyTUdx4Pc9+hB4xJMoSMdEe0lpYW3Hid7dw5AArOVjbqowNzo8Smjr
         utIiPqMSTOh75qJJGMGOE7e2Cko5hvEaDNLK6lEnAfzmQZwTEeoxtRO7kEfwHsbnJt5k
         yEHA==
X-Gm-Message-State: AOAM530GQFO9THdGtIEAmdw4KMrQ5dmLiuDkpgPJ7wrZxX4S2OU8H7LJ
        JQ1G7niPGhZBEXl4MjlqQWZdJKdKpwQY2BzIFI1b/g==
X-Google-Smtp-Source: ABdhPJzT2Ffgf1KZKr2ZKeMbm0T2FTTmEEP6KdtEZrJKSquU8IPPEsmgOIJHitJbSdrl7JmX2J8oRdgb7gZjDarf8wc=
X-Received: by 2002:a81:ad1f:0:b0:2f4:da5b:5133 with SMTP id
 l31-20020a81ad1f000000b002f4da5b5133mr3074648ywh.105.1650600887150; Thu, 21
 Apr 2022 21:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220419081246.2546159-1-wenst@chromium.org> <3591fcc1-d34a-b40a-4e78-edcf9d2ddf08@collabora.com>
 <CAGXv+5HhcQbdGLQFtgPnvzVbSKaQ5GQGvmjwPVOVxjrYnMh1dg@mail.gmail.com>
 <ca8048f4-2e75-a49b-6c54-9f6abba6ead3@collabora.com> <CAGXv+5G2Uyq5fdMUnhr5wOm6O8M3dHNKGaSP2L_Vv1o28mXmOQ@mail.gmail.com>
 <20220422014044.16530C385A7@smtp.kernel.org>
In-Reply-To: <20220422014044.16530C385A7@smtp.kernel.org>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 22 Apr 2022 12:14:36 +0800
Message-ID: <CAGXv+5HJ2EmxH49L4a3t-gGcQpNLwgi74=uZ1iB1fNzSFz7Gbw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider APIs
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 9:40 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Chen-Yu Tsai (2022-04-20 23:05:10)
> >
> > Not exactly. All the clocks in the MTK drivers are allocated at runtime,
> > so we can't use clk_parent_data to point to not-yet-allocated clk_hw-s.
> > Instead we'll need to have
> >
> >     struct mtk_clk_parent_data {
> >         unsigned int clk_id; /* Match CLK_XXX_YYY from dt-binding headers */
> >         ... /* remaining fields same as mtk_clk_parent_data */
> >     };
> >
> > and create the actual clk_parent_data at runtime by looking up clk_id in
> > the set of already registered clks:
> >
> >     int mtk_clk_register_XXX(..., struct mtk_clk_parent_data *pdata,
> >                              struct clk_hw_onecell_data *clk_data) {
> >         struct clk_parent_data data = {
> >             .hw = clk_data[pdata->clk_id],
> >             /* copy other fields verbatim */
> >         };
> >         ...
> >     }
> >
> > Obviously this forces some ordering of how the clks are registered.
> > I believe the order is already correct, and if it isn't, it would be
> > easy to detect, and we can reorder things to fix it.
>
> If this is a common problem, we may need to come up with a generic
> solution that either adds a new clk registration API that fills in the
> clk_parent_data hw pointer or add another member to struct
> clk_parent_data that says "index into this other array of clk_hw
> pointers".

Looking through the large clk drivers, at least Rockchip and MediaTek
drivers would benefit from this. And maybe the Tegra ones as well, though
I'm not familiar with them.

Meson, Qcom, and sunxi-ng all use the static clk_hw scheme, so they're
unaffected.

I can think of a couple ways to tackle this:

A. Add a new data structure as I showed above, and a helper to fill in
   |struct clk_parent_data| from said data structure. This basically moves
   what I planned to do for the MediaTek clk driver to the clk provider
   API. This is the least intrusive option.

B. Add the |clk_id| field to |struct clk_parent_data|, and a |struct clk_hw *|
   field to |struct clk_init_data| for the array. Lookup would be done at
   clk registration time in clk_core_populate_parent_map(). This still
   forces checking of the clk_hw pointer and proper ordering of clk
   registration though. And it also bloats the data structures for folks
   not using the feature.

C. Same as B, but keep the pointer to the array around (in clk_core?), and
   move the lookup into clk_core_fill_parent_index(). This provides similar
   behavior to using global clk name or static |struct clk_hw *| values in
   that clk registration order is not restricted.

All the above options are designed around the desire to be able to make
either the new data structure or |struct clk_parent_data| constant.

Thoughts?


Regards
ChenYu
