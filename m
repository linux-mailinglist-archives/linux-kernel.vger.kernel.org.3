Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C261553E8AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbiFFOWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239416AbiFFOWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:22:00 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD8C22E69F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:21:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b8so2369200edj.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vp8NNxHI8Mr5cvDebnpWHQ0r8fITxP4wMBgbky8hlKs=;
        b=cbfuFGvG9P3RoNLs/7komKcZAI5iYlhxO2c1PtY35nnPC3+G7B+1hWFJWkoS4PJIsj
         12l7R0+8en8jn64ramruBDLAM4LNDxwV5QlXnXU3GiVqV+E3Gtvm4iPw/S9vicOs+MKd
         veBzx9Qi7+Ff2iaPYmy4Uf1JlMPTfqESgCUDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vp8NNxHI8Mr5cvDebnpWHQ0r8fITxP4wMBgbky8hlKs=;
        b=UrzncEUlm/+n476p/3gtxKMkcB9/zIBA7f01wGk25QH8zEk/OXwGsCseOMdiHTw1Td
         cnvso57zPNnNvfsjdyb5MBaxZ8k/8RacXWuW77r4QCepuLGWqI8d0sVhJXTgUGLfH9NP
         NgLObJ33KHkGbDQ8P0f3ajH4hMvYP6w6YTWzgA9V2wKNseyaVBxe1a/H4TYECLSW3H/o
         VS8YE1OtSvZCy3Hz/+J6JLCVu5QHAXPHt8YYftP5FlpNcf0CWBlqwwxTCSvuS3dyu6oq
         fGhOTlBduQgFKBWKloHA1Ftlgbj/cJNmWaenPsN32NVe3Q9qI4f6DsqQEo66KES21kVL
         CAeg==
X-Gm-Message-State: AOAM531LM8csspYtT0hT2SaMSkMHbRMosSkGW4QQVKKhFPF1PZq4gHvn
        +eRWmA1+afnXAqzYBHzq+tkifhD7s95iVRka
X-Google-Smtp-Source: ABdhPJyMh5EWpCWNKPH6rM2tVxXfKdtDDpBTSg+pAF69Ey/kKnh6R5T3je6NSLkbgHuZ2gKP3nKQ/A==
X-Received: by 2002:a05:6402:84a:b0:423:fe99:8c53 with SMTP id b10-20020a056402084a00b00423fe998c53mr26852321edz.195.1654525316984;
        Mon, 06 Jun 2022 07:21:56 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id bv3-20020a170906b1c300b006f3ef214ddesm6411388ejb.68.2022.06.06.07.21.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:21:55 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id q15so12041181wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:21:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1685:b0:218:45f0:5be6 with SMTP id
 y5-20020a056000168500b0021845f05be6mr2525253wrd.301.1654525314159; Mon, 06
 Jun 2022 07:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-3-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-3-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:21:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYjMKN=M=PWnGny0x5TaQ5gF7b_vL4muCsCi+rH7FAbA@mail.gmail.com>
Message-ID: <CAD=FV=VYjMKN=M=PWnGny0x5TaQ5gF7b_vL4muCsCi+rH7FAbA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] drm/panel: boe-tv101wum-nl6: Implement
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
>  drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
