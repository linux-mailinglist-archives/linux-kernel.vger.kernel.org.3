Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCA35A4FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiH2PEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiH2PEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:04:12 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE97A85A9F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:04:10 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z20so8348950ljq.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=347LfAP44frQffdHJ/9JrhHkWnMPl3tC3TkZmIT/0NE=;
        b=jWuBrwJQtN3vnRcvGuWYl6rCPZeeGWKfwekOKFMZAZJAopoRRDOSpGVrBSVgL3YUbn
         Gts3fGDwlIff6pYoiRTaQeUDPYQy/fFV2eELp/KRKZf38hGTlpXdWvKeo/7NqeepsRWY
         yTihnSYuAX6/QBE8kRmxAd7cenmDMHTrI0AnopDvWgtxw8iK8wa6HQqNq6swKQXf0iFx
         JJlZL1+lvcdfk+VPOmCYMh10xZsleuo4sRPp/LiollY71hl18vvA4nnvM9vWXUM9noWS
         2m0e7LLzx7ztw6ON3JCeH9Wyt0Y2/V+KYN+O7mttlB+64NztmemE1uUoqDFNJT0kY6KK
         ZQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=347LfAP44frQffdHJ/9JrhHkWnMPl3tC3TkZmIT/0NE=;
        b=74VAqm96nXPGSWx8F0kTaGxGcD4n3hyFYk0o14avuzyN/Or9q6ZgryNWrRMHZ1/9j8
         YzEH4HBOAy0YjP8tiXqXp3lchgM0Gm41tKlyM2fQycxERp02ynEN7y82/nsOsZQgE52L
         +i462lrNvSLtejZRdKenJDh7+WJXVKGtQmNeaMAoFj8ep3l4feTiU9U4zEUDxy2uY7hS
         9R4pX+nMrEJDhs+FG+sBJec2DEjjbYP7SzNgP6ATQpwE/Lp6Fs5TWSpYXTls+kfcv4Wf
         gJJAoRk4PfDvH5ZYMQR0Q3ojDlqrTPUusQQhC7vufuM7ijFZxCyFSIws0hS3M/bYdXVM
         9Quw==
X-Gm-Message-State: ACgBeo3Ke+8CJBPQa2PLCjXZYnpWymL3J+49+IQ7VPt9gJROb5Ppr8iT
        L9LvAGE2/YRBWUlfVXvTC7GZb5dSUUE4UD7DwE4hKQD9ObJ9XA==
X-Google-Smtp-Source: AA6agR4GKG6UxIBeSkOj9tZcipNHDDnq+j1l+bVcOZUPMOaA9GrHrvXDpw8gLBRsJuY++8TK/MQWsHwVNf9LJUS8rQ0=
X-Received: by 2002:a17:906:d550:b0:733:8e1a:f7 with SMTP id
 cr16-20020a170906d55000b007338e1a00f7mr14228340ejc.580.1661785438494; Mon, 29
 Aug 2022 08:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220716081304.2762135-1-zheyuma97@gmail.com>
In-Reply-To: <20220716081304.2762135-1-zheyuma97@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 29 Aug 2022 17:03:47 +0200
Message-ID: <CAG3jFytOyhy_es2cULpp0TCdp70HTcqKo1hd-ZxVaC4O-vi-3w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: megachips: Fix a null pointer dereference bug
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

On Sat, 16 Jul 2022 at 10:13, Zheyu Ma <zheyuma97@gmail.com> wrote:
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
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> index cce98bf2a4e7..c68a4cdf4625 100644
> --- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> +++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
> @@ -296,7 +296,9 @@ static void ge_b850v3_lvds_remove(void)
>          * This check is to avoid both the drivers
>          * removing the bridge in their remove() function
>          */
> -       if (!ge_b850v3_lvds_ptr)
> +       if (!ge_b850v3_lvds_ptr ||
> +               !ge_b850v3_lvds_ptr->stdp2690_i2c ||
> +               !ge_b850v3_lvds_ptr->stdp4028_i2c)

This chunk fails checkpatch --strict.

Alignment should match open parenthesis
#39: FILE: drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c:300:


>                 goto out;
>
>         drm_bridge_remove(&ge_b850v3_lvds_ptr->bridge);
> --
> 2.25.1
>
