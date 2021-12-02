Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCAE7466135
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 11:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356749AbhLBKMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 05:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237551AbhLBKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 05:12:40 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E339EC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 02:09:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id o14so19888577plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 02:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eUknh67dSM1BU/4u3ziS1dMgG4inj8/UBL++Q0CdK0k=;
        b=JqjTi5ACFyAGtR5GwQ/as9YkGNVJxFp6QpANCaDVUIZItvGC1scRaywJAzEin3vVfF
         zE9YkXFa3cn0Qft1lKu5eIziw6kYiy+guMWK75vCQ4cXbSURffIbHSm/7ZelBNzzlTsV
         wPDRn9adGioMKYtexSqBfZeCQAL5ceOuR04wI4buuCcRWLUa/A5TcZ/MVZU/6CdVrnR/
         y+wv/edG7Gc28gN3beXJYThzmJv50qgn9yYivYms89fuhTWgzJBSAli4iWqYp/djBqUT
         TpPFaGKYmdxYDzrYHg4P6hYsgO+7vPA/D+jXQu51kvmGmMTy/Rk/eRFuGsWir5tjFey7
         46Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUknh67dSM1BU/4u3ziS1dMgG4inj8/UBL++Q0CdK0k=;
        b=P1Y3AQ/3eFjT9WQaEXXi/g9rfbcvYO8OalVPSx3tZQnMNAgtXZe3KsqtNHKactpT6D
         SRdlzO5BlqySnT+VZJ8f1BKIv2ms8qvm+WWzrgsPwJ3/caPlERZG8dOymg5f0Gk799zO
         sQFrmW9lPF46Mgq56uDmucptb9oh4hvSIUUG0qKJNNbCqSG34QPLwfqBxwpxId6rXNF5
         cpd+yidkpgKdvMdZec53Cc8QzisBRgmffy6wxR8Tlk2jPP/9MYAM7TMnA+qY5k70BXcm
         kiLQs+9qErK1KLuLkdwveHsMTFQCDLAt/CXpXZFyu1CZ2m6qZ/KizQymsEmjKkf78jtO
         xmug==
X-Gm-Message-State: AOAM530HaodPASaBHJB3R0v4155BSOQz4kL1eAW1EEoORtXnD/G+xan6
        ySchLrFXWlc/WiUfC5C9V8siIBnnsxnfLxQquYY=
X-Google-Smtp-Source: ABdhPJwxjkDP4hocpChUXb5An6oY60u1hySOxTXanF169akmDX2uMycWG8IUjgsATXS7JN/3A6uTpBTeFI2IQceubVQ=
X-Received: by 2002:a17:90a:c78f:: with SMTP id gn15mr4873923pjb.54.1638439757336;
 Thu, 02 Dec 2021 02:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20211130132912.131985-1-zhou1615@umn.edu>
In-Reply-To: <20211130132912.131985-1-zhou1615@umn.edu>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 2 Dec 2021 11:09:06 +0100
Message-ID: <CAMeQTsYZuqqOGjernWKY=GL28DuW=0wXDbGsvaiuv+53CA36vg@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500/psb_intel_lvds: Fix a wild pointer dereference
 in psb_intel_lvds_get_modes()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alan Cox <alan@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 2:30 PM Zhou Qingyang <zhou1615@umn.edu> wrote:
>
> In psb_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode and used in drm_mode_probed_add().
> drm_mode_probed_add() passes mode->head to list_add_tail().
> list_add_tail() will further call __list_add() and there is a
> dereference of mode->head in __list_add(), which could lead to a wild
> pointer dereference on failure of drm_mode_duplicate().
>
> Fix this bug by adding a check of mode.
>
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
>
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
>
> Builds with CONFIG_DRM_GMA500=m show no new warnings,
> and our static analyzer no longer warns about this code.
>
> Fixes: 89c78134cc54 ("gma500: Add Poulsbo support")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>  drivers/gpu/drm/gma500/psb_intel_lvds.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
> index ac97e0d3c7dd..da928189be91 100644
> --- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
> +++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
> @@ -505,6 +505,9 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
>         if (mode_dev->panel_fixed_mode != NULL) {
>                 struct drm_display_mode *mode =
>                     drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
> +               if (!mode)
> +                       return -ENOMEM;
> +

Hi, Zhou.

psb_intel_lvds_get_modes() implements .get_modes in struct
drm_connector_helper_funcs. It should return the number of added modes
and not an error code.

-Patrik

>                 drm_mode_probed_add(connector, mode);
>                 return 1;
>         }
> --
> 2.25.1
>
