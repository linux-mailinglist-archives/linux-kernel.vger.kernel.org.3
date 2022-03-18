Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6024DDDB3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbiCRQHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238561AbiCRQHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:07:21 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAAA2F512D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:05:24 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ja24so12505445ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng3Zfgvd5FVkTd0Uh5IRUD76rsMejGN3gWOznRlV1AU=;
        b=eMQlO+mrb9A2jfxLMXqk9N4cwzcfjYk9PgwRUQPbbWq8PrJcsRqiioCuc/lcGeT/Rb
         di3UfDN3w9jX5W2eU19SQU/huMP6WAWIldLoFr6nCEtXMIIx6uKZMqKk2oaf2RSUCvef
         jua3dvYZYcgdw1vgb3AKiQzvF/r6V5cTNVonE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng3Zfgvd5FVkTd0Uh5IRUD76rsMejGN3gWOznRlV1AU=;
        b=5dGLXJXIAZxd1h1vl1DJms7u5uU3YvlmtuWE+GYs0+z2kYBojIGtfm0RK4uPErysq6
         Vfu2779C3+gZ5ve9a41jVaGplCnHgxr1pHBjQrN9Bi/iHJumbDPJ773S8oA1beIiPbV0
         E2z/IRIlEDIrdvm3yVAuoLckC9zjAmMEdyogRbSn/gHEOUR04qoRE29NEjOqS7q0VwBG
         aYBiLKxuiTzDVSwNsvot3qd5YxBJOPvbOz5IsS2GI9Bn9lJ6UqokSG0SIEcOSx4GMtkC
         wAB6NJvKgj6ubeUTTTB91ounnVn87HlNeycZyaOatUMXXeGiXX3ZcBRK6EoCCuIAdug7
         f0Fw==
X-Gm-Message-State: AOAM531xUfjmFe2Z1bAfNjFajLQxINEkyGE7Zb68k4uUrnGwouyDauEA
        O8lmxy0fUAefFuuQ9fUJut9aixAD+Ixua5g1xtxpJA==
X-Google-Smtp-Source: ABdhPJxE4LldAUD+bZTnDyWv9PpK8dKAkCwuerF34kj2CvGwv8y9h0bYTsBnCSE7kym6Ww2DP2jqRKvPNKBCYl4dqWU=
X-Received: by 2002:a17:907:60cf:b0:6df:a8e8:3597 with SMTP id
 hv15-20020a17090760cf00b006dfa8e83597mr5578067ejc.111.1647619522963; Fri, 18
 Mar 2022 09:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220309143200.111292-1-paul.kocialkowski@bootlin.com>
In-Reply-To: <20220309143200.111292-1-paul.kocialkowski@bootlin.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Fri, 18 Mar 2022 21:35:11 +0530
Message-ID: <CAMty3ZAZKHTqfR=ecRgpzJtVefhFFrSpcEqueSQ6K-=Q75XU4w@mail.gmail.com>
Subject: Re: [PATCH] drm: of: Properly try all possible cases for bridge/panel detection
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>
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

Hi Paul,

On Wed, Mar 9, 2022 at 8:02 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> While bridge/panel detection was initially relying on the usual
> port/ports-based of graph detection, it was recently changed to
> perform the lookup on any child node that is not port/ports
> instead when such a node is available, with no fallback on the
> usual way.
>
> This results in breaking detection when a child node is present
> but does not contain any panel or bridge node, even when the
> usual port/ports-based of graph is there.

Can you add that pipeline example on the commit message, it gives more
information on specific use cases why the existing code breaks.

Thanks,
Jagan.
