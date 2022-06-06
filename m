Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B5953EAD5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239517AbiFFOWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiFFOWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:22:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03182ED7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:22:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x62so19035675ede.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYyKGEeq3UcMlhiJRIzst7R0qW1WAne+X1OnepWLUYE=;
        b=SFL7T5uifrBNLjB2DlOQ76k2CWD4lYFfvi+Cpg2JoGdLGFnhB7NYaEk4VeIgQjMih4
         dWD6g0rOGkVYh08vQvggGJY2yZvlDGzOf+oz68gB+AJ6zFrx06LXKkzALLHoXBKljZOe
         I9/PsfKKDUm55hO4bPdYQWfKmR4oBwin7fnuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYyKGEeq3UcMlhiJRIzst7R0qW1WAne+X1OnepWLUYE=;
        b=nmIWoajROdd0BNi1jNbbuo23d1f8AVNardoNmAy3+6yuvuDLnvCSovkAO5tfciyFP4
         FRDNJEZEi8sVlI4moBayzSwBKBQjTKXW6P4tDrXq+nXv8nitUGPTjym94cZ8Xt/6Hr1r
         HWtGeulyX00ByeCqe61s6YDKPzUTlSIn6UTjCbuc96d/IzhYSDbg/eCUdk1PuSQ95RzG
         FUeSpEcERWSJ+NQ+uL9zJxn9KgIg14J0leKe5vi8D6dQQApTiT++KDxkJLCAAqfy1KzZ
         ojK4a4vfEDaMv+65h8neTjc/SCGk7E3qtazmUnI0TOwJlHob0KR+26Fq829QxSkadCbh
         rkeg==
X-Gm-Message-State: AOAM532a9Iiy/DOh/WBHld/jm7flFWCq0y9h9ZMJ3NlPOBwDBqwOQnNK
        HNUQi8n7ajaX95RaNYpKemEgRxT70m23nmkA
X-Google-Smtp-Source: ABdhPJyOHmPkvVIzCYlqN3JChqDedv3776dPBfZyJTf8f5VeT+ylPEmeCwTgq2OAVEMpsv1nCyfvIw==
X-Received: by 2002:a05:6402:438a:b0:42e:985:4944 with SMTP id o10-20020a056402438a00b0042e09854944mr26293258edc.283.1654525334895;
        Mon, 06 Jun 2022 07:22:14 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id kq15-20020a170906abcf00b0070cac22060esm4777909ejb.95.2022.06.06.07.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:22:12 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id t13so20082369wrg.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:22:10 -0700 (PDT)
X-Received: by 2002:a5d:68d2:0:b0:210:31cc:64a6 with SMTP id
 p18-20020a5d68d2000000b0021031cc64a6mr21413566wrw.679.1654525330160; Mon, 06
 Jun 2022 07:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220606044720.945964-1-hsinyi@chromium.org> <20220606044720.945964-4-hsinyi@chromium.org>
In-Reply-To: <20220606044720.945964-4-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 6 Jun 2022 07:21:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VNnWcvedzgxfSWT0-sTR3jF8LsVXKFRnm49ZCJw6EH6A@mail.gmail.com>
Message-ID: <CAD=FV=VNnWcvedzgxfSWT0-sTR3jF8LsVXKFRnm49ZCJw6EH6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] drm/panel: panel-edp: Implement .get_orientation callback
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
>  drivers/gpu/drm/panel/panel-edp.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
