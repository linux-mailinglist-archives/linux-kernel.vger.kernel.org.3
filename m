Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BF53982E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 22:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347821AbiEaUmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 16:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237511AbiEaUmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 16:42:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8923F6F4B6
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:42:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rs12so28843184ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fCWWt9NpzsBTceHg7wJgmyAh2h0yT9EdXCCTllStCtg=;
        b=MkEbHZFZ0NblSs3QWDSw8yOZv5ORx1gmf/KDKGn6K5nkQxKKOjIR7us0wQHilrzRX9
         grHVLJaT/od38Kt5I5Cb9WmJgxRb+wKWa4TEUD+2i+E2IkvN1cgvQVyXBEohFGNBaNRM
         pB5I0rZJd44GHQTSU8vlaivXM+ETC6D0dkS6lOUSRe1KyTNLHUFvzH7Q6fSWruFE0bqs
         4W/bnwx8LfVENwmcUSE7X9RMDrCPrhBzFbk2n0huORQstBAlr0Pu3XZgw9p8F1rlQZjb
         vBD0vsG5065kj7hHL3znTmC9z2bgIzWiYcEf14ljM/XodCuH6l3f6xCkT1MtBBzCOVsO
         w+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fCWWt9NpzsBTceHg7wJgmyAh2h0yT9EdXCCTllStCtg=;
        b=5qcHihvu+mYnLYFfcd9H5EzMv/2LzHddgzBT4FYnsEuCUjT/Dyjlm2Hx5jzg/9CmuJ
         7+sgroZyIChoRohZ6Z5utiXQDcGOrNcEj/ChyrSdG10FjOOka0KfWePvY9DZWQw3WkmP
         s5ITUtCAGO5Nj4kBN0gP6RQkyJRTNaEI96p0H+FWqiUoBN+ptkzDX/Ue4CYyBdRfXizZ
         d3ogq+CC47Lw3qg/8H974XABJDV3vEu6ZmupjiqltfImbZJ+jXOz9+wkAkAL5WEGDADx
         KgSEO3oD+tC4QUt+hvu+I6ZN2NH4V64Ena5dVwhxn/GNggATVxwUREZROv1JnxpRVwfV
         dbhQ==
X-Gm-Message-State: AOAM530rWwKk3dP/2PxbCzjvsr6SZwv7ZgaIWT3UdIZYeB4Z4BwX279T
        bOGPa8IhLmtUgaXZhRTHeOA0LljCx5PsjL2ZpfsHRRVMYtYmNQ==
X-Google-Smtp-Source: ABdhPJx+3GZDgCxy/32q1dZuv7jmnDJRmuqzUZT0z+QaQEW56wRTTMSPz1xgCSYUF0gqRtMIcV6JYVOYxerltPLSBlI=
X-Received: by 2002:a17:907:1c8c:b0:6ff:144d:e7da with SMTP id
 nb12-20020a1709071c8c00b006ff144de7damr27188397ejc.542.1654029767912; Tue, 31
 May 2022 13:42:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220530102017.471865-1-jose.exposito89@gmail.com>
 <20220530102017.471865-2-jose.exposito89@gmail.com> <20220530131158.kqq2mohxoh52xpeg@penduick>
 <20220530162903.GA6546@elementary> <CAGS_qxpV2SsihEdgXZ6+7N0dxLmdRANq+qE4iUZ2aNrf6vuLYg@mail.gmail.com>
 <20220531184454.GA237621@elementary>
In-Reply-To: <20220531184454.GA237621@elementary>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 31 May 2022 13:42:36 -0700
Message-ID: <CAGS_qxoWTo+TqAMOaoD=XEQhFp0K0QN4LS4XRQxFR9aTv=XmfA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb332()
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, kunit-dev@googlegroups.com,
        javierm@redhat.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 31, 2022 at 11:45 AM Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> wrote:
> >
> > From above, a)
> > Specifically here, it'd be encouraged to instead do
> >   depends on DRM && KUNIT=3Dy && DRM_KMS_HELPER
>
> My first attempt was to go with:
>
>         depends on KUNIT=3Dy && DRM && DRM_KMS_HELPER
>
> However, when I try to run the tests I get this error:
>
>         $ ./tools/testing/kunit/kunit.py run --kunitconfig=3Ddrivers/gpu/=
drm --arch=3Dx86_64
>         Regenerating .config ...
>         Populating config with:
>         $ make ARCH=3Dx86_64 olddefconfig O=3D.kunit
>         ERROR:root:Not all Kconfig options selected in kunitconfig were i=
n the generated .config.
>         This is probably due to unsatisfied dependencies.
>         Missing: CONFIG_DRM_KMS_HELPER=3Dy, CONFIG_DRM_FORMAR_HELPER_TEST=
=3Dy
>
> I wasn't able to figure out why that was happening, so I decided to use
> "select", which seems to solve the problem.
>
> Do you know why this could be happening?

Ah, you should probably ignore my suggestion then.

Looking at the Kconfig file, it's defined as
  config DRM_KMS_HELPER
  tristate
  depends on DRM
  help
    CRTC helpers for KMS drivers.

Notably, the config lacks a description string.
IIUC, this makes it a "hidden" kconfig option, i.e. you can't directly
select it yourself in a .config, it must be selected by another
kconfig option.

E.g. you can try selecting it manually and see it fail via:
$ ./tools/testing/kunit/kunit.py config --arch=3Dx86_64
--kconfig_add=3DCONFIG_DRM=3Dy --kconfig_add=3DCONFIG_DRM_KMS_HELPER=3Dy
...
Missing: CONFIG_DRM_KMS_HELPER=3Dy

So having the test select it makes the most sense, unless there's a
better kconfig option to automatically select it (I have no idea,
someone with knowledge of the DRM code might though).

Daniel
