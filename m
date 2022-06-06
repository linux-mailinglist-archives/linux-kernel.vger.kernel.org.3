Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BEE53E983
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiFFOUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239793AbiFFOUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:20:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D43D7733
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:20:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so29211554ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+zeR4exPLerrOWbFqJdvC1kGSPV0cQ3LiC/P/8HiMc8=;
        b=PonbL/t/3A7d5fxWp714fQaE0asV5scUDmSWkPDH/8ppJ3ACkjD7EQxVjGPRTczbAV
         +ZhuqpjDO9slqOB13l23ZRAGbkF7eFZeKZm7Cu+8FA5rhbqpcoQ+NVZTycnhk3HUoB9F
         jmHkHnS82cP/zG/7a9T1ujSZRRldb5j5Kvc91nEc49qIKGZu5hFv7znxKPK8Xd+Ex8fg
         kDTOkJT1V8c7b91pZjT2ER8nRbYddJvXY7rqbHYtkepKifmL3A/zeDvO0eXoF23oCIUx
         MeD2T/s68EQSuRUjvGt5kc9ECHPodgpZAF470X92i6sC3hSVrYjROw4y0r/c65V2F5JG
         Tc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+zeR4exPLerrOWbFqJdvC1kGSPV0cQ3LiC/P/8HiMc8=;
        b=qaEiHPcocXLsw8c0qs58ZE5c8ENcE75L886ceAwYWDmFB8mVlIyMhpxHOat/UkQVJF
         4lG0HZ7fg+T2EmVtpEmXE/ET8BKIYJWHcIYAdkhwW+c6OY/cFKl8h6ZkYKQogRV/34fL
         BjzdpYkObW4FWz2UIk5IkOrRJxNDO6d2m54iYVQH0GxY1FRSFSIiG9oGGwmPbB6rFDpi
         AWuaQ8iW+OaP1tjxNEkBg7VW4ZSyel1IodVwT1ZS88TFNLEHTQOrHj30skwRQmqhFf76
         /6lu3qAzEQLQtmixYiqpjtzpaLXTaOiBOhZIUL4W8zLqWKpjE3okxA72azTJnK1uAOy2
         n78g==
X-Gm-Message-State: AOAM530CIL2aOylWqteleo8Q8VosimnwaSWt40y/wcmlb/cwP2Tt0dXg
        b2rDzgYg+suoJdAKcx79xtTjltR8LhrJzj/DI51YSw==
X-Google-Smtp-Source: ABdhPJxDecYJ9aEv69zBvu7MNAmQYz5Y28J8OShJ+zypoo94WzMWVcetkjW5fUL/4qVdb/vHqRg5X8tnlC42fQjH8DA=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr21651391ejc.631.1654525202555; Mon, 06
 Jun 2022 07:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220606095516.938934-1-jose.exposito89@gmail.com>
 <20220606095516.938934-2-jose.exposito89@gmail.com> <20220606134242.h6kuqn4zbpmc2rql@houat>
 <576ed6ef-b961-9214-2c9b-56cb5b493b4e@redhat.com> <20220606135219.nwhp4fdawg2qjeam@houat>
 <78c1eb65-ea78-8744-5382-ea86a56a66f4@redhat.com>
In-Reply-To: <78c1eb65-ea78-8744-5382-ea86a56a66f4@redhat.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 6 Jun 2022 07:19:51 -0700
Message-ID: <CAGS_qxrPKJrXufMKOCO3eCEpq-Udq6uy32x6aneSPRnm=1O4HQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        davidgow@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 6:57 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>

<snip>

> >>>>  $ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm \
> >>>>          --kconfig_add CONFIG_VIRTIO_UML=y \
> >>>>          --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> >>>
> >>> It's not clear to me why you would need VIRTIO here? The Kunit config
> >>> file should be enough to run the tests properly
> >>>
> >>
> >> It's needed or otherwise KUnit will complain with:
> >>
> >> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig
> >> [15:47:31] Configuring KUnit Kernel ...
> >> Regenerating .config ...
> >> Populating config with:
> >> $ make ARCH=um O=.kunit olddefconfig
> >> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
> >> This is probably due to unsatisfied dependencies.
> >> Missing: CONFIG_DRM=y, CONFIG_DRM_KUNIT_TEST=y
> >> Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".
> >>
> >> The following works correctly but it won't use User Mode Linux:
> >>
> >> ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/.kunitconfig --arch=x86_64
> >
> > But then, can't we add them to .kunitconfig?
> >
>
> That's what I asked in the previous RFC too. Daniel mentioned that it shouldn't
> go there because is platform specific (AFAIU, one might want to test it on x86,

Slight correction, it was David who explicitly suggested it shouldn't
go in there.
https://lists.freedesktop.org/archives/dri-devel/2022-June/357611.html

> aarch64, etc) but then I asked why we couldn't have a arch/um/.kunitconfig.
>
> The answer was that's not that simple and some agreement on how to do it is needed:

I'm a bit more in favor of having UML-specific options in the drm
.kunitconfig file, but I agree it's a bit unclear.
If people want to easily run with --arch=x86_64 or others, then
they're indeed a liability.

Another option is to perhaps explicitly name the .kunitconfig file
something like drm/uml.kunitconfig, which doesn't solve the problem
but makes it less of a footgun.

Stepping back, I feel like perhaps a cleaner answer lies in adding a
new Kconfig option that selects CONFIG_UML_PCI_OVER_VIRTIO under UML
and just CONFIG_PCI otherwise.
But that's a bigger discussion still.

Daniel
