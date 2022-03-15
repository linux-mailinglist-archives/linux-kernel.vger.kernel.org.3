Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F224D9E19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349377AbiCOOwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbiCOOwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:52:21 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68B255210;
        Tue, 15 Mar 2022 07:51:06 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id v2so6774045qtc.5;
        Tue, 15 Mar 2022 07:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqRiDtRTyctY9EOBnjU+68Czy+r+PuJUhYm8YFFF+dU=;
        b=358qAgFsVlM5cbiARUsfvr28rC0AZXGlqbSniIm30DAApa4Yjw6JpGuSfqkRvPWvgA
         M3uG/5BywCeKRUFB991sGbCx5mrFTLfzBxZPi5913XY8Fwlc2UlW8VjSDl+k/RLdxvKb
         VuoHS/rzd8wxSvTkH8wi9ktZA1uamlwv9M8JnsVLPNj4La6wHg8oaFjsqw2+VVrpGP/z
         jcwDjftj5hibevKjm/yk36GBqMbvFh4RaYl7edP/Hpc6TkBljGqeHvzdPg5rd0XN+9rX
         GEDvJbCEG4tJoDNQuH/kUNcDQSEk3YsI4kxlKQ42KB+Nr6+9p+LQD75dXQ1XgUdXIOmn
         CSXA==
X-Gm-Message-State: AOAM531JaGVGl12CJ6hg7HI+7oplQ+WRru1DyqQ733ryRCebbetbBoDh
        1Nns6OCGTG2SKFpGpBb92yeHAoxdacxO5Q==
X-Google-Smtp-Source: ABdhPJzmB7nLoyRpF4NYx8ZMr7ID4dCLljWoE9yBrRWdL4uzdVt+NWGjmXaaMnyYQ/NMqTAt5Il0ZQ==
X-Received: by 2002:a05:622a:509:b0:2e0:6f77:725a with SMTP id l9-20020a05622a050900b002e06f77725amr22685713qtx.294.1647355864853;
        Tue, 15 Mar 2022 07:51:04 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id 193-20020a3706ca000000b0067d3e4b5667sm9076608qkg.67.2022.03.15.07.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 07:51:03 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id j2so37913380ybu.0;
        Tue, 15 Mar 2022 07:51:03 -0700 (PDT)
X-Received: by 2002:a25:dfd3:0:b0:629:24ff:eab0 with SMTP id
 w202-20020a25dfd3000000b0062924ffeab0mr22936647ybg.613.1647355863067; Tue, 15
 Mar 2022 07:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220315061031.21642-1-moudy.ho@mediatek.com> <20220315061031.21642-2-moudy.ho@mediatek.com>
 <ed5418b4-e353-d879-f9b0-7a9de8fed862@collabora.com> <4fa1dd33-adeb-a8ae-0ded-51a813347252@landley.net>
In-Reply-To: <4fa1dd33-adeb-a8ae-0ded-51a813347252@landley.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 15:50:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXA=Wo2mW_N9GGDY_NBgyhK3fDBpUO=mJb-CdoYvKU70w@mail.gmail.com>
Message-ID: <CAMuHMdXA=Wo2mW_N9GGDY_NBgyhK3fDBpUO=mJb-CdoYvKU70w@mail.gmail.com>
Subject: Re: [PATCH v13 1/6] soc: mediatek: mutex: add common interface to
 accommodate multiple modules operationg MUTEX
To:     Rob Landley <rob@landley.net>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, drinkcat@chromium.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Mar 15, 2022 at 3:37 PM Rob Landley <rob@landley.net> wrote:
> On 3/15/22 4:10 AM, AngeloGioacchino Del Regno wrote:
> > Il 15/03/22 07:10, Moudy Ho ha scritto:
> >> In order to allow multiple modules to operate MUTEX hardware through
> >> a common interfrace, a flexible index "mtk_mutex_table_index" needs to
> >> be added to replace original component ID so that like DDP and MDP
> >> can add their own MUTEX table settings independently.
> >>
> >> In addition, 4 generic interface "mtk_mutex_set_mod", "mtk_mutex_set_sof",
> >> "mtk_mutex_clear_mod" and "mtk_mutex_clear_sof" have been added, which is
> >> expected to replace the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp"
> >> pair originally dedicated to DDP in the future.
> >>
> >> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

> >> --- a/drivers/soc/mediatek/mtk-mutex.c
> >> +++ b/drivers/soc/mediatek/mtk-mutex.c
> >> @@ -156,6 +156,7 @@ struct mtk_mutex_data {
> >>      const unsigned int *mutex_sof;
> >>      const unsigned int mutex_mod_reg;
> >>      const unsigned int mutex_sof_reg;
> >> +    const unsigned long long *mutex_table_mod;
> >
> > Can we change this to u64 instead?
>
> Linux is still LP64, correct?

On 64-bit platforms, yes.

Note that this is about "long long", which is 64-bit on all Linux platforms.
But as the table seems to be used to store 2 32-bit values, it doesn't hurt
to be explicit and use "u64"? Or a struct with 2 "u32" values?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
