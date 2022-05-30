Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7D5382A9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 16:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbiE3O0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 10:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241388AbiE3ORd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 10:17:33 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FE58FF8A
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:46:00 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b200so11256261qkc.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 06:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8tubySlO9EL1sX7JJbgIYlj3V7gJSLQUkL2tqjiHPYE=;
        b=qGFcst+H2sU9jethczFKj5MxMnXaCOn7OK090+/w4SslVfP0RhOPM+PrM/s6zmntEl
         F0i0jWuXjup30AM1FCFtkmrQsYf603Ww0X7DlWH4G1X8DXidwxDvsLuIyOSA46WT96pb
         gk/ByJ8wJJ6VG89vBxpWS4sT4viGby0Q7/aGVZjueV2Ol45MU6QR/kGUMziF9kEKL5jr
         Vq5IvoXl5vRQyKgPRCK8sxmINhmRSQBk+B7MLNnt8CZ+4eyNendacm1T2oVMcG8QIJLi
         JWs9iipRsPWjnyyw+uAEIr8g/Vhe0bmPXgyg2Sg9dqgZeemBHQFV9hvvB+/wubuuBXQ7
         z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8tubySlO9EL1sX7JJbgIYlj3V7gJSLQUkL2tqjiHPYE=;
        b=wWOLChQuxbRgPwtfmJ5M+Pbm4qOkykKhMDXrAtz8olav73IW4SXMhODRz5AvJNLBiU
         NOBUrhnEPARp6FzUzQ1HT6eh1b5kka4IX1ZjyNIkRBGUq5kXcFT/ipf+psUwl+XqFyW2
         5dRYwiRJg9h0/ORrRSeN4LSP3vjXLsf0bGsdxifG5d/YTPn0aCt9DQdEvyeWZK+egLHV
         5zT0FIEoE6COD8bLwz7ytBJl+Y76BV/88a/cpcy2OV6XB29hgankmr1rHvCgqfk9J/z4
         llG+5YjthP+7vYZ+GguHdtkYppdZpzxGZTEN7NETGNZD3unKv6OvxkqOUAj3Ia074vtU
         1+pA==
X-Gm-Message-State: AOAM5337u7akCBwRzpfMiXqM3+gbrmN1Ny/diTj0YN7k0u/hVR3U9R4P
        1ZzwNO5D5XHkL225JNFNFP+1KpsCV/yOChj8iVs=
X-Google-Smtp-Source: ABdhPJw9o/+WDde4Jga387TqM8IY0EJdHUkX7NWLrzCofs5w6vulQVu5Xs2CiFpqzcOEIKw7lNGA0rRWaL1NB5GNp1o=
X-Received: by 2002:a05:620a:40d1:b0:6a5:b4a3:dfbe with SMTP id
 g17-20020a05620a40d100b006a5b4a3dfbemr14550181qko.340.1653918359158; Mon, 30
 May 2022 06:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220525115445.93500-1-roman.o.stratiienko@globallogic.com> <20220530132232.himfp7ubiacbmkpx@penduick>
In-Reply-To: <20220530132232.himfp7ubiacbmkpx@penduick>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Mon, 30 May 2022 16:45:48 +0300
Message-ID: <CAGphcdnPnFeafky=8-vyd_wKgbuTJc+MOb9UsM_0P-hVL_oiMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Fix blend route/enable register corruption for DE2.0/DE3.0
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz,
        Roman Stratiienko <roman.o.stratiienko@globallogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

=D0=BF=D0=BD, 30 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 16:22, Maxime Ripar=
d <maxime@cerno.tech>:
>
> Hi Roman,
>
> On Wed, May 25, 2022 at 11:54:45AM +0000, Roman Stratiienko wrote:
> > By this commit 2 related issues are solved:
> >
> >   Issue #1. Corruption in blend route/enable register:
> >
> > Register corruption happens after using old_state->zpos to disable laye=
r
> > state. Blend route/enable registers are shared with other layers
> > and other layers may have already assigned this PIPE to valid value.
> >
> > Solution: Do not use old_state->zpos to disable the plane pipe in
> > blend registers.
> >
> >   Issue #2. Remove disabled layer from blend route/enable registers:
> >
> > Since sun4i/drm are using normalized_zpos, .atomic_update() will setup
> > blend route/enable pipes starting from PIPE0 to PIPEX, where X+1 is a
> > number of layers used by the CRTC in this frame.
> >
> > Remaining pipes (PIPE[X+1] - PIPE[MAX]) can have old data that MUST be
> > updated.
> >
> > new_state->normalized_zpos can't be used, since drm helpers won't updat=
e
> > it for disabled planes.
> >
> > Solution:
> >
> > 1. Track the number of total used planes for crtc.
> > 2. Use this number instead of zpos to disable unused blend pipes.
> >
> > Signed-off-by: Roman Stratiienko <roman.o.stratiienko@globallogic.com>
>
> If there's two issues, and two solutions, it should be two patches.

I would say.. It's a single complex issue.
Solving one part without solving another will make things only worse.

>
> Maxime
