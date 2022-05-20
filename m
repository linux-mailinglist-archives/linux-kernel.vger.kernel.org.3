Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BE152E417
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 06:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbiETEwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 00:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345438AbiETEwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 00:52:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE8E66C8F
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:52:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ck4so9204831ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 21:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXQ11dkGIoE0lV36QZDgqg8uCYyptybDNTq4ktZBTbs=;
        b=Gn7sIKywSM62dUwnlqYPfjztZlNBpnEvxn/LPGPAND/LIIcY7GDg8EgQIw+Zh3y/U1
         h9lNgaIg/X2sWmLtWsZCJ6kKKaAQiFpLbw531WuTGezENUeCvmgZzu1lNfBWdlyCnfL+
         Uo716ZjvlyclNOH5OVjrtuSR2M+RHKhbiqW+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXQ11dkGIoE0lV36QZDgqg8uCYyptybDNTq4ktZBTbs=;
        b=a4YihJCWQXTVDiHLCyO/uPKDVT5z+5muCU5RPOyESj4Wcezb1OL1+TEe22niEkWFJK
         yn0z9GESu5l/OmqV72f6IIM3Tielf7CWwYasxjsqWuqOBReY3vHWHRs7/kD1Aogv83hk
         44gO3JD4scBirP+gmNuwALmshpONuxWAcgSIVJoL4fRJTu09JMBRY68uR4ZBOTFzU/fl
         s+5cb/jZzG9OgCiPyjc4naqiuwHmZS8WdQR5nb/GAGd9hv1B3U0sh72QLg6Wnz8m1bVz
         kkmNc12sYAk0cejl71KjDgdYoBjgDYjWWeGlxd6+G1oodgvZvjmY5e8F5m9306E+OfFV
         jvsg==
X-Gm-Message-State: AOAM530dwvwKDJWut8ABrbIoPfbsqcUKP5A1u2F+To6ZoWhpgjmtV31j
        LeRSzwNnzyz5hOKVkOV/9WwJmGUImy+yjPilmapUqg==
X-Google-Smtp-Source: ABdhPJw9Y9lBj9Z5FwDbfz0z2g17IMdLUZaYayEtlHgFK/MU4JnEW8hdabOOpLZh98m29bEIpS/fA3W+v5e7mgJb+sk=
X-Received: by 2002:a17:907:3f8e:b0:6f4:4723:4185 with SMTP id
 hr14-20020a1709073f8e00b006f447234185mr7108632ejc.359.1653022356766; Thu, 19
 May 2022 21:52:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220519134728.456643-1-y.oudjana@protonmail.com>
 <20220519134728.456643-3-y.oudjana@protonmail.com> <CAGXv+5GnjY1DOWHx-B4PZqNi5tnWOgYQ_TCk6YzhtEnPQnVVnA@mail.gmail.com>
In-Reply-To: <CAGXv+5GnjY1DOWHx-B4PZqNi5tnWOgYQ_TCk6YzhtEnPQnVVnA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 20 May 2022 12:52:25 +0800
Message-ID: <CAGXv+5FO+wZyyORV36+OmRn62M9zxfmB5WaTCkSgWJ6k9=572Q@mail.gmail.com>
Subject: Re: [PATCH 2/6] clk: mediatek: Use mtk_clk_register_gates_with_dev in
 simple probe
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:49 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Thu, May 19, 2022 at 9:49 PM Yassine Oudjana
> <yassine.oudjana@gmail.com> wrote:
> >
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> >
> > Register gates with dev in mtk_clk_simple_probe.
> >
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Side note: one day I would like to rename all the common functions so
that the follow the style of the CCF. One example would be

  - mtk_XXX_register() takes |struct device *|
  - of_mtk_XXX_register() takes |struct device_node *|

I don't know if I'll ever get to it.
