Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F266959542A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbiHPHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiHPHzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:55:09 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FDAB940B
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:08:29 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-33387bf0c4aso18261037b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=MBSDgt1+KSEMqLb88Z3kkhrcZMPuM+VYZYiBJd++HWM=;
        b=ialTs+JRTPXZpcZbTfdBeaRhv22RmAXvx1OhrylS37gvBZ+FPrEa2Ez89OiaPxwQ9D
         ua5yHGmGXIjYX+TIP6VN7SP9IivKO7pbYNYzhQ1QcWQv3upgFU6zBSt0MX6zSE7w1v36
         DY9F5KcKqJROyfsREA1cwEhjViUfVNbCz/CWoC68hE6SITCGs0hCwQjAPODVLopgFwuv
         QALMsJFLqwrRj3Y2Suuzd5XHBAe34fSDfn50qgFSFpjk7MpQWRfJ8ztaendd/herIZba
         RvJvF1HH2cKzh1JoWyCnRglpGcAa0fG5fX2Mwr6xwn7O70xu5lbEGVaDd6XAxVL1lA7w
         +Hsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=MBSDgt1+KSEMqLb88Z3kkhrcZMPuM+VYZYiBJd++HWM=;
        b=Z3kkuxLz0JCs8QRaowh41sYewta60GXB4b6AILljRjg5lRoKKLKShQy1SaEWf1GqsZ
         o/WkitvWLu5A4+Z+Ey1g+mJICYE5Yyr01RjVCIv7UjCH5m97+KZQFMO2y0iSwk30+eHr
         cnlsmljxP1VpX1CL/7ZrdOeBU2+oIwG8irpkv8BS7c6Ja6q5hWZartf7dgggcqp4lrM/
         JiZPvFXDDqmQhzzjBmOMVb8V/19jIgHx/Rukc6wPe3edSUtAjnWpc8ducvo1FIX/U9/e
         4KdfFIZHid/EhX5zRfcOVQQUh3Yi4sPWpMFGS1zcHYa3U/KWebDd4TnoUx0yvmBzS2Fg
         P/Cg==
X-Gm-Message-State: ACgBeo280M08/qdWZxGZmysImHHNh0xF/wy3ID12W0mDlTl7CT4oJL0L
        5UZTB5zQgEkRVbLxlIaZYQksktIm+ZMDz8OEoc59OmJOk6V8hnqH
X-Google-Smtp-Source: AA6agR5pVH1dUTfVBzR2nBu+fzXW1D2Jhm2zSJo2x2RpMuFIg1ZvlQT5wUDcW8jdXQ/dCDx9n0xJ+06XchwNP0TxggY=
X-Received: by 2002:a81:478b:0:b0:329:f9b1:9911 with SMTP id
 u133-20020a81478b000000b00329f9b19911mr15505202ywa.8.1660626508904; Mon, 15
 Aug 2022 22:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org>
In-Reply-To: <20220815093905.134164-1-hsinyi@chromium.org>
From:   Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
Date:   Tue, 16 Aug 2022 13:08:18 +0800
Message-ID: <CAMuczyURTSj6x-BWu-ciSyPidFTUD-p6QkDQ23u63vgFcs26qQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2022=E5=B9=B48=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=885:39=E5=AF=AB=E9=81=93=EF=BC=9A
>
> The double reset power-on sequence is a workaround for the hardware
> flaw in some chip that SPI Clock output glitch and cause internal MPU
> unable to read firmware correctly. The sequence is suggested in ps8640
> application note.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>
>
> ---
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index 49107a6cdac18..d7483c13c569b 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -375,6 +375,11 @@ static int __maybe_unused ps8640_resume(struct devic=
e *dev)
>         gpiod_set_value(ps_bridge->gpio_reset, 1);
>         usleep_range(2000, 2500);
>         gpiod_set_value(ps_bridge->gpio_reset, 0);
> +       /* Double reset for T4 and T5 */
> +       msleep(50);
> +       gpiod_set_value(ps_bridge->gpio_reset, 1);
> +       msleep(50);
> +       gpiod_set_value(ps_bridge->gpio_reset, 0);
>
>         /*
>          * Mystery 200 ms delay for the "MCU to be ready". It's unclear i=
f
> --
> 2.37.1.595.g718a3a8f04-goog
>
