Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49CAC5A5DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiH3ILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH3ILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:11:17 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD9DA7AAD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:11:15 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z8so4332382edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fF0F3OYElqiJ53mOWS2AL4qmvq01DykDqlv2QChjd7g=;
        b=CzT/IQv7gIVrM71VDnXPNhL10sVQ2eUR0MHqENslzwNedOPhq/reWqCs2XyNtxxZc+
         09hE41ikqlI9fAL2+O22OJZ8I7UBrqLO2ofhMISbkSWo57EXqcsZCFGMO4lqdzxHeLgS
         sImQjaRz6cCmdNbS0laz6bbe3+3tw/zCaFZptsMGG0HZy2abJzxP26ymxEvPKyDPrJXa
         1EN8U2X3ZbKkdwnJNULDab2vUNVhmuj1qbmGNXs3g+gUdHUOf9m4iBi9/S4KYHomjFeD
         Te8jiPbJxU67i6RL+9TDxBSIJR3NWKHC9cYxz91qW5AxoZpXDWiwe4A4Uj9XwvG46jns
         iEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fF0F3OYElqiJ53mOWS2AL4qmvq01DykDqlv2QChjd7g=;
        b=2HEd2p8P29QAhvkhO22ptxYAl9S/RkZiv8F9mX/ED0fsVD9RAnBpv9b3xtpvoPs11q
         9b2EKseERNcwZrL3W8kS0kR9XAJ0+hGuRhqDD8btMKXVYTNxOQbUw54ZJAQWoZSwijfT
         kMdJyhdTZlD8mrS/ctXdugA7hTQhQrPKLYou7xDFA4WM4xUXlElbphUPamcKrRt4OMB4
         IeAlEIU7qEuKnQjTLROLH1sv7Ww3fipd74LLe5JyKdC9sfkVE8zNdbe7IdqFY4Nd8X3b
         QKckIKUfjx6/X+lMblovY/ono7uHP81OWIhKVJDVjtykDWpPqAHChfpFYQuwotGv7V7N
         Tf0g==
X-Gm-Message-State: ACgBeo1DLQNG9gPFAS2EVfYj/a+y5FwREt+LZud2Nqt4EYrnpySohUeX
        4nNlYP9mLFnxxrkB9nZxCYlU6ncw+l7K9V3DNbTZGw==
X-Google-Smtp-Source: AA6agR7wcsvJt7cWbQfr58ltQz1nqA2WxVpk4pe5C09l6YNxCdtMXZvU+pXR0hNwmstqf0n6DYqJ1xHU4O3UpqLiN7c=
X-Received: by 2002:aa7:d846:0:b0:447:d664:8409 with SMTP id
 f6-20020aa7d846000000b00447d6648409mr15730188eds.159.1661847073970; Tue, 30
 Aug 2022 01:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220830073450.1897020-1-zheyuma97@gmail.com>
In-Reply-To: <20220830073450.1897020-1-zheyuma97@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 30 Aug 2022 10:11:01 +0200
Message-ID: <CAG3jFyuQOb8gM0=86sUDXVjRiBw+3R3fCxc-E2X+=KnLaoQrKA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: megachips: Fix a null pointer dereference bug
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     peter.senna@gmail.com, martin.donnelly@ge.com,
        martyn.welch@collabora.co.uk, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

On Tue, 30 Aug 2022 at 09:35, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> When removing the module we will get the following warning:
>
> [   31.911505] i2c-core: driver [stdp2690-ge-b850v3-fw] unregistered
> [   31.912484] general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> [   31.913338] KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> [   31.915280] RIP: 0010:drm_bridge_remove+0x97/0x130
> [   31.921825] Call Trace:
> [   31.922533]  stdp4028_ge_b850v3_fw_remove+0x34/0x60 [megachips_stdpxxxx_ge_b850v3_fw]
> [   31.923139]  i2c_device_remove+0x181/0x1f0
>
> The two bridges (stdp2690, stdp4028) do not probe at the same time, so
> the driver does not call ge_b850v3_resgiter() when probing, causing the
> driver to try to remove the object that has not been initialized.
>
> Fix this by checking whether both the bridges are probed.
>
> Fixes: 11632d4aa2b3 ("drm/bridge: megachips: Ensure both bridges are probed before registration")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
>     - Alignment format
> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index cce98bf2a4e7..72248a565579 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
>          * This check is to avoid both the drivers
>          * removing the bridge in their remove() function
>          */
> -       if (!ge_b850v3_lvds_ptr)
> +       if (!ge_b850v3_lvds_ptr ||
> +           !ge_b850v3_lvds_ptr->stdp2690_i2c ||
> +               !ge_b850v3_lvds_ptr->stdp4028_i2c)
>                 goto out;
>
>         drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> --
> 2.25.1
>

Applied to drm-misc-next.
