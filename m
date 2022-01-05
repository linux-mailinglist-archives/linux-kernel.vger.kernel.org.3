Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F907485993
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243774AbiAETzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbiAETz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:55:29 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D54C061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:55:29 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so612328otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlPJsMW5yVPe7P3RKOvMwPlqeJN1/Nu2FfKIApHsgbo=;
        b=DwPxC3cLLNM8XVTzd55gQ7bhxNML705Ttl/ErwNTDEyJwlW4XJMuoiodES7QQ//mSL
         NqvSpNl3q6yIa44pWFb8gv6RfQh9JDnxYAV18DuYJc10XKzkRm4oMwtHC9HPCapN6hMm
         iqc0/E4iLeL6kOCUEBwGPMA/dnUvUs7BdnY/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlPJsMW5yVPe7P3RKOvMwPlqeJN1/Nu2FfKIApHsgbo=;
        b=Sinl/eJe7C9VsGxin9xhzNXZw6zYVv97V/EB7QrNF89exvvjNApRoZ0Xc3i6ZvFCFN
         QJ1pumkBXHEX4TZd7jLPkIvGvMTXV7FeDQ44G1Xn2QX3Y8tnKLYvXbSGIw/fyuirVI0H
         yUH+WyyJwxJig8ruVe0Ub2UQjoll6PBSZudC9DJCBNxy5pZJUJg9hn/c3skgIllVmCDO
         I01YmApGrItZW6FAW4hH5GckpcheRp/pd/F/SWgzMrsDLG0pPYy2xmwxMcMA+sGtkgKm
         j9yCgiX7uVD/EPuGW2eRFFy833di7SPohSwlDeIZsQkSKYzfmvYRGicnrtclP/qjugvK
         Jqig==
X-Gm-Message-State: AOAM532eNe+koMebWZ+eORRse+lnEsPT97WRA3mGwt4rlPtuVqh21uQE
        hAlZ/vLWH6XMbljI2EOfHf3/UrnQMJ/s1Q==
X-Google-Smtp-Source: ABdhPJymYbIVgSGZw/dDvu0o40dfOW1JIEKyxS3/8Ru1+tF09VoIkCwfPEP+7AWJyCdYFehQhZECgw==
X-Received: by 2002:a05:6830:1258:: with SMTP id s24mr40764767otp.226.1641412528508;
        Wed, 05 Jan 2022 11:55:28 -0800 (PST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id be30sm9566103oib.50.2022.01.05.11.55.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:55:27 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id r131so573756oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:55:27 -0800 (PST)
X-Received: by 2002:a05:6808:3097:: with SMTP id bl23mr3823157oib.77.1641412527103;
 Wed, 05 Jan 2022 11:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20211001144212.v2.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
In-Reply-To: <20211001144212.v2.1.I773a08785666ebb236917b0c8e6c05e3de471e75@changeid>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 5 Jan 2022 11:55:05 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOEv3xigBaEwtYcGM7Q9uNHrwijoWTHoiLg--UT=vA7TA@mail.gmail.com>
Message-ID: <CA+ASDXOEv3xigBaEwtYcGM7Q9uNHrwijoWTHoiLg--UT=vA7TA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: analogix_dp: Grab runtime PM reference for DP-AUX
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     Sean Paul <sean@poorly.run>, Jonas Karlman <jonas@kwiboo.se>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        stable <stable@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(updating Andrzej's email)

On Fri, Oct 1, 2021 at 2:50 PM Brian Norris <briannorris@chromium.org> wrote:
> If the display is not enable()d, then we aren't holding a runtime PM
> reference here. Thus, it's easy to accidentally cause a hang, if user
> space is poking around at /dev/drm_dp_aux0 at the "wrong" time.
>
> Let's get the panel and PM state right before trying to talk AUX.
>
> Fixes: 0d97ad03f422 ("drm/bridge: analogix_dp: Remove duplicated code")
> Cc: <stable@vger.kernel.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
> - Fix spelling in Subject
> - DRM_DEV_ERROR() -> drm_err()
> - Propagate errors from un-analogix_dp_prepare_panel()
>
>  .../drm/bridge/analogix/analogix_dp_core.c    | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Ping? Do I need to do anything more here?

Thanks,
Brian
