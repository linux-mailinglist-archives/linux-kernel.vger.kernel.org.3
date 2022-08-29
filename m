Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE85A50E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiH2QCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiH2QCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:02:31 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8DC75FDE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:02:29 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cu2so16703746ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 09:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PWMBMRMPN5GhvCOAnnAdFknz4G+9De4RqcsPk0Z1BG4=;
        b=NYJnIKLUJrUZStzT8ciuU41oE7tVij2lLq+s+AiEcOqIZwRO2tVIvUmDN2h0h+krqo
         d1IzFfocFezhlX9U9fk02nHKFeBuuQqrjG5Yixliri9tUNIVf5qacBQipFaZczv6jP4A
         vq9KS79+uIf3t1gDDWkMp9aXUQtbyAvr3/NdRmEG/UJ5blaAxBSEHgjSQRSS2N2TYk0R
         0Yn8HMa9dyg/hOoPn2qBkP1VxMq4+A4RxXM4M9k2ohO+Nup6xhbaGD+0qpjE9I1Pn/gg
         Na7hh1ha8jwnRIXebmeJHDx33e6q7F7H9UpnJ9dQ+Imp4gxiyNPLG8V+wCLbY0aU2FcE
         Mk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PWMBMRMPN5GhvCOAnnAdFknz4G+9De4RqcsPk0Z1BG4=;
        b=VgbZMGoisQRB68Ng7Pi1NDrct+h8jXcG+5OYv1R6TRsxAk40hqhVqfWQtRUJtNojoI
         +fVdCLzFDStVtUA9EhENhrKS75sCGP06Z1GkGPoCHzodOACgjKPj0Ar4RCz+fy9TaEdj
         c3vQxCTturKZ9XTJmpPJQIxHn4XroOfs0m3jT5SPW4mIxQ0F0Ye64d2pFN4XyHwGeE5o
         uH4BDBvSRrFwOcHb+rcagSc7vfrkZNpSsyxpMs0dLzdDV3aUNgXV0XK8BLOE1/udh1aa
         AXjwdF/TcpIA3P6ZYRUHvj7xBT8xQBjVSmYqiMy5YzqrdXz26t3aLdglGtf5xi9bsn4v
         dXbQ==
X-Gm-Message-State: ACgBeo0m5T5z+NMbYXP69nElbufVQh7BGUi0DQukFp6gGTftcWn/VHVP
        u6fmA41P3git0diyhra8hWG5dI2obEexwX1wsGXozGvMPfg=
X-Google-Smtp-Source: AA6agR6el4xi1uh8MNRyeKzalfI37Tyvgw01vmh8rhtJ4CKqz7iElZwCgeZkvXcMx5FicxZX67QbZ1VGJh0PgF+k3xo=
X-Received: by 2002:a17:907:743:b0:740:ef93:2ffc with SMTP id
 xc3-20020a170907074300b00740ef932ffcmr10122140ejb.514.1661788948001; Mon, 29
 Aug 2022 09:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220319151016.983348-1-alvin@pqrs.dk>
In-Reply-To: <20220319151016.983348-1-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 29 Aug 2022 18:02:17 +0200
Message-ID: <CAG3jFyvqPFL4d=s6DsbVZOzkuMwwi-GUZwFYyeajr=jLqmdm4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: bridge: adv7511: CEC support for ADV7535
To:     =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alvin,

Sorry about being slow to get to this series.

Can you rebase it on drm-misc-next and send out the next version?

On Sat, 19 Mar 2022 at 16:10, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> We have an ADV7535 which is nominally supported by this driver. These
> two patches fix up the driver to get CEC working too.
>
> The first adds the basic support by correcting some register offsets.
>
> The second addresses an issue we saw with CEC RX on the ADV7535. It
> hasn't been tested with the other chips (e.g. ADV7533), although it
> should be compatible. I'm sending it against drm-misc-next because the
> issue wasn't reported for other chips, and ADV7535 didn't have CEC
> support before. But feel free to take it into -fixes instead.
>
> Alvin =C5=A0ipraga (2):
>   drm: bridge: adv7511: enable CEC support for ADV7535
>   drm: bridge: adv7511: use non-legacy mode for CEC RX
>
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  27 ++++-
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 116 +++++++++++++------
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  22 +++-
>  3 files changed, 119 insertions(+), 46 deletions(-)
>
> --
> 2.35.1
>
