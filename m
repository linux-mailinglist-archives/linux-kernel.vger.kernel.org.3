Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4634D323F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbiCIP5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiCIP5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:57:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10D13C255
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:56:16 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qx21so5978593ejb.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6rzSBg+hycjyAg3vNgFOkzB2r7Wku4uLvqN81LLhjM=;
        b=oAhEDWHOR+wZdZZD6U5/mkxMVidolVS6sz1LQJ3eelAui4Co0GyuNOPxYNkA+mrbNi
         4eBicluFjI+EU0X1bYrUfywV5/WayNK9POkQeKQnRjA202XeqSF8jw2yYZqXmbKj6sEJ
         38dJhL/a1cmVFwkEbTy06O8qVbW7kuymRt9oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6rzSBg+hycjyAg3vNgFOkzB2r7Wku4uLvqN81LLhjM=;
        b=UPcU4K5PSI1qorsfbbUQemFeyw5UsCk1xW8JFSTkPeP09VPtkrTbqq7EMGo5c7djLF
         f4nnIDEZTT5anNuym2CI8ZqOqz/VRtMHPxHqn4dg14zPey5ygbUSFWwvU1ACQOnNyeQo
         q78BKp1sXDBnkp+hJCI6EOh3BOfk1e/a3VtIeNSUfdreDRbv4Easf9xNbb5a1zLi3mTj
         BUHa0UZS4s/obO2lvUX9dNi6y3dKTY4Pwhy0maP+u3tIs338Qshn0arAs8TfJoysATVr
         kXlbytA3peosZ6oTC0nCg8aRH9twJ6qWpHHnL5qYCFzr8ULYs3bMyqrZcIGs6+IhEql+
         vwKg==
X-Gm-Message-State: AOAM532JixvzNm2Di2UgxrLfUqqotnV8WCExxHfaiKvT1K8uQaCm4Sp5
        AVP5wVJ/ghQ6vOm6Upk0CkNRgPkLOMxZVPcT
X-Google-Smtp-Source: ABdhPJy2J9jIqO//fCGWWqMHJK8cx40nf9DHB78ORKm8eqzX3J4LMHbe6oWyjGcDvQAYqPEykZYoZQ==
X-Received: by 2002:a17:907:6e1b:b0:6db:30f5:980c with SMTP id sd27-20020a1709076e1b00b006db30f5980cmr348196ejc.359.1646841375178;
        Wed, 09 Mar 2022 07:56:15 -0800 (PST)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id gz20-20020a170907a05400b006d91b214235sm871550ejc.185.2022.03.09.07.56.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 07:56:14 -0800 (PST)
Received: by mail-wr1-f51.google.com with SMTP id p9so3712308wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 07:56:14 -0800 (PST)
X-Received: by 2002:a5d:5257:0:b0:1f0:1822:69ad with SMTP id
 k23-20020a5d5257000000b001f0182269admr229452wrc.342.1646841373661; Wed, 09
 Mar 2022 07:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
In-Reply-To: <20220308110615.1.I1f1b10daf7361feb6705f789deb680b8d7720de9@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 9 Mar 2022 07:56:01 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V4oicW6ZVVyE3sNYxAdaEiGdjAZC77o-wjn3=fmfL6eg@mail.gmail.com>
Message-ID: <CAD=FV=V4oicW6ZVVyE3sNYxAdaEiGdjAZC77o-wjn3=fmfL6eg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/bridge: Add MAINTAINERS entry for DRM drivers for
 bridge chip bindings
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 8, 2022 at 11:07 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The bindings for bridge chips should also get the same maintainers
> entry so the right people get notified about bindings changes.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

There didn't seem to be a reason to wait, so I pushed all 3 to
drm-misc-next w/ collected tags

46db48f25ed1 drm/bridge: Add myself as a reviewer for the Parade
PS8640 bridge chip
59c217b3dde5 drm/bridge: Add myself as a reviewer for the TI SN65DSI86
bridge chip
73a46da4fa7c drm/bridge: Add MAINTAINERS entry for DRM drivers for
bridge chip bindings

-Doug
