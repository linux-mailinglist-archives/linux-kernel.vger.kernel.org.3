Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2989753E5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbiFFO3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiFFO3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:29:45 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A162CA3C6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:29:45 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h23so18236377ejj.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtB/1q8V6w+BWdhC9EKrHFyvz/JN34Sk5t7oVzNMdlI=;
        b=S54yq+aqgMtQgBARzs3r9I0ZrPQI5ZVZEutMIlcApQ0O+ylp3x4EGRtSkJThXVjx2y
         aHxka38JYLUmgi2B0Sh9t/3M28Bm9PGYHW8+XnhqG2jI9keSQmZuZPdHSadC73yyLPQ7
         Io5j+kBcKNbhtIatxrfuoa626ix5piOgJmDyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtB/1q8V6w+BWdhC9EKrHFyvz/JN34Sk5t7oVzNMdlI=;
        b=1ZApFvadYQdQK+CMhW8TLXm7uI0RfK0lPfhXGRJR5ntACXT+nZze5DYAPh1td/rwRT
         QyEW4C5nrQ+3zdaKz9MUYKNBkGYwDiREkfY1EYhgRrXaY4RvwoWlAAimw5r1pSvT34oT
         Rk+hyP6HE26WRyAbCbiqfI51gTxbWzntX+dspEQrzMcFOXPDrxrPKvVSx7mlFN6T4coi
         o/XXL22VEbYp0T5a8vR5r8Udw5pO3lPWT46+hZxbXQGa6QI5D8E6qOVBZoJBj0YfZaXm
         q2r3gOt9PP22nlwYjhQMZBNU98n/C+2ORyahrMnMcNj3i8heMXLvjDq2LbT7gVttUetf
         tIvQ==
X-Gm-Message-State: AOAM532wgfaypwwy8EalI8eZFYqlmjRLhYDc5eA3mLlz3DqTYtkHJToe
        bDuhQn96xBW0BHTJM6KSGkg6M7y5wwThleAGPts=
X-Google-Smtp-Source: ABdhPJzksOhBzJ8brFRc/rdSUHDCX+YcVAGdyZit9syOWQ7/3wHErHdcqbWrTnVhTZ3Z0gJ1FvQBlQ==
X-Received: by 2002:a17:906:7252:b0:6fe:9163:a4f5 with SMTP id n18-20020a170906725200b006fe9163a4f5mr21605067ejk.562.1654525783387;
        Mon, 06 Jun 2022 07:29:43 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id gt43-20020a1709072dab00b0070f1b033de4sm4049787ejc.200.2022.06.06.07.29.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:29:42 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso8010866wmr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:29:42 -0700 (PDT)
X-Received: by 2002:a05:600c:202:b0:39c:40de:ec19 with SMTP id
 2-20020a05600c020200b0039c40deec19mr16405042wmi.29.1654525391306; Mon, 06 Jun
 2022 07:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-7-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-7-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:22:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UwFuNrgBqyseHNLzuRQqyYHXe_sgSfQUSfsp80923h7A@mail.gmail.com>
Message-ID: <CAD=FV=UwFuNrgBqyseHNLzuRQqyYHXe_sgSfQUSfsp80923h7A@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] drm/panel: ili9881c: Implement .get_orientation callback
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 5, 2022 at 9:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> To return the orientation property to drm/kms driver.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> ---
> v2->v3: add comments for notice.
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
