Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDD44DCFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiCQU4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiCQU4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:56:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882F2DAFCC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:55:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3905CB81FCB
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6260C340EC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647550515;
        bh=pze1z1BdbXGkFdCxOha8uoXDciJVurg0YhEMJq3runk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CkePYpcghyT7B9A7yzhLZc+hWJC38j3LHw7aOwkWXJgdylnJfppDK0g+HSzYOaQI/
         /ZbaDCpREmCCoaN3PjaZoI5TurB22skINuBF0QwYOLwu7OrM2LDC4OQ9zJ1zXYEp0G
         ohpFmGkgqQ1zQbNIE/Q/r+bE3AIMlAu+mhFVXRFFr0+PJLD9UhDOvlxKx5UFAdng2F
         QDUvD3vnZZdSbm7bhX7NdWdOjFx0ZU/BlW5ErRJvS+/3D6zj71m+zelZE8MYAjq6LG
         1yyFnSCyk0b/KON8A7FJ3eWbuO4GYQ5z9H6WP6ZD8lITF8J3Dk0yYBf9gKp+XZKGEV
         Xs6DsALpmMVsQ==
Received: by mail-wm1-f53.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso3819764wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:55:15 -0700 (PDT)
X-Gm-Message-State: AOAM530wN8MYMpVk27PL6vPCfCK9M0BUEawBULiwzF4y0swrKN71xZGB
        8UJBGn9kf1aTdgrg7uST9C3WxFVPn0GzwQkbNI0=
X-Google-Smtp-Source: ABdhPJyZSHw1ltlznEHKpdgeeoKyl8jbWM+Dk2G5VG9wHw91b7cvT5lTxqYcy7l9pCd4B5lxaWL6odka8LdVjGdJIyo=
X-Received: by 2002:a7b:cd13:0:b0:38b:f39c:1181 with SMTP id
 f19-20020a7bcd13000000b0038bf39c1181mr5645518wmj.20.1647550514226; Thu, 17
 Mar 2022 13:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220316183708.1505846-1-arnd@kernel.org> <aaf204b2-e876-d271-3d4e-51cbcc70d690@suse.de>
 <1f6c4559-ee48-ca67-8ff1-f7f9d330bc12@suse.de> <CAK8P3a3ogV8sJshQJrzHe7hc2k1Opq-2hvXf6DU+HfhREk-DhQ@mail.gmail.com>
 <7082c67a-a336-54fc-dd32-81b9b8c0a64b@suse.de>
In-Reply-To: <7082c67a-a336-54fc-dd32-81b9b8c0a64b@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 17 Mar 2022 21:54:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0Tfnza=OSR=-A_2u5QYNx8ZPm+FrFUtncVZMQYVNsATQ@mail.gmail.com>
Message-ID: <CAK8P3a0Tfnza=OSR=-A_2u5QYNx8ZPm+FrFUtncVZMQYVNsATQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: add CONFIG_DRM_KMS_HELPER dependencies
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 8:15 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 16.03.22 um 21:59 schrieb Arnd Bergmann:
> > On Wed, Mar 16, 2022 at 8:31 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >
> > I was going for 'depends on' in the panel drivers because I saw the same being
> > done for other panel drivers, and mixing the two methods causes dependency
> > loops. I looked again now, and find that 'select DRM_KMS_HELPER' is more
> > common for other drivers, and makes sense here because it is generally
> > not user-selectable.
> >
> > The easiest replacement for my patch would then be to just use 'select
> > DRM_KMS_HELPER' from CONFIG_DRM_MIPI_DBI, which makes it
> > safer and more consistent with your change. If you like, I'll send an updated
> > version.
>
> MIPI DBI is another helper and select is not transitive IIRC. So drivers
> would still have to select KMS helpers as well. (?)

Not sure what you mean here: if a driver selects DRM_MIPI_DBI,
and DRM_MIPI_DBI selects DRM_KMS_HELPER, the leaf driver
does not need to select DRM_KMS_HELPER because it is already
selected. This is one of the major problems of overusing 'select' because
you end up unable to turn things off.

Maybe you are thinking of the case where DRM_MIPI_DBI depends
on DRM_KMS_HELPER, and something selects DRM_MIPI_DBI.
In this case, the dependency does /not/ get inherited by the leaf
driver, it needs a copy of the dependency or it triggers a warning,
which is what my patch intended.

> More generally, I think you're right about making DRM helper libraries
> using 'depends on' to link to other libraries. Drivers would at least
> know which config symbols to select. A number of config rules would have
> to be adapted to make that happen, I guess.

Generally speaking, a problem with DRM is that it uses way too
much 'select' to enforce other subsystems to be enabled, this is
what causes DRM to have more problems with incorrect or circular
dependencies, and the only way to avoid that is to be consistent
about the dependencies: each symbol should only be referenced
with either 'select' or 'depends on' but not both, and 'select' should
ideally only be used on hidden symbols.

> > One thing I'm not sure about is whether there is still use for ever having
> > CONFIG_DRM without CONFIG_DRM_KMS_HELPER if it gets selected
> > by almost every driver anyway. Is this actually a configuration that
> > users rely on, or should we just remove the symbol completely and
> > build the KMS helpers unconditionally?
>
> Best leave it as it is. i915 doesn't use it. And since it's a helper, it
> should not be lumped together with core DRM code simply for reasons of
> design.

Ok

> For DRM_KMS_HELPER itself, the mid-term plan is to move some of the code
> into other modules. KMS helpers used to contain all kind of helpers, but
> recently there's interest in reducing the minimum size of a built-in DRM
> with minimal driver support. So the non-essential stuff needs to go into
> modules for the more-sophisticated DRM drivers.

Right, that makes sense.

       Arnd
