Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FB544AEC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbiFILra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiFILrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:47:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90736E3DF5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:45:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i29so20817140lfp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3ypSb+XDrbeyHXO4y2Np7U53zPPEdC7B+zbSpknR0k=;
        b=OY/i7kxud0oo+BFCt+TUyi9H+g3C5k5yrf+GXzEjHjPnjtkGEK4seV9DkRk020ZUWz
         WKIH+f9T+Afyh0yOus92Sk0vZdrYShJ4ANs3mHE/+w0RKzy/cpBxO+5vSXpcs/6I/W1F
         VgAz/3Vc0Nn9QjNv2tmAAZMKO/Zx0Ief1thCMpUMys0hnSluwTEWS9QWq5+xu+Xs3xCj
         KJI2vfV/hzfKhedkmNIIP79nVy65JYBECsLTbLv14046cdq+juG+NEFNr00i7eve/JuS
         L/L653ZLeJUs2U8MFmzrO0Dn6Jw5uA4RYssB8Qz6MWalyz5dsMEsbsKnbJjRN9KmbwEF
         YCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3ypSb+XDrbeyHXO4y2Np7U53zPPEdC7B+zbSpknR0k=;
        b=gfnY4SsaPuVlBkLuGoveTqaKBErthWM8MVZGiktl7euJoR90GmSr4pHDvQrlCo70ws
         5atfkbVcK2isVU8CQet0ceUVlIvPJruxn/ycBKIYzPoUI0UJRjfWww3WxGjqe3gDBNJq
         E5z7nakO+8CvA70HpCgS0g/1XZixIhC7FzlhlmMD3vY+9vofJVidOibx1gZhkqDQYUv2
         8+cPVcm6GGbNnbDLW9ax1Nct5VByh9IxW/aMBPDtaj1NU3HkrB11UrmycaWkC8dzLDla
         vEIqR8ldED9+CzSJGFdlt+HmWc+fypuvL6t2ZOiufShjSf/7tefCSy8y+quWkJW0LAWL
         mzzQ==
X-Gm-Message-State: AOAM533k9YNbBKe9ylv5//HvvXnuLs0qz7RHGk/6AoLZPUmm7x007ZZ+
        Ja0WXn2YgNT3jBxGPZST+7ywH58oPPyi8D9RSAN1zw==
X-Google-Smtp-Source: ABdhPJyH77X7NZCKlUAkh1b8rGns+ZTVzL2JJqtqHXE5Z9Yu2vwepFP1JhFxEiQXE3Fhj1dWwk3q+ErEVVRC0NDjZtA=
X-Received: by 2002:a05:6512:303:b0:479:1baf:7e5b with SMTP id
 t3-20020a056512030300b004791baf7e5bmr19877546lfp.184.1654775136919; Thu, 09
 Jun 2022 04:45:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220601070707.3946847-1-saravanak@google.com> <20220601070707.3946847-2-saravanak@google.com>
In-Reply-To: <20220601070707.3946847-2-saravanak@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Jun 2022 13:44:59 +0200
Message-ID: <CAPDyKFpZTmt71LgQ9vNE4_iRff-OBkDWkHrc7y9zQ7o_Z_UYFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] PM: domains: Delete usage of driver_deferred_probe_check_state()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 at 09:07, Saravana Kannan <saravanak@google.com> wrote:
>
> Now that fw_devlink=on by default and fw_devlink supports
> "power-domains" property, the execution will never get to the point
> where driver_deferred_probe_check_state() is called before the supplier
> has probed successfully or before deferred probe timeout has expired.
>
> So, delete the call and replace it with -ENODEV.

With fw_devlink=on by default - does that mean that the parameter
can't be changed?

Or perhaps the point is that we don't want to go back, but rather drop
the fw_devlink parameter altogether when moving forward?

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Just a minor nitpick below. Nevertheless, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 739e52cd4aba..3e86772d5fac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2730,7 +2730,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                 mutex_unlock(&gpd_list_lock);
>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>                         __func__, PTR_ERR(pd));
> -               return driver_deferred_probe_check_state(base_dev);

Adding a brief comment about why -EPROBE_DEFER doesn't make sense
here, would be nice.

> +               return -ENODEV;
>         }
>
>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
> --
> 2.36.1.255.ge46751e96f-goog
>

Kind regards
Uffe
