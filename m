Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A2F4FBDC5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346719AbiDKNwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346661AbiDKNwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:52:08 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066D9237F0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:49:52 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id ke15so13232505qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVG2fXlBh+awI+zoG5EckE/Z3Lioiux+cIKRFlmEU0g=;
        b=D3xdY1OK8KmdjzH6LG9W0CVm9zLNajVHJANYnYi0hjA1PDtLKVezFmtkosul9b2pKn
         GsEPQQsPu5BIILcIbuBYGi6tZHpuy/7LDD2Rq7op4LmELRU0DzVkPQeHl8yM+ugauu6i
         y44U3rfTSF9mprSn+z3elpnWwsdWy7hGrxjGDgNbAp2c6jmoRuncHagnCeAPyuOBIxm6
         i2irYgiP+p/IphTv0DuGN58JRRsCrBOHcfYdTs4KYbqtH0MkUsm73Q/VMbHok+OAid+V
         f+fzBZCtppKJ1U/zBBFKvZClAk39Y0w8298ut0xIBVdEwH088XURmXP9eNP9baY4N3jZ
         x2nA==
X-Gm-Message-State: AOAM53057OYrpEq4VlbXc2e6zAL3e1cdwJP81DwqCh+LPkQHD5Hl4VVr
        qSRWAM8uHmeAjy8SXeXruVfdKTk6EtZxuQ==
X-Google-Smtp-Source: ABdhPJxF3a0VlW6VCxyXpcYmmOM+U4cwZPOZS2+Qt3rxtXJBR0gUT7fFMAVggrd9tNbfSxjGe8VUxw==
X-Received: by 2002:a0c:c788:0:b0:444:2c7f:4126 with SMTP id k8-20020a0cc788000000b004442c7f4126mr10856160qvj.50.1649684990576;
        Mon, 11 Apr 2022 06:49:50 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id c7-20020a37e107000000b0069c126c5107sm2537458qkm.39.2022.04.11.06.49.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 06:49:50 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id t12so7072215ybt.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:49:49 -0700 (PDT)
X-Received: by 2002:a25:29c2:0:b0:641:224f:17d6 with SMTP id
 p185-20020a2529c2000000b00641224f17d6mr7405779ybp.546.1649684989768; Mon, 11
 Apr 2022 06:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220312063437.19160-1-yuehaibing@huawei.com> <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
In-Reply-To: <08e81f07-99d2-62a3-8eea-b2c0432b4d18@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 11 Apr 2022 15:49:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVYtV9KHYqjcXS05XM+QqbCgPKB_uZCCAN0eAqHUmoeTg@mail.gmail.com>
Message-ID: <CAMuHMdVYtV9KHYqjcXS05XM+QqbCgPKB_uZCCAN0eAqHUmoeTg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/solomon: Make DRM_SSD130X depends on MMU
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
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

Hi Javier,

On Tue, Mar 15, 2022 at 12:28 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> On 3/12/22 07:34, YueHaibing wrote:
> > WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
> >   Depends on [n]: HAS_IOMEM [=y] && DRM [=m] && MMU [=n]
> >   Selected by [m]:
> >   - DRM_SSD130X [=m] && HAS_IOMEM [=y] && DRM [=m]
> >
> > DRM_GEM_SHMEM_HELPER depends on MMU, DRM_SSD130X should also depends on MMU.
> >
> > Fixes: a61732e80867 ("drm: Add driver for Solomon SSD130x OLED displays")
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
>
> Indeed. All the DRM drivers that select DRM_GEM_SHMEM_HELPER depend on MMU.

That's very unfortunate. Is there no way around this?

Else fbdev can never be deprecated in favor of DRM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
