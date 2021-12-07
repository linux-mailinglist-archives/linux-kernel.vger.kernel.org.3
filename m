Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A94F46C71A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242028AbhLGWLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbhLGWLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:11:34 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93CFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:08:03 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id i9so485178ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=atU9jwmDu1ac+tPH14Y2BWTuoNEX/32eFlQLglMG6iM=;
        b=boojLZt+HAHZ9Pd+otNf2edcHXApkbFARJtm0jHillGMhkFsreHcZUi0H+HIrhTULQ
         Q1aatEYVf+GCcA6HSI83dPF3c6WN279buc+UUSGcKNnavVUy3eZsmKV3JtfowUAhfno8
         mN6JUQ09qCxd26HLA53VXFcP2b0nN01NnCSjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atU9jwmDu1ac+tPH14Y2BWTuoNEX/32eFlQLglMG6iM=;
        b=JO/6gWC0WU9tOwJZrTUnv+/eU4vN/sOLgiOk6B3cjIISUqacrVfLWY0yQIcMNrw1HT
         iOVIe4f21OXHeVS/c+jvMM10EMKZRpc7skiCYATwb0pTlbiY4TbvBTK4gTvqkN7061Uo
         Y45sALSvjjCJ5posGDJ4M2n2bf/muYHAG6TATUrDNSZ2Kcd045fWnz6pOje7SZwa9t97
         ipK+2MMlX9ITN0YXMxMKSI7Y6X2WgeL3ysBFFyir5ezSu4EP+JgUcakc8tzmpDInJhC8
         n4kg1t6mCgU/1yMe4rJ4IBajeZLvgZJ25WcVQrg21dswNFejAlEuLnrq09QeBqgREkLN
         mBDQ==
X-Gm-Message-State: AOAM533XiGF2FGq6OdRw1cmuBqhPaRABfcNKrKY1D3I0WjZPbR/0rHik
        ir7aGWMn9MXjielIOn+3x9gs/Tirwp2AFQ==
X-Google-Smtp-Source: ABdhPJwUhZWFfKFv/DxrOtrIHTKg2pbkvitOkZ9fDcqayScaqEP24D/IslfjCZAWnQn4Ri3QaIHT5A==
X-Received: by 2002:a05:6e02:184c:: with SMTP id b12mr2385843ilv.293.1638914882823;
        Tue, 07 Dec 2021 14:08:02 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id g15sm729144ile.88.2021.12.07.14.08.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 14:08:02 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id t8so444413ilu.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:08:02 -0800 (PST)
X-Received: by 2002:a92:cdaa:: with SMTP id g10mr2213708ild.142.1638914390989;
 Tue, 07 Dec 2021 13:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20211207215753.635841-1-robdclark@gmail.com>
In-Reply-To: <20211207215753.635841-1-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Dec 2021 13:59:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xh1OHVCdwHauebFC-OUBCXfkZkTC3V8yxARou_UfXq1Q@mail.gmail.com>
Message-ID: <CAD=FV=Xh1OHVCdwHauebFC-OUBCXfkZkTC3V8yxARou_UfXq1Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: sn65dsi86: defer if there is no dsi host
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>,
        Stephen Boyd <swboyd@chromium.org>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 7, 2021 at 1:52 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Otherwise we don't get another shot at it if the bridge probes before
> the dsi host is registered.  It seems like this is what *most* (but not
> all) of the other bridges do.
>
> It looks like this was missed in the conversion to attach dsi host at
> probe time.
>
> Fixes: c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our DSI device at probe")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
> v2: Drop DRM_ERROR() in favor of drm_err_probe() and shift around the
>     spot where we report the error
> v3: Add \n and cull error msgs a bit further
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

I can add a further:

Tested-by: Doug Anderson <dianders@chromium.org>

Since it's pretty straightforward and I don't expect it to be
controversial, I'll plan to land it tomorrow in drm-misc-next unless I
hear otherwise.

-Doug
