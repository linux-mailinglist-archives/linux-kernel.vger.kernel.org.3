Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F8A4F5D3F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiDFL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiDFL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:58:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A334F885D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:27:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m12-20020a17090b068c00b001cabe30a98dso4986568pjz.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKzm3ts/p6RnszpnwSKsUwR1wyDzLKNmtQRoYiUd/Hk=;
        b=OMyV3E+AUaGadK52HWRLwkBXPhxNoHdBTufKc2Zw5jOXf1FfHJ7YSdn9KDcAfcO3L4
         KPyMtDrvp9R/V/E9HpxKDmQkvcbtxHwLz6/eEupW86fjupzGHc6nwHPVU4MnRRQp0A+b
         AsQDD2OwDe6ln8Isy5Toheh2tPcF6LJ4iPWL/ZYTZRyhwb+/QWJ4fr3FYwhGYEH+hP2t
         bu1FESE8ZLYGeyMzpkdptkuMf9QS8qBJAq+3gMuKNMF8pEnAWCGr9qFyaysmEztj2Nec
         +PNpclku4O/k4c+/8bw1IihP9xOrI9yceEdXfY7Yr5qTZwKifoLgVTbYGEuYubS/b2hf
         TFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKzm3ts/p6RnszpnwSKsUwR1wyDzLKNmtQRoYiUd/Hk=;
        b=R1yuq/6bnnQRTh9FqDDJ0IOp64y2xjWSGJ0twW1GhgJLGlbPOBPzIGb3xOwP6elI8a
         U9d74tsOGu64kYj0AsFAaYbqRx3yPsCJI9Lnc529xJZOapQP6H0wAdq9IO+SfTJTwj8A
         6qymYi4tbeTkqP+exoZBi8of+HjfD9n7Adf06jFTXiSYdgFe9vIXZaegVTFjqOAgH1DL
         OvaQs2sJeyrOUNkQE9khfjtrghN1boXgyST1ePY5WwjO5DQIdJ9WTFmbRqMIMG9qG/uq
         cveIvnU3UrWmwr6DdnQluxZAbMFf6aOYnjRIIW3xANGeFE8peUXD33F8R3wIjw6Ux3a8
         +ZCA==
X-Gm-Message-State: AOAM533+/7T+3WBS28951mLuMnKIRcBMbNBTbZFAWLQSgojzwdnMny2Z
        UpI6BMWI1EeE+y6NYVDb5L6x3NlU6G+ixornZw8oDLao
X-Google-Smtp-Source: ABdhPJxFRMVQkG3dZ4jB+r4LgFBIFnZkirPkN4hRK9dO72zMJqI8mtPvMiSYiqpivMhRFM13LUEFyvkca8bOcT97nTQ=
X-Received: by 2002:a17:902:7e0d:b0:156:47a4:a7c4 with SMTP id
 b13-20020a1709027e0d00b0015647a4a7c4mr7534354plm.141.1649230050621; Wed, 06
 Apr 2022 00:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220401115811.9656-1-xiam0nd.tong@gmail.com>
In-Reply-To: <20220401115811.9656-1-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 6 Apr 2022 09:27:19 +0200
Message-ID: <CAMeQTsbK+Akk0m3UUCx-U9F6ju_OVM0R6uZN5KB-Gu6C6Do1pw@mail.gmail.com>
Subject: Re: [PATCH] drm/gma500: fix a missing break in psb_driver_load
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 1:58 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. To
> avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> break the loop when the entry is found.
>
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>  drivers/gpu/drm/gma500/psb_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> index 2aff54d505e2..b61a8b0eea38 100644
> --- a/drivers/gpu/drm/gma500/psb_drv.c
> +++ b/drivers/gpu/drm/gma500/psb_drv.c
> @@ -402,6 +402,9 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
>                         ret = gma_backlight_init(dev);
>                         break;
>                 }
> +
> +               if (!ret)
> +                       break;

Hi,
We cannot do it like this either. If the first connector isn't LVDS or
MIPI we would just break out of the iteration because ret is
presumably 0 at start and gma_backlight_init() would never run.

-Patrik

>         }
>         drm_connector_list_iter_end(&conn_iter);
>
> --
> 2.17.1
>
