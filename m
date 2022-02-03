Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5754A7FAC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbiBCHSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbiBCHSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA49C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 23:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A31D8B83356
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B68FC340EC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 07:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643872715;
        bh=5H5/k5olynjeqCdmMW5v7q2bRtXHy37Na6heaQilUwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A3qNuibCnfG1vzIEmqyA1hhMwUy4zY58OPEDKygk3LkVjTn35fJuNVWwdHkdcHJ1u
         9F33AuDoF6cF7U+xH5wKCd8fAW2RLw6+YqN3bw52bfUPfksoPyWh5uXA2to9CZ5Xar
         YR4bqATC9komeJpFQVwshHLcHUzqAgOf8I7rPndsvdgx/b+tgZu+xCsmBwJDm7c4Bu
         uKGCAsbsOJxBNGm+12+vfAeNEmuoytXLTrhFXYnwdiLY22EtVX20vgyyQjaLm02ELY
         JmnnYlNiBwVVw/B06++DPpK+YtgbqobFv8xU7S0cvsnlIHCk3AkGFQc1PmKyka0Vch
         pn72Kt3KU6rFw==
Received: by mail-wr1-f43.google.com with SMTP id j25so2430784wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 23:18:35 -0800 (PST)
X-Gm-Message-State: AOAM53290xj012W4WTDQmqJe+W95ZRT6wmyXf9Y71gVm3ybjmnbqtncN
        CHTMwU5XlssS1NvfkngHy5MINYSJXjLh8oqktM0=
X-Google-Smtp-Source: ABdhPJyRCdrTnIbw1EbQEAwvRcn64WxftR6K+xurhn6IWOiTvTZn+f6oHgNzFyWKMIgR1DlwEhyWySVgzm4jWEghz1w=
X-Received: by 2002:a05:6000:144f:: with SMTP id v15mr29005306wrx.407.1643872713707;
 Wed, 02 Feb 2022 23:18:33 -0800 (PST)
MIME-Version: 1.0
References: <6fc4a81f-1a13-bff9-7b2e-d5bec382cb42@synopsys.com>
 <9bab4777-3034-b789-fdf6-ca8d7e6a8c35@infradead.org> <CAOMZO5Aa4WxuadfoFGwwyYyD4UGPm-E258xTWU3-ozp_hwG-7g@mail.gmail.com>
 <d8981e2a-4f61-72bb-e5cc-bf4ded29c08a@synopsys.com> <CAK8P3a3ELrSC=KX6cr8UnP6kkJN0AXeAE4EG4oUY=Zz7gG_dgg@mail.gmail.com>
 <b44de208-6d5f-3fcd-0e36-f05745297747@synopsys.com>
In-Reply-To: <b44de208-6d5f-3fcd-0e36-f05745297747@synopsys.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 3 Feb 2022 08:18:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a27RtHxYwtj=rjxcDzkMdKhC-w9ho=SApHpczma_vU8JQ@mail.gmail.com>
Message-ID: <CAK8P3a27RtHxYwtj=rjxcDzkMdKhC-w9ho=SApHpczma_vU8JQ@mail.gmail.com>
Subject: Re: Kconfig CONFIG_FB dependency regression
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        John Youn <John.Youn@synopsys.com>,
        Bing Yuan <Bing.Yuan@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 3, 2022 at 12:55 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> Arnd Bergmann wrote:
> > On Wed, Feb 2, 2022 at 1:14 AM Thinh Nguyen <Thinh.Nguyen@synopsys.com> wrote:
> >> Fabio Estevam wrote:
> >
> > CONFIG_FB should not normally be needed for booting, so unless
> > you have a graphical application in your initramfs that requires the /dev/fb0
> > device to work, it is not supposed to make a difference.
> >
>
> I'm not sure, but it seems like the setup we have isn't the only one
> that needed it. Fabio also noted that the imx_v6_v7_defconfig also needs
> to have CONFIG_FB set.

No, that one is different: the change for imx_v6_v7_defconfig was
done because they actually use a framebuffer console on some devices,
so the patch just adds the symbol to enable the drivers they are using.

This is expected with my original patch that doesn't implicitly enable
the framebuffer layer any more. What is not expected is for the kernel
to hang during boot as you reported for your unidentified platform.

> > Are there any other differences in your .config before and after the patch?
> > It's possible that you use some other driver that in turn depends on
> > CONFIG_FB. Does your machine have any graphical output device?
> > If yes, which driver do you use?
>
> I don't have the answer to those questions yet. Need more investigation.
> I'm new to this particular test setup.

Do you mean you don't know if there is a screen attached to the system?

> >
> > You may also want to make sure that you have 9d6366e743f3 ("drm:
> > fb_helper: improve CONFIG_FB dependency") in your kernel, which
> > fixes a minor problem with my original patch.
> >
>
> The issue also occurs in mainline, which has your minor fix commit
> above. The revert isn't clean for the latest kernel version. I also have
> to revert some of the changes along with CONFIG_FB. The revert looks
> more like this for the latest kernel:
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index b1f22e457fd0..7cbc733a8569 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -118,8 +118,9 @@ config DRM_DEBUG_MODESET_LOCK
>
>  config DRM_FBDEV_EMULATION
>         bool "Enable legacy fbdev support for your modesetting driver"
> -       depends on DRM_KMS_HELPER
> -       depends on FB=y || FB=DRM_KMS_HELPER
> +       depends on DRM
> +       select DRM_KMS_HELPER
> +       select FB
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
>
>
>
> I attached the configs for kernel v5.17-rc1. The "bad" config is without
> any revert, the "good" config is with the change above.

Looking at the config, I see that this is for an x86 machine,
and you have the FB_EFI driver and EFI_EARLYCON enabled.

What I suspec is going on is that you are looking at a screen rather
than a serial console, and the kernel doesn't actually hang but you
just don't see any more messages after the DRM driver takes
over from EFI_EARLYCON because there is no console driver.

In this case, what you see is the intended behavior, not a bug.
If you want a graphical console in your system, you need to
enable the support for this in your config.

       Arnd
