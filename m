Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE2F528836
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245063AbiEPPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245056AbiEPPLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:11:12 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026DA8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:11:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t25so26360504lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=ThtkhJjqmQfv2SviiAcmC8uKNvCTv+1Qfs3YExwXtrM=;
        b=AjpSNO+RwZkxk9UOYfbwCpYPaJePlh7oHjbLSRFeUi0zmB2xOIMXi5ZBJr625RCOqW
         RrV6ZMvjzumxfNzEYF65DfpGotjDd8oumRdmgUF4U0J6XGJDF7nl3AeCsxY67vKsk1v1
         Msru0Wty4qi5jhQCtr68vZDSjdPBoa0gPTL/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=ThtkhJjqmQfv2SviiAcmC8uKNvCTv+1Qfs3YExwXtrM=;
        b=kqhgv/1pJhoN6K5ngBaReHiNTjkkOO+NkVPaXqGVSDcCIE+DMUiSFvzPC/L9UoZzqL
         rsQjjqMO/i/x98SQmdE6842LRm3vlWmT77FHfSjhnsRZW6+DtVtLtamidQnDayJ8XUCy
         1GL29pMWZ/BUDOjWlELxITAXHSsm8+W8rV3JMVI7DW6ZjCUYIvQxAEyulfOMopue1KeW
         w/ryJWxbOc+R/oVyRw7rLZAEi3hJeN7m9qDSVwRfnU77G9mjHRP/EeLo0J/8YjrHktn4
         MH/mqmBNpLWy+BB0adAghyed81nY7BWRmmJb24GIFMYQVyxCF069k3kzbMbJb/Mh7gwX
         XQoA==
X-Gm-Message-State: AOAM533JO7ar4iSxxm266JL2rFXVgR6993OgFK8PR1b/HZcYSUEtYdVZ
        GhyASPtWr/uEPjwnfa9nY3DRExQTRVuFp/W3Kf9eOQ==
X-Received: by 2002:ac2:4475:0:b0:473:f03c:a041 with SMTP id
 y21-20020ac24475000000b00473f03ca041mt3948439lfl.192.1652713868087; Mon, 16
 May 2022 08:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220510182810.1223574-1-markyacoub@chromium.org>
In-Reply-To: <20220510182810.1223574-1-markyacoub@chromium.org>
From:   Mark Yacoub <markyacoub@chromium.org>
Date:   Mon, 16 May 2022 11:10:57 -0400
Message-ID: <CAJUqKUp2OGxexZDncNZu9NAsScWtFaZqGKzBt8yf0JFzSLvaWA@mail.gmail.com>
Subject: Re: [PATCH] drm: Add a debug message when getting a prop is missing
Cc:     seanpaul@chromium.org, markyacoub@google.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :))

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
