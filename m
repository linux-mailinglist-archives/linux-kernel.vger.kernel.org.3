Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99336553944
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352848AbiFUR65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiFUR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A455B20
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2015061674
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1AAC385A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 17:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655834332;
        bh=ie0fsV1NYE5zKGkG5gMpaBWr3MLQDZYRSPzwKnAxneM=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=JHCfdE6dN3MO0DXOhdUQXJcHo0AsiOF5Q+ukREbQ6KO0Rt0D4FGy1r/5xrZrFdmRb
         WgYbTT0PlxGBjQS+5p6AxW2GLu9HkLUPuT3C3YWw50lr0MzN7eYSmjIcgwwG21ImIY
         nbGNa91GpE6Fw/R2R42DlSoPNA8D65I3tzab9pI3ggqgXXppeRGo0bPkG7U7UN2zO9
         Jfgeoh1QVgIsXIBM0hFK4r93cw+s+6YwPwDQSLRKiNz1ZfIMYlmoM+gl98ogqUW3Mc
         3wIvgYu8kaV0jEJsk0GnLLqwA1HhmeuEjK35/YDW20+DIdX2QMl5iwOSOfy8JefIyN
         rf6PRqS1lI1ow==
Received: by mail-vs1-f50.google.com with SMTP id j39so14644103vsv.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:58:52 -0700 (PDT)
X-Gm-Message-State: AJIora8TootsTbIH5Q9nOrchIvT4keEU3ghv4IbwyDHFBBevBIlbvM8S
        4WVlxSowymyUuUXeFsQQB9xPDH42Dgow4xYR/Eg=
X-Google-Smtp-Source: AGRyM1svAWcHbrEfGfm5k/hfuTdXisxqG0fTMNVOlWCOHViV1GoqBV/BhrgxrOMrH1bW8b9DhhQj/KWLQU4ZXR87G2A=
X-Received: by 2002:a05:6102:38cd:b0:354:3f24:56bf with SMTP id
 k13-20020a05610238cd00b003543f2456bfmr3870027vst.49.1655834331405; Tue, 21
 Jun 2022 10:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220619095324.492678-1-judyhsiao@chromium.org> <165583076931.271995.9857794745310978104.b4-ty@kernel.org>
In-Reply-To: <165583076931.271995.9857794745310978104.b4-ty@kernel.org>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Wed, 22 Jun 2022 01:58:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v66+ZjKFvCfq-H3F_ZdyxiKHY6=7juhSCmHPK3o8kgw+Og@mail.gmail.com>
Message-ID: <CAGb2v66+ZjKFvCfq-H3F_ZdyxiKHY6=7juhSCmHPK3o8kgw+Og@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 0/3] ASoC: rockchip: i2s: switch BCLK to GPIO
To:     Mark Brown <broonie@kernel.org>
Cc:     judyhsiao@chromium.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>, wenst@chromium.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        briannorris@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jun 22, 2022 at 1:00 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Sun, 19 Jun 2022 09:53:21 +0000, Judy Hsiao wrote:
> > The patches series is to fix the unexpected large DC output
> > voltage of Max98357a that burns the speakers on the rockchip
> > platform when BCLK and SD_MODE are ON but LRCLK is OFF.
> >
> > Changes Since V4:
> >     -- Fix indentation in the driver. (Align parameters with the parenthesis
> >        placement.)
> >     -- Fix incorrect return type of rockchip_snd_rxctrl.
> > Changes Since V3:
> >     -- Fix indentation in the documentation.
> >     -- Put pinctrl-1 right after pinctrl-0 in dtsi.
> >     -- Fix indentation in the driver.
> >     -- Remove unnecessary dev_dbg() in the driver.
> > Changes Since V2:
> >     -- Add documents of i2s pinctrl-names.
> >     -- Fix dtsi syntax error.
> >     -- Include the dtsi change and the driver change in the same series.
> >     -- Ensure that driver gets both bclk_on and bclk_off states before using them.
> >
> > [...]
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [1/3] ASoC: rockchip: i2s: switch BCLK to GPIO
>       commit: 44f362c2cc6dd0c5e3cb499c4fb4ed45b63a6196

Seems you applied v1 instead of v4?

Either way, this causes the driver to crash for any I2S node that doesn't
have pinctrl properties set. Notably, the I2S controller that sends audio
to the HDMI controller will never have pinctrl properties, since the
connection is internal.


ChenYu


> [3/3] ASoC: dt-bindings: rockchip: Document pinctrl-names for i2s
>       (no commit info)
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
