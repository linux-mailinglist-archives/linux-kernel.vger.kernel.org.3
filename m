Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC7524FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355236AbiELOWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355263AbiELOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:22:40 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CB22440A
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:22:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t25so9363631lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=rPnOfJw0T6UU7cqpzZ+d/TG5zakVBK0RQfAjuTld5dc=;
        b=YZXHaZtN+wM0fntocGWGb1b1EH/wlmqNG9zz7r6nNiH2kTuGiEqXe/N32kDJ2Zo/BJ
         mnz3wtKsE8mQPjpUSr2RnYxmu8H6W0hhfgVhFMs5gM4gGOTN7N9E06ILVUV1fAMC6Q3x
         ch01vrumcL3PpLSBYwrsw/vXASJ/qbK2lGf8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=rPnOfJw0T6UU7cqpzZ+d/TG5zakVBK0RQfAjuTld5dc=;
        b=qWxo4EJO3Vf6seUpwkhz/2CtlVUsh/kCzGrxtYRX0NI+AgVc/MbpvQ+Jqbg2vBVeGn
         QJQJlhtBF7+HnT+wQ6t2bUjUb6/3Rwr18qPtjTOFdhT94NFl/6Ub7qpwLbGygg0xRuNn
         xwq/7aEltLF65ABTvPcdpmT4M4NBA4a1ZsImViabwSZ6L5KnhLms1G0AH/1KDLBcotGi
         VYIlll5damjp9Lbjrn0iMKj5eyKn+Ss2h88ZZxYfz1HSLGp/dDyZBAniNZG6xFJRADpw
         VDw6BBZ9fCTgcHHGnahUUYJsRpaJqZZ9sXicri2Vm80pW0JqALBNo5VSBz3dj4LQ8FJc
         GWDg==
X-Gm-Message-State: AOAM531FieEe9qaBkq8Uany6Ng1I5NiPjBeUjdGS8XBzEWZ8efZnCfix
        kP2aDTO4cUaEHC5s/w5LB4n69iYcQG+QewdexUklUQ==
X-Received: by 2002:a05:6512:e87:b0:44a:5117:2b2b with SMTP id
 bi7-20020a0565120e8700b0044a51172b2bmt9450lfb.275.1652365351715; Thu, 12 May
 2022 07:22:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220510182810.1223574-1-markyacoub@chromium.org>
In-Reply-To: <20220510182810.1223574-1-markyacoub@chromium.org>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Thu, 12 May 2022 10:22:21 -0400
Message-ID: <CAJUqKUptOgOOnReSS7Hb0btRokEP2uovQi9meLc=XExDSBx-4w@mail.gmail.com>
Subject: Re: [PATCH] drm: Add a debug message when getting a prop is missing
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :)

On Tue, May 10, 2022 at 2:28 PM Mark Yacoub <markyacoub@chromium.org> wrote:
>
> [Why]
> If a connector property is attached but
> drm_atomic_connector_get_property doesn't handle a case for it,
> modeteset will crash with a segfault without.
>
> [How]
> Add a debug message indicating that a connector property is not handled
> when user space is trying to read it.
>
> TEST=modetest
>
> Signed-off-by: Mark Yacoub <markyacoub@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index acb1ee93d206..36b0f664dd80 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -884,6 +884,12 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>                 return connector->funcs->atomic_get_property(connector,
>                                 state, property, val);
>         } else {
> +               // LOG that the kernel is missing handling this property as a case here.
> +               drm_dbg_atomic(
> +                       dev,
> +                       "[CONNECTOR:%d:%s] Get Property [PROP:%d:%s] is not handled\n",
> +                       connector->base.id, connector->name, property->base.id,
> +                       property->name);
>                 return -EINVAL;
>         }
>
> --
> 2.36.0.512.ge40c2bad7a-goog
>
