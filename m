Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123045171C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385576AbiEBOnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 10:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238116AbiEBOnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 10:43:37 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BA2120BA
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 07:40:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id e24so12867763pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UpUy8a2LGTGKAB1XvqmqE3EV2zftEVageSYqcaWSjV4=;
        b=BnVlJ/lPIQXcYp3dPFroPdhD3nvyMU/t7gqwe4fNv8tUug+20DPAlBv6FqPEL2/HF+
         d3iCEXSUksKjESBER9VK3AumPu4O3Eork+FwgQJiDF/NWTt9X5h1UF84wB1B5ptTFsGg
         g9I4AHrkIIv0zTrgRzi0b7RFGovc7RsCYtm4qpU40pXo6nZBfw0ssQqxMiAXw4p1VAuV
         /ZQNyi5JzTXvBR63pgp8OInR8mNRgchcZjH7HTsGY5wOIIxf3+bPhVbjy/qP4hqC/ls5
         /QRY+GnFlUT7G3cbub4jlh3v1QtFZEqMvkPXsCQgZUgTIXmUNnXkYF8uiN0Mp3WG9Mqg
         1uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UpUy8a2LGTGKAB1XvqmqE3EV2zftEVageSYqcaWSjV4=;
        b=uyQTR6UJHAdnt/GW3LD9K0LPde23QBK1KfcndUdK7DH8XTr4hF9Bawztq5rcZWfRHP
         4nfTuRcdhQCPU0yd9qNL5bRSaUumQRygDQFddoEDAeNm0G5xyW2YoP7tePOsb/IAkDb+
         KYzRURj0aXtbaV42pNIG/l4Sm9TfY64fP9MLGgpH6YArjm8xno71HMOogvSwhl08CXJV
         74/Uk7T/7iQ4MsDALrxEnl9cgGgG3zUFlEX56t1rXk8bJ6s0VJCRAKXSwgw9Y0Owz3Km
         2ZVoC+n0x40dzsK6Mlj4h/YJQhIzRHtwlea26loHxKhtDaMZCxDHIN9yS+PBNM1hRilr
         REfw==
X-Gm-Message-State: AOAM533Ih1ey60+fKQ4OwD08p3aREDz8n1tM1JLghWkuyRUvIN+lhB5E
        zmiLD0HVkTdyehMpDgG7aZ2rt9mloVMicuaSty3upQ==
X-Google-Smtp-Source: ABdhPJyGk1Y+Z0yzBRpwaavA333ksRfujeF06Ys8IMOVOBLnFOU3i4i1W2PpwI7FUNle3WRDM6tEKM4cl6XzkFydyWk=
X-Received: by 2002:a17:903:2350:b0:15e:93de:763a with SMTP id
 c16-20020a170903235000b0015e93de763amr9336775plh.117.1651502403846; Mon, 02
 May 2022 07:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220423120854.1503163-1-alvin@pqrs.dk>
In-Reply-To: <20220423120854.1503163-1-alvin@pqrs.dk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 2 May 2022 16:39:53 +0200
Message-ID: <CAG3jFysm2haeZ9jVkK96n1_vVjVkwRtLqOvM-r-F5qmQ7YDQpg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm: bridge: adv7511: CEC support for ADV7535
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

On Sat, 23 Apr 2022 at 14:09, Alvin =C5=A0ipraga <alvin@pqrs.dk> wrote:
>
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>
> Changes:
>
> v1->v2:
>   - add Robert's r-b
>   - fix up 'case XXX...YYY+14' statements to read nicer in the 2nd patch
>
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
>
> Alvin =C5=A0ipraga (2):
>   drm: bridge: adv7511: enable CEC support for ADV7535
>   drm: bridge: adv7511: use non-legacy mode for CEC RX
>
>  drivers/gpu/drm/bridge/adv7511/adv7511.h     |  27 ++++-
>  drivers/gpu/drm/bridge/adv7511/adv7511_cec.c | 116 +++++++++++++------
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c |  19 ++-
>  3 files changed, 116 insertions(+), 46 deletions(-)

Applied to drm-misc-next.
