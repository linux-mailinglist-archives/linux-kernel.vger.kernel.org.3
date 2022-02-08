Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89C4ACFE0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346423AbiBHDu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiBHDuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:50:55 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAB3C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:50:54 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id p5so46050175ybd.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGJv0AFVdfHzUa0yHqnma3btGQlzXWk1wSqSnWWw9Dk=;
        b=mJm2SUkp44PAeoyfQimwj06GljPK6ZlqDXI5AuQfTSigjQ8pV5o1ebijkpLq4WG/Gp
         IMzFiyeYTiPnV9e/8k+G2x9dJnUo4cXsJQZN66aXlRdWYuZXJrMfHg7zybpBtcAi6Xqn
         kL1U1hw+GGReC6MiCpqdsZ/N7V4pxLg3Zj3Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGJv0AFVdfHzUa0yHqnma3btGQlzXWk1wSqSnWWw9Dk=;
        b=OgyzyCUV//eMl1wDBAnPcGlO9RcY72ua6mvVN294Lak3l/Qw/iCXByiK8Q1hIRCLs/
         Z5CtvrulZWPfTroOMXcNrh8pBXeEHvWj0GOI8P7Aq385leEqGkkJY03NH5C0Khx1bbq0
         79BhhtcjLV2yR76wqgyhxliklZsHty3BuJ3J1anB4PzQGCEnGST/xD25WtOI927uJoda
         1mgBrRFn2a1PuomsXOurX4Z81IXq49qhLxOTo+/VQvEMHH94T953AbyuxR32a+50PguW
         YpQjjMU1D1OzLm6+qlqBvx918uHVE5nOfqfBV+6fARAOQxJrwMsjsVkQw4sPZXtZvoi8
         m65A==
X-Gm-Message-State: AOAM532TRmLm31A0Gz8ZkhcjmDzYhthvrIiqCnlVsxZ0ylmOVg1IMqJA
        vKGoQ260fQYkVPGbaaAQ9CSl3JU87jQpMTKTYmzGoQ==
X-Google-Smtp-Source: ABdhPJzBnKRYSQxz0sUuAXLlIdIIDiufeVnpjx8TXskOYyz1WTj3X8uhPzwU+v2jw3moTuLJEUn06yrPSPGxjYtAf04=
X-Received: by 2002:a81:1b4e:: with SMTP id b75mr2986110ywb.295.1644292253418;
 Mon, 07 Feb 2022 19:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20220202134834.690675-1-wenst@chromium.org> <20220202134834.690675-16-wenst@chromium.org>
 <752d5d00-4e05-1bd6-564f-3bce21a35713@collabora.com>
In-Reply-To: <752d5d00-4e05-1bd6-564f-3bce21a35713@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 8 Feb 2022 11:50:42 +0800
Message-ID: <CAGXv+5HSLh0OgJc=EU=wvB4DaOMDLjsgJ6qnHY423d1L5+DixQ@mail.gmail.com>
Subject: Re: [PATCH v2 15/31] clk: mediatek: Implement mtk_clk_unregister_fixed_clks()
 API
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 3, 2022 at 5:47 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 02/02/22 14:48, Chen-Yu Tsai ha scritto:
> > mtk_clk_register_fixed_clks(), as the name suggests, is used to register
> > a given list of fixed rate clks. However it is lacking a counterpart
> > unregister API.
> >
> > Implement said unregister API so that the various clock platform drivers
> > can utilize it to do proper unregistration, cleanup and removal.
> >
> > In the header file, the register function's declaration is also
> > reformatted to fit code style guidelines.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: Miles Chen <miles.chen@mediatek.com>
>
> Hello Chen-Yu,
>
> I like this entire series, but I had to manually apply this patch (and some of
> the other ones)...

This was based on linux-next, which already has a couple clk patches queued
up.

> Especially for the ones that will be touching MT8195 clock drivers, can you
> please rebase over series [1] by Chun-Jie?

I think this series supersedes the first patch in that series? As for the
other two, I think the discussion about the bindings is ongoing, which
might affect the third patch as well?

ChenYu

> [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=603955
>
> Thanks,
> Angelo
>
