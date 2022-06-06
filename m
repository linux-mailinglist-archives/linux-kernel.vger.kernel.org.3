Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B55453E823
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239541AbiFFOXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiFFOXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:23:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2ED1CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:23:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id x5so13962516edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yGL0Upz9tWnkdyE7J91J4gh0jAtGzDIxVVzukBDULoo=;
        b=CMRHt1AN30bDkUOr86s0m7NX4v6Nb+f9O1f35JrMFYxJW+BntmP8QkDNPVhjPtLBAY
         +XZXVhMMoo3pRxxgqF6QmA5eND0Uhc4PnRQFCZGdnwOLTPB4jgL6mvWNPsslH/pJ8IAP
         3HOTuodUa88+MXtlY2t8w6gtk1sibf3wiJKvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yGL0Upz9tWnkdyE7J91J4gh0jAtGzDIxVVzukBDULoo=;
        b=KEYS9IH1V3DQfMp9uw89U6i7jU5LLLWzlNOeo117ttehjbjz/hLTnyPLBwWADdorwM
         hpw5IKoOjENbv68szHJlN3EOta+UQ9QwF8FCh89fMJmhtAiQZLAn8oIRgTo9SxFXxFca
         OPS5gEn01N9fcy5CpLkUblNxnNq5YXDxwdzHJt7nhx4MDTv0CHOCmaWmUePtwe6BKl0O
         E8Tek34OeWljvptE9zCfodikTH6aC90Ry2Mks097iaeHw7Bmq9RXrclax1zhF2lFAEBb
         aSlk+hsHR013yWj4LQ5Ec83wyLHeTbaAsDJF5Ag/+XVx6mKY6aHNioAECqXdC5Ne8mvs
         nXCA==
X-Gm-Message-State: AOAM533S12apm0c/RNtNbtkxh7/GRCorj/R13na4cPy3wRobwV/4MLLb
        ZmgxzLCYQNC7dlvJSU2sOkYmDIPZmTIYBGZn
X-Google-Smtp-Source: ABdhPJxxGtxuKBQRnPD6wsxh21rG8qZ9X6DAhbsuPTJSskeSck+n2kkK/SGwbSinmVZERGmxAXzPBw==
X-Received: by 2002:a50:ec89:0:b0:42d:cc7f:abbe with SMTP id e9-20020a50ec89000000b0042dcc7fabbemr27017749edr.381.1654525378878;
        Mon, 06 Jun 2022 07:22:58 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id j22-20020a1709066dd600b006fea2705d18sm6339399ejt.210.2022.06.06.07.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:22:55 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h5so20134102wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:22:53 -0700 (PDT)
X-Received: by 2002:a5d:608d:0:b0:218:3cfa:afe9 with SMTP id
 w13-20020a5d608d000000b002183cfaafe9mr5831997wrt.422.1654525373078; Mon, 06
 Jun 2022 07:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-6-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-6-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:22:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WeF=fM9dVSgdNNP8_mOWZXZyoSwF-tztSXe1=dLb5KzA@mail.gmail.com>
Message-ID: <CAD=FV=WeF=fM9dVSgdNNP8_mOWZXZyoSwF-tztSXe1=dLb5KzA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] drm/panel: panel-simple: Implement
 .get_orientation callback
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
>  drivers/gpu/drm/panel/panel-simple.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
