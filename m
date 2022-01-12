Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8764348C267
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiALKiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238736AbiALKiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:38:22 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353C7C061748
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:38:22 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e3so3759229lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 02:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=my1JYoEiT1gg/0wBQ3AmYSF58BomzlSIMMv9wEH/Wj8=;
        b=LssndgcLu0hMWC6Zaltu/L4Ygbgam74yEK5Mc3g+kkSWR37FnDKmHLpYl6l7eiJGPr
         fX/PBU5TpP5v3h621MkentElJF+hQbAWCoLx6kElctBlyqqhTcJaghbUn9mx1l+zZudm
         GOTTp9bxDhk2nd8NEL1P/nVMnSSisXZLFm72b3TIjgO2KekhR/W8sOQFoOoHEKBgLQcF
         S6RX33TVr0CwBO0iudfHkIaTh5hP6pSiBBjoEj6nQYOnh2bjAkOosWe9zNt+qVGeNdi4
         RErx5IdjaensUOxj37M5rUkhyDl9skppod/kbd933aqHCIULu002QPwIDLRamhuCn1Sc
         cs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=my1JYoEiT1gg/0wBQ3AmYSF58BomzlSIMMv9wEH/Wj8=;
        b=TGX+4Jk3gF5hZLTybJgOgHa3+1MyFQikZW3vn1rbUlM/xMn4ia9IwoUKBpfY1M5B9s
         WZV586XDGPYqB8xmM0cIwHiF5GYBqV9uON4gGwwXqsggRrWTIZcVzhluGZWD+Un5uD7l
         duV5kiUd/YuV1ZQFxq2eAEQBJhGV3Tspj107XotqJjTZPftqXxvf6kcAyo5iTeM9rcCm
         G+FBm2hcBGo72RTErAxVLQDcziWd9diD8Wqin+7ZuG51MQ6sNwXXxOnTug2dFzYuEiy9
         9EBOzxzsQVn6wGULFLCJ9Z+En2k4e8j76zsQPG6Nbaw0mON2CLYucfDQHMJ+dK+ZtXyB
         9ckA==
X-Gm-Message-State: AOAM530cSR3eQFrJzTYEqeEgoQjY8ddqejCzw5Uvm3X8VEPbj9p07gyr
        TxZ2SbfZazWWKnY72iqBdCiYvecnDH8Jg3lNMMM3sj641JSXVWke
X-Google-Smtp-Source: ABdhPJxNLa3Ky4ELrS281ZBj7vXZdGR+ehC76qbhJRH36UFdnXSeLB0v0lqH+5U/BaOdmBopCoSVQvBbkn9Vc8GIY6c=
X-Received: by 2002:a05:6512:400f:: with SMTP id br15mr4970479lfb.233.1641983900527;
 Wed, 12 Jan 2022 02:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20220104060325.3957-1-michael@allwinnertech.com> <20220112093415.wdy3ht5yizw5lffl@houat>
In-Reply-To: <20220112093415.wdy3ht5yizw5lffl@houat>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jan 2022 11:37:44 +0100
Message-ID: <CAPDyKFrD_c36Di66_TCJP3hFFwGHmAgH-DQAPLkJLx-m57VQvw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sunxi-mmc: check ocr_avail on resource request
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Wu <michael@allwinnertech.com>
Cc:     wens@csie.org, samuel@sholland.org, andre.przywara@arm.com,
        jernej.skrabec@gmail.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 10:34, Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Tue, Jan 04, 2022 at 02:03:25PM +0800, Michael Wu wrote:
> > Some platforms have no regulator, discrete power devices are used instead.
>
> Is it really the case? vmmc at least should be mandatory so a platform
> not having a regulator would violate the binding itself.
>
> > However, sunxi_mmc_probe does not catch this exception when regulator is
> > absent in DTS. This leads to sd or eMMC init failure.
>
> This will still happen with your patch though?
>
> > To solve this, a fixed vmmc regulator must be hooked up in DTS, like this:
> > reg_dummy_vmmc: dummy_vmmc {
> >       compatible = "regulator-fixed";
> >       regulator-name = "dummy-vmmc";
> >       regulator-min-microvolt = <3300000>;
> >       regulator-max-microvolt = <3300000>;
> > };
> >
> > mmc0:mmc@4020000 {
> >       compatible = "allwinner,sun50i-a100-emmc";
> >       device_type = "mmc0";
> >       vmmc-supply = <&reg_dummy_vmmc>;
> > }
> >
> > In this patch, we print an error message and abort the probe process if
> > the regulator is not specified in DTS.
>
> I'm fine with the patch itself, but it's really not clear to me what
> situation is being fixed or improved here.
>
> You're first mentioning that this is fixing the driver probing even if a
> regulator is absent, but then states (rightfully) that in such a case we
> should use a fixed regulator. So we should always have a regulator then?
>
> I assume that you want the driver to properly error out instead of going
> on if either a regulator is missing or if its voltages are out of range?
>
> If the former, then we should probably check if host->mmc->supply.vmmc
> returned an error. If the latter, then yes, checking ocr_avail is
> probably fine but we should make it clearer in the error message that
> it's what it's about.

Just wanted to mention that I just had a very similar discussion
around another patch [1]. Please have a look at that discussion to get
my opinion on this.

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/20211215130711.111186-4-gsomlo@gmail.com/
