Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980FF5A26FD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 13:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245468AbiHZLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHZLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 07:42:44 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A6CCE493
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:42:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z8so1813104edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 04:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=zrOUwjMiJLEQnorFwBXUXwNV/zm3wEQOoRsBf8uog7Q=;
        b=U4rUv4EoAmPfiCoSUnphA6oOwJ4BIldC5W7psWAbxmS9oPKkwzKYseYdRVD8E6ceVu
         prVJAzz31O0Z5bI1YbQkz9SwwxG3pRT5YNdHG6oMp1M1CYdMLkN88b8dcxqtdytJeCue
         iCD1p9Yj2M7si13UrRlq80NqMDRx/0e0aS7azGxXY1Xmb0AcsXK0m1+yXx2lo9yyP1he
         mstz/rJ5RF4kWk6ERLEHG+N/vF7SnP+oXR3MTiaJFaWjp7RBofwrpydMYkREi2tQ1Ibx
         nQxEXbqeiWv7OA4qS3udBUzz2DzeBa0zfjlLs8VLw+OUpFqYlPKkY8Tg7uLBllUBbXae
         jzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=zrOUwjMiJLEQnorFwBXUXwNV/zm3wEQOoRsBf8uog7Q=;
        b=QkK1p69fhLohL4nmtbLAXUGtAe23ieg8HLIcfwOWV3N8NAvIecEg88K7sekWtPjwin
         7/MZ5SMXPlNcOWGwgzSO2nxT6a3F6h05ngptPzS7p2KVtVlw6vtLhqL1OTazECPLIB7B
         J1eeMgj4eSx2yPbsprj5p4k2vTy9AdwY/2lw+rt+wpmi/2nHs3Jqn/0e2H9FHnLj4i0w
         Th/tYWbiddXXD6XkpuJSk7u+Wt1qYpQnEK4/Ei4ON827+rDEo6t597+E+ZxjOm9BoWBq
         or8PQJqqeMq9lMS7I+ozNKtB6GJi1FTgA/yLx1197MAOGxJ/2ZrbFNAd829kPA8Mv6w2
         b/Bg==
X-Gm-Message-State: ACgBeo3YdMRCYwjDHy73EfjTdz2E3jqtW88ytfZENwomYvVxwTKdPz0T
        nNx5qHAVBGpVdsgH8oKuQYLrFqjEaBxzMddFvK7+Yw==
X-Google-Smtp-Source: AA6agR4qgeBuy8ICwhXd8sQJYQGeXtvsZdgXOMuTzqsLARLDSJmZWXMNu6KxWCfFajUhlPbY0jiQTw0Z6OanDBXf5Ng=
X-Received: by 2002:a05:6402:1f8c:b0:43e:8fab:76c with SMTP id
 c12-20020a0564021f8c00b0043e8fab076cmr6453960edc.126.1661514161435; Fri, 26
 Aug 2022 04:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220823004243.11596-1-rdunlap@infradead.org>
In-Reply-To: <20220823004243.11596-1-rdunlap@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 13:42:30 +0200
Message-ID: <CACRpkdZyk0OT2LuvHJRQgv+UjUgSzvyu1RECUEPu2T+8bcBziA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: fix drm_mipi_dbi build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dillon Min <dillon.minfei@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 2:42 AM Randy Dunlap <rdunlap@infradead.org> wrote:

> drm_mipi_dbi needs lots of DRM_KMS_HELPER support, so select
> that Kconfig symbol like it is done is most other uses, and
> the way that it was before MIPS_DBI was moved from tinydrm
> to its core location.
>
> Fixes these build errors:
>
> ld: drivers/gpu/drm/drm_mipi_dbi.o: in function `mipi_dbi_buf_copy':
> drivers/gpu/drm/drm_mipi_dbi.c:205: undefined reference to `drm_gem_fb_ge=
t_obj'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:211: undefined reference to `drm_gem_f=
b_begin_cpu_access'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:215: undefined reference to `drm_gem_f=
b_vmap'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:222: undefined reference to `drm_fb_sw=
ab'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:224: undefined reference to `drm_fb_me=
mcpy'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:227: undefined reference to `drm_fb_xr=
gb8888_to_rgb565'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:235: undefined reference to `drm_gem_f=
b_vunmap'
> ld: drivers/gpu/drm/drm_mipi_dbi.c:237: undefined reference to `drm_gem_f=
b_end_cpu_access'
> ld: drivers/gpu/drm/drm_mipi_dbi.o: in function `mipi_dbi_dev_init_with_f=
ormats':
> ld: drivers/gpu/drm/drm_mipi_dbi.o:/X64/../drivers/gpu/drm/drm_mipi_dbi.c=
:469: undefined reference to `drm_gem_fb_create_with_dirty'
>
> Fixes: 174102f4de23 ("drm/tinydrm: Move mipi-dbi")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Dillon Min <dillon.minfei@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>

Patch applied to drm-misc-next

Yours,
Linus Walleij
