Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1524C8C3B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbiCANFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiCANF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:05:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAD19ADA5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:04:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s11so3790530pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=Xc9NL1d+//BooJG2pml3jrtqXm6+Y0L6ReYIipFBYiAymzfd3Ro0UqCIsGGv7pzmzs
         xmfs7tpUkyH4huXwN7+tUwnFGMU01DX1figlNAeGeLriBYIUcG66wEYEA0KsonhyYqZ8
         bHQBGhQrQpOg6xou2P8/xGjovxtgl+Xaqbxc+YWjthRy5q584R+01bTRHZkGvaKMfrkm
         1LdB2u7uyU0teOYEp3os+zMzGQbKRoOJsCGejqjuF06p8wNAxQGgCgeU7rfE2x2/p+6l
         LPMD2gm3iABuMy6uDufsjPLtW6V6kjYojC9fWN8kKLk2/O79llXkR2U4BBPdeSWdx6Hq
         F/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bBkJiLuPHjOc9NWEYiRCYWyb3Lk5w/JeF/xlR5gs4hs=;
        b=Wekq+JILrazzXmWTZuNx/C/Dk08jHETc2nZJdxqfVe8fmgvickT8VICm8oQuBixXda
         Me58xgoQS7O5vJ2xAHk9KBXJQLbCGV5uIrbXokqJCWxPequKp4K66bo9FJ+9NUHQTMsG
         sSxIsF0AKgvNSGiLvTvfbVay0ZiA1Q8nelJ6BGBpmTbiTxiz/9YjCA5DZM9W1T0gFCtC
         i6wtvsioPNhJ7lNyq7MZaXCcnmmn+0Ptj74IfYHj3JnEWA8uMDhrN/j7DPhMc9StPTZ8
         JjPP5nssgvCmXEeSo9qAycSmoKMfOmQDzizM8LDh0RCEx3Da/42upGA8jPCzP/4SZ01O
         9VLA==
X-Gm-Message-State: AOAM530yjoueTt+MQSJD/Koh9EW4RHxCzlGI4GxPpjgHn4pCsYd18y3A
        lNQskZBT7e8w5CvUteQ/k3JQTHL5Y3GtSX1pKtk4tw==
X-Google-Smtp-Source: ABdhPJxTmBed6kFC71ml0AX/2OYElQqn2M8Fyn2ERareq2KhsmTlJ76U//wIcIqT2V7P9FR+3qat6BDCYU/HtN0UeOI=
X-Received: by 2002:a05:6a00:889:b0:4e0:dcc3:5e06 with SMTP id
 q9-20020a056a00088900b004e0dcc35e06mr27213845pfj.29.1646139887560; Tue, 01
 Mar 2022 05:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20220221074224.12920-1-jose.exposito89@gmail.com> <20220221085643.b7klu7heomv6rubv@houat>
In-Reply-To: <20220221085643.b7klu7heomv6rubv@houat>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 1 Mar 2022 14:04:36 +0100
Message-ID: <CAG3jFysW1jFPr7v0=tNANRoMKrqy6dkWBmp7Y=-eEsyKeCNkbA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: chipone-icn6211: switch to devm_drm_of_get_bridge
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        jagan@amarulasolutions.com, andrzej.hajda@intel.com,
        narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, lgirdwood@gmail.com, broonie@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied to drm-misc-next.
