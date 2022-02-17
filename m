Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4734B9648
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 04:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiBQDCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 22:02:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbiBQDCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 22:02:46 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2FDF9FA8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:02:32 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id m8so1310365ilg.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 19:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SDqKCMLHkPaCw6ovXM1GLOoMd4SQY+h9F+jSwe4SwVM=;
        b=CPcBoH/ZU+9TlZUx5RzQ2x3a1alnNTknYehhGtoJGt1JR9X23kDmOaE4q6r/RxlP5T
         WE2lclOVh8jz7GUEJZ94hiJdhNyibl+0mU+YPDDJflmwHPwcrXACnTrA10lZcASZ7og4
         ShDW63gXOenKl70jeR76h7kGvNRWqeNt0JomQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SDqKCMLHkPaCw6ovXM1GLOoMd4SQY+h9F+jSwe4SwVM=;
        b=hY0apFHYLnQ2t8qF2qZzXm1QWMG2rZoKz6VwCBRE6k9orwyrRO65zp7O2z3oqUrLLf
         YKHESV2kymZ/rXPtF4daKzKIoO9asbfiWtzWgxWFMP232wG8Lw8tXPciGOtW7m9to/Bw
         VYazt5Ha/6l4eHPFwhiYUtrMsizonnVk9WowzxWlrgkSmGw8fNePx/YJnFSjrtUk+jW7
         Uhrg63ppv2scp03i1bWEhGhdS2ThWVlB88jeYNmNQ+SH5nYa8nMDUpVkcr5Hv00ckfUw
         zM1TLfDstPoEe+TrG2u9T6vHIy5EQeolLRNpVRbP5U9fP705urJQ8q6DL9H+MIeqOrHp
         Fbgw==
X-Gm-Message-State: AOAM530AJj7RvNO3W8fL1X3Qzy1Gt0MTAWcaVoTIXGru7XGR5nm6JJZr
        MJo0TNG/hfwdUfEw2vqZeQw1/l3soRrf0KVLzfm1GQ==
X-Google-Smtp-Source: ABdhPJxp5fVLExa7nP7nDRhaTzG3tJgMhyOvVFoLKomiTIf/veYIrjOSrg6pLxP77T6y0Otez7aIwbJzW3CgselSD5A=
X-Received: by 2002:a05:6e02:1a6d:b0:2bf:60df:d27 with SMTP id
 w13-20020a056e021a6d00b002bf60df0d27mr631014ilv.105.1645066951384; Wed, 16
 Feb 2022 19:02:31 -0800 (PST)
MIME-Version: 1.0
References: <20220217024418.3780171-1-xji@analogixsemi.com>
In-Reply-To: <20220217024418.3780171-1-xji@analogixsemi.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 17 Feb 2022 11:02:05 +0800
Message-ID: <CAJMQK-gDHsH=F=d+9W1-jOqKx6kveUtRRSG03W6KDVat=BzZhg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix release wrong workqueue
To:     Xin Ji <xji@analogixsemi.com>
Cc:     andrzej.hajda@intel.com, Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com,
        Xin Ji <xji@analogix.corp-partner.google.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 10:45 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> From: Xin Ji <xji@analogix.corp-partner.google.com>
>
> If "hdcp_workqueue" exist, must release "hdcp_workqueue",
> not "workqueue".
>
> Fixes: cd1637c7e480 ("drm/bridge: anx7625: add HDCP support")
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

This fixes an issue that the driver will crash during unbind.

>  drivers/gpu/drm/bridge/analogix/anx7625.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 633618bafd75..9aab879a8851 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2736,8 +2736,8 @@ static int anx7625_i2c_remove(struct i2c_client *client)
>
>         if (platform->hdcp_workqueue) {
>                 cancel_delayed_work(&platform->hdcp_work);
> -               flush_workqueue(platform->workqueue);
> -               destroy_workqueue(platform->workqueue);
> +               flush_workqueue(platform->hdcp_workqueue);
> +               destroy_workqueue(platform->hdcp_workqueue);
>         }
>
>         if (!platform->pdata.low_power_mode)
> --
> 2.25.1
>
