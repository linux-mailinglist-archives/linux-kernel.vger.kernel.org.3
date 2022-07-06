Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C47056899B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiGFNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiGFNey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:34:54 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108EE260C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:34:53 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10bffc214ffso10706304fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxuLumhCwznNZcI7GXJpC/L4mRfNizaGC/XbqUh/5Cc=;
        b=AqUniGBmIEOL+tLXImG0kxgTzaHAcBgZIbmsAqJmlfD/1+CCSQQQ7fOFUyBwJOfH7O
         /hN00Tl01eYwBZF4e1pZ7Q+tApZ1qiK+RK4Ru+2hq6o5tgGK+lln1NNTwENYUlgkbC1K
         rdyupyZE5Mha3b82G4Jfrh5ZlgVF3GO/3HD/KbdcP1tlke7SyICrOMH352c5DVDr/9TM
         iWT9Lb1fVshNkcAR/pZ6tt8AWpNk6ZjjzOa1bTA8P9eO4ZXpukNXRCv8JEiLkEnj1Y+L
         wpC0B4Pl75FW+tjLmBQQe70vIu14NhnmepHDNd0ceQkG9FzoIf/vCb39baBBba1LEGT4
         L63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxuLumhCwznNZcI7GXJpC/L4mRfNizaGC/XbqUh/5Cc=;
        b=cl+jS26yAl771BW/DDO4lXXUFvqdi93N18mISV8KTgfY05pFV5siGVICFMJYQEf87b
         4lozI6F+cKddgraIOK+/S1CbdDahMyNK15wnEcXf5eig/JxvFT234c3OECsr1Nj/3i+v
         bbCIk6ibitPAYQXfwy9KWkijNX1LtwES1W/1sWdF3fxfENacvj7S7nJ+0yt8b7S1o+Ad
         J7zBFeBt/Lg3d2Mz09T4DZqGPkR3r0o7oQ4UnvDRyki05T6aZrg4GgyST6kQf68EVhuw
         Pp/7aAlKGjXV+0cYRLPkKi16G4Sg+uDguL9pctKT3aspP2w1l9bAYmeMWSQaU8YWqxIX
         bP0A==
X-Gm-Message-State: AJIora+4hZDbPaFJbFfaCaGYNPGXoeI6opp2iA/kl1LQPxLvWlHuBol6
        AHokBw8XEQgCUcBdZJjDYcmINCOBTL2Oajbaivy7Eg==
X-Google-Smtp-Source: AGRyM1vHdnhl8q3DuApTpUlCTFeXaNxX7B0xLQkj5wv6yAKOaA3nem0reFJL6DuiqrgxWKvNo1Oja+FRy4Kflu4g/3Y=
X-Received: by 2002:a05:6870:65a4:b0:10b:f0a4:17d2 with SMTP id
 fp36-20020a05687065a400b0010bf0a417d2mr11636243oab.241.1657114492343; Wed, 06
 Jul 2022 06:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220701065634.4027537-1-victor.liu@nxp.com> <20220701065634.4027537-2-victor.liu@nxp.com>
 <201c6bb7-ad86-5b89-e9a1-20a5740b8869@denx.de>
In-Reply-To: <201c6bb7-ad86-5b89-e9a1-20a5740b8869@denx.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 Jul 2022 15:34:40 +0200
Message-ID: <CAG3jFyun7NkLCy+bM0XHNRPrk6_kt7z8aB4Ud+4HdeNhffQydA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: fsl-ldb: Fix mode clock rate validation
To:     Marek Vasut <marex@denx.de>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, sam@ravnborg.org, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 at 13:00, Marek Vasut <marex@denx.de> wrote:
>
> On 7/1/22 08:56, Liu Ying wrote:
> > With LVDS dual link, up to 160MHz mode clock rate is supported.
> > With LVDS single link, up to 80MHz mode clock rate is supported.
> > Fix mode clock rate validation by swapping the maximum mode clock
> > rates of the two link modes.
> >
> > Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")
> > Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Robert Foss <robert.foss@linaro.org>
> > Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> > Cc: Jonas Karlman <jonas@kwiboo.se>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied 1-2/3 to drm-misc-next. Picked Mareks patch for 3/3 since it
was submitted first and is identical.
