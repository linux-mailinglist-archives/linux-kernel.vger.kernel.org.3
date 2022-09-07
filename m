Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C15B0810
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiIGPJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbiIGPJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:09:11 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58D4B5E46
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:09:08 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id nc14so31054623ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=q+70v53buIxQaWBchIFk8shCKU1WJV1DdLwWTP+ddeI=;
        b=PsSk7c5ChVk3DJTul0PslXYL3Ii3rxu7S+9k3ZdWO7J5+Rg3SJKW/GHR+l1IdCcqbD
         QzOSg+X20xKhDWwzVNp1EVZBeuM2og/eiCkM9VRatVBVuKtFUtC1IFd6TnphWbjqABrV
         lPI8ekc2MCGq7SaNBqXRHV/YntEXs/I2px8KM7Uiih87ZHZU+6OWWEzoS4qPY0Dysev9
         Kf1PW1ximX/Nir+q+GFzRH9fkY+Yz9NccxBJ97dIkXFYKX6Fbwdx2rSEm5fgP9TwN8TP
         Yn0/K6m8BPkKDGCZQYLjYFkzq7AqD2/EwCvermdk+S+d7m7gCF9XDJd4z+oxXRFK59CM
         CsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q+70v53buIxQaWBchIFk8shCKU1WJV1DdLwWTP+ddeI=;
        b=fZ0lxTmUIW64ibDkzlcOBIZAqv3m9PFbAbinoYetZ7867sb2Jl8ZrfhVByfql3kRp1
         0OfCO3h/2mMnnCO42Ggn3JH5Z83IOv0dZ2Lk0UPLGJd4rRwJO1pRyfBHJbVTylB2MR1X
         hIEHNl+pLvz60NPdXZEkuisqwYT0aIDZ9f7xo8YfJAg6O/D8vmA1+i54zSdkifkNYI3x
         wuTo5BYU7xvXgWePbcwsX1ZuvcKhl2S/nuHapbKV0gidKhaiD5jgn7KYsXFq343x0zzI
         5prUYJZHsiUcPFSn1UdAWmMs7xY4iZrvm0Jq1zDP0TgAPmenRo6pnXZxn/hizh+79z7a
         +3BA==
X-Gm-Message-State: ACgBeo2P7PAd5exQ7v51mAoG/MZ1FY/3va5M6WydAq4O77xROR+UJDv8
        hxyI+00csRJ3vMWmvVP3Tf0=
X-Google-Smtp-Source: AA6agR7+yo4NVJ1b3xBSrgRyiVKs02kmJQtjtA3mve9GOkmdtQU6KrWKBuLTC8Uj3eslmjookwi2Eg==
X-Received: by 2002:a17:907:7d8e:b0:742:8ea0:686c with SMTP id oz14-20020a1709077d8e00b007428ea0686cmr2603244ejc.591.1662563347199;
        Wed, 07 Sep 2022 08:09:07 -0700 (PDT)
Received: from kista.localnet (82-149-1-172.dynamic.telemach.net. [82.149.1.172])
        by smtp.gmail.com with ESMTPSA id p23-20020a056402501700b0043ba7df7a42sm10858179eda.26.2022.09.07.08.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:09:06 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH v2 36/41] drm/sun4i: tv: Merge mode_set into atomic_enable
Date:   Wed, 07 Sep 2022 17:09:04 +0200
Message-ID: <4210281.ejJDZkT8p0@kista>
In-Reply-To: <20220907074134.36yysxrnnpty4ngw@houat>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech> <10138422.nUPlyArG6x@kista> <20220907074134.36yysxrnnpty4ngw@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 07. september 2022 ob 09:41:34 CEST je Maxime Ripard napisal(a):
> On Tue, Sep 06, 2022 at 10:04:32PM +0200, Jernej =C5=A0krabec wrote:
> > Dne ponedeljek, 29. avgust 2022 ob 15:11:50 CEST je Maxime Ripard=20
napisal(a):
> > > Our mode_set implementation can be merged into our atomic_enable
> > > implementation to simplify things, so let's do this.
> >=20
> > Are you sure this is a good thing in long term? What if user wants to
> > change mode? Unlikely, but why not.
>=20
> It doesn't change anything feature-wise: whenever the mode is changed on
> the CRTC, the encoder is going to be disabled and enabled.
>=20
> It's disabled here:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic=
_he
> lper.c#L1064
>=20
> And enabled here:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_atomic=
_he
> lper.c#L1403
>=20
> With drm_atomic_crtc_needs_modeset() being defined here:
> https://elixir.bootlin.com/linux/latest/source/include/drm/drm_atomic.h#L=
104
> 9

Right.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


