Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35515072AF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354435AbiDSQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354409AbiDSQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:11:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15192369F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:09:15 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id s33so4483637ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dbizut872liacGVURGZMlMNbflBr9epUzTZJN1naRRU=;
        b=jQv1RSMsFzje+yB/e6v+OpSiCJnR44fMcWevRJTPKbrmn6IihmoSIIrfqoWFaqzc/O
         F6YrSuYN0LGc6K0+nJQaTGmy7YT2SPv+KLYl7TLDCXZC/Dd0bkJZWnRH9/8Dmy6kXiTm
         YSWrSlPH8N1NZV/8YOzffDWMyqRr1kHgM1diM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dbizut872liacGVURGZMlMNbflBr9epUzTZJN1naRRU=;
        b=YpDYku+zyrrhc5ZJ+Yveslnq01pNp8rA/i0y+HZqZ2wEAKCVkY4Czg5kBt3ibPHItA
         Kh3XBIAnCZvJVui3rY1THx/N/MKWTW+WQ9znAu6gNsSWCG3KMMybgiIAv+v45hXZiKXc
         XvDnQbRxVLheHUktIQ38zPXZmtrBKyRksIme5IuNL4FsfH3KK907VF1ceB5NVfYvHTK4
         WzXalMcgrqROyUdZ+NtQoxMxw32mcjxGm6dn2egG9Z8o15uiruhWY6EhteVNXWLP9eSd
         xYrJ1QUrgQwbszyzwC0z24PJTLMO2/5LUks4g4w/+MiUfTagydfdrnXKdJPQp0HJ6xss
         XjbQ==
X-Gm-Message-State: AOAM53316kgW5/lZpEl6FUTe7JZSQRu2cGo6Y3YaTos7MUbq/u7Q2bcQ
        HzF/MiUDNTAWhppAiMxXWzksFRGGyIlC7gHiPeXVlw==
X-Google-Smtp-Source: ABdhPJxDMzjn5Y2J9FTFdHSqniel5HGl8fBt4c5FpZBarwwavL1g/XXm4Hv35bLv7P1296yIbQnPlOL9AD+nB2QKHEM=
X-Received: by 2002:a25:2ac3:0:b0:645:36f4:2db3 with SMTP id
 q186-20020a252ac3000000b0064536f42db3mr4262319ybq.189.1650384554231; Tue, 19
 Apr 2022 09:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220419081246.2546159-1-wenst@chromium.org> <3591fcc1-d34a-b40a-4e78-edcf9d2ddf08@collabora.com>
In-Reply-To: <3591fcc1-d34a-b40a-4e78-edcf9d2ddf08@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 20 Apr 2022 00:09:03 +0800
Message-ID: <CAGXv+5HhcQbdGLQFtgPnvzVbSKaQ5GQGvmjwPVOVxjrYnMh1dg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] clk: mediatek: Move to struct clk_hw provider APIs
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:08 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 19/04/22 10:12, Chen-Yu Tsai ha scritto:
> > Hi everyone,
> >
> > This is part 2 of my proposed MediaTek clk driver cleanup work [1].
> >
>
> ..snip..
>
> >
> > The next phase of the cleanup/improvement shall be to introduce some
> > variant of `struct clk_parent_data` to describe clk relationships
> > efficiently.
> >
> > Please have a look.
> >
>
> Hello Chen-Yu,
>
> I am grateful to see this series, as the MediaTek clock drivers are getting
> a bit old, despite new platforms being implemented practically as we speak.
>
> With this, you surely get that I completely agree with the proposed cleanup
> and modernization of the entire MediaTek clocks infrastructure, but I think
> that introducing a `struct clk_parent_data` for these drivers is, at this
> point, a must, that not only fully justifies these patches, but also "makes
> the point" - as the effect of that would be a performance improvement as we
> would *at least* avoid lots of clk_cpy_name() in case of parent_hws, or in
> case or parent_data where no .fw_name is provided (which would be the case
> for most of the clocks).

You and me both. :) And yes, one of the intended results is to make the
clk driver probe faster.

> That said, my advice would be to add that conversion to declaring clocks
> with .hw.init.parent_data and/or .hw.init.parent_hws to this series as to
> really make it complete.

This series itself already touches a lot of code, even if most of it was
done by coccinelle. I'd like to send them separately to not overwhelm
people.

Also, I haven't actually started on that part yet. It is actually part 3
of my overall plan. I have a good idea of what to do, given I did similar
work for the sunxi-ng clk drivers (though half finished...).

Most of the clk references are internal to each driver, and those would
be mapped from some CLK_ID to some `struct clk_hw *` internally, but all
blocks have external parents that need to be modeled as well, and we
would likely need global clk name fallbacks for the blocks that don't
have parents declared in the device tree, which is unfortunately most
of them. Especially the central clock controllers like infracfg or pericfg
take many clk inputs, to the point that MediaTek folks were somewhat
unwilling to bloat the device tree with them.

So it does seem easier to use something like clk_parent_data with
`struct clk_hw *` replaced with an index everywhere. This structure
would get converted into clk_parent_data by the singular clk registration
helpers.

This would have to coexist with the existing helpers we have. So I think
this work would be combined with the helper API cleanup / alignment with
clk provider API.

Does that make sense to you?

> Of course, if you have concerns about old platforms that you cannot test,
> or for which this kind of conversion would require a huge amount of effort,
> then I would go for converting as many as possible as a first step and then
> leave the others for later.
>
> I would envision MT8183, 8186, 8192, 8195 to be a good amount of first
> candidates for this great effort.

I'm working with MT8183 right now, as it can readily boot mainline to a
shell. Depending on the schedule and whose on board with resources, I'd
probably handle the other ChromeOS platforms, or delegate it internally.


Regards
ChenYu
